Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161505AbWJUQ46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161505AbWJUQ46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993143AbWJUQ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:56:31 -0400
Received: from mail.suse.de ([195.135.220.2]:43164 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993138AbWJUQv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:28 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [7/19] x86_64: fix page align in e820 allocator 
Message-Id: <20061021165127.1402513C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Vivek Goyal <vgoyal@in.ibm.com>

Currently some code pieces assume that address returned by find_e820_area()
are page aligned.  But looks like find_e820_area() had no such intention
and hence one might end up stomping over some of the data.  One such case
is bootmem allocator initialization code stomped over bss.

This patch modified find_e820_area() to return page aligned address.  This
might be little wasteful of memory but at the same time probably it is
easier to handle page aligned memory.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/e820.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux/arch/x86_64/kernel/e820.c
===================================================================
--- linux.orig/arch/x86_64/kernel/e820.c
+++ linux/arch/x86_64/kernel/e820.c
@@ -54,13 +54,13 @@ static inline int bad_addr(unsigned long
 
 	/* various gunk below that needed for SMP startup */
 	if (addr < 0x8000) { 
-		*addrp = 0x8000;
+		*addrp = PAGE_ALIGN(0x8000);
 		return 1; 
 	}
 
 	/* direct mapping tables of the kernel */
 	if (last >= table_start<<PAGE_SHIFT && addr < table_end<<PAGE_SHIFT) { 
-		*addrp = table_end << PAGE_SHIFT; 
+		*addrp = PAGE_ALIGN(table_end << PAGE_SHIFT);
 		return 1;
 	} 
 
@@ -68,18 +68,18 @@ static inline int bad_addr(unsigned long
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START && last >= INITRD_START && 
 	    addr < INITRD_START+INITRD_SIZE) { 
-		*addrp = INITRD_START + INITRD_SIZE; 
+		*addrp = PAGE_ALIGN(INITRD_START + INITRD_SIZE);
 		return 1;
 	} 
 #endif
 	/* kernel code */
-	if (last >= __pa_symbol(&_text) && last < __pa_symbol(&_end)) {
-		*addrp = __pa_symbol(&_end);
+	if (last >= __pa_symbol(&_text) && addr < __pa_symbol(&_end)) {
+		*addrp = PAGE_ALIGN(__pa_symbol(&_end));
 		return 1;
 	}
 
 	if (last >= ebda_addr && addr < ebda_addr + ebda_size) {
-		*addrp = ebda_addr + ebda_size;
+		*addrp = PAGE_ALIGN(ebda_addr + ebda_size);
 		return 1;
 	}
 
@@ -152,7 +152,7 @@ unsigned long __init find_e820_area(unsi
 			continue; 
 		while (bad_addr(&addr, size) && addr+size <= ei->addr+ei->size)
 			;
-		last = addr + size;
+		last = PAGE_ALIGN(addr) + size;
 		if (last > ei->addr + ei->size)
 			continue;
 		if (last > end) 
