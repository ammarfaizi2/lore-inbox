Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWGVDDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWGVDDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 23:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGVDDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 23:03:31 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:59036 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751117AbWGVDDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 23:03:31 -0400
Date: Fri, 21 Jul 2006 22:58:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Success: tty_io flush_to_ldisc() error message triggered
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200607212301_MC3-1-C5B7-9F6C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the patch below that you sent me, this message printed today on
my SMP system when terminating pppd:

        flush_to_ldisc - TTY_FLUSHING set, low_latency=0

And this bug is also in 2.6.17.4 - I forgot to reboot into 2.6.16.x
and the system locked up the same way 2.6.16 used to.  That was made
even more fun by the 'SysRq broken on SMP' bug fixed by a pending
2.6.17.7 patch...


--- 2.6.16.20-d4.orig/include/linux/tty.h
+++ 2.6.16.20-d4/include/linux/tty.h
@@ -266,6 +266,7 @@ struct tty_struct {
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
+#define TTY_FLUSHING 		19	/* Flushing tty buffers to line discipline */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
 
--- 2.6.16.20-d4.orig/drivers/char/tty_io.c
+++ 2.6.16.20-d4/drivers/char/tty_io.c
@@ -2781,9 +2781,12 @@ static void flush_to_ldisc(void *private
 		return;
 
 	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		/*
-		 * Do it after the next timer tick:
-		 */
+		printk(KERN_ERR"flush_to_ldisc - TTY_DONT_FLIP set\n");
+		schedule_delayed_work(&tty->buf.work, 1);
+		goto out;
+	}
+	if (test_and_set_bit(TTY_FLUSHING, &tty->flags)) {
+		printk(KERN_ERR"flush_to_ldisc - TTY_FLUSHING set, low_latency=%d\n", tty->low_latency);
 		schedule_delayed_work(&tty->buf.work, 1);
 		goto out;
 	}
@@ -2805,6 +2808,7 @@ static void flush_to_ldisc(void *private
 		tty_buffer_free(tty, tbuf);
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	clear_bit(TTY_FLUSHING, &tty->flags);
 out:
 	tty_ldisc_deref(disc);
 }
-- 
Chuck
