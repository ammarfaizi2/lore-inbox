Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUIBN0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUIBN0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268307AbUIBN0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:26:34 -0400
Received: from ozlabs.org ([203.10.76.45]:27026 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268306AbUIBN0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:26:20 -0400
Date: Thu, 2 Sep 2004 23:21:06 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com
Subject: [PATCH] [ppc64] implement page_is_ram
Message-ID: <20040902132106.GG26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Haren Myneni <hbabu@us.ibm.com>

This patch contains - Removes __initdata from lmb definition (struct lmb
lmb;) and modified the existing page_is_ram function.

Also changed the current argument from physical address to pfn to make
it compatible across architectures. Please review them and send me your
comments/suggestions. If you are OK with any one patch, please include
it in the mainline kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/lmb.c~pageisram arch/ppc64/kernel/lmb.c
--- foobar2/arch/ppc64/kernel/lmb.c~pageisram	2004-09-02 23:09:59.602570739 +1000
+++ foobar2-anton/arch/ppc64/kernel/lmb.c	2004-09-02 23:09:59.653566819 +1000
@@ -20,7 +20,7 @@
 #include <asm/abs_addr.h>
 #include <asm/bitops.h>
 
-struct lmb lmb __initdata;
+struct lmb lmb;
 
 static unsigned long __init
 lmb_addrs_overlap(unsigned long base1, unsigned long size1,
diff -puN arch/ppc64/kernel/ppc_ksyms.c~pageisram arch/ppc64/kernel/ppc_ksyms.c
diff -puN arch/ppc64/mm/init.c~pageisram arch/ppc64/mm/init.c
--- foobar2/arch/ppc64/mm/init.c~pageisram	2004-09-02 23:09:59.614569817 +1000
+++ foobar2-anton/arch/ppc64/mm/init.c	2004-09-02 23:15:17.947007636 +1000
@@ -85,7 +85,6 @@ unsigned long __max_memory;
 /* info on what we think the IO hole is */
 unsigned long 	io_hole_start;
 unsigned long	io_hole_size;
-unsigned long	top_of_ram;
 
 void show_mem(void)
 {
@@ -498,16 +497,12 @@ void __init mm_init_ppc64(void)
 	 * So we need some rough way to tell where your big IO hole
 	 * is. On pmac, it's between 2G and 4G, on POWER3, it's around
 	 * that area as well, on POWER4 we don't have one, etc...
-	 * We need that to implement something approx. decent for
-	 * page_is_ram() so that /dev/mem doesn't map cacheable IO space
-	 * when XFree resquest some IO regions witout using O_SYNC, we
-	 * also need that as a "hint" when sizing the TCE table on POWER3
+	 * We need that as a "hint" when sizing the TCE table on POWER3
 	 * So far, the simplest way that seem work well enough for us it
 	 * to just assume that the first discontinuity in our physical
 	 * RAM layout is the IO hole. That may not be correct in the future
 	 * (and isn't on iSeries but then we don't care ;)
 	 */
-	top_of_ram = lmb_end_of_DRAM();
 
 #ifndef CONFIG_PPC_ISERIES
 	for (i = 1; i < lmb.memory.cnt; i++) {
@@ -530,22 +525,32 @@ void __init mm_init_ppc64(void)
 	ppc64_boot_msg(0x100, "MM Init Done");
 }
 
-
 /*
  * This is called by /dev/mem to know if a given address has to
  * be mapped non-cacheable or not
  */
-int page_is_ram(unsigned long physaddr)
+int page_is_ram(unsigned long pfn)
 {
-#ifdef CONFIG_PPC_ISERIES
-	return 1;
+	int i;
+	unsigned long paddr = (pfn << PAGE_SHIFT);
+
+	for (i=0; i < lmb.memory.cnt; i++) {
+		unsigned long base;
+
+#ifdef CONFIG_MSCHUNKS
+		base = lmb.memory.region[i].physbase;
+#else
+		base = lmb.memory.region[i].base;
 #endif
-	if (physaddr >= top_of_ram)
-		return 0;
-	return io_hole_start == 0 ||  physaddr < io_hole_start ||
-		physaddr >= (io_hole_start + io_hole_size);
+		if ((paddr >= base) &&
+			(paddr < (base + lmb.memory.region[i].size))) {
+			return 1;
+		}
+	}
+	
+	return 0;
 }
-
+EXPORT_SYMBOL(page_is_ram);
 
 /*
  * Initialize the bootmem system and give it all the memory we
@@ -599,6 +604,7 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES];
 	unsigned long zholes_size[MAX_NR_ZONES];
 	unsigned long total_ram = lmb_phys_mem_size();
+	unsigned long top_of_ram = lmb_end_of_DRAM();
 
 	printk(KERN_INFO "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
diff -puN drivers/char/mem.c~pageisram drivers/char/mem.c
--- foobar2/drivers/char/mem.c~pageisram	2004-09-02 23:09:59.621569279 +1000
+++ foobar2-anton/drivers/char/mem.c	2004-09-02 23:09:59.660566281 +1000
@@ -86,7 +86,7 @@ static inline int uncached_access(struct
 	 * above the IO hole... Ah, and of course, XFree86 doesn't pass
 	 * O_SYNC when mapping us to tap IO space. Surprised ?
 	 */
-	return !page_is_ram(addr);
+	return !page_is_ram(addr >> PAGE_SHIFT);
 #else
 	/*
 	 * Accessing memory above the top the kernel knows about or through a file pointer
diff -puN include/asm-ppc64/lmb.h~pageisram include/asm-ppc64/lmb.h
--- foobar2/include/asm-ppc64/lmb.h~pageisram	2004-09-02 23:09:59.627568817 +1000
+++ foobar2-anton/include/asm-ppc64/lmb.h	2004-09-02 23:09:59.661566204 +1000
@@ -47,7 +47,7 @@ struct lmb {
 	struct lmb_region reserved;
 };
 
-extern struct lmb lmb __initdata;
+extern struct lmb lmb;
 
 extern void __init lmb_init(void);
 extern void __init lmb_analyze(void);
diff -puN include/asm-ppc64/page.h~pageisram include/asm-ppc64/page.h
--- foobar2/include/asm-ppc64/page.h~pageisram	2004-09-02 23:09:59.633568356 +1000
+++ foobar2-anton/include/asm-ppc64/page.h	2004-09-02 23:09:59.662566127 +1000
@@ -181,8 +181,7 @@ static inline int get_order(unsigned lon
 
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
 
-/* Not 100% correct, for use by /dev/mem only */
-extern int page_is_ram(unsigned long physaddr);
+extern int page_is_ram(unsigned long pfn);
 
 #endif /* __ASSEMBLY__ */
 
_
