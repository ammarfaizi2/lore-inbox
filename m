Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281211AbRKLBia>; Sun, 11 Nov 2001 20:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281212AbRKLBiV>; Sun, 11 Nov 2001 20:38:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47634 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281211AbRKLBiM>; Sun, 11 Nov 2001 20:38:12 -0500
Message-ID: <3BEF27D1.7793AE8E@zip.com.au>
Date: Sun, 11 Nov 2001 17:37:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hogsberg@users.sourceforge.net, jamesg@filanet.com
CC: "H . J . Lu" <hjl@lucon.org>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: sbp2.c on SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

drivers/ieee1394/sbp2.c deadlocks immediately on SMP, because
io_request_lock is not held over its call to scsi_old_done().

I don't know why scsi_old_done() actually requires io_request_lock;
perhaps Jens could comment on whether I've taken the lock in the
appropriate place?

With the appended patch I can confirm that the driver happily runs
`dbench 40' for half an hour on dual x86.   Even when you kick the
disk onto the floor (sorry, HJ).

The games which scsi_old_done() plays with spinlocks and interrupt
enabling are really foul.  If someone calls it with interrupts disabled
(sbp2 does this) then scsi_old_done() will enable interrupts for you.
If, for example, you call scsi_old_done() under spin_lock_irqsave(), 
the reenabling of interrupts will expose you to deadlocks.  Perhaps
scsi_old_done() should just use spin_unlock()/spin_lock()?

I tried enabling SBP2_USE_REAL_SPINLOCKS in sbp2.c and that appears to
work just fine, although I haven't left that change in place here.

You don't actually _need_ SMP hardware to test SMP code, BTW.  You
can just build an SMP kernel and run that on a uniprocessor box.
This will still catch a wide range of bugs - it certainly detects
the lockup which was occurring because of the scsi_old_done() thing.

Incidentally, it would be nice to be able to get this driver working
properly when linked into the kernel - it makes debugging much easier :)



--- linux-2.4.15-pre2/drivers/ieee1394/sbp2.c	Wed Oct 17 14:19:20 2001
+++ linux-akpm/drivers/ieee1394/sbp2.c	Sun Nov 11 17:22:47 2001
@@ -2767,7 +2767,9 @@ static void sbp2scsi_complete_command(st
 	/*
 	 * Tell scsi stack that we're done with this command
 	 */
+	spin_lock_irq(&io_request_lock);
 	done (SCpnt);
+	spin_unlock_irq(&io_request_lock);
 
 	return;
 }

-
