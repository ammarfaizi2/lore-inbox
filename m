Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADVwc>; Thu, 4 Jan 2001 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbRADVwX>; Thu, 4 Jan 2001 16:52:23 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:12532 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S129183AbRADVwR>; Thu, 4 Jan 2001 16:52:17 -0500
Date: Thu, 4 Jan 2001 21:52:10 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104215210.D1148@redhat.com>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random> <20010104142043.N23469@redhat.com> <m21yujuoew.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m21yujuoew.fsf@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Thu, Jan 04, 2001 at 08:07:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 08:07:19PM +0100, Peter Osterlund wrote:

> If you do this, you should probably also return -EAGAIN if the printer
> is out of paper, otherwise I would still lose data when the printer
> goes out of paper. Currently it returns -ENOSPC in this situation. I
> suppose the different return codes were meant as a way for user space
> to be able to know why printing failed, so that it could take
> appropriate actions, but maybe this is not used by any programs.

They were intended for that, yes, but it's probably better to stick
with the 2.2 return codes.  Here's a patch to do that.  Look okay?

Tim.
*/

2001-01-04  Tim Waugh  <twaugh@redhat.com>

	* drivers/char/lp.c: Follow 2.2 behaviour more closely.

--- linux-2.4.0-prerelease/drivers/char/lp.c.offline	Thu Jan  4 21:13:02 2001
+++ linux-2.4.0-prerelease/drivers/char/lp.c	Thu Jan  4 21:42:19 2001
@@ -207,7 +207,7 @@
 			last = LP_POUTPA;
 			printk(KERN_INFO "lp%d out of paper\n", minor);
 		}
-		error = -ENOSPC;
+		error = -EIO;
 	} else if (!(status & LP_PSELECD)) {
 		if (last != LP_PSELECD) {
 			last = LP_PSELECD;
@@ -230,7 +230,10 @@
 	if (last != 0)
 		lp_error(minor);
 
-	return error;
+	if (LP_F (minor) & LP_ABORT)
+		return error;
+
+	return 0;
 }
 
 static ssize_t lp_write(struct file * file, const char * buf,
@@ -292,7 +295,7 @@
 			/* incomplete write -> check error ! */
 			int error = lp_check_status (minor);
 
-			if (LP_F(minor) & LP_ABORT) {
+			if (error) {
 				if (retv == 0)
 					retv = error;
 				break;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
