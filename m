Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272453AbTGaKwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272980AbTGaKvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:51:43 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:63236 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272976AbTGaKui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:50:38 -0400
Date: Thu, 31 Jul 2003 11:50:37 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 4/6] dm: 64 bit ioctl fixes
Message-ID: <20030731105037.GH394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ioctl32 handlers for the 64-bit architectures to recognize
the new Device-Mapper version 4 ioctls. The version 1 ioctls are still
there.  If/When the version 1 ioctls are removed, these same files
will need to be updated again.

I have been unable to test this patch yet, since I have not had any
luck getting 2.6.0-test2 to compile on my ppc64 box (not a dm-related
problem).  But the patch is pretty trivial, so I'm pretty confident it
will work. If anyone else can test this (on mips64, sparc64, parisc,
or x86-64), let me know if you have any problems.  [Kevin Corry]


--- diff/arch/mips64/kernel/ioctl32.c	2003-07-08 09:55:18.000000000 +0100
+++ source/arch/mips64/kernel/ioctl32.c	2003-07-31 11:13:30.000000000 +0100
@@ -1154,6 +1154,21 @@
 #endif /* CONFIG_SIBYTE_TBPROF */
 
 #if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+	#if defined(CONFIG_DM_IOCTL_V4)
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_LIST_DEVICES),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_DEV_WAIT),
+	IOCTL32_DEFAULT(DM_TABLE_LOAD),
+	IOCTL32_DEFAULT(DM_TABLE_CLEAR),
+	IOCTL32_DEFAULT(DM_TABLE_DEPS),
+	IOCTL32_DEFAULT(DM_TABLE_STATUS),
+	#else
 	IOCTL32_DEFAULT(DM_VERSION),
 	IOCTL32_DEFAULT(DM_REMOVE_ALL),
 	IOCTL32_DEFAULT(DM_DEV_CREATE),
@@ -1165,6 +1180,7 @@
 	IOCTL32_DEFAULT(DM_DEV_STATUS),
 	IOCTL32_DEFAULT(DM_TARGET_STATUS),
 	IOCTL32_DEFAULT(DM_TARGET_WAIT),
+	#endif
 #endif /* CONFIG_BLK_DEV_DM */
 
 COMPATIBLE_IOCTL(MTIOCTOP)			/* mtio.h ioctls  */
--- diff/arch/sparc64/kernel/ioctl32.c	2003-06-30 10:07:20.000000000 +0100
+++ source/arch/sparc64/kernel/ioctl32.c	2003-07-31 11:13:30.000000000 +0100
@@ -1546,6 +1546,21 @@
 COMPATIBLE_IOCTL(BNEPGETCONNLIST)
 COMPATIBLE_IOCTL(BNEPGETCONNINFO)
 /* device-mapper */
+#if defined(CONFIG_DM_IOCTL_V4)
+COMPATIBLE_IOCTL(DM_VERSION)
+COMPATIBLE_IOCTL(DM_REMOVE_ALL)
+COMPATIBLE_IOCTL(DM_LIST_DEVICES)
+COMPATIBLE_IOCTL(DM_DEV_CREATE)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE)
+COMPATIBLE_IOCTL(DM_DEV_RENAME)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
+COMPATIBLE_IOCTL(DM_DEV_STATUS)
+COMPATIBLE_IOCTL(DM_DEV_WAIT)
+COMPATIBLE_IOCTL(DM_TABLE_LOAD)
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR)
+COMPATIBLE_IOCTL(DM_TABLE_DEPS)
+COMPATIBLE_IOCTL(DM_TABLE_STATUS)
+#else
 COMPATIBLE_IOCTL(DM_VERSION)
 COMPATIBLE_IOCTL(DM_REMOVE_ALL)
 COMPATIBLE_IOCTL(DM_DEV_CREATE)
@@ -1557,6 +1572,7 @@
 COMPATIBLE_IOCTL(DM_DEV_STATUS)
 COMPATIBLE_IOCTL(DM_TARGET_STATUS)
 COMPATIBLE_IOCTL(DM_TARGET_WAIT)
+#endif
 /* And these ioctls need translation */
 HANDLE_IOCTL(HDIO_GETGEO_BIG_RAW, hdio_getgeo_big)
 /* NCPFS */
--- diff/include/linux/compat_ioctl.h	2003-07-11 09:39:50.000000000 +0100
+++ source/include/linux/compat_ioctl.h	2003-07-31 11:13:30.000000000 +0100
@@ -119,6 +119,20 @@
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)
 #ifdef CONFIG_BLK_DEV_DM
 /* DM */
+#ifdef CONFIG_DM_IOCTL_V4
+COMPATIBLE_IOCTL(DM_VERSION)
+COMPATIBLE_IOCTL(DM_LIST_DEVICES)
+COMPATIBLE_IOCTL(DM_DEV_CREATE)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE)
+COMPATIBLE_IOCTL(DM_DEV_RENAME)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
+COMPATIBLE_IOCTL(DM_DEV_STATUS)
+COMPATIBLE_IOCTL(DM_DEV_WAIT)
+COMPATIBLE_IOCTL(DM_TABLE_LOAD)
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR)
+COMPATIBLE_IOCTL(DM_TABLE_DEPS)
+COMPATIBLE_IOCTL(DM_TABLE_STATUS)
+#else
 COMPATIBLE_IOCTL(DM_VERSION)
 COMPATIBLE_IOCTL(DM_REMOVE_ALL)
 COMPATIBLE_IOCTL(DM_DEV_CREATE)
@@ -131,6 +145,7 @@
 COMPATIBLE_IOCTL(DM_TARGET_STATUS)
 COMPATIBLE_IOCTL(DM_TARGET_WAIT)
 #endif
+#endif
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)
 COMPATIBLE_IOCTL(GIO_FONT)
