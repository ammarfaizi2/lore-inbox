Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTJHNf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbTJHNew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:34:52 -0400
Received: from mail.convergence.de ([212.84.236.4]:7137 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261518AbTJHN24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:56 -0400
Subject: [PATCH 5/14] multiple device *read* opens support
In-Reply-To: <1065619733417@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:53 +0200
Message-Id: <1065619733696@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] allow multiple read device opens
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h	2003-08-25 12:16:12.000000000 +0200
@@ -55,12 +58,18 @@
 struct dvb_device {
 	struct list_head list_head;
 	struct file_operations *fops;
+ 
+ 
+ 
 	struct dvb_adapter *adapter;
 	int type;
 	u32 id;
 
-	int users;
+	/* in theory, 'users' can vanish now,
+	   but I don't want to change too much now... */
+	int readers;
 	int writers;
+	int users;
 
         /* don't really need those !? -- FIXME: use video_usercopy  */
         int (*kernel_ioctl)(struct inode *inode, struct file *file,
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.c linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.c	2003-09-10 11:29:20.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.c	2003-08-21 10:53:19.000000000 +0200
@@ -112,7 +121,11 @@
 	if (!dvbdev->users)
                 return -EBUSY;
 
-	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
+	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
+                if (!dvbdev->readers)
+		        return -EBUSY;
+		dvbdev->readers--;
+	} else {
                 if (!dvbdev->writers)
 		        return -EBUSY;
 		dvbdev->writers--;
@@ -130,8 +143,11 @@
 	if (!dvbdev)
                 return -ENODEV;
 
-	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
+	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
+		dvbdev->readers++;
+	} else {
 		dvbdev->writers++;
+	}
 
 	dvbdev->users++;
 	return 0;
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-09-09 09:24:21.000000000 +0200
@@ -870,6 +886,7 @@
 	static const struct dvb_device dvbdev_template = {
 		.users = ~0,
 		.writers = 1,
+		.readers = (~0)-1,
 		.fops = &dvb_frontend_fops,
 		.kernel_ioctl = dvb_frontend_ioctl
 	};


