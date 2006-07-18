Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWGRJ2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWGRJ2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWGRJ1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:27:35 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22658 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932124AbWGRJU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:57 -0400
Message-Id: <20060718091952.769829000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:17 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 17/33] Support loading an initrd when running on Xen
Content-Disposition: inline; filename=i386-setup-initrd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the initial physical memory layout when booting on Xen, the initrd
image ends up below min_low_pfn (as registered with the bootstrap memory
allocator).  Add Xen subarch support to enable initrd_below_start_ok flag,
and disable initrd_reserve_bootmem.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/setup.c                    |    4 +++-
 include/asm-i386/mach-xen/setup_arch_post.h |    6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff -r f4c730a90338 arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Jun 13 23:54:44 2006 -0700
+++ b/arch/i386/kernel/setup.c	Wed Jun 14 00:02:16 2006 -0700
@@ -1205,6 +1205,7 @@ extern unsigned long __init setup_memory
 extern unsigned long __init setup_memory(void);
 extern void zone_sizes_init(void);
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
+int initrd_reserve_bootmem = 1;
 
 void __init setup_bootmem_allocator(void)
 {
@@ -1265,7 +1266,8 @@ void __init setup_bootmem_allocator(void
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
+			if (initrd_reserve_bootmem)
+				reserve_bootmem(INITRD_START, INITRD_SIZE);
 			initrd_start =
 				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
 			initrd_end = initrd_start+INITRD_SIZE;
diff -r f4c730a90338 arch/i386/mach-xen/setup-xen.c
--- a/arch/i386/mach-xen/setup-xen.c	Tue Jun 13 23:54:44 2006 -0700
+++ b/arch/i386/mach-xen/setup-xen.c	Wed Jun 14 00:02:16 2006 -0700
@@ -5,6 +5,8 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/initrd.h>
 
 #include <asm/e820.h>
 #include <asm/setup.h>
@@ -68,4 +70,10 @@ void __init machine_specific_arch_setup(
 	memcpy(saved_command_line, xen_start_info->cmd_line,
 	       MAX_GUEST_CMDLINE > COMMAND_LINE_SIZE ?
 	       COMMAND_LINE_SIZE : MAX_GUEST_CMDLINE);
+
+	if (INITRD_START &&
+	    INITRD_START + PAGE_OFFSET < min_low_pfn << PAGE_SHIFT) {
+		initrd_reserve_bootmem = 0;
+		initrd_below_start_ok = 1;
+	}
 }
diff -r f4c730a90338 include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Tue Jun 13 23:54:44 2006 -0700
+++ b/include/asm-i386/setup.h	Wed Jun 14 00:02:16 2006 -0700
@@ -66,6 +66,7 @@ extern unsigned char boot_params[PARAM_S
 #define LOWMEMSIZE()	(0x9f000)
 
 extern unsigned long init_pg_tables_end;
+extern int initrd_reserve_bootmem;
 
 struct e820entry;
 

--
