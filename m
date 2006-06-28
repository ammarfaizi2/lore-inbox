Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423188AbWF1FZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423188AbWF1FZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423181AbWF1FYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:24:44 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5582 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423178AbWF1FTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:16 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 28/31] sparc64: transmit arch-specific options to kinit via /arch.cmd
Date: Tue, 27 Jun 2006 22:17:28 -0700
Message-Id: <klibc.200606272217.28@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sparc64 has support for a bunch of architecture-specific options
taken from the PROM.  Convert them to kernel command line form and
write the file /arch.cmd in the rootfs, which can be recovered by
kinit and processed.  The kinit support has already been committed.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 921aaa1bc54bbcdc3a91d3ea4f23b2b13d42699d
tree 7e25561f0762b93f3793b8593276c58898d4b8da
parent 973116495f231a6775ef098df4481a34a38bfff7
author H. Peter Anvin <hpa@zytor.com> Wed, 24 May 2006 22:44:55 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:15 -0700

 arch/sparc64/kernel/setup.c |   92 +++++++++++++++++++++++++++++--------------
 1 files changed, 61 insertions(+), 31 deletions(-)

diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index a6a7d81..4bdfd22 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -32,6 +32,7 @@ #include <linux/root_dev.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
+#include <linux/fcntl.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -102,7 +103,7 @@ int obp_system_intr(void)
 	return 0;
 }
 
-/* 
+/*
  * Process kernel command line switches that are specific to the
  * SPARC or that require special low-level processing.
  */
@@ -214,8 +215,6 @@ #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-extern int root_mountflags;
-
 char reboot_command[COMMAND_LINE_SIZE];
 
 static struct pt_regs fake_swapper_regs = { { 0, }, 0, 0, 0, 0 };
@@ -315,6 +314,64 @@ void __init sun4v_patch(void)
 	}
 }
 
+/*
+ * Platform-specific configuration commands which don't come from
+ * the actual kernel command line.  Write them into a file in rootfs
+ * so kinit can pick them up.
+ */
+static int __init set_arch_init_commands(void)
+{
+	int fd = sys_open("/arch.cmd", O_WRONLY|O_CREAT|O_APPEND, 0666);
+	int chosen;
+	u32 cl, sv, gw;
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
+	chosen = prom_finddevice("/chosen");
+	cl = prom_getintdefault(chosen, "client-ip", 0);
+	sv = prom_getintdefault(chosen, "server-ip", 0);
+	gw = prom_getintdefault(chosen, "gateway-ip", 0);
+
+	if (cl && sv) {
+		len += min((int)(sizeof buffer - 1 - len),
+			   snprintf(buffer+len, sizeof buffer - len,
+				    "ip=%u.%u.%u.%u:%u.%u.%u.%u:"
+				    "%u.%u.%u.%u\n",
+				    (u8)(cl >> 24), (u8)(cl >> 16),
+				    (u8)(cl >> 8), (u8)cl,
+				    (u8)(sv >> 24), (u8)(sv >> 16),
+				    (u8)(sv >> 8), (u8)sv,
+				    (u8)(gw >> 24), (u8)(gw >> 16),
+				    (u8)(gw >> 8), (u8)gw));
+	}
+
+	sys_write(fd, buffer, len);
+	sys_close(fd);
+
+	return 0;
+}
+
+late_initcall(set_arch_init_commands);
+
 #ifdef CONFIG_SMP
 void __init boot_cpu_id_too_large(int cpu)
 {
@@ -345,37 +402,10 @@ #endif
 
 	idprom_init();
 
-	if (!root_flags)
-		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
-#endif
 
 	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
 
-#ifdef CONFIG_IP_PNP
-	if (!ic_set_manually) {
-		int chosen = prom_finddevice ("/chosen");
-		u32 cl, sv, gw;
-		
-		cl = prom_getintdefault (chosen, "client-ip", 0);
-		sv = prom_getintdefault (chosen, "server-ip", 0);
-		gw = prom_getintdefault (chosen, "gateway-ip", 0);
-		if (cl && sv) {
-			ic_myaddr = cl;
-			ic_servaddr = sv;
-			if (gw)
-				ic_gateway = gw;
-#if defined(CONFIG_IP_PNP_BOOTP) || defined(CONFIG_IP_PNP_RARP)
-			ic_proto_enabled = 0;
-#endif
-		}
-	}
-#endif
-
 	/* Get boot processor trap_block[] setup.  */
 	init_cur_cpu_trap(current_thread_info());
 
@@ -438,7 +468,7 @@ static int ncpus_probed;
 
 static int show_cpuinfo(struct seq_file *m, void *__unused)
 {
-	seq_printf(m, 
+	seq_printf(m,
 		   "cpu\t\t: %s\n"
 		   "fpu\t\t: %s\n"
 		   "prom\t\t: %s\n"
