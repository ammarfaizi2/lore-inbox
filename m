Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVCaD6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVCaD6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCaD6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:58:41 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:18307 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262490AbVCaD6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:58:36 -0500
Date: Wed, 30 Mar 2005 19:51:23 -0500
From: Christopher Li <chrisl@vmware.com>
To: linux kernel mail list <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Greg K-H <greg@kroah.com>
Subject: [patch] bug fix in usbdevfs
Message-ID: <20050331005123.GA541@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sorry that the last patch about 32 bit compat ioctl on
64 bit kernel actually breaks the usbdevfs. That is on the current
BK tree. I am retarded. 

Here is the patch to fix it. Tested with USB hard disk and webcam
in both 32bit compatible mode and native 64bit mode.

Again, sorry about that.

Chris


Index: linux-2.5/drivers/usb/core/devio.c
===================================================================
--- linux-2.5.orig/drivers/usb/core/devio.c	2005-03-30 18:19:50.000000000 -0800
+++ linux-2.5/drivers/usb/core/devio.c	2005-03-30 19:35:31.000000000 -0800
@@ -1032,15 +1032,15 @@
 	if (put_user(urb->error_count, &userurb->error_count))
 		return -EFAULT;
 
-	if (!(usb_pipeisoc(urb->pipe)))
-		return 0;
-	for (i = 0; i < urb->number_of_packets; i++) {
-		if (put_user(urb->iso_frame_desc[i].actual_length,
-			     &userurb->iso_frame_desc[i].actual_length))
-			return -EFAULT;
-		if (put_user(urb->iso_frame_desc[i].status,
-			     &userurb->iso_frame_desc[i].status))
-			return -EFAULT;
+	if (usb_pipeisoc(urb->pipe)) {
+		for (i = 0; i < urb->number_of_packets; i++) {
+			if (put_user(urb->iso_frame_desc[i].actual_length,
+				     &userurb->iso_frame_desc[i].actual_length))
+				return -EFAULT;
+			if (put_user(urb->iso_frame_desc[i].status,
+				     &userurb->iso_frame_desc[i].status))
+				return -EFAULT;
+		}
 	}
 
 	free_async(as);
@@ -1126,7 +1126,7 @@
 	if (get_urb32(&uurb,(struct usbdevfs_urb32 *)arg))
 		return -EFAULT;
 
-	return proc_do_submiturb(ps, &uurb, ((struct usbdevfs_urb __user *)arg)->iso_frame_desc, arg);
+	return proc_do_submiturb(ps, &uurb, ((struct usbdevfs_urb32 __user *)arg)->iso_frame_desc, arg);
 }
 
 static int processcompl_compat(struct async *as, void __user * __user *arg)
@@ -1146,15 +1146,15 @@
 	if (put_user(urb->error_count, &userurb->error_count))
 		return -EFAULT;
 
-	if (!(usb_pipeisoc(urb->pipe)))
-		return 0;
-	for (i = 0; i < urb->number_of_packets; i++) {
-		if (put_user(urb->iso_frame_desc[i].actual_length,
-			     &userurb->iso_frame_desc[i].actual_length))
-			return -EFAULT;
-		if (put_user(urb->iso_frame_desc[i].status,
-			     &userurb->iso_frame_desc[i].status))
-			return -EFAULT;
+	if (usb_pipeisoc(urb->pipe)) {
+		for (i = 0; i < urb->number_of_packets; i++) {
+			if (put_user(urb->iso_frame_desc[i].actual_length,
+				     &userurb->iso_frame_desc[i].actual_length))
+				return -EFAULT;
+			if (put_user(urb->iso_frame_desc[i].status,
+				     &userurb->iso_frame_desc[i].status))
+				return -EFAULT;
+		}
 	}
 
 	free_async(as);
@@ -1177,10 +1177,8 @@
 {
 	struct async *as;
 
-	printk("reapurbnblock\n");
 	if (!(as = async_getcompleted(ps)))
 		return -EAGAIN;
-	printk("reap got as %p\n", as);
 	return processcompl_compat(as, (void __user * __user *)arg);
 }
 
