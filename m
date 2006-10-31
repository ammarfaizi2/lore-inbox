Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWJaAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWJaAMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbWJaAMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:12:37 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:35215 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S1030206AbWJaAMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:12:37 -0500
Date: Tue, 31 Oct 2006 01:12:36 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>, dsd@gentoo.org,
       kernel@gentoo.org, draconx@gmail.com, jpdenheijer@gmail.com,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061031001235.GE2933@quickstop.soohrt.org>
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>,
	Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
	dsd@gentoo.org, kernel@gentoo.org, draconx@gmail.com,
	jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz> <slrnekc3q8.2vm.olecom@flower.upol.cz> <200610301522.k9UFMXmM004701@turing-police.cc.vt.edu> <slrnekc8np.2vm.olecom@flower.upol.cz> <slrnekcu6m.2vm.olecom@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnekcu6m.2vm.olecom@flower.upol.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Oleg Verych wrote:
> For current state of things, i wish to propose
> 
> kbuild-mm-more-option-check-fixes.pre-patch:
> 
> Request For Testing.
> 
> Interested parties may test this one.
> $(ret) is used for debug. In final version it may be removed,
> $(objtree)/null must be known for clean targets.
> 
> I've replaced one `echo -e' with `printf', because, for example, my shell is
> not bash, and built-in `echo' have not `-e' option, `printf' works everywhere.
> [trailing spaces killed: +1]
> 
> Any comments are appreciated.

The problem is, this brings us back to the problem where this whole
patch orgy began: Gentoo Portage sandbox violations when writing (the
null symlink) to the kernel tree when building external modules. What
about using $(M) as a base directory if it is defined?

--- linux-mm/scripts/Kbuild.include.orig	2006-10-31 01:06:13.000000000 +0100
+++ linux-mm/scripts/Kbuild.include	2006-10-31 01:07:01.000000000 +0100
@@ -7,6 +7,20 @@ squote  := '
 empty   :=
 space   := $(empty) $(empty)
 
+# Immortal null for mortals and roots
+ifdef M
+  null = $(M)/null
+else
+  null = null
+endif
+define createnull
+  $(shell \
+    if test -L $(null); \
+      then echo $(null); \
+      else rm -f $(null); ln -s /dev/null $(null); \
+    fi)
+endef
+
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
 dot-target = $(dir $@).$(notdir $@)
@@ -56,30 +70,46 @@ endef
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
+    if $(CC) $(CFLAGS) $(1) -c -o $(createnull) -xassembler $(null) >$(null) 2>&1; \
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
+    if printf "$(1)" | $(AS) >$(createnull) 2>&1 -W -o $(null); \
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
+    if $(CC) $(CFLAGS) $(1) -S -o $(createnull) -xc $(null) >$(null) 2>&1; \
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
+    if $(CC) $(CFLAGS) $(1) -S -o $(createnull) -xc $(null) >$(null) 2>&1; \
+      then $(call ret,"y"); \
+      else $(call ret,"n"); \
+    fi)
+endef
 
 # cc-option-align
 # Prefix align with either -falign or -malign
@@ -97,10 +127,13 @@ cc-ifversion = $(shell if [ $(call cc-ve
 
 # ld-option
 # Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
-ld-option = $(shell if $(CC) $(1) \
-			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f ldtest$$$$.out)
+define ld-option
+  $(shell \
+    if $(CC) $(1) -nostdlib -o $(createnull) -xc $(null) >$(null) 2>&1; \
+      then $(call ret,"$(1)"); \
+      else $(call ret,"$(2)"); \
+    fi)
+endef
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
@@ -120,7 +153,7 @@ cmd = @$(echo-cmd) $(cmd_$(1))
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
 
 ###
-# if_changed      - execute command if any prerequisite is newer than 
+# if_changed      - execute command if any prerequisite is newer than
 #                   target, or command line has changed
 # if_changed_dep  - as if_changed, but uses fixdep to reveal dependencies
 #                   including used config symbols
