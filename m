Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266874AbUHOUOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUHOUOV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUHOUOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:14:21 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:41838 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266874AbUHOUNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:13:52 -0400
Date: Sun, 15 Aug 2004 22:16:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild: *.lds.s -> *.lds rename. Infrastructure
Message-ID: <20040815201627.GB14133@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 12:18:07+02:00 sam@mars.ravnborg.org 
#   kbuild: Generate *.lds instead of *.lds.s
#   
#   When building a kernel on platforms where the filesytem do
#   not distingush between upper and lower case the rule:
#   .S -> .s did not work.
#   In a normal build this is only used for linker scripts.
#   So create a separate rule for .lds files, and use generic cpp flags.
#   
#   Patch from: Dan Aloni <da-x@colinux.org>
#   Modified to use cpp flags + added documentation.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.lib
#   2004/08/15 12:17:51+02:00 sam@mars.ravnborg.org +5 -0
#   Add flags to be used for generec preprocessing
# 
# scripts/Makefile.build
#   2004/08/15 12:17:51+02:00 sam@mars.ravnborg.org +8 -0
#   Add specific command for preprocessing linker scripts.
# 
# arch/i386/kernel/Makefile
#   2004/08/15 12:17:51+02:00 sam@mars.ravnborg.org +1 -1
#   Rename linker script from *lds.s to *.lds
# 
# Makefile
#   2004/08/15 12:17:51+02:00 sam@mars.ravnborg.org +7 -7
#   Renmae linker scripts from *.lds.s to *.lds
#   Set new linker flags
# 
# Documentation/kbuild/makefiles.txt
#   2004/08/15 12:17:51+02:00 sam@mars.ravnborg.org +31 -0
#   Documented support for *lds files
# 
diff -Nru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2004-08-15 22:16:13 +02:00
+++ b/Documentation/kbuild/makefiles.txt	2004-08-15 22:16:13 +02:00
@@ -938,6 +938,37 @@
 	will be displayed with "make KBUILD_VERBOSE=0".
 	
 
+--- 6.8 Preprocessing linker scripts
+
+	When the vmlinux image is build the linker script:
+	arch/$(ARCH)/kernel/vmlinux.lds is used.
+	The script is a preprocessed variant of the file vmlinux.lds.S
+	located in the same directory.
+	kbuild knows .lds file and includes a rule *lds.S -> *lds.
+	
+	Example:
+		#arch/i386/kernel/Makefile
+		always := vmlinux.lds
+	
+		#Makefile
+		export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
+		
+	The assigment to $(always) is used to tell kbuild to build the
+	target: vmlinux.lds.
+	The assignment to $(CPPFLAGS_vmlinux.lds) tell kbuild to use the
+	specified options when building the target vmlinux.lds.
+	
+	When building the *.lds target kbuild used the variakles:
+	CPPFLAGS	: Set in top-level Makefile
+	EXTRA_CPPFLAGS	: May be set in the kbuild makefile
+	CPPFLAGS_$(@F)  : Target specific flags.
+	                  Note that the full filename is used in this
+	                  assignment.
+
+	The kbuild infrastructure for *lds file are used in several
+	architecture specific files.
+
+
 === 7 Kbuild Variables
 
 The top Makefile exports the following variables:
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-15 22:16:13 +02:00
+++ b/Makefile	2004-08-15 22:16:13 +02:00
@@ -545,7 +545,7 @@
 quiet_cmd_sysmap = SYSMAP 
       cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 		   
-LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
+LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds
 
 #	Generate section listing all symbols and add it into vmlinux
 #	It's a three stage process:
@@ -591,13 +591,13 @@
 .tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
-.tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+.tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
-.tmp_vmlinux2: $(vmlinux-objs) .tmp_kallsyms1.o arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+.tmp_vmlinux2: $(vmlinux-objs) .tmp_kallsyms1.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
-.tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+.tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
 endif
@@ -618,13 +618,13 @@
 	$(rule_verify_kallsyms)
 endef
 
-vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux)
 
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
-$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds.s: $(vmlinux-dirs) ;
+$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds: $(vmlinux-dirs) ;
 
 # Handle descending into subdirectories listed in $(vmlinux-dirs)
 # Preset locale variables to speed up the build process. Limit locale
@@ -687,7 +687,7 @@
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
 
-export AFLAGS_vmlinux.lds.o += -P -C -U$(ARCH)
+export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
 
 # Single targets
 # ---------------------------------------------------------------------------
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2004-08-15 22:16:13 +02:00
+++ b/arch/i386/kernel/Makefile	2004-08-15 22:16:13 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := head.o init_task.o vmlinux.lds.s
+extra-y := head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-08-15 22:16:13 +02:00
+++ b/scripts/Makefile.build	2004-08-15 22:16:13 +02:00
@@ -219,6 +219,14 @@
 targets += $(real-objs-y) $(real-objs-m) $(lib-y)
 targets += $(extra-y) $(MAKECMDGOALS) $(always)
 
+# Linker scripts preprocessor (.lds.S -> .lds)
+# ---------------------------------------------------------------------------
+quiet_cmd_cpp_lds_S = LDS     $@
+      cmd_cpp_lds_S = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -o $@ $<
+
+%.lds: %.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
 # Build the compiled-in targets
 # ---------------------------------------------------------------------------
 
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	2004-08-15 22:16:13 +02:00
+++ b/scripts/Makefile.lib	2004-08-15 22:16:13 +02:00
@@ -100,6 +100,7 @@
 
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+_cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
 # If building the kernel in a separate objtree expand all occurrences
 # of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
@@ -107,6 +108,7 @@
 ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
 __a_flags	= $(_a_flags)
+__cpp_flags     = $(_cpp_flags)
 else
 
 # Prefix -I with $(srctree) if it is not an absolute path
@@ -120,6 +122,7 @@
 # FIXME: Replace both with specific CFLAGS* statements in the makefiles
 __c_flags	= $(call addtree,-I$(obj)) $(call flags,_c_flags)
 __a_flags	=                          $(call flags,_a_flags)
+__cpp_flags     =                          $(call flags,_cpp_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
@@ -128,6 +131,8 @@
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
+
+cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(__cpp_flags)
 
 ld_flags       = $(LDFLAGS) $(EXTRA_LDFLAGS)
 
