Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbTFQNpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbTFQNpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:45:04 -0400
Received: from ns.suse.de ([213.95.15.193]:6669 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264725AbTFQNpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:45:00 -0400
Date: Tue, 17 Jun 2003 15:58:55 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix /proc/kcore for i386
Message-ID: <20030617135855.GA19808@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The recent IA64 changes for /proc/kcore broke the access on i386.
Currently no notes are written for the direct mapped or vmalloced
memory, which makes gdb reject it.

This patch fixes it. Other ports probably need to do the same changes.

There is still another problem in /proc/kcore for which I am submitting a 
separate patch.

-Andi

diff -u linux-2.5.72-work/arch/i386/mm/init.c-o linux-2.5.72-work/arch/i386/mm/init.c
--- linux-2.5.72-work/arch/i386/mm/init.c-o	2003-05-27 03:00:45.000000000 +0200
+++ linux-2.5.72-work/arch/i386/mm/init.c	2003-06-17 15:55:03.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
+#include <linux/proc_fs.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -425,6 +426,8 @@
 extern void set_max_mapnr_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
+static struct kcore_list kcore_mem, kcore_vmalloc; 
+
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -477,6 +480,10 @@
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
 
+	kclist_add(&kcore_mem, __va(0), max_low_pfn << PAGE_SHIFT); 
+	kclist_add(&kcore_vmalloc, (void *)VMALLOC_START, 
+		   VMALLOC_END-VMALLOC_START);
+
 	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
 		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
 		num_physpages << (PAGE_SHIFT-10),


