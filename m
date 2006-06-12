Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWFLPHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWFLPHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWFLPHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:07:21 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:32233
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1752026AbWFLPHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:07:20 -0400
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
From: Paul Fulghum <paulkf@microgate.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
References: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:07:10 -0500
Message-Id: <1150124830.3703.6.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck:

Here is a patch to serialize flush_to_ldisc
with per device granularity. It should fix the
corruption of the free list that is the probably
cause of the freeze you are seeing. Test it to
see if there are any ill effects (it works fine here
on an AMD x2 SMP kernel). I realize that
the problem happens infrequently, so you won't
be able to tell quickly if it fixed the freeze.

This is a necessary change regardless, but I'm
confident it is the cause of your problem.

Just keep using it and keep me posted on the results.

Thanks,
Paul

--- a/include/linux/tty.h	2006-06-09 09:33:16.000000000 -0500
+++ b/include/linux/tty.h	2006-06-12 09:22:10.000000000 -0500
@@ -267,6 +267,7 @@ struct tty_struct {
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
+#define TTY_FLUSHING 		19	/* Flushing tty buffers to line discipline */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
 
--- a/drivers/char/tty_io.c	2006-06-12 09:27:35.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-06-12 09:31:41.000000000 -0500
@@ -2785,10 +2785,8 @@ static void flush_to_ldisc(void *private
 	if (disc == NULL)	/*  !TTY_LDISC */
 		return;
 
-	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		/*
-		 * Do it after the next timer tick:
-		 */
+	if (test_bit(TTY_DONT_FLIP, &tty->flags) ||
+	    test_and_set_bit(TTY_FLUSHING, &tty->flags)) {
 		schedule_delayed_work(&tty->buf.work, 1);
 		goto out;
 	}
@@ -2810,6 +2808,7 @@ static void flush_to_ldisc(void *private
 		tty_buffer_free(tty, tbuf);
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	clear_bit(TTY_FLUSHING, &tty->flags);
 out:
 	tty_ldisc_deref(disc);
 }


