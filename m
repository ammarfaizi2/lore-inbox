Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWHJTiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWHJTiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWHJTiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:02 -0400
Received: from ns2.suse.de ([195.135.220.15]:29676 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932701AbWHJThs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:48 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [67/145] x86_64: Detect CFI support in the assembler at runtime
Message-Id: <20060810193623.1923113B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:23 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

... instead of using a CONFIG option. The config option still controls
if the resulting executable actually has unwind information.

This is useful to prevent compilation errors when users select
CONFIG_STACK_UNWIND on old binutils and also allows to use
CFI in the future for non kernel debugging applications.

Cc: jbeulich@novell.com
Cc: sam@ravnborg.org


Signed-off-by: Andi Kleen <ak@suse.de>

---
 Documentation/kbuild/makefiles.txt |    5 +++++
 arch/i386/Makefile                 |    3 +++
 arch/x86_64/Makefile               |    2 ++
 include/asm-x86_64/dwarf2.h        |    2 +-
 scripts/Kbuild.include             |    6 ++++++
 5 files changed, 17 insertions(+), 1 deletion(-)

Index: linux/Documentation/kbuild/makefiles.txt
===================================================================
--- linux.orig/Documentation/kbuild/makefiles.txt
+++ linux/Documentation/kbuild/makefiles.txt
@@ -421,6 +421,11 @@ more details, with real examples.
 	The second argument is optional, and if supplied will be used
 	if first argument is not supported.
 
+    as-instr
+	as-instr checks if the assembler reports a specific instruction
+	and then outputs either option1 or option2
+	C escapes are supported in the test instruction
+
     cc-option
 	cc-option is used to check if $(CC) support a given option, and not
 	supported to use an optional second option.
Index: linux/arch/x86_64/Makefile
===================================================================
--- linux.orig/arch/x86_64/Makefile
+++ linux/arch/x86_64/Makefile
@@ -54,6 +54,8 @@ endif
 cflags-y += $(call cc-option,-funit-at-a-time)
 # prevent gcc from generating any FP code by mistake
 cflags-y += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
+# do binutils support CFI?
+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 
 CFLAGS += $(cflags-y)
 CFLAGS_KERNEL += $(cflags-kernel-y)
Index: linux/include/asm-x86_64/dwarf2.h
===================================================================
--- linux.orig/include/asm-x86_64/dwarf2.h
+++ linux/include/asm-x86_64/dwarf2.h
@@ -13,7 +13,7 @@
    away for older version. 
  */
 
-#ifdef CONFIG_UNWIND_INFO
+#ifdef CONFIG_AS_CFI
 
 #define CFI_STARTPROC .cfi_startproc
 #define CFI_ENDPROC .cfi_endproc
Index: linux/scripts/Kbuild.include
===================================================================
--- linux.orig/scripts/Kbuild.include
+++ linux/scripts/Kbuild.include
@@ -59,6 +59,12 @@ as-option = $(shell if $(CC) $(CFLAGS) $
 	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
 	     else echo "$(2)"; fi ;)
 
+# as-instr
+# Usage: cflags-y += $(call as-instr, instr, option1, option2)
+
+as-instr = $(shell if echo -e "$(1)" | $(AS) -Z -o /dev/null \
+		   2>&1 >/dev/null ; then echo "$(2)"; else echo "$(3)"; fi;)
+
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
 
Index: linux/arch/i386/Makefile
===================================================================
--- linux.orig/arch/i386/Makefile
+++ linux/arch/i386/Makefile
@@ -46,6 +46,9 @@ cflags-y += -ffreestanding
 # a lot more stack due to the lack of sharing of stacklots:
 CFLAGS				+= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo $(call cc-option,-fno-unit-at-a-time); fi ;)
 
+# do binutils support CFI?
+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
+
 CFLAGS += $(cflags-y)
 
 # Default subarch .c files
