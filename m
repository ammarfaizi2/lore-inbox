Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUHMT6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUHMT6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUHMTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:53:52 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:17490 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267375AbUHMTr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:47:57 -0400
Date: Fri, 13 Aug 2004 21:50:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [8/12] kbuild: Introduce hostprogs-y, deprecate host-progs
Message-ID: <20040813195014.GH10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 21:38:42+02:00 sam@mars.ravnborg.org 
#   kbuild: Introduce hostprogs-y, deprecate host-progs
#   
#   Introducing hostprogs-y allows a user to use the typical Kbuild
#   pattern in a Kbuild file:
#   hostprogs-$(CONFIG_KALLSYMS) += ...
#   
#   And then during cleaning the referenced file are still deleted.
#   Deprecate the old host-progs assignment but kept the functionlity.
#   
#   External modules will continue to use host-progs for a while - drawback is
#   that they now see a warning.
#   Workaround - just assign both variables:
#   hostprogs-y := foo
#   host-progs  := $(hostprogs-y)
#   
#   All in-kernel users will be converted in next patch.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.host
#   2004/08/10 21:38:27+02:00 sam@mars.ravnborg.org +14 -12
#   Replace host-progs with hostprogs-y (and hostprogs-m)
# 
# scripts/Makefile.clean
#   2004/08/10 21:38:27+02:00 sam@mars.ravnborg.org +4 -2
#   Introduced the new hostprogs variant, and kept the old one
# 
# scripts/Makefile.build
#   2004/08/10 21:38:27+02:00 sam@mars.ravnborg.org +6 -1
#   Deprecate host-progs, replace it with hostprogs-y.
# 
# Documentation/kbuild/makefiles.txt
#   2004/08/10 21:38:27+02:00 sam@mars.ravnborg.org +26 -11
#   Replcae host-progs with hostprogs-y
# 
diff -Nru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2004-08-13 21:08:12 +02:00
+++ b/Documentation/kbuild/makefiles.txt	2004-08-13 21:08:12 +02:00
@@ -25,6 +25,7 @@
 	   --- 4.4 Using C++ for host programs
 	   --- 4.5 Controlling compiler options for host programs
 	   --- 4.6 When host programs are actually built
+	   --- 4.7 Using hostprogs-$(CONFIG_FOO)
 
 	=== 5 Kbuild clean infrastructure
 
@@ -387,7 +388,7 @@
 Two steps are required in order to use a host executable.
 
 The first step is to tell kbuild that a host program exists. This is
-done utilising the variable host-prog.
+done utilising the variable hostprogs-y.
 
 The second step is to add an explicit dependency to the executable.
 This can be done in two ways. Either add the dependency in a rule, 
@@ -402,7 +403,7 @@
 	built on the build host.
 
 	Example:
-		host-progs := bin2hex
+		hostprogs-y := bin2hex
 
 	Kbuild assumes in the above example that bin2hex is made from a single
 	c-source file named bin2hex.c located in the same directory as
@@ -418,7 +419,7 @@
 
 	Example:
 		#scripts/lxdialog/Makefile
-		host-progs    := lxdialog  
+		hostprogs-y   := lxdialog  
 		lxdialog-objs := checklist.o lxdialog.o
 
 	Objects with extension .o are compiled from the corresponding .c
@@ -438,7 +439,7 @@
 
 	Example:
 		#scripts/kconfig/Makefile
-		host-progs      := conf
+		hostprogs-y     := conf
 		conf-objs       := conf.o libkconfig.so
 		libkconfig-objs := expr.o type.o
   
@@ -457,7 +458,7 @@
 
 	Example:
 		#scripts/kconfig/Makefile
-		host-progs    := qconf
+		hostprogs-y   := qconf
 		qconf-cxxobjs := qconf.o
 
 	In the example above the executable is composed of the C++ file
@@ -468,7 +469,7 @@
 
 	Example:
 		#scripts/kconfig/Makefile
-		host-progs    := qconf
+		hostprogs-y   := qconf
 		qconf-cxxobjs := qconf.o
 		qconf-objs    := check.o
 	
@@ -509,7 +510,7 @@
 
 	Example:
 		#drivers/pci/Makefile
-		host-progs := gen-devlist
+		hostprogs-y := gen-devlist
 		$(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
 			( cd $(obj); ./gen-devlist ) < $<
 
@@ -524,18 +525,32 @@
 
 	Example:
 		#scripts/lxdialog/Makefile
-		host-progs    := lxdialog
-		always        := $(host-progs)
+		hostprogs-y   := lxdialog
+		always        := $(hostprogs-y)
 
 	This will tell kbuild to build lxdialog even if not referenced in
 	any rule.
 
+--- 4.7 Using hostprogs-$(CONFIG_FOO)
+
+	A typcal pattern in a Kbuild file lok like this:
+
+	Example:
+		#scripts/Makefile
+		hostprogs-$(CONFIG_KALLSYMS) += kallsyms
+
+	Kbuild knows about both 'y' for built-in and 'm' for module.
+	So if a config symbol evaluate to 'm', kbuild will still build
+	the binary. In other words Kbuild handle hostprogs-m exactly
+	like hostprogs-y. But only hostprogs-y is recommend used
+	when no CONFIG symbol are involved.
+
 === 5 Kbuild clean infrastructure
 
 "make clean" deletes most generated files in the src tree where the kernel
 is compiled. This includes generated files such as host programs.
-Kbuild knows targets listed in $(host-progs), $(always), $(extra-y) and
-$(targets). They are all deleted during "make clean".
+Kbuild knows targets listed in $(hostprogs-y), $(hostprogs-m), $(always),
+$(extra-y) and $(targets). They are all deleted during "make clean".
 Files matching the patterns "*.[oas]", "*.ko", plus some additional files
 generated by kbuild are deleted all over the kernel src tree when
 "make clean" is executed.
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-08-13 21:08:12 +02:00
+++ b/scripts/Makefile.build	2004-08-13 21:08:12 +02:00
@@ -14,8 +14,13 @@
 
 include scripts/Makefile.lib
 
-# Do not include host-progs rules unles needed
 ifdef host-progs
+$(warning kbuild: $(obj)/Makefile - Usage of host-progs is deprecated. Please replace with hostprogs-y!)
+hostprogs-y += $(host-progs)
+endif
+
+# Do not include host rules unles needed
+ifneq ($(hostprogs-y)$(hostprogs-m),)
 include scripts/Makefile.host
 endif
 
diff -Nru a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean	2004-08-13 21:08:12 +02:00
+++ b/scripts/Makefile.clean	2004-08-13 21:08:12 +02:00
@@ -29,8 +29,10 @@
 # Add subdir path
 
 subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
-__clean-files	:= $(extra-y) $(EXTRA_TARGETS) $(always) $(host-progs) \
-		   $(targets) $(clean-files)
+__clean-files	:= $(extra-y) $(EXTRA_TARGETS) $(always) \
+		   $(targets) $(clean-files)             \
+		   $(host-progs)                         \
+		   $(hostprogs-y) $(hostprogs-m) $(hostprogs-)
 __clean-files   := $(wildcard                                               \
                    $(addprefix $(obj)/, $(filter-out /%, $(__clean-files))) \
 		   $(filter /%, $(__clean-files)))
diff -Nru a/scripts/Makefile.host b/scripts/Makefile.host
--- a/scripts/Makefile.host	2004-08-13 21:08:12 +02:00
+++ b/scripts/Makefile.host	2004-08-13 21:08:12 +02:00
@@ -6,21 +6,21 @@
 # Both C and C++ is supported, but preferred language is C for such utilities.
 #
 # Samle syntax (see Documentation/kbuild/makefile.txt for reference)
-# host-progs := bin2hex
+# hostprogs-y := bin2hex
 # Will compile bin2hex.c and create an executable named bin2hex
 #
-# host-progs    := lxdialog
+# hostprogs-y    := lxdialog
 # lxdialog-objs := checklist.o lxdialog.o
 # Will compile lxdialog.c and checklist.c, and then link the executable
 # lxdialog, based on checklist.o and lxdialog.o
 #
-# host-progs      := qconf
+# hostprogs-y      := qconf
 # qconf-cxxobjs   := qconf.o
 # qconf-objs      := menu.o
 # Will compile qconf as a C++ program, and menu as a C program.
 # They are linked as C++ code to the executable qconf
 
-# host-progs := conf
+# hostprogs-y := conf
 # conf-objs  := conf.o libkconfig.so
 # libkconfig-objs := expr.o type.o
 # Will create a shared library named libkconfig.so that consist of
@@ -28,28 +28,30 @@
 # are made as position independent code).
 # conf.c is compiled as a c program, and conf.o is linked together with
 # libkconfig.so as the executable conf.
-# Note: Shared libraries consisting of C++ files are not supported  
+# Note: Shared libraries consisting of C++ files are not supported
 
-# host-progs := tools/build may have been specified. Retreive directory
-obj-dirs += $(foreach f,$(host-progs), $(if $(dir $(f)),$(dir $(f))))
+__hostprogs := $(hostprogs-y)$(hostprogs-m)
+
+# hostprogs-y := tools/build may have been specified. Retreive directory
+obj-dirs += $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
 obj-dirs := $(strip $(sort $(filter-out ./,$(obj-dirs))))
 
 
 # C code
 # Executables compiled from a single .c file
-host-csingle	:= $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
+host-csingle	:= $(foreach m,$(__hostprogs),$(if $($(m)-objs),,$(m)))
 
 # C executables linked based on several .o files
-host-cmulti	:= $(foreach m,$(host-progs),\
+host-cmulti	:= $(foreach m,$(__hostprogs),\
 		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
 
 # Object (.o) files compiled from .c files
-host-cobjs	:= $(sort $(foreach m,$(host-progs),$($(m)-objs)))
+host-cobjs	:= $(sort $(foreach m,$(__hostprogs),$($(m)-objs)))
 
 # C++ code
 # C++ executables compiled from at least on .cc file
 # and zero or more .c files
-host-cxxmulti	:= $(foreach m,$(host-progs),$(if $($(m)-cxxobjs),$(m)))
+host-cxxmulti	:= $(foreach m,$(__hostprogs),$(if $($(m)-cxxobjs),$(m)))
 
 # C++ Object (.o) files compiled from .cc files
 host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))
@@ -63,7 +65,7 @@
 #Object (.o) files used by the shared libaries
 host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
 
-host-progs      := $(addprefix $(obj)/,$(host-progs))
+__hostprogs     := $(addprefix $(obj)/,$(__hostprogs))
 host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
 host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
 host-cobjs	:= $(addprefix $(obj)/,$(host-cobjs))
