Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315271AbSEGXIz>; Tue, 7 May 2002 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315280AbSEGXIy>; Tue, 7 May 2002 19:08:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23036 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315271AbSEGXIk>; Tue, 7 May 2002 19:08:40 -0400
Subject: Re: x86 question: Can a process have > 3GB memory?
From: Robert Love <rml@tech9.net>
To: Clifford White <ctwhite@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com>
Content-Type: multipart/mixed; boundary="=-g3LKlJNc+b3GdENEb2Bn"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 07 May 2002 16:08:55 -0700
Message-Id: <1020812936.2079.31.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g3LKlJNc+b3GdENEb2Bn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-05-07 at 16:03, Clifford White wrote:

> We are working with a database that requires a large amount of memory
> allocated by a single process.
> This is on an Intel 32-bit platform.
> We'd like to go > 3GB of memory per process.
> Is this possible on a 32-bit machine? I have been reading the various
> 'highmem' discussions, but that's kernel page tables...
> Or is this a glibc issue, and not proper for a kernel-list question?
> Any pointers would be appreciated. The Intel ESMA (Extended Server Memory
> Arch) page states that it's possible, but.....how?

You can go to 3.5GB, anything more and stuff starts getting real tight
and not very nice.  You can only do 3.5/0.5 on non-PAE, though - PAE
requires segments to be aligned on 1GB-boundaries.

The attached patch (for which credit goes elsewhere - Ingo or Randy, I
think?) implements the full range of 1 to 3.5GB user space partitioning,
selectable at compile-time.

	Robert Love


--=-g3LKlJNc+b3GdENEb2Bn
Content-Disposition: attachment; filename=00_3.5G-address-space-4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=00_3.5G-address-space-4.patch; charset=ISO-8859-1

diff -urN 2.4.18pre7/Rules.make 3g/Rules.make
--- 2.4.18pre7/Rules.make	Thu Jan 24 02:05:25 2002
+++ 3g/Rules.make	Mon Jan 28 05:55:28 2002
@@ -214,12 +214,29 @@
 #
 # Added the SMP separator to stop module accidents between uniprocessor
 # and SMP Intel boxes - AC - from bits by Michael Chastain
+# Added separator for different PAGE_OFFSET memory models - Ingo.
 #
=20
 ifdef CONFIG_SMP
 	genksyms_smp_prefix :=3D -p smp_
 else
 	genksyms_smp_prefix :=3D=20
+endif
+
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
 endif
=20
 $(MODINCL)/%.ver: %.c
diff -urN 2.4.18pre7/arch/i386/Makefile 3g/arch/i386/Makefile
--- 2.4.18pre7/arch/i386/Makefile	Tue May  1 19:35:18 2001
+++ 3g/arch/i386/Makefile	Mon Jan 28 05:55:28 2002
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
diff -urN 2.4.18pre7/arch/i386/config.in 3g/arch/i386/config.in
--- 2.4.18pre7/arch/i386/config.in	Thu Jan 24 02:05:26 2002
+++ 3g/arch/i386/config.in	Mon Jan 28 05:55:30 2002
@@ -171,12 +171,23 @@
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
diff -urN 2.4.18pre7/arch/i386/vmlinux.lds 3g/arch/i386/vmlinux.lds
--- 2.4.18pre7/arch/i386/vmlinux.lds	Thu Jan 24 02:05:26 2002
+++ 3g/arch/i386/vmlinux.lds	Thu Jan  1 01:00:00 1970
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
diff -urN 2.4.18pre7/arch/i386/vmlinux.lds.S 3g/arch/i386/vmlinux.lds.S
--- 2.4.18pre7/arch/i386/vmlinux.lds.S	Thu Jan  1 01:00:00 1970
+++ 3g/arch/i386/vmlinux.lds.S	Mon Jan 28 05:55:28 2002
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
diff -urN 2.4.18pre7/include/asm-i386/page.h 3g/include/asm-i386/page.h
--- 2.4.18pre7/include/asm-i386/page.h	Thu Jan 24 02:06:02 2002
+++ 3g/include/asm-i386/page.h	Mon Jan 28 05:55:28 2002
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
diff -urN 2.4.18pre7/include/asm-i386/page_offset.h 3g/include/asm-i386/pag=
e_offset.h
--- 2.4.18pre7/include/asm-i386/page_offset.h	Thu Jan  1 01:00:00 1970
+++ 3g/include/asm-i386/page_offset.h	Mon Jan 28 05:55:28 2002
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
diff -urN 2.4.18pre7/include/asm-i386/processor.h 3g/include/asm-i386/proce=
ssor.h
--- 2.4.18pre7/include/asm-i386/processor.h	Tue Jan 22 18:55:59 2002
+++ 3g/include/asm-i386/processor.h	Mon Jan 28 05:55:28 2002
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
diff -urN 2.4.18pre7/mm/memory.c 3g/mm/memory.c
--- 2.4.18pre7/mm/memory.c	Tue Jan 22 18:56:30 2002
+++ 3g/mm/memory.c	Mon Jan 28 05:55:28 2002
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

--=-g3LKlJNc+b3GdENEb2Bn--

