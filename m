Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313170AbSDDOD2>; Thu, 4 Apr 2002 09:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDDODW>; Thu, 4 Apr 2002 09:03:22 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:44201 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S313170AbSDDODI>; Thu, 4 Apr 2002 09:03:08 -0500
Date: Thu, 4 Apr 2002 16:03:05 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kraxel@bytesex.org
Subject: [PATCH 2.5.8-pre1] motioneye video driver
Message-ID: <20020404140305.GH9820@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kraxel@bytesex.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.8-pre1 'video_generic_ioctl' has gone, replaced by 
'video_generic_ioctl'. However, no video driver has been
updated to use the new API.

The Gerd's patches from http://bytesex.org/patches/2.5/
must be applied.

Attached is the motioneye driver patch only, which I can
confirm it works properly.

Stelian.

===== drivers/media/video/meye.c 1.9 vs edited =====
--- 1.9/drivers/media/video/meye.c	Thu Mar 14 17:16:34 2002
+++ edited/drivers/media/video/meye.c	Thu Apr  4 11:08:17 2002
@@ -893,8 +893,8 @@
 	return 0;
 }
 
-static int meye_ioctl(struct inode *inode, struct file *file,
-		      unsigned int cmd, void *arg) {
+static int meye_do_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, void *arg) {
 
 	switch (cmd) {
 
@@ -1169,6 +1169,12 @@
 	return 0;
 }
 
+static int meye_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, meye_do_ioctl);
+}
+
 static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
 	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end - vma->vm_start;
@@ -1209,7 +1215,7 @@
 	open:		meye_open,
 	release:	meye_release,
 	mmap:		meye_mmap,
-	ioctl:		video_generic_ioctl,
+	ioctl:		meye_ioctl,
 	llseek:		no_llseek,
 };
 
@@ -1219,7 +1225,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_MEYE,
 	fops:		&meye_fops,
-	kernel_ioctl:	meye_ioctl,
 };
 
 static int __devinit meye_probe(struct pci_dev *pcidev, 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
