Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTBRDL7>; Mon, 17 Feb 2003 22:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTBRDL7>; Mon, 17 Feb 2003 22:11:59 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10967 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267569AbTBRDL4>; Mon, 17 Feb 2003 22:11:56 -0500
Date: Mon, 17 Feb 2003 19:21:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
Message-ID: <28510000.1045538497@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   plain 2.5.59 does
>> 
>>   59-mjb4 does NOT
> 
> Can you check mjb 1-3 too? The better it gets pinpointed, the easier it's 
> going to be to find.

I should note that our performance team also has triple-faults on some 
database app on a 8x machine ... that goes away with mjb4, not sure why 
as yet. There's nothing in there that I can think of that would fix
a triple fault, so it may well be something annoyingly subtle.

Try -mjb1 first, if that still fixes it, then I'll start hacking off 
chunks for you to test. Try 62 as well ... that has dcache_rcu merged,
which is another major chunk of the patch. kgdb is also big, and may 
well change timings ...
 
> Also, if you can figure out _which_ part of the patch makes a difference,
> that would obviously be even better.  Part of the stuff in mjb is already
> merged in later kernels (ie things like using sequence locks for xtime is
> already there in 2.5.60, so clearly that doesn't seem to be the thing that
> helps your situation).

Yup, a lot of it is designed to give our performance team a stable base
to work from - so minimal changes to a 59 base.

I use gcc-2.95.4 (Debian) as Chris does and have found that extremely 
stable, not sure what the perf team were using, I'll find out.

> Now, interestingly enough, the mjb patch _does_ contain a change to 
> mm/memory.c that really makes no sense _except_ in the case of a compiler 
> bug. So you could check whether that (small) mm/memory.c patch is the 
> thing that makes a difference for you..

That's the config_page_offset patch, which Dave ported forward from 
Andrea's tree ... I've split that out below:

diff -urpN -X /home/fletch/.diff.exclude 21-config_hz/arch/i386/Kconfig 22-config_page_offset/arch/i386/Kconfig
--- 21-config_hz/arch/i386/Kconfig	Wed Feb  5 22:22:59 2003
+++ 22-config_page_offset/arch/i386/Kconfig	Wed Feb  5 22:23:00 2003
@@ -660,6 +660,44 @@ config HIGHMEM64G
 
 endchoice
 
+choice
+	help
+	  On i386, a process can only virtually address 4GB of memory.  This
+	  lets you select how much of that virtual space you would like to 
+	  devoted to userspace, and how much to the kernel.
+
+	  Some userspace programs would like to address as much as possible and 
+	  have few demands of the kernel other than it get out of the way.  These
+	  users may opt to use the 3.5GB option to give their userspace program 
+	  as much room as possible.  Due to alignment issues imposed by PAE, 
+	  the "3.5GB" option is unavailable if "64GB" high memory support is 
+	  enabled.
+
+	  Other users (especially those who use PAE) may be running out of
+	  ZONE_NORMAL memory.  Those users may benefit from increasing the
+	  kernel's virtual address space size by taking it away from userspace, 
+	  which may not need all of its space.  An indicator that this is 
+	  happening is when /proc/Meminfo's "LowFree:" is a small percentage of
+	  "LowTotal:" while "HighFree:" is very large.
+
+	  If unsure, say "3GB"
+	prompt "User address space size"
+        default 1GB
+	
+config	05GB
+	bool "3.5 GB"
+	depends on !HIGHMEM64G
+	
+config	1GB
+	bool "3 GB"
+	
+config	2GB
+	bool "2 GB"
+	
+config	3GB
+	bool "1 GB"
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff -urpN -X /home/fletch/.diff.exclude 21-config_hz/arch/i386/Makefile 22-config_page_offset/arch/i386/Makefile
--- 21-config_hz/arch/i386/Makefile	Fri Jan 17 09:18:19 2003
+++ 22-config_page_offset/arch/i386/Makefile	Wed Feb  5 22:23:00 2003
@@ -89,6 +89,7 @@ drivers-$(CONFIG_OPROFILE)		+= arch/i386
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
+AFLAGS_vmlinux.lds.o += -imacros $(TOPDIR)/include/asm-i386/page.h
 
 boot := arch/i386/boot
 
diff -urpN -X /home/fletch/.diff.exclude 21-config_hz/arch/i386/vmlinux.lds.S 22-config_page_offset/arch/i386/vmlinux.lds.S
--- 21-config_hz/arch/i386/vmlinux.lds.S	Fri Jan 17 09:18:20 2003
+++ 22-config_page_offset/arch/i386/vmlinux.lds.S	Wed Feb  5 22:23:00 2003
@@ -10,7 +10,7 @@ ENTRY(_start)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = __PAGE_OFFSET + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
diff -urpN -X /home/fletch/.diff.exclude 21-config_hz/include/asm-i386/page.h 22-config_page_offset/include/asm-i386/page.h
--- 21-config_hz/include/asm-i386/page.h	Tue Jan 14 10:06:18 2003
+++ 22-config_page_offset/include/asm-i386/page.h	Wed Feb  5 22:23:00 2003
@@ -89,7 +89,16 @@ typedef struct { unsigned long pgprot; }
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
-#define __PAGE_OFFSET		(0xC0000000)
+#include <linux/config.h>
+#ifdef CONFIG_05GB
+#define __PAGE_OFFSET          (0xE0000000)
+#elif defined(CONFIG_1GB)
+#define __PAGE_OFFSET          (0xC0000000)
+#elif defined(CONFIG_2GB)
+#define __PAGE_OFFSET          (0x80000000)
+#elif defined(CONFIG_3GB)
+#define __PAGE_OFFSET          (0x40000000)
+#endif
 
 /*
  * This much address space is reserved for vmalloc() and iomap()
diff -urpN -X /home/fletch/.diff.exclude 21-config_hz/include/asm-i386/processor.h 22-config_page_offset/include/asm-i386/processor.h
--- 21-config_hz/include/asm-i386/processor.h	Thu Jan  2 22:05:15 2003
+++ 22-config_page_offset/include/asm-i386/processor.h	Wed Feb  5 22:23:00 2003
@@ -279,7 +279,11 @@ extern unsigned int mca_pentium_flag;
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
+#ifdef CONFIG_05GB
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 16))
+#else
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#endif
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -urpN -X /home/fletch/.diff.exclude 21-config_hz/mm/memory.c 22-config_page_offset/mm/memory.c
--- 21-config_hz/mm/memory.c	Mon Jan 13 21:09:28 2003
+++ 22-config_page_offset/mm/memory.c	Wed Feb  5 22:23:00 2003
@@ -101,8 +101,7 @@ static inline void free_one_pmd(struct m
 
 static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -113,8 +112,21 @@ static inline void free_one_pgd(struct m
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
-		free_one_pmd(tlb, pmd+j);
+	/*
+	 * Beware if changing the loop below.  It once used int j,
+	 * 	for (j = 0; j < PTRS_PER_PMD; j++)
+	 * 		free_one_pmd(pmd+j);
+	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
+	 * terminated the loop with a _signed_ address comparison
+	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
+	 * If also configured for 3GB of kernel virtual address space,
+	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
+	 * a pmd, when that mm exits the loop goes on to free "entries"
+	 * found at 0x80000000 onwards.  The loop below compiles instead
+	 * to be terminated by unsigned address comparison using "jb".
+	 */
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++)
+		free_one_pmd(tlb,md);
 	pmd_free_tlb(tlb, pmd);
 }
 

