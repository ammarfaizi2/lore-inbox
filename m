Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUHNTsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUHNTsp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHNTsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:48:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:18844 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265214AbUHNTqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:46:07 -0400
X-Authenticated: #12437197
Date: Sat, 14 Aug 2004 22:46:25 +0300
From: Dan Aloni <da-x@colinux.org>
To: Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [#3 1/2] Generate vmlinux.lds instead of vmlinux.lds.s
Message-ID: <20040814194625.GA20753@callisto.yi.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org> <20040813080941.GA7639@callisto.yi.org> <20040813092426.GA27895@callisto.yi.org> <20040813183347.GA9098@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813183347.GA9098@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

Here's the first patch. Note that I had to choose PPFLAGS instead 
of CPPFLAGS because otherwise it would have collided with the other
uses of CPPFLAGS.

I've test-built a clean kernel. 

This applies against 2.6.8.1 (the Olympic kernel :).

diff -urN -X dontdiff2 -X /home/karrde/colinux/bin/dontdiff linux-2.6.8.1-callisto/Makefile linux-2.6.8.1-callisto-work/Makefile
--- linux-2.6.8.1-callisto/Makefile	2004-08-14 18:00:44.000000000 +0300
+++ linux-2.6.8.1-callisto-work/Makefile	2004-08-14 21:09:34.000000000 +0300
@@ -300,6 +300,7 @@
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
+PPFLAGS         := -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
@@ -309,6 +310,7 @@
 export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
+export PPFLAGS PPFLAGS_KERNEL PPFLAGS_MODULE
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
@@ -540,7 +542,7 @@
 
 do_system_map = $(NM) $(1) | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > $(2)
 
-LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
+LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds
 
 #	Generate section listing all symbols and add it into vmlinux
 #	It's a three stage process:
@@ -584,13 +586,13 @@
 .tmp_kallsyms%.S: .tmp_vmlinux%
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
@@ -603,13 +605,13 @@
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
@@ -667,7 +669,7 @@
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
 
-export AFLAGS_vmlinux.lds.o += -P -C -U$(ARCH)
+export PPFLAGS_vmlinux.o += -P -C -U$(ARCH)
 
 # Single targets
 # ---------------------------------------------------------------------------
@@ -1106,6 +1108,10 @@
 	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 
+pp_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
+	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+	  $(modkern_aflags) $(EXTRA_PPFLAGS) $(PPFLAGS_$(*F).o)
+
 quiet_cmd_as_o_S = AS      $@
 cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
 
diff -urN -X dontdiff2 -X /home/karrde/colinux/bin/dontdiff linux-2.6.8.1-callisto/arch/i386/kernel/Makefile linux-2.6.8.1-callisto-work/arch/i386/kernel/Makefile
--- linux-2.6.8.1-callisto/arch/i386/kernel/Makefile	2004-08-14 18:00:04.000000000 +0300
+++ linux-2.6.8.1-callisto-work/arch/i386/kernel/Makefile	2004-08-14 20:50:56.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := head.o init_task.o vmlinux.lds.s
+extra-y := head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -urN -X dontdiff2 -X /home/karrde/colinux/bin/dontdiff linux-2.6.8.1-callisto/scripts/Makefile.build linux-2.6.8.1-callisto-work/scripts/Makefile.build
--- linux-2.6.8.1-callisto/scripts/Makefile.build	2004-06-16 08:19:52.000000000 +0300
+++ linux-2.6.8.1-callisto-work/scripts/Makefile.build	2004-08-14 21:08:12.000000000 +0300
@@ -186,6 +186,20 @@
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
+# Linker scripts preprocessor (.lds.S -> .lds)
+# ---------------------------------------------------------------------------
+
+modkern_ppflags := $(PPFLAGS_KERNEL)
+
+$(real-objs-m)      : modkern_ppflags := $(PPFLAGS_MODULE)
+$(real-objs-m:.o=.s): modkern_ppflags := $(PPFLAGS_MODULE)
+
+quiet_cmd_cpp_lds_S    = LDS     $@
+      cmd_cpp_lds_S    = $(CPP) $(pp_flags) -o $@ $<
+
+%.lds: %.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
diff -urN -X dontdiff2 -X /home/karrde/colinux/bin/dontdiff linux-2.6.8.1-callisto/scripts/Makefile.lib linux-2.6.8.1-callisto-work/scripts/Makefile.lib
--- linux-2.6.8.1-callisto/scripts/Makefile.lib	2004-06-16 08:19:23.000000000 +0300
+++ linux-2.6.8.1-callisto-work/scripts/Makefile.lib	2004-08-14 21:07:00.000000000 +0300
@@ -139,6 +139,7 @@
 
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+_pp_flags      = $(PPFLAGS) $(EXTRA_PPFLAGS) $(PPFLAGS_$(*F).o)
 _hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
 _hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
 
@@ -149,6 +150,7 @@
 ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
 __a_flags	= $(_a_flags)
+__pp_flags	= $(_pp_flags)
 __hostc_flags	= $(_hostc_flags)
 __hostcxx_flags	= $(_hostcxx_flags)
 else
@@ -164,6 +166,7 @@
 # FIXME: Replace both with specific CFLAGS* statements in the makefiles
 __c_flags	= $(call addtree,-I$(obj)) $(call flags,_c_flags)
 __a_flags	=                          $(call flags,_a_flags)
+__pp_flags	=                          $(call flags,_pp_flags)
 __hostc_flags	= -I$(obj)                 $(call flags,_hostc_flags)
 __hostcxx_flags	= -I$(obj)                 $(call flags,_hostcxx_flags)
 endif
@@ -175,6 +178,9 @@
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
 
+pp_flags       = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+		 $(__pp_flags) $(modkern_ppflags)
+
 hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
 hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 


-- 
Dan Aloni
da-x@colinux.org
