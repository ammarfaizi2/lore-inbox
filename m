Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131919AbRADAKm>; Wed, 3 Jan 2001 19:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbRADAKb>; Wed, 3 Jan 2001 19:10:31 -0500
Received: from fep03.swip.net ([130.244.199.131]:37335 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S131919AbRADAKS>; Wed, 3 Jan 2001 19:10:18 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-parport@torque.net,
        tim@cyberelk.demon.co.uk
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010103201344.A3203@athlon.random> <m2hf3gz6yc.fsf@ppro.localdomain> <20010103223504.L32185@athlon.random>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 04 Jan 2001 01:08:01 +0100
In-Reply-To: Andrea Arcangeli's message of "Wed, 3 Jan 2001 22:35:04 +0100"
Message-ID: <m266jww55q.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Wed, Jan 03, 2001 at 10:00:59PM +0100, Peter Osterlund wrote:
> > off.  Apparently the printer tells the computer it is OK to send data
> > to it when it is off.
> 
> So then parport_write is probably buggy because it's losing data silenty while
> the printer is off. So the below is probably a band aid. Really some printer
> acts in a different way (see the LP_CAREFUL hack in 2.2.x) so it maybe that
> parport_write is ok on some printer and it would need something like a
> LP_CAREFUL option to work also on some other printer. Or maybe some parport
> handshake is badly designed in hardware and it cannot report errors (or maybe
> there's the hardware compatibility mode that cannot know about LP_CAREFUL to
> workaround some printer behaviour). In such case your patch is probably the
> only way to go (but almost certainly for the software compatibility mode it
> should be possible to report errors via parport_write as we do in 2.2.x).

The tunelp man-page seems to think there are printers that need the
LP_CAREFUL handling. I also noted that if I disconnect my printer from
the computer, the data will no longer be lost. Apparently the printer
confuses the parallel port when it is powered off.

> > I also only get one DMA write timeout when putting the printer in
> > offline mode during sending, instead of repeated timeouts as I got
> > with the previous patch.
> 
> I see, it makes sense to try to parport_write only when errors goes away, but I
> think it's nicer to have lp_error or lp_check_status that loops internally in
> interruptible mode if LP_ABORT isn't set via lptune. probably the code should
> be restructured a bit.

What do you think about the following patch? It also works for all the
tests mentioned in my previous message.

--- linux-2.4.0-prerelease/drivers/char/lp.c.orig	Wed Jan  3 18:48:39 2001
+++ linux-2.4.0-prerelease/drivers/char/lp.c	Thu Jan  4 00:45:52 2001
@@ -188,10 +188,7 @@
 	int error = 0;
 	unsigned int last = lp_table[minor].last_error;
 	unsigned char status = r_str(minor);
-	if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
-		/* No error. */
-		last = 0;
-	else if ((status & LP_POUTPA)) {
+	if ((status & LP_POUTPA)) {
 		if (last != LP_POUTPA) {
 			last = LP_POUTPA;
 			printk(KERN_INFO "lp%d out of paper\n", minor);
@@ -210,8 +207,7 @@
 		}
 		error = -EIO;
 	} else {
-		last = 0; /* Come here if LP_CAREFUL is set and no
-                             errors are reported. */
+		last = 0; /* Come here if no errors are reported. */
 	}
 
 	lp_table[minor].last_error = last;
@@ -222,6 +218,21 @@
 	return error;
 }
 
+static int lp_wait_ready(int minor)
+{
+	int error = 0;
+	do {
+		error = lp_check_status (minor);
+		if (error && (LP_F(minor) & LP_ABORT))
+			break;
+		if (signal_pending (current)) {
+			error = -EINTR;
+			break;
+		}
+	} while (error);
+	return error;
+}
+
 static ssize_t lp_write(struct file * file, const char * buf,
 		        size_t count, loff_t *ppos)
 {
@@ -259,7 +270,7 @@
 	parport_set_timeout (lp_table[minor].dev,
 			     lp_table[minor].timeout);
 
-	if ((retv = lp_check_status (minor)) == 0)
+	if ((retv = lp_wait_ready (minor)) == 0)
 	do {
 		/* Write the data. */
 		written = parport_write (port, kbuf, copy_size);
@@ -279,9 +290,9 @@
 
 		if (copy_size > 0) {
 			/* incomplete write -> check error ! */
-			int error = lp_check_status (minor);
+			int error = lp_wait_ready (minor);
 
-			if (LP_F(minor) & LP_ABORT) {
+			if (error) {
 				if (retv == 0)
 					retv = error;
 				break;
@@ -453,10 +464,7 @@
 				LP_F(minor) &= ~LP_ABORTOPEN;
 			break;
 		case LPCAREFUL:
-			if (arg)
-				LP_F(minor) |= LP_CAREFUL;
-			else
-				LP_F(minor) &= ~LP_CAREFUL;
+			/* Obsolete */
 			break;
 		case LPWAIT:
 			LP_WAIT(minor) = arg;
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
--- linux-2.4.0-prerelease/include/linux/lp.h.orig	Thu Jan  4 00:21:15 2001
+++ linux-2.4.0-prerelease/include/linux/lp.h	Thu Jan  4 00:21:21 2001
@@ -20,7 +20,6 @@
 #define LP_NOPA  0x0010
 #define LP_ERR   0x0020
 #define LP_ABORT 0x0040
-#define LP_CAREFUL 0x0080 /* obsoleted -arca */
 #define LP_ABORTOPEN 0x0100
 
 #define LP_TRUST_IRQ_  0x0200 /* obsolete */

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
