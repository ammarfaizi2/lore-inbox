Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937831AbWLGAUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937831AbWLGAUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937830AbWLGAUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:20:19 -0500
Received: from ozlabs.org ([203.10.76.45]:35642 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937831AbWLGAUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:20:18 -0500
From: Michael Neuling <mikey@neuling.org>
To: linux-kernel@vger.kernel.org
cc: H Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@ftp.linux.org.uk>
X-GPG-Fingerprint: 9B25 DC2A C58D 2C8D 47C2  457E 0887 E86F 32E6 BE16
MIME-Version: 1.0
Subject: [PATCH] free initrds boot option
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 07 Dec 2006 11:18:43 +1100
Message-ID: <4410.1165450723@neuling.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add free_initrd= option to control freeing of initrd memory after
extraction.  By default, free memory as previously.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Useful for kexec when you want to reuse the same initrd.  Testing on
POWERPC with CPIOs 

 init/initramfs.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/init/initramfs.c
===================================================================
--- linux-2.6-ozlabs.orig/init/initramfs.c
+++ linux-2.6-ozlabs/init/initramfs.c
@@ -487,6 +487,17 @@ static char * __init unpack_to_rootfs(ch
 	return message;
 }
 
+static int do_free_initrd = 1;
+
+int __init free_initrd_param(char *p)
+{
+	if (p && strncmp(p, "0", 1) == 0)
+		do_free_initrd = 0;
+
+	return 0;
+}
+early_param("free_initrd", free_initrd_param);
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
 
+	if (!do_free_initrd)
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
