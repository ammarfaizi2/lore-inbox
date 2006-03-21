Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWCUQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWCUQfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCUQf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29452 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932430AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 11/46] kbuild: make cc-version available in kbuild files
In-Reply-To: <11429580554163-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <1142958055134-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move $(CC) support functions to Kbuild.include so they are available
in the kbuild files.
In addition the following was done:
	o as-option documented in Documentation/kbuild/makefiles.txt
	o Moved documentation to new section to match
	  new scope of functions
	o added cc-ifversion used to conditionally select a text string
	  dependent on actual $(CC) version
	o documented cc-ifversion
	o change so Kbuild.include is read before the kbuild file

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/makefiles.txt |  166 +++++++++++++++++++++---------------
 Makefile                           |   32 -------
 scripts/Kbuild.include             |   37 ++++++++
 scripts/Makefile.build             |    3 -
 4 files changed, 136 insertions(+), 102 deletions(-)

20a468b51325b3636785a8ca0047ae514b39cbd5
diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 443230b..99d51a5 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -17,6 +17,7 @@ This document describes the Linux kernel
 	   --- 3.8 Command line dependency
 	   --- 3.9 Dependency tracking
 	   --- 3.10 Special Rules
+	   --- 3.11 $(CC) support functions
 
 	=== 4 Host Program support
 	   --- 4.1 Simple Host Program
@@ -38,7 +39,6 @@ This document describes the Linux kernel
 	   --- 6.6 Commands useful for building a boot image
 	   --- 6.7 Custom kbuild commands
 	   --- 6.8 Preprocessing linker scripts
-	   --- 6.9 $(CC) support functions
 
 	=== 7 Kbuild Variables
 	=== 8 Makefile language
@@ -385,6 +385,102 @@ more details, with real examples.
 	to prerequisites are referenced with $(src) (because they are not
 	generated files).
 
+--- 3.11 $(CC) support functions
+
+	The kernel may be build with several different versions of
+	$(CC), each supporting a unique set of features and options.
+	kbuild provide basic support to check for valid options for $(CC).
+	$(CC) is useally the gcc compiler, but other alternatives are
+	available.
+
+    as-option
+    	as-option is used to check if $(CC) when used to compile
+	assembler (*.S) files supports the given option. An optional
+	second option may be specified if first option are not supported.
+
+	Example:
+		#arch/sh/Makefile
+		cflags-y += $(call as-option,-Wa$(comma)-isa=$(isa-y),)
+
+	In the above example cflags-y will be assinged the the option
+	-Wa$(comma)-isa=$(isa-y) if it is supported by $(CC).
+	The second argument is optional, and if supplied will be used
+	if first argument is not supported.
+
+    cc-option
+	cc-option is used to check if $(CC) support a given option, and not
+	supported to use an optional second option.
+
+	Example:
+		#arch/i386/Makefile
+		cflags-y += $(call cc-option,-march=pentium-mmx,-march=i586)
+
+	In the above example cflags-y will be assigned the option
+	-march=pentium-mmx if supported by $(CC), otherwise -march-i586.
+	The second argument to cc-option is optional, and if omitted
+	cflags-y will be assigned no value if first option is not supported.
+
+   cc-option-yn
+   	cc-option-yn is used to check if gcc supports a given option
+	and return 'y' if supported, otherwise 'n'.
+
+	Example:
+		#arch/ppc/Makefile
+		biarch := $(call cc-option-yn, -m32)
+		aflags-$(biarch) += -a32
+		cflags-$(biarch) += -m32
+	
+	In the above example $(biarch) is set to y if $(CC) supports the -m32
+	option. When $(biarch) equals to y the expanded variables $(aflags-y)
+	and $(cflags-y) will be assigned the values -a32 and -m32.
+
+    cc-option-align
+	gcc version >= 3.0 shifted type of options used to speify
+	alignment of functions, loops etc. $(cc-option-align) whrn used
+	as prefix to the align options will select the right prefix:
+	gcc < 3.00
+		cc-option-align = -malign
+	gcc >= 3.00
+		cc-option-align = -falign
+	
+	Example:
+		CFLAGS += $(cc-option-align)-functions=4
+
+	In the above example the option -falign-functions=4 is used for
+	gcc >= 3.00. For gcc < 3.00 -malign-functions=4 is used.
+	
+    cc-version
+	cc-version return a numerical version of the $(CC) compiler version.
+	The format is <major><minor> where both are two digits. So for example
+	gcc 3.41 would return 0341.
+	cc-version is useful when a specific $(CC) version is faulty in one
+	area, for example the -mregparm=3 were broken in some gcc version
+	even though the option was accepted by gcc.
+
+	Example:
+		#arch/i386/Makefile
+		cflags-y += $(shell \
+		if [ $(call cc-version) -ge 0300 ] ; then \
+			echo "-mregparm=3"; fi ;)
+
+	In the above example -mregparm=3 is only used for gcc version greater
+	than or equal to gcc 3.0.
+
+    cc-ifversion
+	cc-ifversion test the version of $(CC) and equals last argument if
+	version expression is true.
+
+	Example:
+		#fs/reiserfs/Makefile
+		EXTRA_CFLAGS := $(call cc-ifversion, -lt, 0402, -O1)
+
+	In this example EXTRA_CFLAGS will be assigned the value -O1 if the
+	$(CC) version is less than 4.2.
+	cc-ifversion takes all the shell operators: 
+	-eq, -ne, -lt, -le, -gt, and -ge
+	The third parameter may be a text as in this example, but it may also
+	be an expanded variable or a macro.
+
 
 === 4 Host Program support
 
@@ -973,74 +1069,6 @@ When kbuild executes the following steps
 	architecture specific files.
 
 
---- 6.9 $(CC) support functions
-
-	The kernel may be build with several different versions of
-	$(CC), each supporting a unique set of features and options.
-	kbuild provide basic support to check for valid options for $(CC).
-	$(CC) is useally the gcc compiler, but other alternatives are
-	available.
-
-    cc-option
-	cc-option is used to check if $(CC) support a given option, and not
-	supported to use an optional second option.
-
-	Example:
-		#arch/i386/Makefile
-		cflags-y += $(call cc-option,-march=pentium-mmx,-march=i586)
-
-	In the above example cflags-y will be assigned the option
-	-march=pentium-mmx if supported by $(CC), otherwise -march-i586.
-	The second argument to cc-option is optional, and if omitted
-	cflags-y will be assigned no value if first option is not supported.
-
-   cc-option-yn
-   	cc-option-yn is used to check if gcc supports a given option
-	and return 'y' if supported, otherwise 'n'.
-
-	Example:
-		#arch/ppc/Makefile
-		biarch := $(call cc-option-yn, -m32)
-		aflags-$(biarch) += -a32
-		cflags-$(biarch) += -m32
-	
-	In the above example $(biarch) is set to y if $(CC) supports the -m32
-	option. When $(biarch) equals to y the expanded variables $(aflags-y)
-	and $(cflags-y) will be assigned the values -a32 and -m32.
-
-    cc-option-align
-	gcc version >= 3.0 shifted type of options used to speify
-	alignment of functions, loops etc. $(cc-option-align) whrn used
-	as prefix to the align options will select the right prefix:
-	gcc < 3.00
-		cc-option-align = -malign
-	gcc >= 3.00
-		cc-option-align = -falign
-	
-	Example:
-		CFLAGS += $(cc-option-align)-functions=4
-
-	In the above example the option -falign-functions=4 is used for
-	gcc >= 3.00. For gcc < 3.00 -malign-functions=4 is used.
-	
-    cc-version
-	cc-version return a numerical version of the $(CC) compiler version.
-	The format is <major><minor> where both are two digits. So for example
-	gcc 3.41 would return 0341.
-	cc-version is useful when a specific $(CC) version is faulty in one
-	area, for example the -mregparm=3 were broken in some gcc version
-	even though the option was accepted by gcc.
-
-	Example:
-		#arch/i386/Makefile
-		cflags-y += $(shell \
-		if [ $(call cc-version) -ge 0300 ] ; then \
-			echo "-mregparm=3"; fi ;)
-
-	In the above example -mregparm=3 is only used for gcc version greater
-	than or equal to gcc 3.0.
-	
-
 === 7 Kbuild Variables
 
 The top Makefile exports the following variables:
diff --git a/Makefile b/Makefile
index c55d0f1..05b451a 100644
--- a/Makefile
+++ b/Makefile
@@ -258,38 +258,6 @@ endif
 
 export quiet Q KBUILD_VERBOSE
 
-######
-# cc support functions to be used (only) in arch/$(ARCH)/Makefile
-# See documentation in Documentation/kbuild/makefiles.txt
-
-# as-option
-# Usage: cflags-y += $(call as-option, -Wa$(comma)-isa=foo,)
-
-as-option = $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
-	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
-	     else echo "$(2)"; fi ;)
-
-# cc-option
-# Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
-
-cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
-
-# cc-option-yn
-# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
-cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
-                > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
-
-# cc-option-align
-# Prefix align with either -falign or -malign
-cc-option-align = $(subst -functions=0,,\
-	$(call cc-option,-falign-functions=0,-malign-functions=0))
-
-# cc-version
-# Usage gcc-ver := $(call cc-version $(CC))
-cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC)))
-
 
 # Look for make include files relative to root of kernel src
 MAKEFLAGS += --include-dir=$(srctree)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 0168d6c..92ce94b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -44,6 +44,43 @@ define filechk
 	fi
 endef
 
+######
+# cc support functions to be used (only) in arch/$(ARCH)/Makefile
+# See documentation in Documentation/kbuild/makefiles.txt
+
+# as-option
+# Usage: cflags-y += $(call as-option, -Wa$(comma)-isa=foo,)
+
+as-option = $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
+	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
+	     else echo "$(2)"; fi ;)
+
+# cc-option
+# Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
+
+cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
+
+# cc-option-yn
+# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
+cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
+                > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
+
+# cc-option-align
+# Prefix align with either -falign or -malign
+cc-option-align = $(subst -functions=0,,\
+	$(call cc-option,-falign-functions=0,-malign-functions=0))
+
+# cc-version
+# Usage gcc-ver := $(call cc-version, $(CC))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
+              $(if $(1), $(1), $(CC)))
+
+# cc-ifversion
+# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
+cc-ifversion = $(shell if [ $(call cc-version, $(CC)) $(1) $(2) ]; then \
+                       echo $(3); fi;)
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
 # Usage:
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c33e62b..2737765 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -10,11 +10,12 @@ __build:
 # Read .config if it exist, otherwise ignore
 -include .config
 
+include scripts/Kbuild.include
+
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
 include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
 
-include scripts/Kbuild.include
 include scripts/Makefile.lib
 
 ifdef host-progs
-- 
1.0.GIT


