Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVC2Gb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVC2Gb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVC2Gbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:31:55 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:42082 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262446AbVC2G14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:27:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Date: Tue, 29 Mar 2005 01:27:52 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200503282126.55366.adobriyan@mail.ru>
In-Reply-To: <200503282126.55366.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503290127.52614.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 March 2005 12:26, Alexey Dobriyan wrote:
> Steps to reproduce for me:
> 	* Boot CONFIG_PREEMPT_BKL=y kernel (.config, dmesg are attached)
> 	* Start rebooting
> 	* Start moving serial mouse (I have Genius NetMouse Pro)
> 	* Right after gpm is shut down I see the oops
> 	* The system continues to reboot
> 

Could you try the patch below, please? Thanks!

-- 
Dmitry

===================================================================

Input: serport - fix an Oops when closing port - should not call
       serio_interrupt when serio port is being unregistered.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serport.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

Index: dtor/drivers/input/serio/serport.c
===================================================================
--- dtor.orig/drivers/input/serio/serport.c
+++ dtor/drivers/input/serio/serport.c
@@ -27,11 +27,14 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS_LDISC(N_MOUSE);
 
 #define SERPORT_BUSY	1
+#define SERPORT_ACTIVE	2
+#define SERPORT_DEAD	3
 
 struct serport {
 	struct tty_struct *tty;
 	wait_queue_head_t wait;
 	struct serio *serio;
+	spinlock_t lock;
 	unsigned long flags;
 };
 
@@ -49,10 +52,31 @@ static void serport_serio_close(struct s
 {
 	struct serport *serport = serio->port_data;
 
-	serport->serio->id.type = 0;
+	set_bit(SERPORT_DEAD, &serport->flags);
 	wake_up_interruptible(&serport->wait);
 }
 
+static int serport_serio_start(struct serio *serio)
+{
+	struct serport *serport = serio->port_data;
+
+	spin_lock(&serport->lock);
+	set_bit(SERPORT_ACTIVE, &serport->flags);
+	spin_unlock(&serport->lock);
+
+	return 0;
+}
+
+static void serport_serio_stop(struct serio *serio)
+{
+	struct serport *serport = serio->port_data;
+
+	spin_lock(&serport->lock);
+	clear_bit(SERPORT_ACTIVE, &serport->flags);
+	serport->serio = NULL;
+	spin_unlock(&serport->lock);
+}
+
 /*
  * serport_ldisc_open() is the routine that is called upon setting our line
  * discipline on a tty. It prepares the serio struct.
@@ -79,6 +103,7 @@ static int serport_ldisc_open(struct tty
 	serport->serio = serio;
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	serport->tty = tty;
+	spin_lock_init(&serport->lock);
 	tty->disc_data = serport;
 
 	memset(serio, 0, sizeof(struct serio));
@@ -87,6 +112,8 @@ static int serport_ldisc_open(struct tty
 	serio->id.type = SERIO_RS232;
 	serio->write = serport_serio_write;
 	serio->close = serport_serio_close;
+	serio->start = serport_serio_start;
+	serio->stop = serport_serio_stop;
 	serio->port_data = serport;
 
 	init_waitqueue_head(&serport->wait);
@@ -117,8 +144,17 @@ static void serport_ldisc_receive(struct
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
 	int i;
+
+	spin_lock(&serport->lock);
+
+	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
+		goto out;
+
 	for (i = 0; i < count; i++)
 		serio_interrupt(serport->serio, cp[i], 0, NULL);
+
+out:
+	spin_unlock(&serport->lock);
 }
 
 /*
@@ -148,7 +184,7 @@ static ssize_t serport_ldisc_read(struct
 
 	serio_register_port(serport->serio);
 	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty, name));
-	wait_event_interruptible(serport->wait, !serport->serio->id.type);
+	wait_event_interruptible(serport->wait, test_bit(SERPORT_DEAD, &serport->flags));
 	serio_unregister_port(serport->serio);
 
 	clear_bit(SERPORT_BUSY, &serport->flags);
