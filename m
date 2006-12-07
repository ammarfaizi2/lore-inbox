Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968368AbWLGDnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968368AbWLGDnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 22:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968376AbWLGDnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 22:43:00 -0500
Received: from ozlabs.org ([203.10.76.45]:46667 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968368AbWLGDnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 22:43:00 -0500
From: Michael Neuling <mikey@neuling.org>
To: linux-kernel@vger.kernel.org
cc: H Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@ftp.linux.org.uk>
X-GPG-Fingerprint: 9B25 DC2A C58D 2C8D 47C2  457E 0887 E86F 32E6 BE16
MIME-Version: 1.0
Subject: [PATCH] free initrds boot option
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 07 Dec 2006 14:42:57 +1100
Message-ID: <14049.1165462977@neuling.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add retain_initrd option to control freeing of initrd memory after
extraction.  By default, free memory as previously.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Updated based on comments from akpm.  
Added documentation and changed option name to "retain_initrd"
Tested on POWERPC with CPIOs

 Documentation/kernel-parameters.txt |    2 ++
 init/initramfs.c                    |   18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6-ozlabs.orig/Documentation/kernel-parameters.txt
+++ linux-2.6-ozlabs/Documentation/kernel-parameters.txt
@@ -1366,6 +1366,8 @@ and is between 256 and 4096 characters. 
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
+	retain_initrd	[RAM] Keep initrd memory after extraction
+
 	rhash_entries=	[KNL,NET]
 			Set number of hash buckets for route cache
 
Index: linux-2.6-ozlabs/init/initramfs.c
===================================================================
--- linux-2.6-ozlabs.orig/init/initramfs.c
+++ linux-2.6-ozlabs/init/initramfs.c
@@ -487,6 +487,17 @@ static char * __init unpack_to_rootfs(ch
 	return message;
 }
 
+static int do_retain_initrd = 0;
+
+static int __init retain_initrd_param(char *str)
+{
+	if (*str)
+		return 0;
+	do_retain_initrd = 1;
+	return 1;
+}
+__setup("retain_initrd", retain_initrd_param);
+
 extern char __initramfs_start[], __initramfs_end[];
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/initrd.h>
@@ -494,10 +505,13 @@ extern char __initramfs_start[], __initr
 
 static void __init free_initrd(void)
 {
-#ifdef CONFIG_KEXEC
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
 
+	if (do_retain_initrd)
+		goto skip;
+
+#ifdef CONFIG_KEXEC
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
@@ -515,7 +529,7 @@ static void __init free_initrd(void)
 	} else
 #endif
 		free_initrd_mem(initrd_start, initrd_end);
-
+skip:
 	initrd_start = 0;
 	initrd_end = 0;
 }
