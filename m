Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWIUEHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIUEHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIUEHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:07:24 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:41479 "EHLO
	asav12.insightbb.com") by vger.kernel.org with ESMTP
	id S1751202AbWIUEHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:07:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HABCsEUWBT4obLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Grant Coady <gcoady.lk@gmail.com>
Subject: Re: [RFC/PATCH-mm] i8042: activate panic blink only in X
Date: Thu, 21 Sep 2006 00:07:19 -0400
User-Agent: KMail/1.9.3
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200609022320.36754.dtor@insightbb.com> <p738xkz65ly.fsf@verdi.suse.de> <ri9pf258l1q51kgsjs4u90sjp9581djjgs@4ax.com>
In-Reply-To: <ri9pf258l1q51kgsjs4u90sjp9581djjgs@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609210007.20115.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 18:29, Grant Coady wrote:
> On 04 Sep 2006 16:58:33 +0200, Andi Kleen <ak@suse.de> wrote:
> 
> >Dmitry Torokhov <dtor@insightbb.com> writes:
> >
> >> Hi,
> >> 
> >> Here is an attempt to make panicblink only active in X so there is a
> >> chance of keyboard still working after panic in text console. Any reason
> >> why is should not be done this way?
> >> 
> >
> >Looks good to me.
> >
> >Of course it would be even better to fix the panic stuff to not disrupt scrollback,
> >but short of that it's a good idea.
> >
> >-Andi (original panic blink author)
> 
> I'd like to have panic blink and also be able to Shft-Up to previous 
> console screens. 

Ok, so here is my attempt at keeping panic blink in console whithout
atkbd bitching at us about ACKs/NAKs. Console scrollback still does
not work for me, most likely because it needs scheduler to run, but
SysRq seems to be working well.

Please try it and tell meif it works for you. Thanks!

-- 
Dmitry

Subject: i8042 - supress ACK/NAKs when blinking during panic

Input: i8042 - supress ACK/NAKs when blinking during panic

This allows using SysRq and not fill logs with complaints from atkbd.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -106,6 +106,7 @@ static unsigned char i8042_ctr;
 static unsigned char i8042_mux_present;
 static unsigned char i8042_kbd_irq_registered;
 static unsigned char i8042_aux_irq_registered;
+static unsigned char i8042_suppress_kbd_ack;
 static struct platform_device *i8042_platform_device;
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -316,7 +317,7 @@ static irqreturn_t i8042_interrupt(int i
 	unsigned char str, data;
 	unsigned int dfl;
 	unsigned int port_no;
-	int ret;
+	int ret = 1;
 
 	spin_lock_irqsave(&i8042_lock, flags);
 	str = i8042_read_status();
@@ -378,10 +379,16 @@ static irqreturn_t i8042_interrupt(int i
 	    dfl & SERIO_PARITY ? ", bad parity" : "",
 	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
+	if (unlikely(i8042_suppress_kbd_ack))
+		if (port_no == I8042_KBD_PORT_NO &&
+		    (data == 0xfa || data == 0xfe)) {
+			i8042_suppress_kbd_ack = 0;
+			goto out;
+		}
+
 	if (likely(port->exists))
 		serio_interrupt(port->serio, data, dfl, regs);
 
-	ret = 1;
  out:
 	return IRQ_RETVAL(ret);
 }
@@ -842,11 +849,13 @@ static long i8042_panic_blink(long count
 	led ^= 0x01 | 0x04;
 	while (i8042_read_status() & I8042_STR_IBF)
 		DELAY;
+	i8042_suppress_kbd_ack = 1;
 	i8042_write_data(0xed); /* set leds */
 	DELAY;
 	while (i8042_read_status() & I8042_STR_IBF)
 		DELAY;
 	DELAY;
+	i8042_suppress_kbd_ack = 1;
 	i8042_write_data(led);
 	DELAY;
 	last_blink = count;
