Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbUKDLVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbUKDLVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbUKDLUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:20:18 -0500
Received: from sd291.sivit.org ([194.146.225.122]:15321 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262167AbUKDLPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:15:06 -0500
Date: Thu, 4 Nov 2004 12:15:19 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/12] meye: implement non blocking access using poll()
Message-ID: <20041104111519.GK3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2344, 2004-11-02 15:54:01+01:00, stelian@popies.net
  meye: implement non blocking access using poll()
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:25:29 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:25:29 +01:00
@@ -937,6 +937,10 @@
 			up(&meye.lock);
 			return -EINVAL;
 		case MEYE_BUF_USING:
+			if (file->f_flags & O_NONBLOCK) {
+				up(&meye.lock);
+				return -EAGAIN;
+			}
 			if (wait_event_interruptible(meye.proc_list,
 						     (meye.grab_buffer[*i].state != MEYE_BUF_USING))) {
 				up(&meye.lock);
@@ -1072,6 +1076,10 @@
 			up(&meye.lock);
 			return -EINVAL;
 		case MEYE_BUF_USING:
+			if (file->f_flags & O_NONBLOCK) {
+				up(&meye.lock);
+				return -EAGAIN;
+			}
 			if (wait_event_interruptible(meye.proc_list,
 						     (meye.grab_buffer[*i].state != MEYE_BUF_USING))) {
 				up(&meye.lock);
@@ -1137,6 +1145,18 @@
 	return video_usercopy(inode, file, cmd, arg, meye_do_ioctl);
 }
 
+static unsigned int meye_poll(struct file *file, poll_table *wait)
+{
+	unsigned int res = 0;
+
+	down(&meye.lock);
+	poll_wait(file, &meye.proc_list, wait);
+	if (kfifo_len(meye.doneq))
+		res = POLLIN | POLLRDNORM;
+	up(&meye.lock);
+	return res;
+}
+
 static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
 	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end - vma->vm_start;
@@ -1178,6 +1198,7 @@
 	.release	= meye_release,
 	.mmap		= meye_mmap,
 	.ioctl		= meye_ioctl,
+	.poll		= meye_poll,
 	.llseek		= no_llseek,
 };
 
