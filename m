Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSIEPEg>; Thu, 5 Sep 2002 11:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSIEPEg>; Thu, 5 Sep 2002 11:04:36 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39084 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317623AbSIEPEb>; Thu, 5 Sep 2002 11:04:31 -0400
Date: Thu, 5 Sep 2002 10:09:00 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: davidm@hpl.hp.com, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK Changeset 1.615 - Makefile fix breaks i386...
In-Reply-To: <EE17182D9A@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0209050947380.6815-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Petr Vandrovec wrote:

> Hi David,
>   after your $ARCH => $(ARCH) fix in main Makefile make system
> on my machine now believes that arch/i386/vmlinux.lds should
> be built through vmlinux.lds.S => (rule in Makefile) vmlinux.lds.s => 
> (default as,ld) => vmlinux.lds, although neither of vmlinux.lds.S nor 
> vmlinux.lds.s does exist :-( So build fails.
> 
>   I was not able to fix problem other way than moving
> arch/$(ARCH)/vmlinux.lds.s rule down to arch's Makefiles, but I believe
> that there must be some better way to do that...

Ugh, sorry, that's all my bad - I accidentally included a cset in the 
latest merge which I didn't mean to, since it was not tested properly yet 
(obviously ;).

Now, since it happened anyway:

The plan is to always feed the linker script through cpp - many archs do 
it already anyway, so doing it always makes things more consistent. 

Andrew Morton also has a patch which needs preprocessing vmlinux.lds on 
i386, which is an additional reason, another one is the building in a 
separate objdir (That's for later, though)

So, the attached patch finishes this work at least for i386, un-breaking 
it.

Linus, please apply.

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.make

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.616, 2002-09-05 10:07:47-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Preprocess vmlinux.lds on i386 as well.
  
  We want do so on all architectures for consistency, and i386 will need
  the preprocessing soon anyway.

 ----------------------------------------------------------------------------
 arch/i386/vmlinux.lds     |  101 ----------------------------------------------
 b/arch/i386/Makefile      |    4 -
 b/arch/i386/vmlinux.lds.S |  101 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 103 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.616, 2002-09-05 10:07:47-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Preprocess vmlinux.lds on i386 as well.
  
  We want do so on all architectures for consistency, and i386 will need
  the preprocessing soon anyway.

  ---------------------------------------------------------------------------

diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Thu Sep  5 10:08:04 2002
+++ b/arch/i386/Makefile	Thu Sep  5 10:08:04 2002
@@ -18,7 +18,7 @@
 
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-LDFLAGS_vmlinux := -T arch/i386/vmlinux.lds -e stext
+LDFLAGS_vmlinux := -T arch/i386/vmlinux.lds.s -e stext
 
 CFLAGS += -pipe
 
@@ -104,7 +104,7 @@
 
 MAKEBOOT = +$(MAKE) -C arch/$(ARCH)/boot
 
-vmlinux: arch/i386/vmlinux.lds
+vmlinux: arch/i386/vmlinux.lds.s
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
 		clean archclean archmrproper
diff -Nru a/arch/i386/vmlinux.lds b/arch/i386/vmlinux.lds
--- a/arch/i386/vmlinux.lds	Thu Sep  5 10:08:04 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,101 +0,0 @@
-/* ld script to make i386 Linux kernel
- * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
- */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
-OUTPUT_ARCH(i386)
-ENTRY(_start)
-jiffies = jiffies_64;
-SECTIONS
-{
-  . = 0xC0000000 + 0x100000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x9090
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
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
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
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
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
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
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/vmlinux.lds.S	Thu Sep  5 10:08:04 2002
@@ -0,0 +1,101 @@
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+jiffies = jiffies_64;
+SECTIONS
+{
+  . = 0xC0000000 + 0x100000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x9090
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
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


