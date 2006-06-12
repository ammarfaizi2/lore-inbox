Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWFLSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWFLSGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWFLSGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:06:23 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:55947
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751516AbWFLSGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:06:22 -0400
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
From: Paul Fulghum <paulkf@microgate.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200606121239_MC3-1-C23E-9AF9@compuserve.com>
References: <200606121239_MC3-1-C23E-9AF9@compuserve.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 13:06:12 -0500
Message-Id: <1150135572.6065.8.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 12:36 -0400, Chuck Ebbert wrote:
> I already applied this, which should keep it from freezing and
> will print a warning, so I will apply your patch and then check
> the log every time pppd exits.

Your debug output seems like a good idea for catching
the mechanism of reentrance on flush_to_ldisc (if it
is happening at all).

My reading of the workqueue code is that the work
function can run in parallel on a multiple CPU
system. The default workqueue has multiple, per
CPU queues, and the pending bit for the
work item is cleared before execution. This would
allow the work item to be requeued for another CPU
while the function is executing.
(If I'm wrong, I would be happy to be told why)

Anyways, if I can impose on you to use this version
with debug output, it would help clarify this.

If the DONT_FLIP debug output happens too often and
fills you syslog, comment out that part.

--- a/include/linux/tty.h	2006-06-09 09:33:16.000000000 -0500
+++ b/include/linux/tty.h	2006-06-12 09:22:10.000000000 -0500
@@ -267,6 +267,7 @@ struct tty_struct {
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
+#define TTY_FLUSHING 		19	/* Flushing tty buffers to line discipline */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
 
--- a/drivers/char/tty_io.c	2006-06-12 12:54:37.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-06-12 12:54:54.000000000 -0500
@@ -2786,9 +2786,12 @@ static void flush_to_ldisc(void *private
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
@@ -2810,6 +2813,7 @@ static void flush_to_ldisc(void *private
 		tty_buffer_free(tty, tbuf);
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	clear_bit(TTY_FLUSHING, &tty->flags);
 out:
 	tty_ldisc_deref(disc);
 }


