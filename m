Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274995AbRJFFVj>; Sat, 6 Oct 2001 01:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274997AbRJFFVa>; Sat, 6 Oct 2001 01:21:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:23562 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274995AbRJFFVT>;
	Sat, 6 Oct 2001 01:21:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets 
In-Reply-To: Your message of "Thu, 04 Oct 2001 21:47:08 +1000."
             <28136.1002196028@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Oct 2001 15:21:34 +1000
Message-ID: <15366.1002345694@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First patch to clean up Assembler offsets, as described in
http://marc.theaimsgroup.com/?l=linux-kernel&m=100219616028442&w=2

This patch is larger than normal because my testing highlighted a long
standing race in the top level kernel Makefile.

i386 patch.  Yes, I know that doing asm-offsets.c for i386 is overkill,
it only needs a few values that "never" change so they can be hard
coded.  However I need a reference implementation, plus the race needs
to be mitigated.

BTW, this is *much* cleaner in kbuild 2.5.  Bits of the patch are
workarounds for recursive make problems and to handle mkdep not
processing Assembler dependencies :(.

Index: 11-pre4.1/Makefile
--- 11-pre4.1/Makefile Fri, 05 Oct 2001 15:05:09 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29 644)
+++ 11-pre4.1(w)/Makefile Sat, 06 Oct 2001 15:07:25 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29 644)
@@ -205,7 +205,8 @@ CLEAN_FILES = \
 	drivers/scsi/53c700-mem.c \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
-	submenu*
+	submenu* \
+	arch/$(ARCH)/asm-offsets.[sh]
 # directories removed with 'make clean'
 CLEAN_DIRS = \
 	modules
@@ -245,9 +246,9 @@ export	CPPFLAGS CFLAGS AFLAGS
 export	NETWORKS DRIVERS LIBS HEAD LDFLAGS LINKFLAGS MAKEBOOT ASFLAGS
 
 .S.s:
-	$(CPP) $(AFLAGS) -traditional -o $*.s $<
+	$(CPP) $(AFLAGS) $(AFLAGS_$@) -traditional -o $@ $<
 .S.o:
-	$(CC) $(AFLAGS) -traditional -c -o $*.o $<
+	$(CC) $(AFLAGS) $(AFLAGS_$@) -traditional -c -o $@ $<
 
 Version: dummy
 	@rm -f include/linux/compile.h
@@ -273,29 +274,63 @@ symlinks:
 		mkdir include/linux/modules; \
 	fi
 
-oldconfig: symlinks
+# There is a race here against anything built by the top level Makefile or by
+# arch/$(ARCH)/Makefile (directly included by the top level Makefile).
+
+# split-include changes timestamps on config settings without telling make.
+# Because make is not aware that config files have been changed, the timestamp
+# checks in .hdepend (see Rules.make) use the old times for config files.
+# Therefore anything built at the same time that split-include is running gets
+# wrong timestamps for config settings and for the include files that depend on
+# config settings.
+
+# I cannot completely fix this in kbuild 2.4 without moving most of the top
+# level Makefile into a second file and doing make -C on that file after
+# split-include has run.  Explicitly running split-include after *config instead
+# of delaying until make dep mitigates the race, although it does not completely
+# remove it.
+
+# The race is not a problem for SUBDIRS processed from the top level Makefile
+# because split-include has completed before they are entered.  However it is a
+# problem for top level builds and for directories invoked from
+# arch/$(ARCH)/Makefile without using SUBDIRS.
+
+# kbuild 2.5 has a clean separation between configuration (top level and
+# scripts/Makefile) and the rest of the kernel build, so it does not suffer from
+# this race.  Also kbuild 2.5 splits arch/$(ARCH)/Makefile into definitions
+# (Makefile.defs.{no}config) and kernel building commands (Makefile.in).
+# KAO
+
+split_include := scripts/split-include include/linux/autoconf.h include/config && touch include/config/MARKER
+
+oldconfig: symlinks scripts/split-include
 	$(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in
+	@$(split_include)
 
-xconfig: symlinks
+xconfig: symlinks scripts/split-include
 	$(MAKE) -C scripts kconfig.tk
 	wish -f scripts/kconfig.tk
+	@$(split_include)
 
-menuconfig: include/linux/version.h symlinks
+menuconfig: include/linux/version.h symlinks scripts/split-include
 	$(MAKE) -C scripts/lxdialog all
 	$(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in
+	@$(split_include)
 
-config: symlinks
+config: symlinks scripts/split-include
 	$(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
+	@$(split_include)
 
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
-	scripts/split-include include/linux/autoconf.h include/config
-	@ touch include/config/MARKER
+	@$(split_include)
 
 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))
 
-$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/config/MARKER
+$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/config/MARKER before_subdirs
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
 
+.PHONY: before_subdirs
+
 $(TOPDIR)/include/linux/version.h: include/linux/version.h
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
 
@@ -356,7 +391,7 @@ endif
 modules: $(patsubst %, _mod_%, $(SUBDIRS))
 
 .PHONY: $(patsubst %, _mod_%, $(SUBDIRS))
-$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h include/config/MARKER
+$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h include/config/MARKER before_subdirs
 	$(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
 
 .PHONY: modules_install
Index: 11-pre4.1/arch/i386/asm-offsets.c
--- 11-pre4.1/arch/i386/asm-offsets.c Sat, 06 Oct 2001 15:07:38 +1000 kaos ()
+++ 11-pre4.1(w)/arch/i386/asm-offsets.c Fri, 05 Oct 2001 21:53:18 +1000 kaos (linux-2.4/q/f/50_asm-offset  644)
@@ -0,0 +1,32 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int
+main(void)
+{
+  DEFINE(state,        offsetof(struct task_struct, state),);
+  DEFINE(flags,        offsetof(struct task_struct, flags),);
+  DEFINE(sigpending,   offsetof(struct task_struct, sigpending),);
+  DEFINE(addr_limit,   offsetof(struct task_struct, addr_limit),);
+  DEFINE(exec_domain,  offsetof(struct task_struct, exec_domain),);
+  DEFINE(need_resched, offsetof(struct task_struct, need_resched),);
+  DEFINE(tsk_ptrace,   offsetof(struct task_struct, ptrace),);
+  DEFINE(processor,    offsetof(struct task_struct, processor),);
+  BLANK();
+  DEFINE(ENOSYS,       ENOSYS,);
+  return 0;
+}
Index: 11-pre4.1/arch/i386/kernel/entry.S
--- 11-pre4.1/arch/i386/kernel/entry.S Mon, 01 Oct 2001 12:23:40 +1000 kaos (linux-2.4/S/c/24_entry.S 1.1.5.5 644)
+++ 11-pre4.1(w)/arch/i386/kernel/entry.S Sat, 06 Oct 2001 13:04:03 +1000 kaos (linux-2.4/S/c/24_entry.S 1.1.5.5 644)
@@ -68,20 +68,7 @@ IF_MASK		= 0x00000200
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
-/*
- * these are offsets into the task-struct.
- */
-state		=  0
-flags		=  4
-sigpending	=  8
-addr_limit	= 12
-exec_domain	= 16
-need_resched	= 20
-tsk_ptrace	= 24
-processor	= 52
-
-ENOSYS = 38
-
+#include "asm-offsets.h"
 
 #define SAVE_ALL \
 	cld; \
Index: 11-pre4.1/arch/i386/kernel/Makefile
--- 11-pre4.1/arch/i386/kernel/Makefile Wed, 19 Sep 2001 14:59:20 +1000 kaos (linux-2.4/S/c/21_Makefile 1.1.2.1 644)
+++ 11-pre4.1(w)/arch/i386/kernel/Makefile Fri, 05 Oct 2001 22:37:10 +1000 kaos (linux-2.4/S/c/21_Makefile 1.1.2.1 644)
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 .S.o:
-	$(CC) $(AFLAGS) -traditional -c $< -o $*.o
+	$(CC) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) -traditional -c $< -o $@
 
 all: kernel.o head.o init_task.o
 
@@ -40,5 +40,8 @@ obj-$(CONFIG_SMP)		+= smp.o smpboot.o tr
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+
+AFLAGS_entry.o += -I $(TOPDIR)/arch/$(ARCH)
+entry.o: $(TOPDIR)/arch/$(ARCH)/asm-offsets.h
 
 include $(TOPDIR)/Rules.make
Index: 11-pre4.1/arch/i386/Makefile
--- 11-pre4.1/arch/i386/Makefile Wed, 18 Apr 2001 11:00:10 +1000 kaos (linux-2.4/T/c/37_Makefile 1.1.2.1.2.1 644)
+++ 11-pre4.1(w)/arch/i386/Makefile Sat, 06 Oct 2001 15:07:31 +1000 kaos (linux-2.4/T/c/37_Makefile 1.1.2.1.2.1 644)
@@ -145,3 +145,45 @@ archmrproper:
 
 archdep:
 	@$(MAKEBOOT) dep
+
+# Convert raw asm offsets into something that can be included as
+# assembler definitions.  It converts
+#   -> symbol $value source
+# into
+#   symbol = value /* 0xvalue source */
+
+arch/$(ARCH)/asm-offsets.h: arch/$(ARCH)/asm-offsets.s
+	@echo Creating $@
+	@set -e; \
+	  (echo "#ifndef __ASM_OFFSETS_H__"; \
+	   echo "#define __ASM_OFFSETS_H__"; \
+	   echo "/*"; \
+	   echo " * DO NOT MODIFY"; \
+	   echo " *"; \
+	   echo " * This file was generated by arch/$(ARCH)/Makefile."; \
+	   echo " *"; \
+	   echo " */"; \
+	   echo ""; \
+	   awk "/^->\$$/{printf(\"\\n\");} \
+	     /^-> /{ \
+	       sym = \$$2; \
+	       val = \$$3; \
+	       sub(/^\\\$$/, \"\", val); \
+	       \$$1 = \"\"; \
+	       \$$2 = \"\"; \
+	       \$$3 = \"\"; \
+	       printf(\"%-20s = %3d\\t\\t\\t/* 0x%x\\t%s */\\n\", \
+	         sym, val, val, \$$0) \
+	     }"; \
+	   echo ""; \
+	   echo "#endif"; \
+	  ) < $< > $@;
+
+arch/$(ARCH)/asm-offsets.s: include/config/MARKER \
+	include/linux/sched.h \
+	include/linux/types.h \
+	include/linux/stddef.h
+
+# Kludge to prevent subdirs from being processed before asm-offsets.h is created.
+# I hate recursive make!  KAO.
+before_subdirs: arch/$(ARCH)/asm-offsets.h

