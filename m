Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVD0Kvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVD0Kvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVD0Kvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:51:41 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:7880 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261402AbVD0KvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:51:21 -0400
Date: Wed, 27 Apr 2005 12:34:20 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC]: {COMPATIBLE/HANDLE}_IOCTL for EXT3_IOC_GROUP_{EXTEND,ADD}
Message-ID: <20050427103420.GA19711@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm resending this with a less broken subject (which resulted from a
forwarded message):

I need the following patch to make ext3 online resizing work with
linux 2.6.11.6 on amd64 with a 32bit userland. Do the changes look o.k.?

I converted everything to ext3 since it should implement the calls for
ext2 in a compatible way and we only have to include ext3 headers then.
The COMPATIBLE_IOCTL() should probably into compat_ioctl.h, I'll send an
updated version in case these changes look ok.
Cheers,
 -- Guido

--- linux-2.6.11.6/fs/compat_ioctl.c.orig	2005-04-21 11:06:23.000000000 +0200
+++ linux-2.6.11.6/fs/compat_ioctl.c	2005-04-21 11:06:07.000000000 +0200
@@ -48,7 +48,8 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/fb.h>
-#include <linux/ext2_fs.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
 #include <linux/videodev.h>
 #include <linux/netdevice.h>
 #include <linux/raw.h>
@@ -127,10 +127,13 @@
 #ifdef CODE
 
 /* Aiee. Someone does not find a difference between int and long */
-#define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
-#define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
-#define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
-#define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
+#define EXT3_IOC32_GETFLAGS               _IOR('f', 1, int)
+#define EXT3_IOC32_SETFLAGS               _IOW('f', 2, int)
+#define EXT3_IOC32_GETVERSION             _IOR('f', 3, int)
+#define EXT3_IOC32_SETVERSION             _IOW('f', 4, int)
+#define EXT3_IOC32_GROUP_EXTEND           _IOW('f', 7, unsigned int)
+#define EXT3_IOC32_GETVERSION_OLD         _IOR('v', 1, int)
+#define EXT3_IOC32_SETVERSION_OLD         _IOW('v', 2, int)
 
 static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -163,14 +166,17 @@
 	return err;
 }
 
-static int do_ext2_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_ext3_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
-	case EXT2_IOC32_GETFLAGS: cmd = EXT2_IOC_GETFLAGS; break;
-	case EXT2_IOC32_SETFLAGS: cmd = EXT2_IOC_SETFLAGS; break;
-	case EXT2_IOC32_GETVERSION: cmd = EXT2_IOC_GETVERSION; break;
-	case EXT2_IOC32_SETVERSION: cmd = EXT2_IOC_SETVERSION; break;
+	case EXT3_IOC32_GETFLAGS: cmd = EXT3_IOC_GETFLAGS; break;
+	case EXT3_IOC32_SETFLAGS: cmd = EXT3_IOC_SETFLAGS; break;
+	case EXT3_IOC32_GETVERSION: cmd = EXT3_IOC_GETVERSION; break;
+	case EXT3_IOC32_SETVERSION: cmd = EXT3_IOC_SETVERSION; break;
+	case EXT3_IOC32_GROUP_EXTEND: cmd= EXT3_IOC_GROUP_EXTEND; break;
+	case EXT3_IOC32_GETVERSION_OLD: cmd = EXT3_IOC_GETVERSION_OLD; break;
+	case EXT3_IOC32_SETVERSION_OLD: cmd = EXT3_IOC_SETVERSION_OLD; break;
 	}
 	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
 }
@@ -3274,10 +3280,12 @@
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
 #endif
-HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
-HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
+HANDLE_IOCTL(EXT3_IOC32_GETFLAGS, do_ext3_ioctl)
+HANDLE_IOCTL(EXT3_IOC32_SETFLAGS, do_ext3_ioctl)
+HANDLE_IOCTL(EXT3_IOC32_GETVERSION, do_ext3_ioctl)
+HANDLE_IOCTL(EXT3_IOC32_SETVERSION, do_ext3_ioctl)
+HANDLE_IOCTL(EXT3_IOC32_GROUP_EXTEND, do_ext3_ioctl)
+COMPATIBLE_IOCTL(EXT3_IOC_GROUP_ADD)
 HANDLE_IOCTL(VIDIOCGTUNER32, do_video_ioctl)
 HANDLE_IOCTL(VIDIOCSTUNER32, do_video_ioctl)
 HANDLE_IOCTL(VIDIOCGWIN32, do_video_ioctl)

Cheers,
 -- Guido

