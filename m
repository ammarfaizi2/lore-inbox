Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSAOOEk>; Tue, 15 Jan 2002 09:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289582AbSAOOEV>; Tue, 15 Jan 2002 09:04:21 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:53915 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289581AbSAOOEC>; Tue, 15 Jan 2002 09:04:02 -0500
Date: Tue, 15 Jan 2002 09:07:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020115090746.B6007@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 07:22:23PM +0000, Hugh Dickins wrote:
> This patch is not actually what we've used.  Paranoia (what other
> such bugs might there be?) drove me to set physical pages 0x3ffff
> and 0x40000 as Reserved in arch/i386/setup.c.  I don't think it's
> appropriate to force that level of paranoia on others; but anyone
> configuring 3GBK should remember that it's a less-travelled path.
>
> Hugh

Thanks for the patch!  I'm running on it on a 1024MB machine with
the 2GB option, and it passes LTP runalltests.sh.

The 3 patches in this thread combined into one, with a default
config option of 2GB, and help saying, if unsure, say "1GB":


diff -nur linux-2.4.18pre2aa2/Documentation/Configure.help
linux/Documentation/Configure.help
--- linux-2.4.18pre2aa2/Documentation/Configure.help	Tue Jan 15 00:01:38
2002
+++ linux/Documentation/Configure.help	Mon Jan 14 23:59:35 2002
@@ -376,6 +376,59 @@
   Select this if you have a 32-bit processor and more than 4
   gigabytes of physical RAM.
 
+# Choice: maxvm
+Maximum Virtual Memory
+CONFIG_1GB
+  If you have 4 Gigabytes of physical memory or less, you can change
+  where the where the kernel maps high memory.  If you have less 
+  than 1 gigabyte of physical memory, you should disable 
+  CONFIG_HIGHMEM4G because you don't need the choices below.
+
+  If you have a large amount of physical memory, all of it may not
+  be "permanently mapped" by the kernel. The physical memory that
+  is not permanently mapped is called "high memory".
+
+  The numbers in the configuration options are not precise because
+  of the kernel's vmalloc() area, and the PCI space on motherboards
+  may vary as well.  Typically there will 128 megabytes less 
+  "user memory" mapped than the number in the configuration option.  
+  Saying that another way, "high memory" will usually start 128 
+  megabytes lower than the configuration option.
+
+  Selecting "05GB" results in a "3.5GB/0.5GB" kernel/user split: 
+  3.5 gigabytes are kernel mapped so each process sees a 3.5
+  gigabyte virtual memory space and the remaining part of the 4
+  gigabyte virtual memory space is used by the kernel to permanently
+  map as much physical memory as possible.  On a system with 1 gigabyte
+  of physical memory, you may get 384 megabytes of "user memory" and 
+  640 megabytes of "high memory" with this selection.
+
+  Selecting "1GB" results in a "3GB/1GB" kernel/user split: 
+  3 gigabytes are mapped so each process sees a 3 gigabyte virtual
+  memory space and the remaining part of the 4 gigabyte virtual memory
+  space is used by the kernel to permanently map as much physical
+  memory as possible.  On a system with 1 gigabyte of memory, you may
+  get 896 MB of "user memory" and 128 megabytes of "high memory"
+
+  Selecting "2GB" results in a "2GB/2GB" kernel/user split:
+  2 gigabytes are mapped so each process sees a 2 gigabyte virtual
+  memory space and the remaining part of the 4 gigabyte virtual memory
+  space is used by the kernel to permanently map as much physical
+  memory as possible.  On a system with 1 to 1.75 gigabytes of
+  physical memory, this option have all make it so no memory is
+  mapped as "high memory".
+
+  Selecting "3GB" results in a "1GB/3GB" kernel/user split:
+  1 gigabyte is mapped so each process sees a 1 gigabyte virtual
+  memory space and the remaining part of the 4 gigabytes of virtual
+  memory space is used by the kernel to permanently map as much
+  physical memory as possible.
+
+  Options "2GB" and "3GB" may expose bugs that were dormant in
+  certain hardware, compilers, and possibly even the kernel.
+
+  If unsure, say "1GB".
+
 HIGHMEM I/O support
 CONFIG_HIGHIO
   If you want to be able to do I/O to high memory pages, say Y.
diff -nur linux-2.4.18pre2aa2/Rules.make linux/Rules.make
--- linux-2.4.18pre2aa2/Rules.make	Tue Mar  6 22:31:01 2001
+++ linux/Rules.make	Mon Jan 14 23:58:55 2002
@@ -212,6 +212,7 @@
 #
 # Added the SMP separator to stop module accidents between uniprocessor
 # and SMP Intel boxes - AC - from bits by Michael Chastain
+# Added separator for different PAGE_OFFSET memory models - Ingo.
 #
 
 ifdef CONFIG_SMP
@@ -220,6 +221,22 @@
 	genksyms_smp_prefix := 
 endif
 
+ifdef CONFIG_2GB
+ifdef CONFIG_SMP
+	genksyms_smp_prefix := -p smp_2gig_
+else
+	genksyms_smp_prefix := -p 2gig_
+endif
+endif
+
+ifdef CONFIG_3GB
+ifdef CONFIG_SMP
+	genksyms_smp_prefix := -p smp_3gig_
+else
+	genksyms_smp_prefix := -p 3gig_
+endif
+endif
+
 $(MODINCL)/%.ver: %.c
 	@if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then
\
 		echo '$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<';
\
diff -nur linux-2.4.18pre2aa2/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.18pre2aa2/arch/i386/config.in	Tue Jan 15 00:01:38 2002
+++ linux/arch/i386/config.in	Mon Jan 14 23:58:55 2002
@@ -169,7 +169,11 @@
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_X86_PAE y
 else
-   bool '3.5GB user address space' CONFIG_05GB
+   choice 'Maximum Virtual Memory' \
+	"3GB		CONFIG_1GB \
+	 2GB		CONFIG_2GB \
+	 1GB		CONFIG_3GB \
+	 05GB		CONFIG_05GB" 2GB
 fi
 if [ "$CONFIG_NOHIGHMEM" = "y" ]; then
    define_bool CONFIG_NO_PAGE_VIRTUAL y
@@ -179,6 +183,7 @@
    bool 'HIGHMEM I/O support (EXPERIMENTAL)' CONFIG_HIGHIO
 fi
 
+
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
diff -nur linux-2.4.18pre2aa2/include/asm-i386/page_offset.h
linux/include/asm-i386/page_offset.h
--- linux-2.4.18pre2aa2/include/asm-i386/page_offset.h	Tue Jan 15 00:01:38
2002
+++ linux/include/asm-i386/page_offset.h	Mon Jan 14 23:58:55 2002
@@ -1,6 +1,10 @@
 #include <linux/config.h>
-#ifndef CONFIG_05GB
-#define PAGE_OFFSET_RAW 0xC0000000
-#else
+#ifdef CONFIG_05GB
 #define PAGE_OFFSET_RAW 0xE0000000
+#elif defined(CONFIG_1GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#elif defined(CONFIG_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_3GB)
+#define PAGE_OFFSET_RAW 0x40000000
 #endif
diff -nur linux-2.4.18pre2aa2/mm/memory.c linux/mm/memory.c
--- linux-2.4.18pre2aa2/mm/memory.c	Tue Jan 15 00:01:38 2002
+++ linux/mm/memory.c	Mon Jan 14 23:59:18 2002
@@ -106,8 +106,7 @@
 
 static inline void free_one_pgd(pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -118,9 +117,23 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(pmd+j);
+
+	/*
+	 * Beware if changing the loop below.  It once used int j,
+	 *	for (j = 0; j < PTRS_PER_PMD; j++)
+	 *		free_one_pmd(pmd+j);
+	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
+	 * terminated the loop with a _signed_ address comparison
+	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
+	 * If also configured for 3GB of kernel virtual address space,
+	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
+	 * a pmd, when that mm exits the loop goes on to free "entries"
+	 * found at 0x80000000 onwards.  The loop below compiles instead
+	 * to be terminated by unsigned address comparison using "jb".
+	 */
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
+		prefetchw(md+(PREFETCH_STRIDE/16));
+		free_one_pmd(md);
 	}
 	pmd_free(pmd);
 }
-- 
Randy Hron

