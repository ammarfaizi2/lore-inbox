Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWEIIw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWEIIw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWEIIwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:52:54 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8832 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751606AbWEIIt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:27 -0400
Message-Id: <20060509085153.290657000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:13 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 13/35] Support loading an initrd when running on Xen
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

--- linus-2.6.orig/arch/i386/kernel/setup.c
+++ linus-2.6/arch/i386/kernel/setup.c
@@ -1211,6 +1211,7 @@ void __init zone_sizes_init(void)
 extern unsigned long __init setup_memory(void);
 extern void zone_sizes_init(void);
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
+int initrd_reserve_bootmem = 1;
 
 void __init setup_bootmem_allocator(void)
 {
@@ -1271,7 +1272,8 @@ void __init setup_bootmem_allocator(void
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
+			if (initrd_reserve_bootmem)
+				reserve_bootmem(INITRD_START, INITRD_SIZE);
 			initrd_start =
 				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
 			initrd_end = initrd_start+INITRD_SIZE;
--- linus-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ linus-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -48,6 +48,12 @@ static void __init machine_specific_arch
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
 
 static void __init machine_specific_arch_final_setup(void)

--
