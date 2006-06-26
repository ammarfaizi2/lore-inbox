Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWFZA6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWFZA6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFZA6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16271 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964976AbWFZA6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:25 -0400
Date: Sun, 25 Jun 2006 17:57:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 06/43] Re-create ROOT_DEV, too many architectures need it.
Message-Id: <klibc.200606251757.06@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ROOT_DEV carries a root device number communicated in an architecture-
specific way.  We now pass it to kinit via the real-root-dev sysctl call.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 0f5a324d655ad582246b6830843114d09835f593
tree fd3a96a69b6d74ee33dcd54a58b8666c02139a3a
parent f3e41698e540a7d39658d6590fde1379c0f5bab0
author H. Peter Anvin <hpa@zytor.com> Thu, 06 Apr 2006 14:07:43 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:46:23 -0700

 arch/i386/kernel/setup.c   |    1 +
 arch/x86_64/kernel/setup.c |    1 +
 init/initramfs.c           |    4 ----
 init/main.c                |   12 ++++++++++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 16784a6..54c72d9 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1460,6 +1460,7 @@ #ifdef CONFIG_EFI
 		efi_enabled = 1;
 #endif
 
+	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index cadbe33..6d4f025 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -599,6 +599,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
 
+	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
 	saved_video_mode = SAVED_VIDEO_MODE;
diff --git a/init/initramfs.c b/init/initramfs.c
index 0cbd783..7ea4127 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,10 +10,6 @@ #include <linux/syscalls.h>
 unsigned long __initdata initrd_start, initrd_end;
 int __initdata initrd_below_start_ok;
 
-/* This isn't used by the kernel, but exists as a sysctl node for
-   backwards compatibility reasons. */
-unsigned int real_root_dev;
-
 static __initdata char *message;
 static void __init error(char *x)
 {
diff --git a/init/main.c b/init/main.c
index 4b3fd6f..10fb231 100644
--- a/init/main.c
+++ b/init/main.c
@@ -49,6 +49,7 @@ #include <linux/unistd.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/root_dev.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -126,6 +127,11 @@ static char *ramdisk_execute_command;
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = NR_CPUS;
 
+/* ROOT_DEV contains any architecture-specific default root device. */
+/* real_root_dev is used (via sysctl) to communicate ROOT_DEV to kinit. */
+dev_t ROOT_DEV;
+unsigned int real_root_dev;
+
 /*
  * Setup routine for controlling SMP activation
  *
@@ -682,6 +688,12 @@ static int init(void * unused)
 	do_basic_setup();
 
 	/*
+	 * If we have a root device set by architecture-specific means,
+	 * let kinit know about it.
+	 */
+	real_root_dev = new_encode_dev(ROOT_DEV);
+
+	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
