Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752426AbWJ0TQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbWJ0TQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbWJ0TQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 15:16:27 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:59325 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752426AbWJ0TQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 15:16:26 -0400
Date: Fri, 27 Oct 2006 12:08:37 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, gregkh <greg@kroah.com>, sam@ravnborg.org,
       Ankita Garg <ankita@in.ibm.com>
Subject: [PATCH 2/2] kconfig.debug menu dependencies
Message-Id: <20061027120837.f694814d.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

DEBUG_FS, HEADERS_CHECK, and UNWIND don't depend on DEBUG_KERNEL but
they were stuck into the middle of the DEBUG_KERNEL menu, so move
them up above it (since it continues wherever lib/Kconfig.debug was
sourced into, hence below it won't work).

Also make LKDTM depend on DEBUG_KERNEL, as other test modules do
(e.g., RT MUTEX TESTER, RCU TORTURE TEST).

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 lib/Kconfig.debug |   87 +++++++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 43 deletions(-)

--- linux-2619-rc3-pv.orig/lib/Kconfig.debug
+++ linux-2619-rc3-pv/lib/Kconfig.debug
@@ -47,6 +47,48 @@ config UNUSED_SYMBOLS
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
+config DEBUG_FS
+	bool "Debug Filesystem"
+	depends on SYSFS
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  If unsure, say N.
+
+config HEADERS_CHECK
+	bool "Run 'make headers_check' when building vmlinux"
+	depends on !UML
+	help
+	  This option will extract the user-visible kernel headers whenever
+	  building the kernel, and will run basic sanity checks on them to
+	  ensure that exported files do not attempt to include files which
+	  were not exported, etc.
+
+	  If you're making modifications to header files which are
+	  relevant for userspace, say 'Y', and check the headers
+	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
+	  your build tree), to make sure they're suitable.
+
+config UNWIND_INFO
+	bool "Compile the kernel with frame unwind information"
+	depends on !IA64 && !PARISC
+	depends on !MODULES || !(MIPS || PPC || SUPERH || V850)
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  but not slower, and it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame unwind information or frame pointers.
+
+config STACK_UNWIND
+	bool "Stack unwind support"
+	depends on UNWIND_INFO
+	depends on X86
+	help
+	  This enables more precise stack traces, omitting all unrelated
+	  occurrences of pointers into kernel code from the dump.
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
@@ -302,16 +344,6 @@ config DEBUG_INFO
 
 	  If unsure, say N.
 
-config DEBUG_FS
-	bool "Debug Filesystem"
-	depends on SYSFS
-	help
-	  debugfs is a virtual file system that kernel developers use to put
-	  debugging files into.  Enable this option to be able to read and
-	  write to these files.
-
-	  If unsure, say N.
-
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
@@ -340,24 +372,6 @@ config FRAME_POINTER
 	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 
-config UNWIND_INFO
-	bool "Compile the kernel with frame unwind information"
-	depends on !IA64 && !PARISC
-	depends on !MODULES || !(MIPS || PPC || SUPERH || V850)
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  but not slower, and it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame unwind information or frame pointers.
-
-config STACK_UNWIND
-	bool "Stack unwind support"
-	depends on UNWIND_INFO
-	depends on X86
-	help
-	  This enables more precise stack traces, omitting all unrelated
-	  occurrences of pointers into kernel code from the dump.
-
 config FORCED_INLINING
 	bool "Force gcc to inline functions marked 'inline'"
 	depends on DEBUG_KERNEL
@@ -372,20 +386,6 @@ config FORCED_INLINING
 	  become the default in the future, until then this option is there to
 	  test gcc for this.
 
-config HEADERS_CHECK
-	bool "Run 'make headers_check' when building vmlinux"
-	depends on !UML
-	help
-	  This option will extract the user-visible kernel headers whenever
-	  building the kernel, and will run basic sanity checks on them to
-	  ensure that exported files do not attempt to include files which
-	  were not exported, etc.
-
-	  If you're making modifications to header files which are
-	  relevant for userspace, say 'Y', and check the headers
-	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
-	  your build tree), to make sure they're suitable.
-
 config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL
@@ -402,7 +402,7 @@ config RCU_TORTURE_TEST
 
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
-	depends on KPROBES
+	depends on DEBUG_KERNEL && KPROBES
 	default n
 	help
 	This module enables testing of the different dumping mechanisms by
@@ -413,3 +413,4 @@ config LKDTM
 
 	Documentation on how to use the module can be found in
 	drivers/misc/lkdtm.c
+


---
