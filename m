Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUIASEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUIASEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUIASEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:04:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56020 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S267383AbUIASEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:04:08 -0400
Date: Wed, 1 Sep 2004 11:03:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Carsten Milling <cmil@hashtable.de>
Subject: [PATCH][PPC32] Fix the 'checkbin' target
Message-ID: <20040901180356.GD19730@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Currently, the checkbin target on PPC32 isn't quite right.  First, one
of the tests (to ensure that some instructions are known to gas) is
never actually invoked because 'checkbin' doesn't know about stuff set
in .config, so we always have the 'else' case run.  This changes to
always running the test and telling the user to upgrade to at least
binutils 2.12.1.  The next problem is that we were doing $(AS) -o
/dev/null ... in both that test, as well as another.  The problem here
is that the checkbin target is run on the install targets, meaning that
/dev/null will get unlinked when the test passes.  To get around this we
use .tmp_gas_check as the output file instead.

Assuming Sam doesn't object, I hope this can go in quickly.  Thanks.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.orig/arch/ppc/Makefile
+++ linux-2.6/arch/ppc/Makefile
@@ -104,16 +104,15 @@ arch/$(ARCH)/kernel/asm-offsets.s: inclu
 include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-ifdef CONFIG_6xx
-# Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later
-NEW_AS	:= $(shell echo dssall | $(AS) -many -o /dev/null >/dev/null 2>&1 ; echo $$?)
-GOODVER	:= 2.12.1
-else
-NEW_AS	:= 0
-endif
+# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
+# to stdout and these checks are run even on install targets.
+TOUT	:= .tmp_gas_check
+# Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
+# instructions.
+AS_ALTIVEC	:= $(shell echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; echo $$?)
 # gcc-3.4 and binutils-2.14 are a fatal combination.
 GCC_VERSION	:= $(call cc-version)
-BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null >/dev/null 2>&1 && echo 0 || echo 1)
+BAD_GCC_AS	:= $(shell echo mftb 5 | $(AS) -mppc -many -o $(TOUT) >/dev/null 2>&1 && echo 0 || echo 1)
 
 checkbin:
 ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
@@ -122,10 +121,11 @@ ifeq ($(GCC_VERSION)$(BAD_GCC_AS),03041)
 	@echo '*** Please upgrade your binutils or downgrade your gcc'
 	@false
 endif
-ifneq ($(NEW_AS),0)
+ifneq ($(AS_ALTIVEC),0)
+	echo $(AS_ALTIVEC)
 	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '
 	@echo 'correctly with old versions of binutils.'
-	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
+	@echo '*** Please upgrade your binutils to 2.12.1 or newer'
 	@false
 endif
 	@true

-- 
Tom Rini
http://gate.crashing.org/~trini/
