Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUE1Sm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUE1Sm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 14:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUE1Sm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 14:42:57 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:32044 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263781AbUE1Smx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 14:42:53 -0400
Subject: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
From: Paul Fulghum <paulkf@microgate.com>
To: Jurjen Oskam <jurjen@stupendous.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040527174509.GA1654@quadpro.stupendous.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
Content-Type: text/plain
Organization: 
Message-Id: <1085769769.2106.23.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 May 2004 13:42:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch removes unnecessary disabling of
interrupts when processing hangup for tty devices.

This was introduced way back in August 1998
with patch 2.1.115 when the original hangup processing was
changed from cli/sti to lock_kernel()/unlock_kernel().

Up to now, this did not cause any actual problems.
In 2.6.X this causes a warning if any of the called functions
(flush_buffer/write_wakeup) call spin_xxx_bh() functions.

Warning is in spin_unlock_bh (kernel/softirq.c:122)

An example is drivers/net/ppp_synctty.c write_wakeup.
This has been reported several times by different people.

The flush_buffer/write_wakeup calls are also called
when processing ioctl for tty devices, without disabling
interrupts using only lock_kernel()/unlock_kernel().

tty->ldisc.flush_buffer()
	tty_ioctl.c
		ioctl(TCSETSF) -> set_termios()
		ioctl(TCSETAF) -> set_termios()
		ioctl(TCFLSH)

tty->driver.flush_buffer()
	tty_ioctl.c
		ioctl(TCFLSH)

tty->ldisc.write_wakeup()
	tty_ioctl.c
		ioctl(TCOON)  -> start_tty()
		ioctl(TCIOFF) -> send_prio_char() -> start_tty()
		ioctl(TCION)  -> send_prio_char() -> start_tty()

So removal of the interrupt disable/enable from around
these calls in tty_io.c do_tty_hangup(), implements locking
the same as the ioctl calls.

I have tested this patch on an SMP machine with 2.6.6.

I welcome comments and testing by others, particularly those
 who have seen the softirq.c message when doing ppp
(synchronous PPP, PPPoATM etc) that use the ppp_synctty.c

Paul Fulghum
paulkf@microgate.com


--- linux-2.6.6/drivers/char/tty_io.c	2004-05-28 08:26:47.000000000 -0500
+++ linux-2.6.6-mg1/drivers/char/tty_io.c	2004-05-28 08:31:05.000000000 -0500
@@ -442,21 +442,13 @@
 	}
 	file_list_unlock();
 	
-	/* FIXME! What are the locking issues here? This may me overdoing things..
-	* this question is especially important now that we've removed the irqlock. */
-	{
-		unsigned long flags;
-
-		local_irq_save(flags); // FIXME: is this safe?
-		if (tty->ldisc.flush_buffer)
-			tty->ldisc.flush_buffer(tty);
-		if (tty->driver->flush_buffer)
-			tty->driver->flush_buffer(tty);
-		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
-		    tty->ldisc.write_wakeup)
-			(tty->ldisc.write_wakeup)(tty);
-		local_irq_restore(flags); // FIXME: is this safe?
-	}
+	if (tty->ldisc.flush_buffer)
+		tty->ldisc.flush_buffer(tty);
+	if (tty->driver->flush_buffer)
+		tty->driver->flush_buffer(tty);
+	if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
+	    tty->ldisc.write_wakeup)
+		(tty->ldisc.write_wakeup)(tty);
 
 	wake_up_interruptible(&tty->write_wait);
 	wake_up_interruptible(&tty->read_wait);


