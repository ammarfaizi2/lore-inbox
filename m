Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbTEMWWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTEMWLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:11:40 -0400
Received: from palrel12.hp.com ([156.153.255.237]:54498 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263628AbTEMWJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:09:48 -0400
Date: Tue, 13 May 2003 15:22:27 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] owner in irtty-sir
Message-ID: <20030513222227.GE2634@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir259_sir_kthread_Morton-2.diff :
	o [CORRECT] fix module ownership in irtty-sir
	o [FEATURE] important comment in sir_kthread


diff -u -p linux/drivers/net/irda/sir_kthread.d0.c linux/drivers/net/irda/sir_kthread.c
--- linux/drivers/net/irda/sir_kthread.d0.c	Mon May 12 17:47:43 2003
+++ linux/drivers/net/irda/sir_kthread.c	Mon May 12 17:55:49 2003
@@ -151,6 +151,13 @@ static int irda_thread(void *startup)
 
 	while (irda_rq_queue.thread != NULL) {
 
+		/* We use TASK_INTERRUPTIBLE, rather than
+		 * TASK_UNINTERRUPTIBLE.  Andrew Morton made this
+		 * change ; he told me that it is safe, because "signal
+		 * blocking is now handled in daemonize()", he added
+		 * that the problem is that "uninterruptible sleep
+		 * contributes to load average", making user worry.
+		 * Jean II */
 		set_task_state(current, TASK_INTERRUPTIBLE);
 		add_wait_queue(&irda_rq_queue.kick, &wait);
 		if (list_empty(&irda_rq_queue.request_list))
diff -u -p linux/drivers/net/irda/irtty-sir.d0.c linux/drivers/net/irda/irtty-sir.c
--- linux/drivers/net/irda/irtty-sir.d0.c	Mon May 12 17:49:22 2003
+++ linux/drivers/net/irda/irtty-sir.c	Mon May 12 17:53:09 2003
@@ -504,10 +504,7 @@ static int irtty_open(struct tty_struct 
 	struct sirtty_cb *priv;
 	int ret = 0;
 
-	/* unfortunately, there's no tty_ldisc->owner field
-	 * so there is some window for SMP race with rmmod
-	 */
-	MOD_INC_USE_COUNT;
+	/* Module stuff handled via irda_ldisc.owner - Jean II */
 
 	/* First make sure we're not already connected. */
 	if (tty->disc_data != NULL) {
@@ -569,7 +566,6 @@ static int irtty_open(struct tty_struct 
 out_put:
 	sirdev_put_instance(dev);
 out:
-	MOD_DEC_USE_COUNT;
 	return ret;
 }
 
@@ -614,8 +610,6 @@ static void irtty_close(struct tty_struc
 		tty->driver->stop(tty);
 
 	kfree(priv);
-
-	MOD_DEC_USE_COUNT;
 }
 
 /* ------------------------------------------------------- */
@@ -633,6 +627,7 @@ static struct tty_ldisc irda_ldisc = {
 	.receive_buf	= irtty_receive_buf,
 	.receive_room	= irtty_receive_room,
 	.write_wakeup	= irtty_write_wakeup,
+	.owner		= THIS_MODULE,
 };
 
 /* ------------------------------------------------------- */
