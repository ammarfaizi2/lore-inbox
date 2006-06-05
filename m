Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932346AbWFEAbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWFEAbX (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 20:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWFEAbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 20:31:23 -0400
Received: from kanga.kvack.org ([66.96.29.28]:45746 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932346AbWFEAbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 20:31:22 -0400
Date: Sun, 4 Jun 2006 21:31:53 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] Use ld's garbage collection feature
Message-ID: <20060605003152.GA1364@dmt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

Usage of ld's -gc-sections with gcc's -ffunction-sections has
been discussed several times in the past, with a few proposals being
submitted but none being merged (don't know why since it is really
useful).

So, the following patch adds a CONFIG_GCSECTIONS option to make use of
it, allowing the linker to discard unreferenced sections.

There are two main differences from previous attempts:

- Makes use of "-print-gc-sections" option (patch to binutils attached).
- Do not discard symbols referenced by modules (via KEEP directive from
linker script).
- Splits ksymtab* section into one section per member, allowing the
linker to do the sweeping job when CONFIG_MODULES is set (otherwise
exported unused symbols have a reference to them from ksymtab* sections,
preventing garbage collection).


Current implementation requires "make modules" to be run before "make
vmlinux" (need to know what functions used by modules must be kept), but
thats just silly and should be fixed inside the Makefile.

TODO:
- Do the same as done for ksymtab* to kcrctab* (CONFIG_MODVERSIONS)
- Fixup end_rodata breakage (either move it outside generic
vmlinux.lds.h or find a way to get "#include" expansion working
recursively).
- Very likely that KEEP() has been missed from a few unusual 
sections.
- Recursive make invocation from Makefile is sort of ugly.

Results:

This config
http://hera.kernel.org/~marcelo/gcsections/config-test-gcsections 
results in
http://hera.kernel.org/~marcelo/gcsections/dropped_sections.txt
sections being dropped.

vmlinux shrinks from 1090389 to 983933 bytes, or 106k (~= 10%).

I would like to see some equivalent of this merged, since its
_very_ useful. There are _many_ helper functions used by specific
configurations which can just be wasted completly from most builds.

For example

mm/built-in.o:.text.free_pages_and_swap_cache (only used by x86_64)
fs/built-in.o:.text.ilookup5_nowait 
fs/built-in.o:.text.ilookup5		      (only used by OCFS2 and VFAT)
kernel/built-in.o:.text.kallsyms_lookup_name  (only used by PPC)
mm/built-in.o:.text.free_cold_page	      (unused!)

(check dropped_sections.txt for more fun)

Comments are welcome!

diff --git a/Makefile b/Makefile
index 3494c17..45c3f4e 100644
--- a/Makefile
+++ b/Makefile
@@ -571,11 +571,20 @@ vmlinux-lds  := arch/$(ARCH)/kernel/vmli
 
 # Rule to link vmlinux - also used during CONFIG_KALLSYMS
 # May be overridden by arch/$(ARCH)/Makefile
+ifndef CONFIG_GCSECTIONS
 quiet_cmd_vmlinux__ ?= LD      $@
       cmd_vmlinux__ ?= $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) -o $@ \
       -T $(vmlinux-lds) $(vmlinux-init)                          \
       --start-group $(vmlinux-main) --end-group                  \
       $(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
+else
+quiet_cmd_vmlinux__ ?= LD      $@
+      cmd_vmlinux__ ?= $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) -o $@ \
+      -T $(vmlinux-lds) $(vmlinux-init)                          \
+      --start-group $(vmlinux-main) --end-group                  \
+      > arch/$(ARCH)/dropped_sections.txt                        \
+      $(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
+endif
 
 # Generate new vmlinux version
 quiet_cmd_vmlinux_version = GEN     .version
@@ -593,6 +602,27 @@ # Generate System.map
 quiet_cmd_sysmap = SYSMAP 
       cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 
+ifdef CONFIG_GCSECTIONS
+# Find undefined symbols inside modules, and add them to the linker 
+# script with KEEP directive. Then rebuild the kernel.
+
+define update_used_symbols
+	$(Q)if [ $(MAKELEVEL) -eq "0" ]; then				\
+	find . -name "*.ko" -exec nm {} \; |grep "U "|cut -f2 -dU |	\
+		sed -e "s/ //g" > arch/$(ARCH)/undef_module_syms.txt;	\
+	grep .text arch/$(ARCH)/dropped_sections.txt | sed -e s/.*://g  \
+		> arch/$(ARCH)/drop_strip.txt;				\
+	rm -f arch/$(ARCH)/kernel/vmlinux.ldskeep.h;			\
+	cat arch/$(ARCH)/undef_module_syms.txt | while read line ; do   \
+		egrep "$$line$$" arch/$(ARCH)/drop_strip.txt |		\
+		while read L ; do echo KEEP\(*\($$L\)\) ; done		\
+		>> arch/$(ARCH)/kernel/vmlinux.ldskeep.h ; true ; done;	\
+	sh scripts/ksymbols-gen-keep.sh $(ARCH);			\
+	GC_REBUILD_PASS=true $(MAKE) vmlinux				\
+	;fi		
+endef
+endif
+
 # Link of vmlinux
 # If CONFIG_KALLSYMS is set .version is already updated
 # Generate System.map and verify that the content is consistent
@@ -605,6 +635,8 @@ define rule_vmlinux__
 	$(call cmd,vmlinux__)
 	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 
+	$(update_used_symbols)
+
 	$(Q)$(if $($(quiet)cmd_sysmap),                 \
 	  echo '  $($(quiet)cmd_sysmap) System.map' &&) \
 	$(cmd_sysmap) $@ System.map;                    \
@@ -803,8 +835,21 @@ archprepare: prepare1 scripts_basic
 prepare0: archprepare FORCE
 	$(Q)$(MAKE) $(build)=.
 
+
+create_keep_files := keep.ksymstrings.txt keep.ksymtab.txt keep.ksymtabgpl.txt \
+		 vmlinux.ldskeep.h
+
+create_keep_lists:
+ifndef GC_REBUILD_PASS
+	$(Q)$(foreach f, $(create_keep_files),		\
+		rm -f arch/$(ARCH)/kernel/$(f);		\
+		touch arch/$(ARCH)/kernel/$(f);		\
+	)						
+endif
+
 # All the preparing..
-prepare prepare-all: prepare0
+prepare prepare-all: prepare0 create_keep_lists
+
 
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8dfa305..4a60635 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -691,6 +691,12 @@ config REGPARM
 
 	If unsure, say Y.
 
+config GCSECTIONS
+	bool "Garbage collect unused sections"
+	default n
+	help
+	Use ld's --gc-sections option to garbage collect unused sections.
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 3e4adb1..1a2da0d 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -24,9 +24,11 @@ LD              := $(LD) -m elf_i386
 CC              := $(CC) -m32
 endif
 
+ldflags-$(CONFIG_GCSECTIONS) += --gc-sections --print-gc-sections
+
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-LDFLAGS_vmlinux :=
+LDFLAGS_vmlinux := $(ldflags-y)
 CHECKFLAGS	+= -D__i386__
 
 CFLAGS += -pipe -msoft-float
@@ -39,6 +41,8 @@ include $(srctree)/arch/i386/Makefile.cp
 
 cflags-$(CONFIG_REGPARM) += -mregparm=3
 
+cflags-$(CONFIG_GCSECTIONS) += -ffunction-sections
+
 # temporary until string.h is fixed
 cflags-y += -ffreestanding
 
diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 8831303..8c2cb26 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
+	#include "vmlinux.ldskeep.h"
 	SCHED_TEXT
 	LOCK_TEXT
 	KPROBES_TEXT
@@ -32,11 +33,30 @@ SECTIONS
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
+  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { KEEP(*(__ex_table)) }
   __stop___ex_table = .;
 
   RODATA
 
+  /* Kernel symbol table: Normal symbols */			
+  __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		
+  	VMLINUX_SYMBOL(__start___ksymtab) = .;
+	#include "keep.ksymtab.txt"
+	VMLINUX_SYMBOL(__stop___ksymtab) = .;
+  }
+
+  /* Kernel symbol table: GPL-only symbols */			
+  __ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {
+	VMLINUX_SYMBOL(__start___ksymtab_gpl) = .;
+	#include "keep.ksymtabgpl.txt"
+	VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;
+  }
+
+  /* Kernel symbol table: strings */
+  __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {
+	#include "keep.ksymstrings.txt"
+  }
+
   /* writeable */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
@@ -74,7 +94,7 @@ SECTIONS
   __smp_alt_begin = .;
   __smp_alt_instructions = .;
   .smp_altinstructions : AT(ADDR(.smp_altinstructions) - LOAD_OFFSET) {
-	*(.smp_altinstructions)
+	KEEP(*(.smp_altinstructions))
   }
   __smp_alt_instructions_end = .;
   . = ALIGN(4);
@@ -84,7 +104,7 @@ SECTIONS
   }
   __smp_locks_end = .;
   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
-	*(.smp_altinstr_replacement)
+	KEEP(*(.smp_altinstr_replacement))
   }
   . = ALIGN(4096);
   __smp_alt_end = .;
@@ -100,33 +120,33 @@ SECTIONS
   .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
-  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) { *(.init.setup) }
+  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) { KEEP(*(.init.setup)) }
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	KEEP(*(.initcall1.init))
+	KEEP(*(.initcall2.init))
+	KEEP(*(.initcall3.init))
+	KEEP(*(.initcall4.init))
+	KEEP(*(.initcall5.init))
+	KEEP(*(.initcall6.init))
+	KEEP(*(.initcall7.init))
   }
   __initcall_end = .;
   __con_initcall_start = .;
   .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
-	*(.con_initcall.init)
+	KEEP(*(.con_initcall.init))
   }
   __con_initcall_end = .;
   SECURITY_INIT
   . = ALIGN(4);
   __alt_instructions = .;
   .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
-	*(.altinstructions)
+	KEEP(*(.altinstructions))
   }
   __alt_instructions_end = .; 
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
-	*(.altinstr_replacement)
+	KEEP(*(.altinstr_replacement))
   }
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
@@ -134,7 +154,7 @@ SECTIONS
   .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { *(.exit.data) }
   . = ALIGN(4096);
   __initramfs_start = .;
-  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
+  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { KEEP(*(.init.ramfs)) }
   __initramfs_end = .;
   . = ALIGN(L1_CACHE_BYTES);
   __per_cpu_start = .;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9d11550..a967c04 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -24,16 +24,16 @@ #define RODATA								\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start_pci_fixups_early) = .;		\
-		*(.pci_fixup_early)					\
+		KEEP(*(.pci_fixup_early))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_early) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
-		*(.pci_fixup_header)					\
+		KEEP(*(.pci_fixup_header))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
-		*(.pci_fixup_final)					\
+		KEEP(*(.pci_fixup_final))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
-		*(.pci_fixup_enable)					\
+		KEEP(*(.pci_fixup_enable))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
 	}								\
 									\
@@ -96,7 +96,7 @@ #define RODATA								\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
 		VMLINUX_SYMBOL(__start___param) = .;			\
-		*(__param)						\
+		KEEP(*(__param))					\
 		VMLINUX_SYMBOL(__stop___param) = .;			\
 	}
 
diff --git a/include/linux/module.h b/include/linux/module.h
index eaec13d..4675cc0 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -181,6 +181,7 @@ #else
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
+#ifndef CONFIG_GCSECTIONS
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define __EXPORT_SYMBOL(sym, sec)				\
 	extern typeof(sym) sym;					\
@@ -193,6 +194,24 @@ #define __EXPORT_SYMBOL(sym, sec)				\
 	__attribute__((section("__ksymtab" sec), unused))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
+#else
+/* For garbage collection, each symbol has its own 
+   __ksymtab and __kstrtab section, which are later merged into 
+   single ones.
+ */
+#define __EXPORT_SYMBOL(sym, sec)				\
+	extern typeof(sym) sym;					\
+	__CRC_SYMBOL(sym, sec)					\
+	static const char __kstrtab_##sym[]			\
+	__attribute__((section("__ksymtab_strings_" #sym)))	\
+	= MODULE_SYMBOL_PREFIX #sym;                    	\
+	static const struct kernel_symbol __ksymtab_##sym	\
+	__attribute_used__					\
+	__attribute__((section("___ksymtab_" #sym sec), unused))\
+	= { (unsigned long)&sym, __kstrtab_##sym }
+
+#endif
+
 #define EXPORT_SYMBOL(sym)					\
 	__EXPORT_SYMBOL(sym, "")
 
diff --git a/scripts/ksymbols-gen-keep.sh b/scripts/ksymbols-gen-keep.sh
new file mode 100755
index 0000000..3f9fb9b
--- /dev/null
+++ b/scripts/ksymbols-gen-keep.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Add symbols from special sections ksymtab,ksymtab_strings,ksymtab_gpl
+# which we do not want to be discarded into one linker script per 
+# special section.
+#
+
+ARCH=$1
+
+rm -f vmlinux.nm
+nm vmlinux | grep "T " | cut -f 2 -d T | while read line
+	do echo "$line" >> vmlinux.nm
+done
+
+nm vmlinux | grep "D " | cut -f 2 -d D | while read line
+	do echo "$line" >> vmlinux.nm
+done
+
+nm vmlinux | grep "B " | cut -f 2 -d B | while read line
+	do echo "$line" >> vmlinux.nm
+done
+
+cat arch/$ARCH/kernel/vmlinux.ldskeep.h | while read line
+	do sed -e s/"KEEP(\*(.text."//g -e s/"))$"//g
+done >> vmlinux.nm
+
+# ksymtab_strings
+cat arch/$ARCH/dropped_sections.txt | sed -e "s/.*:__ksymtab_strings_//g" | \
+grep -v : | while read line
+	do grep $line$ vmlinux.nm
+done > keep.ksymstrings
+
+cat keep.ksymstrings | while read line ; do 					
+	echo KEEP\(*\("__ksymtab_strings_$line"\)\) 				
+done > keep.ksymstrings.txt
+
+# ksymtab
+egrep -v "ksymtab_strings|ksymtab_.*_gpl" arch/$ARCH/dropped_sections.txt |	\
+sed -e "s/.*:___ksymtab_//g" | grep -v ":" | while read line
+	do grep $line$ vmlinux.nm
+done > keep.ksymtab
+
+cat keep.ksymtab | while read line
+	do echo "KEEP(*(___ksymtab_$line))"
+done > keep.ksymtab.txt
+
+# ksymtab gpl
+egrep "ksymtab_.*_gpl" arch/$ARCH/dropped_sections.txt  | 			\
+sed -e "s/.*://g" -e s/___ksymtab_//g  -e s/_gpl$//g | while read line
+	do grep $line$ vmlinux.nm
+done > keep.ksymtabgpl
+
+cat keep.ksymtabgpl | while read line
+	do echo KEEP\(*\(___ksymtab_"$line"_gpl\)\)
+done > keep.ksymtabgpl.txt
+
+rm -f keep.ksymstrings keep.ksymtab keep.ksymtabgpl
+
+mv keep.*.txt arch/$ARCH/kernel/




--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binutils-gc-print.patch"

--- ./ld/ldmain.c.orig	2006-05-21 17:18:46.000000000 -0300
+++ ./ld/ldmain.c	2006-05-21 17:18:55.000000000 -0300
@@ -316,6 +316,7 @@ main (int argc, char **argv)
   link_info.relax_pass = 1;
   link_info.warn_shared_textrel = FALSE;
   link_info.gc_sections = FALSE;
+  link_info.print_gc_sections = FALSE;
 
   ldfile_add_arch ("");
 
--- ./ld/lexsup.c.orig	2006-05-21 17:06:21.000000000 -0300
+++ ./ld/lexsup.c	2006-05-21 17:18:27.000000000 -0300
@@ -124,6 +124,7 @@ enum option_values
   OPTION_FORCE_EXE_SUFFIX,
   OPTION_GC_SECTIONS,
   OPTION_NO_GC_SECTIONS,
+  OPTION_PRINT_GC_SECTIONS,
   OPTION_HASH_SIZE,
   OPTION_CHECK_SECTIONS,
   OPTION_NO_CHECK_SECTIONS,
@@ -370,6 +371,9 @@ static const struct ld_option ld_options
   { {"no-gc-sections", no_argument, NULL, OPTION_NO_GC_SECTIONS},
     '\0', NULL, N_("Don't remove unused sections (default)"),
     TWO_DASHES },
+  { {"print-gc-sections", no_argument, NULL, OPTION_PRINT_GC_SECTIONS},
+    '\0', NULL, N_("Print removed unused sections"),
+    TWO_DASHES },
   { {"hash-size=<NUMBER>", required_argument, NULL, OPTION_HASH_SIZE},
     '\0', NULL, N_("Set default hash table size close to <NUMBER>"),
     TWO_DASHES },
@@ -812,6 +816,9 @@ parse_args (unsigned argc, char **argv)
 	case OPTION_GC_SECTIONS:
 	  link_info.gc_sections = TRUE;
 	  break;
+	case OPTION_PRINT_GC_SECTIONS:
+	  link_info.print_gc_sections = TRUE;
+	  break;
 	case OPTION_HELP:
 	  help ();
 	  xexit (0);
--- ./include/bfdlink.h.orig	2006-05-21 17:16:54.000000000 -0300
+++ ./include/bfdlink.h	2006-05-21 17:17:21.000000000 -0300
@@ -324,6 +324,9 @@ struct bfd_link_info
   /* TRUE if unreferenced sections should be removed.  */
   unsigned int gc_sections: 1;
 
+  /* TRUE if should print removed unreferenced sections. */
+  unsigned int print_gc_sections: 1;
+
   /* What to do with unresolved symbols in an object file.
      When producing executables the default is GENERATE_ERROR.
      When producing shared libraries the default is IGNORE.  The
--- ./bfd/elflink.c.orig	2006-05-21 17:20:57.000000000 -0300
+++ ./bfd/elflink.c	2006-05-21 18:41:19.000000000 -0300
@@ -8978,6 +8978,9 @@ elf_gc_sweep (bfd *abfd, struct bfd_link
 	     to remove a section from the output.  */
 	  o->flags |= SEC_EXCLUDE;
 
+	  if (info->print_gc_sections == TRUE)
+		printf("%s:%s\n", sub->filename, o->name);
+
 	  /* But we also have to update some of the relocation
 	     info we collected before.  */
 	  if (gc_sweep_hook

--5/uDoXvLw7AC5HRs--
