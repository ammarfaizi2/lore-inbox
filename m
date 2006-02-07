Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWBGDu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWBGDu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWBGDu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:50:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:56237 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964967AbWBGDu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:50:27 -0500
Message-ID: <43E818EB.7010003@us.ibm.com>
Date: Mon, 06 Feb 2006 19:50:03 -0800
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linuxppc64-dev@ozlabs.org
CC: hpa@zytor.com, Milton Miller <miltonm@bga.com>
Subject: [PATCH] Fix in free initrd when overlapped with crashkernel region
Content-Type: multipart/mixed;
 boundary="------------070205090609000107020602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070205090609000107020602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


It is possible that the reserved crashkernel region can be overlapped 
with initrd since the bootloader sets the initrd location. When the 
initrd region is freed, the second kernel memory will not be contiguous. 
The Kexec_load can cause an oops since there is no contiguous memory to 
write the second kernel or this memory could be used in the first kernel 
itself and may not be part of the dump. For example, on powerpc, the 
initrd is located at 36MB and the crashkernel starts at 32MB. The 
kexec_load caused panic since writing into non-allocated memory (after 
36MB). We could see the similar issue even on other archs.

One possibility is to move the initrd outside of crashkernel region. 
But, the initrd region will be freed anyway before the system is up.  
This patch fixes this issue and frees only regions that are not part of 
crashkernel memory in case overlaps. 

Thanks
Haren

Signed-off-by: Haren Myneni <haren@us.ibm.com>




--------------070205090609000107020602
Content-Type: text/x-patch;
 name="kdump-initrd-overlap-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-initrd-overlap-fix.patch"

diff -Naurp 2616-rc2.orig/include/linux/kexec.h 2616-rc2/include/linux/kexec.h
--- 2616-rc2.orig/include/linux/kexec.h	2006-02-06 19:08:01.000000000 -0800
+++ 2616-rc2/include/linux/kexec.h	2006-02-06 19:06:37.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/list.h>
 #include <linux/linkage.h>
 #include <linux/compat.h>
+#include <linux/ioport.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
diff -Naurp 2616-rc2.orig/init/initramfs.c 2616-rc2/init/initramfs.c
--- 2616-rc2.orig/init/initramfs.c	2006-02-06 19:04:42.000000000 -0800
+++ 2616-rc2/init/initramfs.c	2006-02-06 19:04:59.000000000 -0800
@@ -466,10 +466,32 @@ static char * __init unpack_to_rootfs(ch
 extern char __initramfs_start[], __initramfs_end[];
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/initrd.h>
+#include <linux/kexec.h>
 
 static void __init free_initrd(void)
 {
-	free_initrd_mem(initrd_start, initrd_end);
+#ifdef CONFIG_KEXEC
+	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
+	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
+
+	/*
+	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * free only memory that is not part of crashkernel region.
+	 */
+	if (initrd_start < crashk_end && initrd_end > crashk_start) {
+		/*
+		 * Initialize initrd memory region since the kexec boot does 
+		 * not do.
+		 */ 
+		memset((void *)initrd_start, 0, initrd_end - initrd_start); 
+		if (initrd_start < crashk_start)
+			free_initrd_mem(initrd_start, crashk_start); 
+		if (initrd_end > crashk_end) 
+			free_initrd_mem(crashk_end, initrd_end); 
+	} else
+#endif
+		free_initrd_mem(initrd_start, initrd_end);
+
 	initrd_start = 0;
 	initrd_end = 0;
 }

--------------070205090609000107020602--
