Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWJ3WGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWJ3WGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWJ3WGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:06:38 -0500
Received: from raven.upol.cz ([158.194.120.4]:32945 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1422685AbWJ3WGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:06:37 -0500
To: Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
       Oleg Verych <olecom@flower.upol.cz>, dsd@gentoo.org, kernel@gentoo.org,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
X-Posted-To: gmane.linux.kernel
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz> <slrnekc3q8.2vm.olecom@flower.upol.cz> <200610301522.k9UFMXmM004701@turing-police.cc.vt.edu> <slrnekc8np.2vm.olecom@flower.upol.cz>
Organization: Palacky University in Olomouc, experimental physics department.
Date: Mon, 30 Oct 2006 22:12:38 +0000
Message-ID: <slrnekcu6m.2vm.olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-10-30, <olecom@flower> wrote:
> Fix for roots:
> ,--
>|if [ `id -u` == "0" ]; then echo "Root landed !!!"; ! true; fi
> `--
> More polite fools-protection, with guaranteed permission from the user:
> ,--
>|if [ `id -u` == "0" ]; then useradd bkernel && su bkernel fi;
> `--
> ____

For current state of things, i wish to propose

kbuild-mm-more-option-check-fixes.pre-patch:

Request For Testing.

Interested parties may test this one.
$(ret) is used for debug. In final version it may be removed,
$(objtree)/null must be known for clean targets.

I've replaced one `echo -e' with `printf', because, for example, my shell is
not bash, and built-in `echo' have not `-e' option, `printf' works everywhere.
[trailing spaces killed: +1]

Any comments are appreciated.
____

--- linux-2.6.19-rc3-mm1/scripts/Kbuild.include	2006-10-28 01:26:25.000000000 +0000
+++ linux-2.6.19-rc3-mm1/scripts/Kbuild.include~more-option-check-fixes	2006-10-30 20:39:03.641018805 +0000
@@ -7,6 +7,15 @@ squote  := '
 empty   :=
 space   := $(empty) $(empty)
 
+# Immortal null for mortals and roots
+define null
+  $(shell \
+    if test -L null; \
+      then echo null; \
+      else rm -f null; ln -s /dev/null null; \
+    fi)
+endef
+
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
 dot-target = $(dir $@).$(notdir $@)
@@ -56,30 +65,46 @@ endef
 # gcc support functions
 # See documentation in Documentation/kbuild/makefiles.txt
 
+ret = echo "$(1)" ; echo "$(1)" >> results.txt
 # as-option
 # Usage: cflags-y += $(call as-option, -Wa$(comma)-isa=foo,)
-
-as-option = $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
-	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
-	     else echo "$(2)"; fi ;)
+define as-option
+  $(shell \
+    if $(CC) $(CFLAGS) $(1) -c -o $(null) -xassembler null >null 2>&1; \
+      then $(call ret,"$(1)"); \
+      else $(call ret,"$(2)"); \
+    fi)
+endef
 
 # as-instr
 # Usage: cflags-y += $(call as-instr, instr, option1, option2)
-
-as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o astest$$$$.out ; \
-		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f astest$$$$.out)
+define as-instr
+  $(shell \
+    if printf "$(1)" | $(AS) >null 2>&1 -W -o $(null); \
+      then $(call ret,"$(2)"); \
+      else $(call ret,"$(3)"); \
+    fi)
+endef
 
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
-
-cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
+define cc-option
+  $(shell \
+    if $(CC) $(CFLAGS) $(1) -S -o $(null) -xc null >null 2>&1; \
+      then $(call ret,"$(1)"); \
+      else $(call ret,"$(2)"); \
+    fi)
+endef
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn, -march=winchip-c6)
-cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
-                > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
+define cc-option-yn
+  $(shell \
+    if $(CC) $(CFLAGS) $(1) -S -o $(null) -xc null >null 2>&1; \
+      then $(call ret,"y"); \
+      else $(call ret,"n"); \
+    fi)
+endef
 
 # cc-option-align
 # Prefix align with either -falign or -malign
@@ -97,10 +122,13 @@ cc-ifversion = $(shell if [ $(call cc-ve
 
 # ld-option
 # Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
-ld-option = $(shell if $(CC) $(1) \
-			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f ldtest$$$$.out)
+define ld-option
+  $(shell \
+    if $(CC) $(1) -nostdlib -o $(null) -xc null >null 2>&1; \
+      then $(call ret,"$(1)"); \
+      else $(call ret,"$(2)"); \
+    fi)
+endef
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
@@ -120,7 +148,7 @@ cmd = @$(echo-cmd) $(cmd_$(1))
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
 
 ###
-# if_changed      - execute command if any prerequisite is newer than 
+# if_changed      - execute command if any prerequisite is newer than
 #                   target, or command line has changed
 # if_changed_dep  - as if_changed, but uses fixdep to reveal dependencies
 #                   including used config symbols
