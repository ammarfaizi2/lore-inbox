Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWFZBJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWFZBJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFZBIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:08:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19599 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964988AbWFZA6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:49 -0400
Date: Sun, 25 Jun 2006 17:58:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 17/43] sparc32: transfer arch-specific options to /arch.cmd
Message-Id: <klibc.200606251757.17@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boot options which have been obtained in an architecture-specific
fashion have to be copied to /arch.cmd in the rootfs.  This implements
that functionality for sparc32; the code is identical to sparc64 minus
the openprom support for obtaining nfsroot options.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit fc8c0c09f9dd5139dd8d797eaf9fe33962b6cd2c
tree ee9f637f9b8be2032386ae4097505e8583b960b4
parent c6e5c5a77681f5bf6f9fea55d031115e9f58ada6
author H. Peter Anvin <hpa@zytor.com> Thu, 25 May 2006 22:34:47 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:56:23 -0700

 arch/sparc/kernel/setup.c |   47 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 3509e43..ae8f283 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -240,8 +240,6 @@ #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-extern int root_mountflags;
-
 char reboot_command[COMMAND_LINE_SIZE];
 enum sparc_cpu sparc_cpu_model;
 
@@ -328,14 +326,7 @@ #endif
 	}
 	pfn_base = phys_base >> PAGE_SHIFT;
 
-	if (!root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
-#ifdef CONFIG_BLK_DEV_INITRD
-	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
-#endif
 
 	prom_setsync(prom_sync_me);
 
@@ -386,6 +377,44 @@ static int __init set_preferred_console(
 }
 console_initcall(set_preferred_console);
 
+/*
+ * Platform-specific configuration commands which don't come from
+ * the actual kernel command line.  Write them into a file in rootfs
+ * so kinit can pick them up.
+ */
+static int __init set_arch_init_commands(void)
+{
+	int fd = sys_open("/arch.cmd", O_WRONLY|O_CREAT|O_APPEND, 0666);
+	char buffer[256];
+	int len = 0;
+
+	if (fd < 0)
+		return fd;
+
+	buffer[0] = 'r';
+	buffer[1] = root_flags ? 'o' : 'w';
+	buffer[2] = '\n';
+	len = 3;
+
+#ifdef CONFIG_BLK_DEV_RAM
+	len += min((int)(sizeof buffer - 1 - len),
+		   snprintf(buffer+len, sizeof buffer - len,
+			    "ramdisk_start=%u\n"
+			    "prompt_ramdisk=%d\n"
+			    "load_ramdisk=%d\n",
+			    ram_flags & RAMDISK_IMAGE_START_MASK,
+			    !!(ram_flags & RAMDISK_PROMPT_FLAG),
+			    !!(ram_flags & RAMDISK_LOAD_FLAG)));
+#endif
+
+	sys_write(fd, buffer, len);
+	sys_close(fd);
+
+	return 0;
+}
+
+late_initcall(set_arch_init_commands);
+
 extern char *sparc_cpu_type;
 extern char *sparc_fpu_type;
 
