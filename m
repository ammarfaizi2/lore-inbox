Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbRGBPyT>; Mon, 2 Jul 2001 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbRGBPyK>; Mon, 2 Jul 2001 11:54:10 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:45278 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265315AbRGBPxx>; Mon, 2 Jul 2001 11:53:53 -0400
Date: Mon, 2 Jul 2001 11:53:51 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix kernel linker scripts
Message-ID: <20010702115351.B11623@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Apparently all kernel scripts only have .rodata and not also .rodata.* input
sections in it.
This has been no problem so far, but since binutils and gcc support SHF_MERGE
sections (so that string constant (and other constant too) duplicates can be
removed at link time) the compiler creates sections like .rodata.str1.1
and they really should be merged into the rodata output section
(or whatever else) during linking (the default binutils linker scripts are
doing this for ages).
On some architectures it creates no problems, just one more section in
section table (like i386), on others it causes the kernel not to boot at all
(e.g. on ia64).
Please apply.

--- linux/arch/alpha/boot/bootloader.lds.jj	Sun Sep  6 13:34:33 1998
+++ linux/arch/alpha/boot/bootloader.lds	Tue Jun 26 11:05:14 2001
@@ -6,7 +6,7 @@ SECTIONS
   .text : { *(.text) }
   _etext = .;
   PROVIDE (etext = .);
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .data : { *(.data) CONSTRUCTORS }
   .got : { *(.got) }
   .sdata : { *(.sdata) }
--- linux/arch/alpha/vmlinux.lds.in.jj	Mon Jun 26 14:26:56 2000
+++ linux/arch/alpha/vmlinux.lds.in	Tue Jun 26 11:05:24 2001
@@ -53,7 +53,7 @@ SECTIONS
   /* Global data */
   _data = .;
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .data : { *(.data) CONSTRUCTORS }
   .got : { *(.got) }
   .sdata : { *(.sdata) }
--- linux/arch/arm/boot/compressed/vmlinux.lds.in.jj	Thu Feb  8 19:32:44 2001
+++ linux/arch/arm/boot/compressed/vmlinux.lds.in	Tue Jun 26 11:05:35 2001
@@ -24,6 +24,7 @@ SECTIONS
     *(.fixup)
     *(.gnu.warning)
     *(.rodata)
+    *(.rodata.*)
     *(.glue_7)
     *(.glue_7t)
     input_data = .;
--- linux/arch/arm/vmlinux-armo.lds.in.jj	Thu Feb  8 19:32:44 2001
+++ linux/arch/arm/vmlinux-armo.lds.in	Tue Jun 26 11:05:49 2001
@@ -47,6 +47,7 @@ SECTIONS
 			*(.gnu.warning)
 			*(.text.lock)	/* out-of-line lock text */
 			*(.rodata)
+			*(.rodata.*)
 			*(.glue_7)
 			*(.glue_7t)
 			*(.kstrtab)
--- linux/arch/arm/vmlinux-armv.lds.in.jj	Wed May 16 18:25:16 2001
+++ linux/arch/arm/vmlinux-armv.lds.in	Tue Jun 26 11:05:57 2001
@@ -42,6 +42,7 @@ SECTIONS
 			*(.gnu.warning)
 			*(.text.lock)	/* out-of-line lock text */
 			*(.rodata)
+			*(.rodata.*)
 			*(.glue_7)
 			*(.glue_7t)
 		*(.got)			/* Global offset table		*/
--- linux/arch/cris/boot/compressed/decompress.ld.jj	Fri Apr  6 13:42:55 2001
+++ linux/arch/cris/boot/compressed/decompress.ld	Tue Jun 26 11:06:04 2001
@@ -13,6 +13,7 @@ SECTIONS
 		_stext = . ;
 		*(.text)
 		*(.rodata)
+		*(.rodata.*)
 		_etext = . ;
 	} > dram
 	.data :
--- linux/arch/cris/cris.ld.jj	Tue May  1 19:04:56 2001
+++ linux/arch/cris/cris.ld	Tue Jun 26 11:06:23 2001
@@ -24,7 +24,7 @@ SECTIONS
 		*(.fixup)
 		*(.text.__*)
 		*(.rodata)
-		*(.rodata.__*)
+		*(.rodata.*)
 	}
 
 	. = ALIGN(4);                /* Exception table */
--- linux/arch/i386/vmlinux.lds.jj	Wed Jan  3 23:45:26 2001
+++ linux/arch/i386/vmlinux.lds	Tue Jun 26 11:06:33 2001
@@ -17,7 +17,7 @@ SECTIONS
 
   _etext = .;			/* End of text section */
 
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
--- linux/arch/ia64/boot/bootloader.lds.jj	Sun Feb  6 21:42:40 2000
+++ linux/arch/ia64/boot/bootloader.lds	Tue Jun 26 11:06:42 2001
@@ -12,7 +12,7 @@ SECTIONS
 
   /* Global data */
   _data = .;
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .data    : { *(.data) *(.gnu.linkonce.d*) CONSTRUCTORS }
   __gp = ALIGN (8) + 0x200000;
   .got           : { *(.got.plt) *(.got) }
--- linux/arch/ia64/sn/fprom/fprom.lds.jj	Thu Jan  4 16:00:15 2001
+++ linux/arch/ia64/sn/fprom/fprom.lds	Tue Jun 26 11:07:02 2001
@@ -24,7 +24,7 @@ SECTIONS
   _data = .;
 
   .rodata : AT(ADDR(.rodata) - 0x0000000000000000 )
-	{ *(.rodata) }
+	{ *(.rodata) *(.rodata.*) }
   .opd : AT(ADDR(.opd) - 0x0000000000000000 )
 	{ *(.opd) }
   .data : AT(ADDR(.data) - 0x0000000000000000 )
--- linux/arch/ia64/vmlinux.lds.S.jj	Thu Apr  5 15:51:47 2001
+++ linux/arch/ia64/vmlinux.lds.S	Tue Jun 26 11:07:15 2001
@@ -83,7 +83,7 @@ SECTIONS
   ia64_unw_end = .;
 
   .rodata : AT(ADDR(.rodata) - PAGE_OFFSET)
-	{ *(.rodata) }
+	{ *(.rodata) *(.rodata.*) }
   .kstrtab : AT(ADDR(.kstrtab) - PAGE_OFFSET)
 	{ *(.kstrtab) }
   .opd : AT(ADDR(.opd) - PAGE_OFFSET)
--- linux/arch/m68k/vmlinux.lds.jj	Sat Sep  4 16:06:41 1999
+++ linux/arch/m68k/vmlinux.lds	Tue Jun 26 11:07:26 2001
@@ -12,7 +12,7 @@ SECTIONS
 	*(.text.lock)		/* out-of-line lock text */
 	*(.gnu.warning)
 	} = 0x4e75
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
--- linux/arch/m68k/vmlinux-sun3.lds.jj	Sat Sep  4 16:06:41 1999
+++ linux/arch/m68k/vmlinux-sun3.lds	Tue Jun 26 11:07:33 2001
@@ -20,6 +20,7 @@ SECTIONS
 
   .data : {			/* Data */
 	*(.rodata)
+	*(.rodata.*)
 	*(.data)
 	CONSTRUCTORS
   	. = ALIGN(16);		/* Exception table */
--- linux/arch/mips/baget/ld.script.balo.jj	Fri Jun 25 20:40:12 1999
+++ linux/arch/mips/baget/ld.script.balo	Tue Jun 26 11:08:11 2001
@@ -31,6 +31,7 @@ SECTIONS
     _ftext = . ;
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
--- linux/arch/mips/dec/boot/ld.ecoff.jj	Fri Jun 25 20:40:12 1999
+++ linux/arch/mips/dec/boot/ld.ecoff	Tue Jun 26 11:08:24 2001
@@ -13,7 +13,7 @@ SECTIONS
   }
   .rdata :
   {
-    *(.rodata .rdata)
+    *(.rodata .rodata.* .rdata)
   }
   .data :
   {
--- linux/arch/mips/ld.script.big.jj	Wed Jul 12 18:14:41 2000
+++ linux/arch/mips/ld.script.big	Tue Jun 26 11:07:44 2001
@@ -11,6 +11,7 @@ SECTIONS
     _ftext = . ;
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
--- linux/arch/mips/ld.script.little.jj	Wed Jul 12 18:14:41 2000
+++ linux/arch/mips/ld.script.little	Tue Jun 26 11:07:54 2001
@@ -11,6 +11,7 @@ SECTIONS
     _ftext = . ;
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
--- linux/arch/mips64/ld.script.elf64.jj	Wed Nov 29 00:42:04 2000
+++ linux/arch/mips64/ld.script.elf64	Tue Jun 26 11:08:35 2001
@@ -18,6 +18,7 @@ SECTIONS
   .text : {
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
--- linux/arch/mips64/ld.script.elf32.S.jj	Wed Nov 29 00:42:04 2000
+++ linux/arch/mips64/ld.script.elf32.S	Tue Jun 26 11:08:43 2001
@@ -8,6 +8,7 @@ SECTIONS
   {
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
--- linux/arch/parisc/vmlinux.lds.jj	Tue Dec  5 15:29:39 2000
+++ linux/arch/parisc/vmlinux.lds	Tue Jun 26 11:08:54 2001
@@ -22,7 +22,7 @@ SECTIONS
 	} = 0
 
   . = ALIGN(16);
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
   _etext = .;			/* End of text section */
--- linux/arch/ppc/boot/pmac/ld.script.jj	Thu May 24 18:02:07 2001
+++ linux/arch/ppc/boot/pmac/ld.script	Tue Jun 26 11:09:04 2001
@@ -32,6 +32,7 @@ SECTIONS
   {
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     *(.got1)
   }
--- linux/arch/ppc/boot/tree/ld.script.jj	Thu May 24 18:02:07 2001
+++ linux/arch/ppc/boot/tree/ld.script	Tue Jun 26 11:09:17 2001
@@ -32,6 +32,7 @@ SECTIONS
   {
     *(.text)
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
     *(.got1)
   }
--- linux/arch/ppc/vmlinux.lds.jj	Fri Aug  4 14:23:37 2000
+++ linux/arch/ppc/vmlinux.lds	Tue Jun 26 11:09:30 2001
@@ -39,6 +39,7 @@ SECTIONS
   .rodata    :
   {
     *(.rodata)
+    *(.rodata.*)
     *(.rodata1)
   }
   .kstrtab   : { *(.kstrtab) }
--- linux/arch/s390/vmlinux.lds.jj	Tue Feb 13 17:13:44 2001
+++ linux/arch/s390/vmlinux.lds	Tue Jun 26 11:09:39 2001
@@ -14,7 +14,7 @@ SECTIONS
 	*(.gnu.warning)
 	} = 0x0700
   .text.lock : { *(.text.lock) }	/* out-of-line lock text */
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
--- linux/arch/s390x/vmlinux.lds.jj	Wed Apr 11 22:02:29 2001
+++ linux/arch/s390x/vmlinux.lds	Tue Jun 26 11:09:46 2001
@@ -14,7 +14,7 @@ SECTIONS
 	*(.gnu.warning)
 	} = 0x0700
   .text.lock : { *(.text.lock) }	/* out-of-line lock text */
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
--- linux/arch/sh/vmlinux.lds.S.jj	Fri Dec 29 17:07:20 2000
+++ linux/arch/sh/vmlinux.lds.S	Tue Jun 26 11:09:54 2001
@@ -24,7 +24,7 @@ SECTIONS
 	*(.gnu.warning)
 	} = 0x0009
   .text.lock : { *(.text.lock) }	/* out-of-line lock text */
-  .rodata : { *(.rodata) }
+  .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
--- linux/arch/sparc/vmlinux.lds.jj	Thu Nov  9 18:57:41 2000
+++ linux/arch/sparc/vmlinux.lds	Tue Jun 26 11:10:03 2001
@@ -12,7 +12,7 @@ SECTIONS
   } =0
   _etext = .;
   PROVIDE (etext = .);
-  .rodata    : { *(.rodata)  }
+  .rodata    : { *(.rodata) *(.rodata.*) }
   .rodata1   : { *(.rodata1) }
   .data    :
   {
--- linux/arch/sparc64/vmlinux.lds.jj	Thu Nov  9 18:57:41 2000
+++ linux/arch/sparc64/vmlinux.lds	Tue Jun 26 11:10:13 2001
@@ -16,7 +16,7 @@ SECTIONS
   } =0
   _etext = .;
   PROVIDE (etext = .);
-  .rodata    : { *(.rodata)  }
+  .rodata    : { *(.rodata) *(.rodata.*) }
   .rodata1   : { *(.rodata1) }
   .data    :
   {

	Jakub

