Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137162AbREKQID>; Fri, 11 May 2001 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137161AbREKQHx>; Fri, 11 May 2001 12:07:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8288 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S137162AbREKQHo>; Fri, 11 May 2001 12:07:44 -0400
Date: Fri, 11 May 2001 18:07:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: x86 bootmem corruption
Message-ID: <20010511180737.Q30355@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bootmem allocations are executed before all the reserved memory is been
reserved.  This is the fix against 2.4.5pre1. This might explain weird
crashes and "reserved twice" error messages at boot on highmem systems.
I didn't yet had the confirm this patch hels but certainly it is a
necessary fix for correctness.

--- initmem/arch/i386/kernel/setup.c.~1~	Tue May  1 19:35:18 2001
+++ initmem/arch/i386/kernel/setup.c	Fri May 11 01:59:19 2001
@@ -934,7 +934,6 @@
 	 * trampoline before removing it. (see the GDT stuff)
 	 */
 	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
-	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
@@ -943,18 +942,6 @@
 	 */
 	find_smp_config();
 #endif
-	paging_init();
-#ifdef CONFIG_X86_IO_APIC
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	if (smp_found_config)
-		get_smp_config();
-#endif
-#ifdef CONFIG_X86_LOCAL_APIC
-	init_apic_mappings();
-#endif
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
@@ -971,6 +958,26 @@
 			initrd_start = 0;
 		}
 	}
+#endif
+
+	/*
+	 * NOTE: before this point _nobody_ is allowed to allocate
+	 * any memory using the bootmem allocator.
+	 */
+
+#ifdef CONFIG_SMP
+	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
+#endif
+	paging_init();
+#ifdef CONFIG_X86_IO_APIC
+	/*
+	 * get boot-time SMP configuration:
+	 */
+	if (smp_found_config)
+		get_smp_config();
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+	init_apic_mappings();
 #endif
 
 	/*

Andrea
