Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUIWSB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUIWSB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIWSB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:01:58 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:31176 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S268203AbUIWR6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:58:52 -0400
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Date: Fri, 24 Sep 2004 02:59:35 +0900
User-Agent: KMail/1.5.4
References: <20040922131210.6c08b94c.akpm@osdl.org>
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409240259.35630.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Added the kexec-based crashdump code.  This is the code which uses kexec
>   to jump into a new mini-kernel when the main kernel crashes.  Userspace
> code in that mini-kernel then dumps the main kernel's memory to disk. 
> These new patches provide the bits and pieces which the mini-kernel needs
> to be able to get at the main kernel's memory.

Interesting feature.

>   There seem to be no hints as to how to get all this working - that will
>   come.

According to "Documentation/kdump.txt", we need to apply the following patches
to build "mini-kernel".

   http://www.xmission.com/~ebiederm/files/kexec/2.6.8.1-kexec3/
        broken-out/highbzImage.i386.patch
   http://www.xmission.com/~ebiederm/files/kexec/2.6.8.1-kexec3/
        broken-out/vmlinux-lds.i386.patch

But, Appling "arch/i386/kernel/vmlinux.lds.S" to 2.6.9-rc2-mm2 failed.

Someone who try to make mini-kernel against 2.6.9-rc2-m2, also need below patch.


--- 2.6-mm-kdump/arch/i386/kernel/vmlinux.lds.S.orig	2004-09-23 21:47:45.000000000 +0900
+++ 2.6-mm-kdump/arch/i386/kernel/vmlinux.lds.S	2004-09-24 00:13:58.012736264 +0900
@@ -2,133 +2,167 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#define __ASSEMBLY__ 1
+#include <asm/page.h>
+#define LOAD_OFFSET __PAGE_OFFSET
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
-#include <asm/page.h>
+#include <asm/segment.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(startup_32)
+ENTRY(phys_startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = __PAGE_OFFSET + 0x100000;
-  /* read-only */
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	SCHED_TEXT
-	LOCK_TEXT
-	*(.fixup)
-	*(.gnu.warning)
+	. = LOAD_OFFSET + LOAD_ADDRESS;
+	phys_startup_32 = startup_32 - LOAD_OFFSET;
+
+	/* read-only */
+	_text = .;			/* Text and read-only data */
+	.text : AT(ADDR(.text) - LOAD_OFFSET) {
+		*(.text)
+		SCHED_TEXT
+		LOCK_TEXT
+		*(.fixup)
+		*(.gnu.warning)
 	} = 0x9090
 
-  _etext = .;			/* End of text section */
+	_etext = .;			/* End of text section */
+
+	. = ALIGN(16);		/* Exception table */
+	__start___ex_table = .;
+	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
+		*(__ex_table)
+	}
+	__stop___ex_table = .;
+
+	RODATA
+
+	/* writeable */
+	.data : AT(ADDR(.data) - LOAD_OFFSET) {			/* Data */
+		*(.data)
+		CONSTRUCTORS
+	}
+
+	. = ALIGN(4096);
+	__nosave_begin = .;
+	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
+		*(.data.nosave)
+	}
+	. = ALIGN(4096);
+	__nosave_end = .;
+
+	. = ALIGN(4096);
+	.data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
+		*(.data.idt)
+	}
+
+	. = ALIGN(32);
+	.data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
+		*(.data.cacheline_aligned)
+	}
+
+	_edata = .;			/* End of data section */
+
+	. = ALIGN(THREAD_SIZE);	/* init_task */
+	.data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
+		*(.data.init_task)
+	}
+
+	/* will be freed after init */
+	. = ALIGN(4096);		/* Init code and data */
+	__init_begin = .;
+	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) { 
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
+	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
+		*(.init.data)
+	}
+	. = ALIGN(16);
+	__setup_start = .;
+	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
+		*(.init.setup)
+	}
+	__setup_end = .;
+	__initcall_start = .;
+	.initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
+		*(.initcall1.init) 
+		*(.initcall2.init) 
+		*(.initcall3.init) 
+		*(.initcall4.init) 
+		*(.initcall5.init) 
+		*(.initcall6.init) 
+		*(.initcall7.init)
+	}
+	__initcall_end = .;
+	__con_initcall_start = .;
+	.con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
+		*(.con_initcall.init)
+	}
+	__con_initcall_end = .;
+	SECURITY_INIT
+	. = ALIGN(4);
+	__alt_instructions = .;
+	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+	*(.altinstructions)
+	} 
+	__alt_instructions_end = .; 
+	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
+		*(.altinstr_replacement)
+	} 
+	/* .exit.text is discard at runtime, not link time, to deal with references
+	from .altinstructions and .eh_frame */
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
+		*(.exit.text)
+	}
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
+		*(.exit.data)
+	}
+	. = ALIGN(4096);
+	__initramfs_start = .;
+	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
+		*(.init.ramfs)
+	}
+	__initramfs_end = .;
+	. = ALIGN(32);
+	__per_cpu_start = .;
+	.data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
+		*(.data.percpu)
+	}
+	__per_cpu_end = .;
+	. = ALIGN(4096);
+	__init_end = .;
+	/* freed after init ends here */
+
+	__bss_start = .;		/* BSS */
+	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
+		*(.bss.page_aligned)
+		*(.bss)
+	}
+	. = ALIGN(4);
+	__bss_stop = .; 
+
+	_end = . ;
+
+	/* This is where the kernel creates the early boot page tables */
+	. = ALIGN(4096);
+	pg0 = .;
+
+	/* Sections to be discarded */
+	/DISCARD/ : {
+		*(.exitcall.exit)
+	}
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  RODATA
-
-  /* writeable */
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  . = ALIGN(4096);
-  __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
-  __nosave_end = .;
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(THREAD_SIZE);	/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-  SECURITY_INIT
-  . = ALIGN(4);
-  __alt_instructions = .;
-  .altinstructions : { *(.altinstructions) } 
-  __alt_instructions_end = .; 
- .altinstr_replacement : { *(.altinstr_replacement) } 
-  /* .exit.text is discard at runtime, not link time, to deal with references
-     from .altinstructions and .eh_frame */
-  .exit.text : { *(.exit.text) }
-  .exit.data : { *(.exit.data) }
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
-	
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss.page_aligned)
-	*(.bss)
-  }
-  . = ALIGN(4);
-  __bss_stop = .; 
-
-  _end = . ;
-
-  /* This is where the kernel creates the early boot page tables */
-  . = ALIGN(4096);
-  pg0 = .;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
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
+	/* Stabs debugging sections.  */
+	.stab 0 : { *(.stab) }
+	.stabstr 0 : { *(.stabstr) }
+	.stab.excl 0 : { *(.stab.excl) }
+	.stab.exclstr 0 : { *(.stab.exclstr) }
+	.stab.index 0 : { *(.stab.index) }
+	.stab.indexstr 0 : { *(.stab.indexstr) }
+	.comment 0 : { *(.comment) }
 }


