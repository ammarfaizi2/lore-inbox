Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbRADOVY>; Thu, 4 Jan 2001 09:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbRADOVP>; Thu, 4 Jan 2001 09:21:15 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:29678 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S129348AbRADOU5>; Thu, 4 Jan 2001 09:20:57 -0500
Date: Thu, 4 Jan 2001 14:20:43 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104142043.N23469@redhat.com>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104145229.E17640@athlon.random>; from andrea@suse.de on Thu, Jan 04, 2001 at 02:52:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 02:52:29PM +0100, Andrea Arcangeli wrote:

> I think lp_check_status.

Okay.  So what about this patch instead?  If the printer is off-line
to start with, fall into parport_write anyway (it will just time out
and return 0).  If LP_ABORT is set, we return -EAGAIN.

Tim.
*/

--- lp.c~	Thu Jan  4 11:04:30 2001
+++ lp.c	Thu Jan  4 14:16:42 2001
@@ -213,7 +213,7 @@
 			last = LP_PSELECD;
 			printk(KERN_INFO "lp%d off-line\n", minor);
 		}
-		error = -EIO;
+		error = -EAGAIN;
 	} else if (!(status & LP_PERRORP)) {
 		if (last != LP_PERRORP) {
 			last = LP_PERRORP;
@@ -270,8 +270,11 @@
 	parport_set_timeout (lp_table[minor].dev,
 			     lp_table[minor].timeout);
 
-	if ((retv = lp_check_status (minor)) == 0)
-	do {
+	retv = lp_check_status (minor);
+	if (retv == -EAGAIN && (LP_F(minor) & LP_ABORT) == 0)
+		retv = 0;
+
+	if (retv == 0) do {
 		/* Write the data. */
 		written = parport_write (port, kbuf, copy_size);
 		if (written >= 0) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
