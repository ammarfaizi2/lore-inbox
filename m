Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUFVTI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUFVTI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbUFVSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:19:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:17077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265041AbUFVRnL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:11 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261133723@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:53 -0700
Message-Id: <10879261132464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1825, 2004/06/22 09:20:30-07:00, greg@kroah.com

[PATCH] USB: sparse fixups for devio.c


 drivers/usb/core/devio.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Tue Jun 22 09:46:22 2004
+++ b/drivers/usb/core/devio.c	Tue Jun 22 09:46:22 2004
@@ -290,8 +290,11 @@
 		spin_lock_irqsave(&ps->lock, flags);
 	}
 	spin_unlock_irqrestore(&ps->lock, flags);
-	while ((as = async_getcompleted(ps)))
+	as = async_getcompleted(ps);
+	while (as) {
 		free_async(as);
+		as = async_getcompleted(ps);
+	}
 }
 
 static void destroy_async_on_interface (struct dev_state *ps, unsigned int ifnum)
@@ -968,29 +971,27 @@
 static int processcompl(struct async *as)
 {
 	struct urb *urb = as->urb;
+	struct usbdevfs_urb __user *userurb = as->userurb;
 	unsigned int i;
 
 	if (as->userbuffer)
 		if (copy_to_user(as->userbuffer, urb->transfer_buffer, urb->transfer_buffer_length))
 			return -EFAULT;
-	if (put_user(urb->status,
-		     &((struct usbdevfs_urb *)as->userurb)->status))
+	if (put_user(urb->status, &userurb->status))
 		return -EFAULT;
-	if (put_user(urb->actual_length,
-		     &((struct usbdevfs_urb *)as->userurb)->actual_length))
+	if (put_user(urb->actual_length, &userurb->actual_length))
 		return -EFAULT;
-	if (put_user(urb->error_count,
-		     &((struct usbdevfs_urb *)as->userurb)->error_count))
+	if (put_user(urb->error_count, &userurb->error_count))
 		return -EFAULT;
 
 	if (!(usb_pipeisoc(urb->pipe)))
 		return 0;
 	for (i = 0; i < urb->number_of_packets; i++) {
 		if (put_user(urb->iso_frame_desc[i].actual_length,
-			     &((struct usbdevfs_urb *)as->userurb)->iso_frame_desc[i].actual_length))
+			     &userurb->iso_frame_desc[i].actual_length))
 			return -EFAULT;
 		if (put_user(urb->iso_frame_desc[i].status,
-			     &((struct usbdevfs_urb *)as->userurb)->iso_frame_desc[i].status))
+			     &userurb->iso_frame_desc[i].status))
 			return -EFAULT;
 	}
 	return 0;

