Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACVC2>; Wed, 3 Jan 2001 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACVCT>; Wed, 3 Jan 2001 16:02:19 -0500
Received: from fep03.swip.net ([130.244.199.131]:39585 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S129267AbRACVCJ>; Wed, 3 Jan 2001 16:02:09 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org, linux-parport@torque.net,
        tim@cyberelk.demon.co.uk
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010103201344.A3203@athlon.random>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 03 Jan 2001 22:00:59 +0100
In-Reply-To: Andrea Arcangeli's message of "Wed, 3 Jan 2001 20:13:44 +0100"
Message-ID: <m2hf3gz6yc.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Wed, Jan 03, 2001 at 07:44:19PM +0100, Peter Osterlund wrote:
> > Is there a better way to fix this problem?
> 
> It looks the simpler fix to me (main loop needs someway to handle errors
> anyways) but ask Tim too.
> 
> Another way to fix it is to loop in interruptible mode inside lp_error waiting
> the error to go away.

I didn't give my previous patch enough testing. It still doesn't work
if I queue a print job when my printer (HP LaserJet 4MP) is powered
off.  Apparently the printer tells the computer it is OK to send data
to it when it is off.

Anyway, this new patch works for all tests I could think of. I tested
with the printer initially powered off, initially powered on but in
offline mode and initially powered on and in online mode. It also
works if I put the printer in offline mode during sending of a print
job. (tunelp -a and -o also work as expected.)

I also only get one DMA write timeout when putting the printer in
offline mode during sending, instead of repeated timeouts as I got
with the previous patch.

Here is the new patch:

--- linux-2.4.0-prerelease/drivers/char/lp.c.orig	Wed Jan  3 18:48:39 2001
+++ linux-2.4.0-prerelease/drivers/char/lp.c	Wed Jan  3 21:41:31 2001
@@ -231,6 +231,7 @@
 	ssize_t retv = 0;
 	ssize_t written;
 	size_t copy_size = count;
+	int check_status;
 
 #ifdef LP_STATS
 	if (jiffies-lp_table[minor].lastcall > LP_TIME(minor))
@@ -259,10 +260,26 @@
 	parport_set_timeout (lp_table[minor].dev,
 			     lp_table[minor].timeout);
 
-	if ((retv = lp_check_status (minor)) == 0)
+	check_status = 1;
 	do {
-		/* Write the data. */
-		written = parport_write (port, kbuf, copy_size);
+		int error = 0;
+		if (check_status) {
+			error = lp_check_status (minor);
+			if (error) {
+				if (LP_F(minor) & LP_ABORT) {
+					if (retv == 0)
+						retv = error;
+					break;
+				}
+				parport_yield_blocking (lp_table[minor].dev);
+			}
+			check_status = 0;
+		}
+		if (error == 0)
+			/* Write the data. */
+			written = parport_write (port, kbuf, copy_size);
+		else
+			written = 0;
 		if (written >= 0) {
 			copy_size -= written;
 			count -= written;
@@ -279,15 +296,7 @@
 
 		if (copy_size > 0) {
 			/* incomplete write -> check error ! */
-			int error = lp_check_status (minor);
-
-			if (LP_F(minor) & LP_ABORT) {
-				if (retv == 0)
-					retv = error;
-				break;
-			}
-
-			parport_yield_blocking (lp_table[minor].dev);
+			check_status = 1;
 		} else if (current->need_resched)
 			schedule ();
 
--- linux-2.4.0-prerelease/drivers/parport/ieee1284.c.orig	Wed Jan  3 18:50:02 2001
+++ linux-2.4.0-prerelease/drivers/parport/ieee1284.c	Wed Jan  3 21:32:28 2001
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
