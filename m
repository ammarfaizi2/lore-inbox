Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUHMTxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUHMTxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHMTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:52:41 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:5694 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266825AbUHMTm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:42:59 -0400
Date: Fri, 13 Aug 2004 21:45:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [1/12] kbuild: Check for undefined symbols in vmlinux
Message-ID: <20040813194514.GA10556@mars.ravnborg.org>
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
#   2004/08/07 21:35:44+02:00 sam@mars.ravnborg.org 
#   kbuild: Check for undefined symbols in vmlinux
#   
#   At least one bin-utils version for ARM is know to ignore undefined
#   symbols when performing the final link of vmlinux.
#   Add an explicit check for undefined symbols to catch this.
#   The check is made in combination with generating the System.map file
#   and the actual algorithm is moved to a small shell script - mksysmap.
#   
#   External symbols with three leading underscores are ignored - sparc
#   uses them for the BTFIXUP logic.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/mksysmap
#   2004/08/07 21:35:27+02:00 sam@mars.ravnborg.org +54 -0
# 
# scripts/mksysmap
#   2004/08/07 21:35:27+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/kbuild/scripts/mksysmap
# 
# Makefile
#   2004/08/07 21:35:27+02:00 sam@mars.ravnborg.org +18 -7
#   Use new mksysmap script when generating System.map
#   Also make nice printout when executing in non-verbose mode.
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-13 21:09:35 +02:00
+++ b/Makefile	2004-08-13 21:09:35 +02:00
@@ -538,8 +538,9 @@
 	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
 
-do_system_map = $(NM) $(1) | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > $(2)
-
+quiet_cmd_sysmap = SYSMAP 
+      cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
+		   
 LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
 
 #	Generate section listing all symbols and add it into vmlinux
@@ -570,8 +571,10 @@
 kallsyms.o := .tmp_kallsyms$(last_kallsyms).o
 
 define rule_verify_kallsyms
-	@$(call do_system_map, .tmp_vmlinux$(last_kallsyms), .tmp_System.map)
-	@cmp -s System.map .tmp_System.map || \
+	$(Q)$(if $($(quiet)cmd_sysmap),                       \
+	  echo '  $($(quiet)cmd_sysmap) .tmp_System.map' &&)  \
+	  $(cmd_sysmap) .tmp_vmlinux$(last_kallsyms) .tmp_System.map
+	$(Q)cmp -s System.map .tmp_System.map || \
 		(echo Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS ; rm .tmp_kallsyms* ; false)
 endef
 
@@ -595,11 +598,19 @@
 
 endif
 
-#	Finally the vmlinux rule
+# Finally the vmlinux rule
+# This rule is also used to generate System.map
+# and to verify that the content of kallsyms are consistent
 
 define rule_vmlinux
-	$(rule_vmlinux__); \
-	$(call do_system_map, $@, System.map)
+	$(rule_vmlinux__);
+	$(Q)$(if $($(quiet)cmd_sysmap),          \
+	  echo '  $($(quiet)cmd_sysmap) $@' &&)  \
+	$(cmd_sysmap) $@ System.map;             \
+	if [ $$? -ne 0 ]; then                   \
+		rm -f $@;                        \
+		/bin/false;                      \
+	fi;
 	$(rule_verify_kallsyms)
 endef
 
diff -Nru a/scripts/mksysmap b/scripts/mksysmap
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/mksysmap	2004-08-13 21:09:35 +02:00
@@ -0,0 +1,54 @@
+#!/bin/sh -x
+# Based on the vmlinux file create the System.map file
+# System.map is used by module-init tools and some debugging
+# tools to retreive the actual addresses of symbols in the kernel.
+#
+# Before creating the System.map file as a sideeffect check for
+# undefined symbols.
+# At least one version of the ARM bin-utils did not error out on
+# undefined symbols, so catch them here instead.
+
+# Usage
+# mksysmap vmlinux System.map
+
+
+#####
+# Check for undefined symbols.
+# Undefined symbols with three leading underscores are ignored since
+# they are used by the sparc BTFIXUP logic - and is assumed to be undefined.
+
+
+if [ "`$NM -u $1 | grep -v ' ____'`" != "" ]; then
+	echo "$1: error: undefined symbol(s) found:"
+	$NM -u $1 | grep -v ' ___'
+	exit 1
+fi
+
+#####
+# Generate System.map (actual filename passed as second argument)
+
+# $NM produces the following output:
+# f0081e80 T alloc_vfsmnt
+
+#   The second row specify the type of the symbol:
+#   A = Absolute
+#   B = Uninitialised data (.bss)
+#   C = Comon symbol
+#   D = Initialised data
+#   G = Initialised data for small objects
+#   I = Indirect reference to another symbol
+#   N = Debugging symbol
+#   R = Read only
+#   S = Uninitialised data for small objects
+#   T = Text code symbol
+#   U = Undefined symbol
+#   V = Weak symbol
+#   W = Weak symbol
+#   Corresponding small letters are local symbols
+
+# For System.map filter away:
+#   a - local absolute symbols
+#   U - undefined global symbols
+#   w - local weak symbols
+
+nm $1 | grep -v ' [aUw] ' > $2
