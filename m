Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992836AbWJTTCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992836AbWJTTCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992829AbWJTTCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:02:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29616 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S2992828AbWJTTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:02:07 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 20 Oct 2006 21:01:58 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] dv1394: remove BKL contention
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.8f1902e45fb313b4@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Purges the one remaining call to lock_kernel() from the 1394 subsystem.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/dv1394.c
===================================================================
--- linux.orig/drivers/ieee1394/dv1394.c	2006-10-20 20:54:33.000000000 +0200
+++ linux/drivers/ieee1394/dv1394.c	2006-10-20 20:55:03.000000000 +0200
@@ -1536,27 +1536,20 @@ static ssize_t dv1394_read(struct file *
 
 static long dv1394_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct video_card *video;
+	struct video_card *video = file_to_video_card(file);
 	unsigned long flags;
 	int ret = -EINVAL;
 	void __user *argp = (void __user *)arg;
 
 	DECLARE_WAITQUEUE(wait, current);
 
-	lock_kernel();
-	video = file_to_video_card(file);
-
 	/* serialize this to prevent multi-threaded mayhem */
 	if (file->f_flags & O_NONBLOCK) {
-		if (!mutex_trylock(&video->mtx)) {
-			unlock_kernel();
+		if (!mutex_trylock(&video->mtx))
 			return -EAGAIN;
-		}
 	} else {
-		if (mutex_lock_interruptible(&video->mtx)) {
-			unlock_kernel();
+		if (mutex_lock_interruptible(&video->mtx))
 			return -ERESTARTSYS;
-		}
 	}
 
 	switch(cmd)
@@ -1780,7 +1773,6 @@ static long dv1394_ioctl(struct file *fi
 
  out:
 	mutex_unlock(&video->mtx);
-	unlock_kernel();
 	return ret;
 }
 


