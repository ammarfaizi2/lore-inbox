Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWB0Pce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWB0Pce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWB0Pce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:32:34 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:22214 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751474AbWB0PcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:32:20 -0500
Subject: [Patch 4/4] Tell GCC 4.1 to move unlikely() code to a separate
	section
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1141053825.2992.125.camel@laptopd505.fenrus.org>
References: <1141053825.2992.125.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 16:31:24 +0100
Message-Id: <1141054284.2992.136.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is more controversial I assume; it offers the option 
to use the gcc 4.1 option to move unlikely() code to a separate section.
On the con side, this means that longer byte sequences are needed to jump
to this code, on the Pro side it means that the unlikely() code isn't sharing
icache cachelines and tlbs anymore.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
 
---
 arch/x86_64/Kconfig.debug |   10 ++++++++++
 arch/x86_64/Makefile      |    4 ++++
 2 files changed, 14 insertions(+)

Index: linux-reorder2/arch/x86_64/Kconfig.debug
===================================================================
--- linux-reorder2.orig/arch/x86_64/Kconfig.debug
+++ linux-reorder2/arch/x86_64/Kconfig.debug
@@ -12,6 +12,16 @@ config DEBUG_RODATA
 	 of the kernel code won't be covered by a 2MB TLB anymore.
 	 If in doubt, say "N".
 
+config REORDER_BLOCKS
+	bool "Enable gcc to move unlikely() code away"
+	depends on DEBUG_KERNEL
+	help
+	  This option will enable gcc 4.1 and later to reorder code that is
+	  marked unlikely() far away from the code to the end of the kernel
+	  image. This allows the processor to make better use of the instruction
+	  cache, however it also makes OOPses harder to decode.
+	  If in doubt, say "N"
+
 config IOMMU_DEBUG
        depends on GART_IOMMU && DEBUG_KERNEL
        bool "Enable IOMMU debugging"
Index: linux-reorder2/arch/x86_64/Makefile
===================================================================
--- linux-reorder2.orig/arch/x86_64/Makefile
+++ linux-reorder2/arch/x86_64/Makefile
@@ -47,6 +47,10 @@ ifneq ($(CONFIG_DEBUG_INFO),y)
 # -fweb shrinks the kernel a bit, but the difference is very small
 # it also messes up debugging, so don't use it for now.
 #CFLAGS += $(call cc-option,-fweb)
+# -freorder-blocks-and-partition moves all unlikely() code out of the
+# way, to increase icache density of the hot codepaths.
+# this makes oopses harder to read as well, so it's a config option
+cflags-$(CONFIG_REORDER_BLOCKS) += $(call cc-option,-freorder-blocks-and-partition)
 endif
 # -funit-at-a-time shrinks the kernel .text considerably
 # unfortunately it makes reading oopses harder.

