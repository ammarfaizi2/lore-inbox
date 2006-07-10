Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWGJPMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWGJPMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWGJPMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:12:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54420 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422646AbWGJPMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:12:54 -0400
Subject: Re: lockdep input layer warnings.
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Jones <davej@redhat.com>, mingo@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000607061329t4868d265h6f8285c798a0e3b7@mail.gmail.com>
References: <20060706173411.GA2538@redhat.com>
	 <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
	 <1152212575.3084.88.camel@laptopd505.fenrus.org>
	 <d120d5000607061329t4868d265h6f8285c798a0e3b7@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 17:12:51 +0200
Message-Id: <1152544371.4874.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 16:29 -0400, Dmitry Torokhov wrote:
> On 7/6/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Thu, 2006-07-06 at 14:37 -0400, Dmitry Torokhov wrote:
> > > On 7/6/06, Dave Jones <davej@redhat.com> wrote:
> > > > One of our Fedora-devel users picked up on this this morning
> > > > in an 18rc1 based kernel.
> > > >
> > > >                Dave
> > > >
> > > >
> > > >  Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
> > > >  serio: Synaptics pass-through port at isa0060/serio1/input0
> > > >  input: SynPS/2 Synaptics TouchPad as /class/input/input1
> > > >  PM: Adding info for serio:serio2
> > > >
> > > >  =============================================
> > > >  [ INFO: possible recursive locking detected ]
> > > >  ---------------------------------------------
> > >
> > > False alarm, there was a lockdep annotating patch for it in -mm.
> > not so sure; that patch is supposed to be in -rc1 already; investigating
> >
> 
> Well, you are right, the patch is in -rc1 and I see mutex_lock_nested
> in the backtrace but for some reason it is still not happy. Again,
> this is with pass-through Synaptics port and we first taking mutex of
> the child device and then (going through pass-through port) trying to
> take mutex of the parent.

Ok it seems more drastic measures are needed; and a split of the
cmd_mutex class on a per driver basis. The easiest way to do that is to
inline the lock initialization (patch below) but to be honest I think
the patch is a bit ugly; I considered inlining the entire function
instead, any opinions on that?

Index: linux-2.6.18-rc1/drivers/input/serio/libps2.c
===================================================================
--- linux-2.6.18-rc1.orig/drivers/input/serio/libps2.c
+++ linux-2.6.18-rc1/drivers/input/serio/libps2.c
@@ -27,7 +27,7 @@ MODULE_AUTHOR("Dmitry Torokhov <dtor@mai
 MODULE_DESCRIPTION("PS/2 driver library");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ps2_init);
+EXPORT_SYMBOL(__ps2_init);
 EXPORT_SYMBOL(ps2_sendbyte);
 EXPORT_SYMBOL(ps2_drain);
 EXPORT_SYMBOL(ps2_command);
@@ -177,7 +177,7 @@ int ps2_command(struct ps2dev *ps2dev, u
 		return -1;
 	}
 
-	mutex_lock_nested(&ps2dev->cmd_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&ps2dev->cmd_mutex);
 
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
@@ -279,7 +279,7 @@ int ps2_schedule_command(struct ps2dev *
  * ps2_init() initializes ps2dev structure
  */
 
-void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
+void __ps2_init(struct ps2dev *ps2dev, struct serio *serio)
 {
 	mutex_init(&ps2dev->cmd_mutex);
 	init_waitqueue_head(&ps2dev->wait);
Index: linux-2.6.18-rc1/include/linux/libps2.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/libps2.h
+++ linux-2.6.18-rc1/include/linux/libps2.h
@@ -39,7 +39,12 @@ struct ps2dev {
 	unsigned char nak;
 };
 
-void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
+void __ps2_init(struct ps2dev *ps2dev, struct serio *serio);
+static inline void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
+{
+	__ps2_init(ps2dev, serio);
+	mutex_init(&ps2dev->cmd_mutex);
+}
 int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
 void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);


