Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbSIWX7h>; Mon, 23 Sep 2002 19:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSIWX7h>; Mon, 23 Sep 2002 19:59:37 -0400
Received: from mnh-1-09.mv.com ([207.22.10.41]:16390 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261482AbSIWX7d>;
	Mon, 23 Sep 2002 19:59:33 -0400
Message-Id: <200209240109.UAA05448@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: UML kbuild patch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Sep 2002 20:09:03 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UML build needs a few kbuild changes in order to work with the latest
stuff.

Since kbuild now enforces the use of the linker script on the vmlinux build,
UML can't use its old two-stage link, where
	vmlinux is a normal relocatable object file
	which is linked into the linux binary with the linker script

So, in order to fold those into one stage and produce an ELF binary, I need
the vmlinux "linker" to actually be gcc.  This implies I need a 
"-Wl,-T,arch/$(ARCH)/vmlinux.lds.s" instead of the usual 
"-T arch/$(ARCH)/vmlinux.lds.s".

This is done without breaking the other arches by changing the final link
command to $(LD_vmlinux) which is defaulted to $(LD) if the arch doesn't
define it.

The "-Wl,..." is done similarly by using $(LDFLAGS_vmlinux_default) if
the linker command is anything but gcc and $(LDFLAGS_vmlinux_gcc) if it is
gcc.

The one caveat is that I removed $(LDFLAGS) from the link line - you might
want to add it back.

You can pull bk://jdike.stearns.org/kbuild-2.5.  The patch is also appended.

				Jeff


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.600   -> 1.602  
#	            Makefile	1.305   -> 1.307  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/23	jdike@uml.karaya.com	1.601
# Fixes to allow UML to build with the new vmlinux rules.
# --------------------------------------------
# 02/09/23	jdike@uml.karaya.com	1.602
# Made the UML Makefile changes work for the other arches.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Sep 23 19:50:33 2002
+++ b/Makefile	Mon Sep 23 19:50:33 2002
@@ -288,10 +288,12 @@
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
 
+LD_vmlinux := $(if $(LD_vmlinux),$(LD_vmlinux),$(LD))
+
 vmlinux-objs := $(HEAD) $(INIT) $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
 
 quiet_cmd_link_vmlinux = LD      $@
-cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LDFLAGS_$(@F)) $(HEAD) $(INIT) \
+cmd_link_vmlinux = $(LD_vmlinux) $(LDFLAGS_$(@F)) $(HEAD) $(INIT) \
 		--start-group \
 		$(CORE_FILES) \
 		$(LIBS) \
@@ -313,7 +315,11 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-LDFLAGS_vmlinux += -T arch/$(ARCH)/vmlinux.lds.s
+LDFLAGS_vmlinux_default = -T arch/$(ARCH)/vmlinux.lds.s
+LDFLAGS_vmlinux_gcc = -Wl,-T,arch/$(ARCH)/vmlinux.lds.s
+
+vmlinux_base = $(basename $(notdir $(LD_vmlinux)))
+LDFLAGS_vmlinux += $(if $(LDFLAGS_vmlinux_$(vmlinux_base)),$(LDFLAGS_vmlinux_$(vmlinux_base)),$(LDFLAGS_vmlinux_default))
 
 vmlinux: $(vmlinux-objs) arch/$(ARCH)/vmlinux.lds.s FORCE
 	$(call if_changed_rule,link_vmlinux)

