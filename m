Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWGVQR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWGVQR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWGVQR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:17:28 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:19937 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750843AbWGVQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:17:28 -0400
Date: Sat, 22 Jul 2006 12:07:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Success: tty_io flush_to_ldisc() error message triggered
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>
Message-ID: <200607221209_MC3-1-C5CA-50EB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44C2307C.9060607@microgate.com>

On Sat, 22 Jul 2006 09:04:44 -0500, Paul Fulghum wrote:

> That confirms my thoughts on what went wrong:
> multiple copies of the queued work (flush_to_ldisc)
> running in parallel and corrupting the free buffer list.
> 
> A cleaner fix for this is already
> in the 2.6.18 rc series.

The cleaner fix looks more intrusive, though.

Is this simpler change (what I'm running but without the warning
messages) the preferred fix for -stable?


From: Paul Fulghum <paulkf@microgate.com>

Serialize flush_to_ldisc() per-device. Fixes free list corruption
that causes lockup on SMP systems.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Acked-by: Chuck Ebbert <76306.1226@compuserve.com>

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
@@ -2780,10 +2780,8 @@ static void flush_to_ldisc(void *private
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
@@ -2805,6 +2803,7 @@ static void flush_to_ldisc(void *private
 		tty_buffer_free(tty, tbuf);
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	clear_bit(TTY_FLUSHING, &tty->flags);
 out:
 	tty_ldisc_deref(disc);
 }
-- 
Chuck
