Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281006AbRKGWLr>; Wed, 7 Nov 2001 17:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281024AbRKGWLd>; Wed, 7 Nov 2001 17:11:33 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:57138 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281006AbRKGWLJ>; Wed, 7 Nov 2001 17:11:09 -0500
Date: Wed, 7 Nov 2001 17:11:10 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Patch for kernel.real-root-dev on s390
Message-ID: <20011107171110.B27100@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

what do you think about the attached patch. Without it,
a sysctl to kernel.real-root-dev corrupts adjacent memory.
Anyone cares to comment?

-- Pete

diff -ur -X dontdiff linux-2.4.9-13.1/drivers/block/rd.c linux-2.4.9-13.1pt1/drivers/block/rd.c
--- linux-2.4.9-13.1/drivers/block/rd.c	Tue Nov  6 19:19:21 2001
+++ linux-2.4.9-13.1pt1/drivers/block/rd.c	Tue Nov  6 23:43:49 2001
@@ -704,9 +704,6 @@
 
 static void __init rd_load_disk(int n)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
-	extern kdev_t real_root_dev;
-#endif
 
 	if (rd_doload == 0)
 		return;
diff -ur -X dontdiff linux-2.4.9-13.1/include/linux/fs.h linux-2.4.9-13.1pt1/include/linux/fs.h
--- linux-2.4.9-13.1/include/linux/fs.h	Tue Nov  6 19:19:10 2001
+++ linux-2.4.9-13.1pt1/include/linux/fs.h	Tue Nov  6 23:46:44 2001
@@ -1471,7 +1471,7 @@
 extern void mount_root(void);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-extern kdev_t real_root_dev;
+extern unsigned int real_root_dev;
 extern int change_root(kdev_t, const char *);
 #endif
 
diff -ur -X dontdiff linux-2.4.9-13.1/init/main.c linux-2.4.9-13.1pt1/init/main.c
--- linux-2.4.9-13.1/init/main.c	Tue Nov  6 19:19:19 2001
+++ linux-2.4.9-13.1pt1/init/main.c	Tue Nov  6 23:46:12 2001
@@ -126,7 +126,7 @@
 int rows, cols;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-kdev_t real_root_dev;
+unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 #endif
 
 int root_mountflags = MS_RDONLY;
