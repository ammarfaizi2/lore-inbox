Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRKASDJ>; Thu, 1 Nov 2001 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279429AbRKASDA>; Thu, 1 Nov 2001 13:03:00 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:45975 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S279418AbRKASCs>; Thu, 1 Nov 2001 13:02:48 -0500
Date: Thu, 1 Nov 2001 18:02:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Patch: fix serial.c race prevention bug
Message-ID: <20011101180245.D10819@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, lkml,

serial.c appears to contain a bug in the race prevention code:

        /*
         * If we're about to load something into the transmit
         * register, we'll pretend the transmitter isn't empty to
         * avoid a race condition (depending on when the transmit
         * interrupt happens).
         */
        if (info->x_char ||
            ((CIRC_CNT(info->xmit.head, info->xmit.tail,
                       SERIAL_XMIT_SIZE) > 0) &&
             !info->tty->stopped && !info->tty->hw_stopped))
                result &= TIOCSER_TEMT;

The comment doesn't agree with the action the code is taking, and,
since result is either 0 or TIOCSER_TEMT anyway, it is a no-op
whether the if condition is true or false.

The following patch makes the race prevention code actually do
something, namely what is described in the comment.

This is only an issue for people using the TIOCSERGETLSR ioctl.

--- orig/drivers/char/serial.c	Sun Oct 28 20:36:48 2001
+++ linux/drivers/char/serial.c	Thu Nov  1 17:58:28 2001
@@ -2250,7 +2250,7 @@
 	    ((CIRC_CNT(info->xmit.head, info->xmit.tail,
 		       SERIAL_XMIT_SIZE) > 0) &&
 	     !info->tty->stopped && !info->tty->hw_stopped))
-		result &= TIOCSER_TEMT;
+		result &= ~TIOCSER_TEMT;
 
 	if (copy_to_user(value, &result, sizeof(int)))
 		return -EFAULT;


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

