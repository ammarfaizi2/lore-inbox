Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbTAMTFA>; Mon, 13 Jan 2003 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbTAMTFA>; Mon, 13 Jan 2003 14:05:00 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:28050 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268151AbTAMTEq>; Mon, 13 Jan 2003 14:04:46 -0500
Date: Mon, 13 Jan 2003 13:13:28 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, <ebiederm@xmission.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
In-Reply-To: <20030113180450.GA1870@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0301131309240.24477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Sam Ravnborg wrote:

> The purpose was to define common stuff in a single place.
> Ask Rusty Russell if it is fun to add the same section to > 50
> .lds files.
> 
> Based on the feedback I will try to come up with a lighter proposal,
> that does not hurt readability.
> I still want the common stuff separated away.

I second this, though I also agree that your first cut was hiding away 
stuff more than necessary.

I would suggest an approach like the following, of course showing only a 
first simple step. A series of steps like this should allow for a serious 
reduction in size of arch/*/vmlinux.lds.S already, while being obviously 
correct and allowing archs to do their own special thing if necessary (in 
particular, IA64 seems to differ from all the other archs).

--Kai


--- /dev/null	Thu Apr 11 09:25:15 2002
+++ include/asm-generic/vmlinux.lds.h	Mon Jan 13 12:52:56 2003
@@ -0,0 +1,6 @@
+#define EXTABLE                                                               \
+  . = ALIGN(16);                                                              \
+  __start___ex_table = .;                                                     \
+  __ex_table : { *(__ex_table) }                                              \
+  __stop___ex_table = .;                                                      \
+
===== arch/alpha/vmlinux.lds.S 1.14 vs edited =====
--- 1.14/arch/alpha/vmlinux.lds.S	Sun Jan 12 19:12:21 2003
+++ edited/arch/alpha/vmlinux.lds.S	Mon Jan 13 12:53:59 2003
@@ -1,4 +1,5 @@
 #include <linux/config.h>
+#include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-alpha")
 ENTRY(__start)
@@ -18,12 +19,7 @@
 	_etext = .;
   } :kernel
 
-  /* Exception table */
-  __ex_table ALIGN(16) : {
-	__start___ex_table = .;
-	*(__ex_table)
-	__stop___ex_table = .;
-  }
+  EXTABLE
 
   /* Kernel symbol table */
   __ksymtab ALIGN(8) : {
===== arch/arm/vmlinux-armo.lds.in 1.11 vs edited =====
--- 1.11/arch/arm/vmlinux-armo.lds.in	Sun Jan 12 19:12:21 2003
+++ edited/arch/arm/vmlinux-armo.lds.in	Mon Jan 13 12:55:04 2003
@@ -2,6 +2,9 @@
  * taken from the i386 version by Russell King
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
+
+#include <asm-generic/vmlinux.lds.h>
+	
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 jiffies = jiffies_64;
@@ -65,12 +68,7 @@
 
 	.kstrtab : { *(.kstrtab) }
 
-	. = ALIGN(16);
-	__ex_table : {			/* Exception table		*/
-		__start___ex_table = .;
-			*(__ex_table)
-		__stop___ex_table = .;
-	}
+	EXTABLE
 
 	__ksymtab : {			/* Kernel symbol table		*/
 		__start___ksymtab = .;
===== arch/arm/vmlinux-armv.lds.in 1.18 vs edited =====
--- 1.18/arch/arm/vmlinux-armv.lds.in	Sun Jan 12 22:21:35 2003
+++ edited/arch/arm/vmlinux-armv.lds.in	Mon Jan 13 12:55:31 2003
@@ -2,6 +2,9 @@
  * taken from the i386 version by Russell King
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
+
+#include <asm-generic/vmlinux.lds.h>
+	
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 jiffies = jiffies_64;
@@ -68,12 +71,7 @@
 
 	.kstrtab : { *(.kstrtab) }
 
-	. = ALIGN(16);
-	__ex_table : {			/* Exception table		*/
-		__start___ex_table = .;
-			*(__ex_table)
-		__stop___ex_table = .;
-	}
+	EXTABLE
 
 	__gpl_ksymtab : {		/* GPL Kernel symbol table	*/
 		__start___gpl_ksymtab = .;
===== arch/cris/vmlinux.lds.S 1.13 vs edited =====
--- 1.13/arch/cris/vmlinux.lds.S	Sun Jan 12 19:12:21 2003
+++ edited/arch/cris/vmlinux.lds.S	Mon Jan 13 12:56:26 2003
@@ -9,7 +9,8 @@
  */	
 
 #include <linux/config.h>
-	
+#include <asm-generic/vmlinux.lds.h>
+
 jiffies = jiffies_64;
 SECTIONS
 {
@@ -34,10 +35,7 @@
 	.rodata : { *(.rodata) *(.rodata.__*) }
 	.kstrtab : { *(.kstrtab) }
 
-	. = ALIGN(4);                /* Exception table */
-  	__start___ex_table = .;
-  	__ex_table : { *(__ex_table) }
-  	__stop___ex_table = .;
+	EXTABLE
 
   	__start___ksymtab = .;        /* Kernel symbol table */
   	__ksymtab : { *(__ksymtab) }
===== arch/i386/vmlinux.lds.S 1.22 vs edited =====
--- 1.22/arch/i386/vmlinux.lds.S	Sun Jan 12 19:12:21 2003
+++ edited/arch/i386/vmlinux.lds.S	Mon Jan 13 12:54:19 2003
@@ -1,6 +1,9 @@
 /* ld script to make i386 Linux kernel
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
+
+#include <asm-generic/vmlinux.lds.h>
+	
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
@@ -21,10 +24,7 @@
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   . = ALIGN(64);
   __start___ksymtab = .;	/* Kernel symbol table */
===== arch/m68k/vmlinux-std.lds 1.12 vs edited =====
--- 1.12/arch/m68k/vmlinux-std.lds	Sun Jan 12 19:12:21 2003
+++ edited/arch/m68k/vmlinux-std.lds	Mon Jan 13 12:59:13 2003
@@ -1,4 +1,7 @@
 /* ld script to make m68k Linux kernel */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
 OUTPUT_ARCH(m68k)
 ENTRY(_start)
@@ -15,10 +18,7 @@
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
===== arch/m68k/vmlinux-sun3.lds 1.9 vs edited =====
--- 1.9/arch/m68k/vmlinux-sun3.lds	Sun Jan 12 19:12:21 2003
+++ edited/arch/m68k/vmlinux-sun3.lds	Mon Jan 13 12:58:44 2003
@@ -1,4 +1,7 @@
 /* ld script to make m68k Linux kernel */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
 OUTPUT_ARCH(m68k)
 ENTRY(_start)
@@ -23,10 +26,7 @@
 	*(.rodata.*)
 	*(.data)
 	CONSTRUCTORS
-  	. = ALIGN(16);		/* Exception table */
-  	__start___ex_table = .;
-  	*(__ex_table) 
-  	__stop___ex_table = .;
+	EXTABLE
   	__start___ksymtab = .;	/* Kernel symbol table */
   	*(__ksymtab) 
   	__stop___ksymtab = .;
===== arch/mips/vmlinux.lds.S 1.5 vs edited =====
--- 1.5/arch/mips/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/mips/vmlinux.lds.S	Mon Jan 13 13:08:00 2003
@@ -1,3 +1,5 @@
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
 SECTIONS
@@ -16,10 +18,7 @@
   } =0
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   __start___dbe_table = .;	/* Exception table for data bus errors */
   __dbe_table : { *(__dbe_table) }
===== arch/mips64/vmlinux.lds.S 1.4 vs edited =====
--- 1.4/arch/mips64/vmlinux.lds.S	Fri Aug 16 22:08:39 2002
+++ edited/arch/mips64/vmlinux.lds.S	Mon Jan 13 13:07:57 2003
@@ -1,3 +1,5 @@
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
 SECTIONS
@@ -15,10 +17,7 @@
   } =0
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   __start___dbe_table = .;	/* Exception table for data bus errors */
   __dbe_table : { *(__dbe_table) }
===== arch/parisc/vmlinux.lds.S 1.8 vs edited =====
--- 1.8/arch/parisc/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/parisc/vmlinux.lds.S	Mon Jan 13 13:00:53 2003
@@ -1,5 +1,6 @@
 #include <linux/config.h>
-
+#include <asm-generic/vmlinux.lds.h>
+	
 /* ld script to make hppa Linux kernel */
 #ifndef CONFIG_PARISC64
 OUTPUT_FORMAT("elf32-hppa-linux")
@@ -40,11 +41,8 @@
 	*(.data)
 	}
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
+	
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
===== arch/ppc/vmlinux.lds.S 1.15 vs edited =====
--- 1.15/arch/ppc/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/ppc/vmlinux.lds.S	Mon Jan 13 13:01:40 2003
@@ -1,3 +1,5 @@
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_ARCH(powerpc)
 SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
 /* Do we need any of these for elf?
@@ -53,9 +55,7 @@
 
   .fixup   : { *(.fixup) }
 
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
===== arch/ppc64/vmlinux.lds.S 1.11 vs edited =====
--- 1.11/arch/ppc64/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/ppc64/vmlinux.lds.S	Mon Jan 13 13:02:06 2003
@@ -1,3 +1,5 @@
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_ARCH(powerpc:common64)
 /* Do we need any of these for elf?
    __DYNAMIC = 0;    */
@@ -61,9 +63,7 @@
   _edata  =  .;
   PROVIDE (edata = .);
 
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE	
 
   __start___ksymtab = .;        /* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
===== arch/s390/vmlinux.lds.S 1.6 vs edited =====
--- 1.6/arch/s390/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/s390/vmlinux.lds.S	Mon Jan 13 13:03:08 2003
@@ -1,6 +1,9 @@
 /* ld script to make s390 Linux kernel
  * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
@@ -20,10 +23,7 @@
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   . = ALIGN(64);
   __start___ksymtab = .;	/* Kernel symbol table */
===== arch/s390x/vmlinux.lds.S 1.6 vs edited =====
--- 1.6/arch/s390x/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/s390x/vmlinux.lds.S	Mon Jan 13 13:03:27 2003
@@ -1,6 +1,9 @@
 /*	
  * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390:64-bit)
 ENTRY(_start)
@@ -20,10 +23,7 @@
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   . = ALIGN(64);
   __start___ksymtab = .;	/* Kernel symbol table */
===== arch/sh/vmlinux.lds.S 1.7 vs edited =====
--- 1.7/arch/sh/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/sh/vmlinux.lds.S	Mon Jan 13 13:03:55 2003
@@ -3,6 +3,8 @@
  * Written by Niibe Yutaka
  */
 #include <linux/config.h>
+#include <asm-generic/vmlinux.lds.h>
+
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 OUTPUT_FORMAT("elf32-sh-linux", "elf32-sh-linux", "elf32-sh-linux")
 jiffies = jiffies_64;        
@@ -28,10 +30,7 @@
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE	
 
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
===== arch/sparc/vmlinux.lds.S 1.13 vs edited =====
--- 1.13/arch/sparc/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/sparc/vmlinux.lds.S	Mon Jan 13 13:04:28 2003
@@ -1,4 +1,7 @@
 /* ld script to make SparcLinux kernel */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
 OUTPUT_ARCH(sparc)
 ENTRY(_start)
@@ -26,9 +29,8 @@
   __start___fixup = .;
   .fixup   : { *(.fixup) }
   __stop___fixup = .;
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+
+  EXTABLE
 
   . = ALIGN(64);
   __start___ksymtab = .;
===== arch/sparc64/vmlinux.lds.S 1.14 vs edited =====
--- 1.14/arch/sparc64/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/sparc64/vmlinux.lds.S	Mon Jan 13 13:05:01 2003
@@ -1,4 +1,7 @@
 /* ld script to make UltraLinux kernel */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
 OUTPUT_ARCH(sparc:v9a)
 ENTRY(_start)
@@ -30,10 +33,7 @@
   PROVIDE (edata = .);
   .fixup   : { *(.fixup) }
 
-  . = ALIGN(16);
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   . = ALIGN(64);
   __start___ksymtab = .;
===== arch/v850/vmlinux.lds.S 1.4 vs edited =====
--- 1.4/arch/v850/vmlinux.lds.S	Thu Jan  9 00:27:41 2003
+++ edited/arch/v850/vmlinux.lds.S	Mon Jan 13 13:06:04 2003
@@ -12,6 +12,7 @@
  */
 
 #include <linux/config.h>
+#include <asm-generic/vmlinux.lds.h>
 
 
 /* The following macros contain the usual definitions for various data areas.
@@ -44,10 +45,7 @@
 		. = ALIGN (4) ;						      \
 		    	*(.call_table_data)				      \
 			*(.call_table_text)				      \
-		. = ALIGN (16) ;	/* Exception table.  */		      \
-		___start___ex_table = . ;				      \
-			*(__ex_table)					      \
-		___stop___ex_table = . ;				      \
+		EXTABLE                                                       \
 		___start___ksymtab = . ;/* Kernel symbol table.  */	      \
 			*(__ksymtab)					      \
 		___stop___ksymtab = . ;					      \
===== arch/x86_64/vmlinux.lds.S 1.9 vs edited =====
--- 1.9/arch/x86_64/vmlinux.lds.S	Sun Jan 12 19:12:22 2003
+++ edited/arch/x86_64/vmlinux.lds.S	Mon Jan 13 12:58:00 2003
@@ -1,6 +1,9 @@
 /* ld script to make x86-64 Linux kernel
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
+
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(_start)
@@ -21,10 +24,7 @@
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   . = ALIGN(64); 
   __start___ksymtab = .;	/* Kernel symbol table */

