Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316828AbSE1PqF>; Tue, 28 May 2002 11:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316830AbSE1PqE>; Tue, 28 May 2002 11:46:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27641 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316828AbSE1Ppz>; Tue, 28 May 2002 11:45:55 -0400
Subject: Re: changing __PAGE_OFFSET on x86?
From: Robert Love <rml@tech9.net>
To: Josh Fryman <fryman@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020528101515.56785de1.fryman@cc.gatech.edu>
Content-Type: multipart/mixed; boundary="=-ZeYyRfqB5tP7o2ZlBKSo"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 08:45:54 -0700
Message-Id: <1022600754.20317.37.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZeYyRfqB5tP7o2ZlBKSo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-05-28 at 07:15, Josh Fryman wrote:

> to fix this, if we change the __PAGE_OFFSET in include/asm-i386/page.h from
> 0xc0000000 to 0xb000000, are there any hidden dependencies?

Yes, you need to edit arch/i386/vmlinux.lds as well.  Specifically, this
line:

      . = 0xC0000000 + 0x100000;	/* edit the 0xc0000000 */

to make it easier, there is a patch to let you configure a kernel /
user-space memory split at compile-time during configure.  It is by
Andrea - I have attached it.  This is a local copy in which I have added
some configure help.

> (does the __PAGE_OFFSET need to lie on a 1G boundary?)

If you are using PAE, yes - otherwise no.

	Robert Love

--=-ZeYyRfqB5tP7o2ZlBKSo
Content-Disposition: attachment; filename=config-address-space-rml-2.4.18-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=config-address-space-rml-2.4.18-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.18-preempt-lb/Documentation/Configure.help linux/Docume=
ntation/Configure.help
--- linux-2.4.18-preempt-lb/Documentation/Configure.help	Sat Apr 20 16:59:1=
3 2002
+++ linux/Documentation/Configure.help	Tue Apr 23 15:34:18 2002
@@ -399,6 +399,49 @@
   Select this if you have a 32-bit processor and more than 4
   gigabytes of physical RAM.
=20
+# Choice: address_size
+User address space size
+CONFIG_1GB
+  This option allows you to set the partitioning of the logical address
+  space between user and kernel memory. The Linux address space is 4GB
+  and the default partition is to give 3GB to user and 1GB to
+  kernel-space. This is abbreviated "3GB/1GB".
+
+  Some specialized workloads require a larger user or kernel memory
+  space. For example, specialized network processing often benefits
+  from a larger kernel address space than default.  This options lets
+  you select:
+
+	3GB user / 1GB kernel		(default)
+	2GB user / 2GB kernel
+	1GB user / 3GB kernel
+	3.5GB user / 0.5GB kernel	(non-PAE only)
+
+  Note shrinking the user address space may adversely affect certain
+  applications that assume the user address space is 3GB or otherwise
+  that certain regions of memory exist.  It is recommended that you
+  are sure of your system's compatibility with a given partition scheme
+  before you deploy a system with a partition other than 3GB/1GB.
+
+  If uncertain, select "3GB/1GB".  Note this does not affect the amount
+  of physical memory accessible by Linux but only the addressable
+  per-process memory space.
+
+2GB
+CONFIG_2GB
+  Parition the addressable memory space into 2GB user and 2GB kernel.
+
+3GB
+CONFIG_3GB
+  Partion the addressable memory space into 3GB user and 1GB kernel.
+  This is the default.
+
+3.5GB
+CONFIG_05GB
+  Partition the addressable memory space into 3.5GB user and 0.5GB
+  kernel.  This is only valid if PAE (CONFIG_HIGHMEM64G) is not
+  enabled, since segments under PAE must lie on 1GB boundaries.
+
 Normal floppy disk support
 CONFIG_BLK_DEV_FD
   If you want to use the floppy disk drive(s) of your PC under Linux,
diff -urN linux-2.4.18-preempt-lb/Rules.make linux/Rules.make
--- linux-2.4.18-preempt-lb/Rules.make	Sat Apr 20 16:58:06 2002
+++ linux/Rules.make	Tue Apr 23 14:46:47 2002
@@ -214,6 +214,7 @@
 #
 # Added the SMP separator to stop module accidents between uniprocessor
 # and SMP Intel boxes - AC - from bits by Michael Chastain
+# Added separator for different PAGE_OFFSET memory models - Ingo.
 #
=20
 ifdef CONFIG_SMP
@@ -222,6 +223,22 @@
 	genksyms_smp_prefix :=3D=20
 endif
=20
+ifdef CONFIG_2GB
+ifdef CONFIG_SMP
+	genksyms_smp_prefix :=3D -p smp_2gig_
+else
+	genksyms_smp_prefix :=3D -p 2gig_
+endif
+endif
+
+ifdef CONFIG_3GB
+ifdef CONFIG_SMP
+	genksyms_smp_prefix :=3D -p smp_3gig_
+else
+	genksyms_smp_prefix :=3D -p 3gig_
+endif
+endif
+
 $(MODINCL)/%.ver: %.c
 	@if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then \
 		echo '$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<'; \
diff -urN linux-2.4.18-preempt-lb/arch/i386/Makefile linux/arch/i386/Makefi=
le
--- linux-2.4.18-preempt-lb/arch/i386/Makefile	Sat Apr 20 16:58:56 2002
+++ linux/arch/i386/Makefile	Tue Apr 23 14:46:47 2002
@@ -106,6 +106,9 @@
=20
 MAKEBOOT =3D $(MAKE) -C arch/$(ARCH)/boot
=20
+arch/i386/vmlinux.lds: arch/i386/vmlinux.lds.S FORCE
+	$(CPP) -C -P -I$(HPATH) -imacros $(HPATH)/asm-i386/page_offset.h -Ui386 a=
rch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds
+
 vmlinux: arch/i386/vmlinux.lds
=20
 FORCE: ;
@@ -142,6 +145,7 @@
 	@$(MAKEBOOT) clean
=20
 archmrproper:
+	rm -f arch/i386/vmlinux.lds
=20
 archdep:
 	@$(MAKEBOOT) dep
diff -urN linux-2.4.18-preempt-lb/arch/i386/config.in linux/arch/i386/confi=
g.in
--- linux-2.4.18-preempt-lb/arch/i386/config.in	Sat Apr 20 16:58:56 2002
+++ linux/arch/i386/config.in	Tue Apr 23 14:46:47 2002
@@ -174,12 +174,23 @@
 	"off    CONFIG_NOHIGHMEM \
 	 4GB    CONFIG_HIGHMEM4G \
 	 64GB   CONFIG_HIGHMEM64G" off
-if [ "$CONFIG_HIGHMEM4G" =3D "y" ]; then
+if [ "$CONFIG_HIGHMEM4G" =3D "y" -o "$CONFIG_HIGHMEM64G" =3D "y" ]; then
    define_bool CONFIG_HIGHMEM y
+else
+   define_bool CONFIG_HIGHMEM n
 fi
 if [ "$CONFIG_HIGHMEM64G" =3D "y" ]; then
-   define_bool CONFIG_HIGHMEM y
    define_bool CONFIG_X86_PAE y
+   choice 'User address space size' \
+	"3GB		CONFIG_1GB \
+	 2GB		CONFIG_2GB \
+	 1GB		CONFIG_3GB" 3GB
+else
+   choice 'User address space size' \
+	"3GB		CONFIG_1GB \
+	 2GB		CONFIG_2GB \
+	 1GB		CONFIG_3GB \
+	 3.5GB		CONFIG_05GB" 3GB
 fi
=20
 bool 'Math emulation' CONFIG_MATH_EMULATION
diff -urN linux-2.4.18-preempt-lb/arch/i386/vmlinux.lds linux/arch/i386/vml=
inux.lds
--- linux-2.4.18-preempt-lb/arch/i386/vmlinux.lds	Sat Apr 20 16:58:56 2002
+++ linux/arch/i386/vmlinux.lds	Wed Dec 31 19:00:00 1969
@@ -1,82 +0,0 @@
-/* ld script to make i386 Linux kernel
- * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
- */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
-OUTPUT_ARCH(i386)
-ENTRY(_start)
-SECTIONS
-{
-  . =3D 0xC0000000 + 0x100000;
-  _text =3D .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} =3D 0x9090
-
-  _etext =3D .;			/* End of text section */
-
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
-
-  . =3D ALIGN(16);		/* Exception table */
-  __start___ex_table =3D .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table =3D .;
-
-  __start___ksymtab =3D .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab =3D .;
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata =3D .;			/* End of data section */
-
-  . =3D ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . =3D ALIGN(4096);		/* Init code and data */
-  __init_begin =3D .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . =3D ALIGN(16);
-  __setup_start =3D .;
-  .setup.init : { *(.setup.init) }
-  __setup_end =3D .;
-  __initcall_start =3D .;
-  .initcall.init : { *(.initcall.init) }
-  __initcall_end =3D .;
-  . =3D ALIGN(4096);
-  __init_end =3D .;
-
-  . =3D ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  . =3D ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  __bss_start =3D .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end =3D . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.text.exit)
-	*(.data.exit)
-	*(.exitcall.exit)
-	}
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
diff -urN linux-2.4.18-preempt-lb/arch/i386/vmlinux.lds.S linux/arch/i386/v=
mlinux.lds.S
--- linux-2.4.18-preempt-lb/arch/i386/vmlinux.lds.S	Wed Dec 31 19:00:00 196=
9
+++ linux/arch/i386/vmlinux.lds.S	Tue Apr 23 14:46:47 2002
@@ -0,0 +1,82 @@
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+SECTIONS
+{
+  . =3D PAGE_OFFSET_RAW + 0x100000;
+  _text =3D .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} =3D 0x9090
+
+  _etext =3D .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . =3D ALIGN(16);		/* Exception table */
+  __start___ex_table =3D .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table =3D .;
+
+  __start___ksymtab =3D .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab =3D .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata =3D .;			/* End of data section */
+
+  . =3D ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . =3D ALIGN(4096);		/* Init code and data */
+  __init_begin =3D .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . =3D ALIGN(16);
+  __setup_start =3D .;
+  .setup.init : { *(.setup.init) }
+  __setup_end =3D .;
+  __initcall_start =3D .;
+  .initcall.init : { *(.initcall.init) }
+  __initcall_end =3D .;
+  . =3D ALIGN(4096);
+  __init_end =3D .;
+
+  . =3D ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . =3D ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start =3D .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end =3D . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.text.exit)
+	*(.data.exit)
+	*(.exitcall.exit)
+	}
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}
diff -urN linux-2.4.18-preempt-lb/include/asm-i386/page.h linux/include/asm=
-i386/page.h
--- linux-2.4.18-preempt-lb/include/asm-i386/page.h	Sat Apr 20 16:57:57 200=
2
+++ linux/include/asm-i386/page.h	Tue Apr 23 14:46:47 2002
@@ -78,7 +78,9 @@
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
=20
-#define __PAGE_OFFSET		(0xC0000000)
+#include <asm/page_offset.h>
+
+#define __PAGE_OFFSET		(PAGE_OFFSET_RAW)
=20
 /*
  * This much address space is reserved for vmalloc() and iomap()
diff -urN linux-2.4.18-preempt-lb/include/asm-i386/page_offset.h linux/incl=
ude/asm-i386/page_offset.h
--- linux-2.4.18-preempt-lb/include/asm-i386/page_offset.h	Wed Dec 31 19:00=
:00 1969
+++ linux/include/asm-i386/page_offset.h	Tue Apr 23 14:46:47 2002
@@ -0,0 +1,10 @@
+#include <linux/config.h>
+#ifdef CONFIG_05GB
+#define PAGE_OFFSET_RAW 0xE0000000
+#elif defined(CONFIG_1GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#elif defined(CONFIG_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_3GB)
+#define PAGE_OFFSET_RAW 0x40000000
+#endif
diff -urN linux-2.4.18-preempt-lb/include/asm-i386/processor.h linux/includ=
e/asm-i386/processor.h
--- linux-2.4.18-preempt-lb/include/asm-i386/processor.h	Sat Apr 20 16:57:5=
7 2002
+++ linux/include/asm-i386/processor.h	Tue Apr 23 14:46:47 2002
@@ -270,7 +270,11 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
+#ifndef CONFIG_05GB
 #define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#else
+#define TASK_UNMAPPED_BASE	(TASK_SIZE / 16)
+#endif
=20
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -urN linux-2.4.18-preempt-lb/mm/memory.c linux/mm/memory.c
--- linux-2.4.18-preempt-lb/mm/memory.c	Sat Apr 20 16:57:55 2002
+++ linux/mm/memory.c	Tue Apr 23 14:46:47 2002
@@ -106,8 +106,7 @@
=20
 static inline void free_one_pgd(pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
=20
 	if (pgd_none(*dir))
 		return;
@@ -118,9 +117,23 @@
 	}
 	pmd =3D pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j =3D 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(pmd+j);
+
+	/*
+	 * Beware if changing the loop below.  It once used int j,
+	 *	for (j =3D 0; j < PTRS_PER_PMD; j++)
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
+	for (md =3D pmd, emd =3D pmd + PTRS_PER_PMD; md < emd; md++) {
+		prefetchw(md+(PREFETCH_STRIDE/16));
+		free_one_pmd(md);
 	}
 	pmd_free(pmd);
 }

--=-ZeYyRfqB5tP7o2ZlBKSo--

