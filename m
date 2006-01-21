Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWAUW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWAUW5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWAUW5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:57:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34064 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751208AbWAUW5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:57:43 -0500
Date: Sat, 21 Jan 2006 23:57:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121225728.GA13756@mars.ravnborg.org>
References: <20060121180805.GA15761@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121180805.GA15761@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 07:08:05PM +0100, Olaf Hering wrote:
> 
> I want to add a gcc version check for reiserfs, on akpms request.
> This one doesnt work with 2.6.16rc1, havent checked if it ever worked.

I did the following:
- Moved definitions from Makefile to scripts/Kbuild.include
- Moved include of Kbuild.include up before include of kbuild file
- Documented the 'new' as-option
- Added new macro: cc-ifversion
- Added documentation for cc-ifversion

Let me know if this works for you.

>  ifeq ($(CONFIG_PPC32),y)
> -EXTRA_CFLAGS := -O1
> +EXTRA_CFLAGS := $(shell set -x ; if [ $(call cc-version) -lt 0402 ] ; then echo $(call cc-option,-O1); fi ;)

For -O1 I do not see the point in using $(call cc-option ...).
I assume all gcc version does support -O1 - or?

	Sam

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 443230b..14f925a 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -981,6 +981,20 @@ When kbuild executes the following steps
 	$(CC) is useally the gcc compiler, but other alternatives are
 	available.
 
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
     cc-option
 	cc-option is used to check if $(CC) support a given option, and not
 	supported to use an optional second option.
@@ -1039,7 +1053,21 @@ When kbuild executes the following steps
 
 	In the above example -mregparm=3 is only used for gcc version greater
 	than or equal to gcc 3.0.
-	
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
 
 === 7 Kbuild Variables
 
diff --git a/Makefile b/Makefile
index 31bbc6a..da3c528 100644
--- a/Makefile
+++ b/Makefile
@@ -259,38 +259,6 @@ endif
 
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
