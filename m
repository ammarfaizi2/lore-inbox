Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRACTSC>; Wed, 3 Jan 2001 14:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRACTRx>; Wed, 3 Jan 2001 14:17:53 -0500
Received: from fep03.swip.net ([130.244.199.131]:28402 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S129742AbRACTRl>; Wed, 3 Jan 2001 14:17:41 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Printing to off-line printer in 2.4.0-prerelease
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 03 Jan 2001 19:44:19 +0100
Message-ID: <m2k88czda4.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When trying to print to an off-line printer with 2.4 kernels, the
"write" system call to /dev/lp0 stalls for 10 seconds and then returns
EIO.  This has the unfortunate effect that the printout will be lost,
because the redhat print filters (in rh7) use "cat" to send data to
the printer device, and cat gives up when EIO is returned.

In 2.2 kernels, the write call waited until the printer went on-line
again.

I think the problem is that the lp_write() function in lp.c calls
lp_check_status() before starting to write to the parport, and if the
printer is not ready, it simply gives up. (The LP_ABORT flag is not
used in that case.)

The following patch makes things work for me again. The kernel keeps
generating the following debug messages until the printer becomes
ready, but that doesn't seem to cause any problems.

  Jan  3 18:54:27 ppro kernel: DMA write timed out
  Jan  3 18:54:37 ppro kernel: parport0: FIFO is stuck
  Jan  3 18:54:37 ppro kernel: parport0: BUSY timeout (1) in compat_write_block_pio
  Jan  3 18:54:37 ppro kernel: lp0 off-line

Is there a better way to fix this problem?

--- linux-2.4.0-prerelease/drivers/char/lp.c.orig	Wed Jan  3 18:48:39 2001
+++ linux-2.4.0-prerelease/drivers/char/lp.c	Wed Jan  3 18:48:42 2001
@@ -259,7 +259,6 @@
 	parport_set_timeout (lp_table[minor].dev,
 			     lp_table[minor].timeout);
 
-	if ((retv = lp_check_status (minor)) == 0)
 	do {
 		/* Write the data. */
 		written = parport_write (port, kbuf, copy_size);

--- linux-2.4.0-prerelease/drivers/parport/ieee1284.c.orig	Wed Jan  3 18:50:02 2001
+++ linux-2.4.0-prerelease/drivers/parport/ieee1284.c	Wed Jan  3 18:50:16 2001
@@ -524,7 +524,8 @@
 					     PARPORT_STATUS_PAPEROUT,
 					     PARPORT_STATUS_PAPEROUT);
 		if (r)
-			DPRINTK (KERN_INFO "%s: Timeout at event 31\n");
+			DPRINTK (KERN_INFO "%s: Timeout at event 31\n",
+				 port->name);
 
 		port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 		DPRINTK (KERN_DEBUG "%s: ECP direction: forward\n",

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
