Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTFGSut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFGStW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:49:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:45317 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263376AbTFGSsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:48:46 -0400
Date: Sat, 7 Jun 2003 21:02:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stewart Smith <stewart@linux.org.au>, Jeff Garzik <jgarzik@pobox.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [EVIL-PATCH] getting rid of lib/lib.a and breaking many archs in the processes (was Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols)
Message-ID: <20030607190218.GA29826@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Stewart Smith <stewart@linux.org.au>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <20030607073321.GC1540@cancer> <Pine.LNX.4.44.0306071028510.2956-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306071028510.2956-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 10:34:01AM -0700, Linus Torvalds wrote:
> The _clean_ way to do this (I think) might be to make the normal build 
> rules understand a "obj-l" for "library objects", and always build a 
> "lib.a" for those, instead of having the magic "if there is a L_TARGET, 
> use obj-y and make a library of them" special case rule.
> 
> Sam, can you try to sprinkle the proper Makefile magic pixie-dust around?

New variable introduced: lib-y
The lib-y syntax allows you to do the usual tricks such as:
lib-$(CONFIG_SMP) += percpu_counter.o

A built-in.o is always present in a directory that list .o files in
either obj-* or lib-*.
lib.a is made only when lib-y is defined.
In the top-level Makefile I now always have a lib.a and built-in.o for
directories listed in libs-y (libs-y is only used in architecture
specific makefiles).

I am considering removing the requirement to list directories
that uses lib-y in libs-y. Kbuild has the information, so no need
to do it. It just looks a bit too ugly at first glance.

I updated lib/makefile  [crc32.o is now always build-in if selected].
And i386/lib as well.

Does this meet what you had in mind?

	Sam

 Makefile               |    4 +++-
 arch/i386/lib/Makefile |    9 ++++-----
 lib/Makefile           |   11 +++++------
 scripts/Makefile.build |   39 ++++++++++++++++++---------------------
 scripts/Makefile.lib   |    7 +++++++
 5 files changed, 37 insertions(+), 33 deletions(-)

===== Makefile 1.410 vs edited =====
--- 1.410/Makefile	Tue Jun  3 23:27:14 2003
+++ edited/Makefile	Sat Jun  7 19:57:35 2003
@@ -288,7 +288,9 @@
 core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
 drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
 net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
-libs-y		:= $(patsubst %/, %/lib.a, $(libs-y))
+libs-y1		:= $(patsubst %/, %/lib.a, $(libs-y))
+libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
+libs-y		:= $(libs-y1) $(libs-y2)
 
 ifdef include_config
 
===== arch/i386/lib/Makefile 1.11 vs edited =====
--- 1.11/arch/i386/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/i386/lib/Makefile	Sat Jun  7 20:05:00 2003
@@ -2,12 +2,11 @@
 # Makefile for i386-specific library files..
 #
 
-L_TARGET = lib.a
 
-obj-y = checksum.o delay.o \
+lib-y = checksum.o delay.o \
 	usercopy.o getuser.o \
 	memcpy.o strstr.o
 
-obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
-obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
-obj-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
+lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
+lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+lib-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
===== lib/Makefile 1.22 vs edited =====
--- 1.22/lib/Makefile	Mon May 12 22:20:36 2003
+++ edited/lib/Makefile	Sat Jun  7 20:36:14 2003
@@ -6,18 +6,17 @@
 # unless it's something special (ie not a .c file).
 #
 
-L_TARGET := lib.a
 
-obj-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
+lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o idr.o
 
-obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
-obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
-obj-$(CONFIG_SMP) += percpu_counter.o
+lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
+lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+lib-$(CONFIG_SMP) += percpu_counter.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
-  obj-y += dec_and_lock.o
+  lib-y += dec_and_lock.o
 endif
 
 obj-$(CONFIG_CRC32)	+= crc32.o
===== scripts/Makefile.build 1.37 vs edited =====
--- 1.37/scripts/Makefile.build	Tue Jun  3 23:14:57 2003
+++ edited/scripts/Makefile.build	Sat Jun  7 21:01:41 2003
@@ -32,9 +32,7 @@
 endif
 
 ifdef L_TARGET
-ifneq ($(L_TARGET),lib.a)
-$(warning kbuild: $(obj)/Makefile - L_TARGET := $(L_TARGET) target shall be renamed to lib.a. Please fix!)
-endif
+$(error kbuild: $(obj)/Makefile - Use of L_TARGET is replaced by lib-y in 2.5. Please fix!)
 endif
 
 ifdef list-multi
@@ -47,21 +45,19 @@
 
 # ===========================================================================
 
-# If a Makefile does not define a L_TARGET, link an object called "built-in.o"
-
-ifdef L_TARGET
-L_TARGET := $(obj)/$(L_TARGET)
-else
-ifneq ($(strip $(obj-y) $(obj-m) $(obj-n) $(obj-)),)
-O_TARGET := $(obj)/built-in.o
+ifneq ($(strip $(lib-y) $(lib-m) $(lib-n) $(lib-)),)
+lib-target := $(obj)/lib.a
 endif
+
+ifneq ($(strip $(obj-y) $(obj-m) $(obj-n) $(obj-) $(lib-target)),)
+builtin-target := $(obj)/built-in.o
 endif
 
 # We keep a list of all modules in $(MODVERDIR)
 
 touch-module = @echo $(@:.o=.ko) > $(MODVERDIR)/$(@F:.o=.mod)
 
-__build: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(extra-y)) \
+__build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 	 $(if $(KBUILD_MODULES),$(obj-m)) \
 	 $(subdir-ym) $(always)
 	@:
@@ -203,7 +199,8 @@
 %.o: %.S FORCE
 	$(call if_changed_dep,as_o_S)
 
-targets += $(real-objs-y) $(real-objs-m) $(extra-y) $(MAKECMDGOALS) $(always)
+targets += $(real-objs-y) $(real-objs-m) $(lib-y)
+targets += $(extra-y) $(MAKECMDGOALS) $(always)
 
 # Build the compiled-in targets
 # ---------------------------------------------------------------------------
@@ -214,30 +211,30 @@
 #
 # Rule to compile a set of .o files into one .o file
 #
-ifdef O_TARGET
+ifdef builtin-target
 quiet_cmd_link_o_target = LD      $@
-# If the list of objects to link is empty, just create an empty O_TARGET
+# If the list of objects to link is empty, just create an empty built-in.o
 cmd_link_o_target = $(if $(strip $(obj-y)),\
 		      $(LD) $(ld_flags) -r -o $@ $(filter $(obj-y), $^),\
 		      rm -f $@; $(AR) rcs $@)
 
-$(O_TARGET): $(obj-y) FORCE
+$(builtin-target): $(obj-y) FORCE
 	$(call if_changed,link_o_target)
 
-targets += $(O_TARGET)
-endif # O_TARGET
+targets += $(builtin-target)
+endif # builtin-target
 
 #
 # Rule to compile a set of .o files into one .a file
 #
-ifdef L_TARGET
+ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
-cmd_link_l_target = rm -f $@; $(AR) $(EXTRA_ARFLAGS) rcs $@ $(obj-y)
+cmd_link_l_target = rm -f $@; $(AR) $(EXTRA_ARFLAGS) rcs $@ $(lib-y)
 
-$(L_TARGET): $(obj-y) FORCE
+$(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
 
-targets += $(L_TARGET)
+targets += $(lib-target)
 endif
 
 #
===== scripts/Makefile.lib 1.18 vs edited =====
--- 1.18/scripts/Makefile.lib	Mon Mar 10 22:03:33 2003
+++ edited/scripts/Makefile.lib	Sat Jun  7 20:55:00 2003
@@ -18,6 +18,12 @@
 
 obj-m := $(filter-out $(obj-y),$(obj-m))
 
+# Libraries are always collected in one lib file.
+# Filter out objects already built-in
+
+lib-y := $(filter-out $(obj-y), $(sort $(lib-y) $(lib-m)))
+
+
 # Handle objects in subdirs
 # ---------------------------------------------------------------------------
 # o if we encounter foo/ in $(obj-y), replace it by foo/built-in.o
@@ -91,6 +97,7 @@
 targets		:= $(addprefix $(obj)/,$(targets))
 obj-y		:= $(addprefix $(obj)/,$(obj-y))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
+lib-y		:= $(addprefix $(obj)/,$(lib-y))
 subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
 real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
 real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
