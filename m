Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbRADTs1>; Thu, 4 Jan 2001 14:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132273AbRADTsI>; Thu, 4 Jan 2001 14:48:08 -0500
Received: from fep03.swip.net ([130.244.199.131]:10161 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S130198AbRADTsE>; Thu, 4 Jan 2001 14:48:04 -0500
To: Tim Waugh <twaugh@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random> <20010104142043.N23469@redhat.com> <20010104153910.A1507@athlon.random> <20010104145458.P23469@redhat.com>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 04 Jan 2001 20:45:56 +0100
In-Reply-To: Tim Waugh's message of "Thu, 4 Jan 2001 14:54:58 +0000"
Message-ID: <m2y9wrt823.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh <twaugh@redhat.com> writes:

> --8SdtHY/0P4yzaavF
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Thu, Jan 04, 2001 at 03:39:10PM +0100, Andrea Arcangeli wrote:
> 
> > As noted yesterday falling into parport_write will silenty lose data when the
> > printer is off.
> 
> (Actually it depends; I think FIFO/DMA paths are fine, but yes, the
> software implementation can lose data.)

On my printer (HP LJ4MP) if parport_write is called when the printer
is off, it will lose data even in DMA mode. I added printk's to verify
that when I'm sending a 176 byte file to /dev/lp0, it will be
transferred with one call to parport_pc_fifo_write_block_dma and
/proc/interrupts says that one new parport interrupt has arrived.

> > If it's not feasible to make parport_write reliable against
> > power-off printer, then I recommend to loop in interruptible mode
> > before entering the main loop (waiting the printer to power-on) like
> > in latest patch from Peter.
> 
> Have I missed a patch?  How do you know whether or not the printer is
> on yet?

[...]

> If this goes away:
> 
>         if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
>                 /* No error. */
>                 last = 0;
> 
> then some people might not be able to print at all.

OK, how about this patch then?

--- linux-2.4.0-prerelease/drivers/char/lp.c.orig	Wed Jan  3 18:48:39 2001
+++ linux-2.4.0-prerelease/drivers/char/lp.c	Thu Jan  4 20:34:24 2001
@@ -222,6 +222,21 @@
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
@@ -259,7 +274,7 @@
 	parport_set_timeout (lp_table[minor].dev,
 			     lp_table[minor].timeout);
 
-	if ((retv = lp_check_status (minor)) == 0)
+	if ((retv = lp_wait_ready (minor)) == 0)
 	do {
 		/* Write the data. */
 		written = parport_write (port, kbuf, copy_size);
@@ -279,9 +294,9 @@
 
 		if (copy_size > 0) {
 			/* incomplete write -> check error ! */
-			int error = lp_check_status (minor);
+			int error = lp_wait_ready (minor);
 
-			if (LP_F(minor) & LP_ABORT) {
+			if (error) {
 				if (retv == 0)
 					retv = error;
 				break;
--- linux-2.4.0-prerelease/drivers/parport/ieee1284.c.orig	Wed Jan  3 18:50:02 2001
+++ linux-2.4.0-prerelease/drivers/parport/ieee1284.c	Thu Jan  4 20:17:10 2001
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
+++ linux-2.4.0-prerelease/include/linux/lp.h	Thu Jan  4 20:14:17 2001
@@ -20,7 +20,7 @@
 #define LP_NOPA  0x0010
 #define LP_ERR   0x0020
 #define LP_ABORT 0x0040
-#define LP_CAREFUL 0x0080 /* obsoleted -arca */
+#define LP_CAREFUL 0x0080
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
