Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWFLCQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWFLCQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 22:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFLCQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 22:16:34 -0400
Received: from ozlabs.org ([203.10.76.45]:13952 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750710AbWFLCQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 22:16:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17548.52858.22555.610055@cargo.ozlabs.ibm.com>
Date: Mon, 12 Jun 2006 12:16:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, xxebxebx@gmail.com
Subject: [PATCH] Fix for the PPTP hangs that have been reported
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People have been reporting that PPP connections over ptys, such as
used with PPTP, will hang randomly when transferring large amounts of
data, for instance in http://bugzilla.kernel.org/show_bug.cgi?id=6530.
I have managed to reproduce the problem, and the patch below fixes the
actual cause.

The problem is not in fact in ppp_async.c but in n_tty.c.  What
happens is that when pptp reads from the pty, we call read_chan() in
drivers/char/n_tty.c on the master side of the pty.  That copies all
the characters out of its buffer to userspace and then calls
check_unthrottle(), which calls the pty unthrottle routine, which
calls tty_wakeup on the slave side, which calls ppp_asynctty_wakeup,
which calls tasklet_schedule.  So far so good.  Since we are in
process context, the tasklet runs immediately and calls
ppp_async_process(), which calls ppp_async_push, which calls the
tty->driver->write function to send some more output.

However, tty->driver->write() returns zero, because the master
tty->receive_room is still zero.  We haven't returned from
check_unthrottle() yet, and read_chan() only updates tty->receive_room
_after_ calling check_unthrottle.  That means that the driver->write
call in ppp_async_process() returns 0.  That would be fine if we were
going to get a subsequent wakeup call, but we aren't (we just had it,
and the buffer is now empty).

The solution is for n_tty.c to update tty->receive_room _before_
calling the driver unthrottle routine.  The patch below does this.
With this patch I was able to transfer a 900MB file over a PPTP
connection (taking about 25 minutes), whereas without the patch the
connection would always stall in under a minute.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus & Andrew, I think this one is a 2.6.17 candidate.  It's a small
and harmless patch and it fixes a bug that has been annoying quite a
few people, if the bugzilla reports are anything to go by.  I think it
should solve bugzilla 6402 as well.

diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index ede365d..b9371d5 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -1384,8 +1384,10 @@ do_it_again:
 		 * longer than TTY_THRESHOLD_UNTHROTTLE in canonical mode,
 		 * we won't get any more characters.
 		 */
-		if (n_tty_chars_in_buffer(tty) <= TTY_THRESHOLD_UNTHROTTLE)
+		if (n_tty_chars_in_buffer(tty) <= TTY_THRESHOLD_UNTHROTTLE) {
+			n_tty_set_room(tty);
 			check_unthrottle(tty);
+		}
 
 		if (b - buf >= minimum)
 			break;
