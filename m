Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbTHSV4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:56:32 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:3333 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261423AbTHSVzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:55:09 -0400
Date: Tue, 19 Aug 2003 23:53:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: Separate output directory - i386+always patch
Message-ID: <20030819215345.GC1791@mars.ravnborg.org>
References: <20030819215157.GA1791@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819215157.GA1791@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1271  -> 1.1272 
#	scripts/Makefile.clean	1.12    -> 1.13   
#	arch/i386/boot/Makefile	1.26    -> 1.27   
#	scripts/Makefile.lib	1.21    -> 1.22   
#	               (new)	        -> 1.1     arch/i386/boot/tools/Makefile
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/19	sam@mars.ravnborg.org	1.1272
# kbuild/i386: Fixes for separate output dir
# 
# Update i386 makefiles so they support building a kernel in a seperate
# output directory.
# This includes a new syntax for always :=, where a directory
# may be specified
# --------------------------------------------
#
diff -Nru a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	Tue Aug 19 23:41:17 2003
+++ b/arch/i386/boot/Makefile	Tue Aug 19 23:41:17 2003
@@ -27,9 +27,8 @@
 
 targets		:= vmlinux.bin bootsect bootsect.o setup setup.o \
 		   zImage bzImage
-subdir- 	:= compressed
-
-host-progs	:= tools/build
+subdir- 	:= compressed/
+always		:= tools/
 
 # ---------------------------------------------------------------------------
 
@@ -44,7 +43,7 @@
 	    $(obj)/vmlinux.bin $(ROOT_DEV) > $@
 
 $(obj)/zImage $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
-			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
+			      $(obj)/vmlinux.bin $(obj)/tools/ FORCE
 	$(call if_changed,image)
 	@echo 'Kernel: $@ is ready'
 
@@ -58,8 +57,7 @@
 	$(call if_changed,ld)
 
 $(obj)/compressed/vmlinux: FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
-					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
 # Set this if you want to pass append arguments to the zdisk/fdimage kernel
 FDARGS = 
diff -Nru a/arch/i386/boot/tools/Makefile b/arch/i386/boot/tools/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/boot/tools/Makefile	Tue Aug 19 23:41:17 2003
@@ -0,0 +1,2 @@
+host-progs := build
+always     := $(host-progs)
diff -Nru a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean	Tue Aug 19 23:41:17 2003
+++ b/scripts/Makefile.clean	Tue Aug 19 23:41:17 2003
@@ -13,6 +13,7 @@
 # ==========================================================================
 
 __subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
+__subdir-y	+= $(patsubst %/,%,$(filter %/, $(always)))
 subdir-y	+= $(__subdir-y)
 __subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
 subdir-m	+= $(__subdir-m)
@@ -30,8 +31,9 @@
 
 subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
 __clean-files	:= $(wildcard $(addprefix $(obj)/, \
-		   $(extra-y) $(EXTRA_TARGETS) $(always) $(host-progs) \
-		   $(targets) $(clean-files)))
+		   $(extra-y) $(EXTRA_TARGETS) \
+		   $(filter-out %/, $(always)) \
+		   $(host-progs) $(targets) $(clean-files)))
 
 # ==========================================================================
 
@@ -63,4 +65,4 @@
 # Shorthand for $(Q)$(MAKE) scripts/Makefile.clean obj=dir
 # Usage:
 # $(Q)$(MAKE) $(clean)=dir
-clean := -f scripts/Makefile.clean obj
+clean := -f $(if $(KBUILD_OUTPUT),$(srctree)/)scripts/Makefile.clean obj
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Tue Aug 19 23:41:17 2003
+++ b/scripts/Makefile.lib	Tue Aug 19 23:41:17 2003
@@ -32,6 +32,7 @@
 #   and add the directory to the list of dirs to descend into: $(subdir-m)
 
 __subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
+__subdir-y	+= $(patsubst %/,%,$(filter %/, $(always)))
 subdir-y	+= $(__subdir-y)
 __subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
 subdir-m	+= $(__subdir-m)
