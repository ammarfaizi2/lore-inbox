Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423162AbWF1F2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423162AbWF1F2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWF1F04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:26:56 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5070 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423174AbWF1FTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:13 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 29/31] sparc32: transfer arch-specific options to /arch.cmd
Date: Tue, 27 Jun 2006 22:17:29 -0700
Message-Id: <klibc.200606272217.29@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boot options which have been obtained in an architecture-specific
fashion have to be copied to /arch.cmd in the rootfs.  This implements
that functionality for sparc32; the code is identical to sparc64 minus
the openprom support for obtaining nfsroot options.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 15d00a4525e5127f0cb4ff31fae3c80c87d3212e
tree c55726dfc288f0ceee45ae53aa47978a0a9a0f99
parent 921aaa1bc54bbcdc3a91d3ea4f23b2b13d42699d
author H. Peter Anvin <hpa@zytor.com> Thu, 25 May 2006 22:34:47 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:17 -0700

 arch/sparc/kernel/setup.c |   47 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index a893a9c..f7c4673 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -241,8 +241,6 @@ #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-extern int root_mountflags;
-
 char reboot_command[COMMAND_LINE_SIZE];
 enum sparc_cpu sparc_cpu_model;
 
@@ -329,14 +327,7 @@ #endif
 	}
 	pfn_base = phys_base >> PAGE_SHIFT;
 
-	if (!root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
-#endif
 
 	prom_setsync(prom_sync_me);
 
@@ -389,6 +380,44 @@ static int __init set_preferred_console(
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
 
