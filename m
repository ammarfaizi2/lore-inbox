Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUB1GpP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 01:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUB1GpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 01:45:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:24504 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261825AbUB1GpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 01:45:06 -0500
Date: Fri, 27 Feb 2004 22:44:50 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Robbins <drobbins@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Message-ID: <20040228064448.GB3040@kroah.com>
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com> <1077937052.14653.40.camel@wave.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077937052.14653.40.camel@wave.gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 07:57:32PM -0700, Daniel Robbins wrote:
> 
> With 2.6.3-bk9, I also had a block of two mainboard USB ports simply
> stop functioning -- to the point of even no longer sending power to the
> USB hub that I was using.

That's not good.  Are these real usb 2.0 printers?  Can you run them in
1.1 mode instead (just don't load the ehci-hcd driver)?

If that also fails, here's the only usblp patch in 2.6.3-bk9.  If you
revert it, does that solve the problem?

thanks,

greg k-h


diff -Nru a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
--- a/drivers/usb/class/usblp.c	Fri Feb 27 22:42:31 2004
+++ b/drivers/usb/class/usblp.c	Fri Feb 27 22:42:31 2004
@@ -603,7 +603,7 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct usblp *usblp = file->private_data;
-	int timeout, err = 0;
+	int timeout, err = 0, transfer_length;
 	size_t writecount = 0;
 
 	while (writecount < count) {
@@ -654,19 +654,13 @@
 			continue;
 		}
 
-		writecount += usblp->writeurb->transfer_buffer_length;
-		usblp->writeurb->transfer_buffer_length = 0;
+		transfer_length=(count - writecount);
+		if (transfer_length > USBLP_BUF_SIZE)
+			transfer_length = USBLP_BUF_SIZE;
 
-		if (writecount == count) {
-			up (&usblp->sem);
-			break;
-		}
+		usblp->writeurb->transfer_buffer_length = transfer_length;
 
-		usblp->writeurb->transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
-							  (count - writecount) : USBLP_BUF_SIZE;
-
-		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount,
-				usblp->writeurb->transfer_buffer_length)) {
+		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount, transfer_length)) {
 			up(&usblp->sem);
 			return writecount ? writecount : -EFAULT;
 		}
@@ -683,6 +677,8 @@
 			break;
 		}
 		up (&usblp->sem);
+
+		writecount += transfer_length;
 	}
 
 	return count;
