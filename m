Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVIRSk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVIRSk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 14:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVIRSk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 14:40:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:57385 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932164AbVIRSk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 14:40:26 -0400
Date: Sun, 18 Sep 2005 20:41:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Budde, Marco" <budde@telos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++
Message-ID: <20050918184107.GA7771@mars.ravnborg.org>
References: <809C13DD6142E74ABE20C65B11A2439802094E@www.telos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439802094E@www.telos.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco.

> At the moment we are using some additional rules for kbuild.
> They have worked for a previous project of our customer and I
> hope they will work for this project, too.

Following adds proper C++ support to kbuild.
Only composite objects are supported, but for your project thats
not an issue.

Sample Kbuild file:

obj-m := sam.o
EXTRA_CXXFLAGS   := -DDEBUG
CXXFLAGS_file2.o := -DDEBUG2
sam-y := file1.o file2.o

I hope this is useful for your project, but do not count on having this
added to mainstream kernel.
sparse is not used - I do not assume you want to add C++ support to
sparse for now.
Also module versioning is excluded. Mainly because I did not bother test
it - it should be trivial to add.

	Sam

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -322,6 +322,7 @@ AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
 CC		= $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
+CXX		= $(CROSS_COMPILE)g++
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
 STRIP		= $(CROSS_COMPILE)strip
@@ -354,15 +355,18 @@ CFLAGS 		:= -Wall -Wundef -Wstrict-proto
 	  	   -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
+CXXFLAGS	:= -Wall -Wundef -fno-strict-aliasing -fno-common \
+		   -fno-exceptions -fno-rtti
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \
-	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
+	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC CXX\
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
+export CXXFLAGS 
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -187,13 +187,36 @@ define rule_cc_o_c
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
 endef
 
-# Built-in and composite module parts
-
 %.o: %.c FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
+
+# C++ (.cpp) files
+# The C++ file is compiled and updated dependency information is generated.
+# (See cmd_cc_o_cxx + relevant part of rule_cc_o_cxx)
+
+# No support for module versioning for c++ (for now)
+quiet_cmd_cc_o_cxx = C++ $(quiet_modtag) $@
+      cmd_cc_o_cxx = $(CXX) $(cxx_flags) -c -o $@ $<
+
+define rule_cc_o_cxx
+	$(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)   \
+	$(if $($(quiet)cmd_cc_o_cxx),\
+		echo '  $(subst ','\'',$($(quiet)cmd_cc_o_cxx))';)        \
+	$(cmd_cc_o_cxx);						  \
+	scripts/basic/fixdep $(depfile) $@ '$(subst ','\'',$(cmd_cc_o_cxx))' \
+		> $(@D)/.$(@F).tmp; \
+	rm -f $(depfile);						  \
+	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
+endef
+
+%.o: %.cpp FORCE
+	$(call if_changed_rule,cc_o_cxx)
+
+# Built-in and composite module parts
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
+# Also we do not support C++ single-file modules
 
 $(single-used-m): %.o: %.c FORCE
 	$(call cmd,force_checksrc)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -87,7 +87,7 @@ modname_flags  = $(if $(filter 1,$(words
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 _cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
-
+_cxx_flags     = $(CXXFLAGS) $(EXTRA_CXXFLAGS) $(CXXFLAGS_$(@F))
 # If building the kernel in a separate objtree expand all occurrences
 # of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
 
@@ -95,6 +95,7 @@ ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
 __a_flags	= $(_a_flags)
 __cpp_flags     = $(_cpp_flags)
+__cxx_flags     = $(_cxx_flags)
 else
 
 # Prefix -I with $(srctree) if it is not an absolute path
@@ -109,6 +110,7 @@ flags = $(foreach o,$($(1)),$(if $(filte
 __c_flags	= $(call addtree,-I$(obj)) $(call flags,_c_flags)
 __a_flags	=                          $(call flags,_a_flags)
 __cpp_flags     =                          $(call flags,_cpp_flags)
+__cxx_flags     =                          $(call flags,_cpp_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
@@ -120,6 +122,10 @@ a_flags        = -Wp,-MD,$(depfile) $(NO
 
 cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(__cpp_flags)
 
+cxx_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+		 $(__cxx_flags) $(modkern_cflags) \
+		 $(basename_flags) $(modname_flags)
+
 ld_flags       = $(LDFLAGS) $(EXTRA_LDFLAGS)
 
 # Finds the multi-part object the current object will be linked into
