Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264105AbUEMLdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUEMLdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUEMLdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:33:09 -0400
Received: from ozlabs.org ([203.10.76.45]:2182 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264105AbUEMLdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:33:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16547.23800.280519.689864@cargo.ozlabs.ibm.com>
Date: Thu, 13 May 2004 21:33:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, olh@suse.de
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Kconfig bits for CONFIG_SPINLINE
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I sent the patch to uninline the spinlocks, I inadvertently left
out the change to arch/ppc64/Kconfig which defines the config symbol
for inlining the locks (CONFIG_SPINLINE now).  This patch adds it.  It
also adds a symbol CONFIG_PPC_SPLPAR which enables the code for
calling the hypervisor on shared-processor logically-partitioned
system to yield the physical processor to the lock holder when
spinning.  (The code that depends on this symbol is already present in
arch/ppc64/lib/locks.c.)

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/Kconfig g5-ppc64/arch/ppc64/Kconfig
--- linux-2.5/arch/ppc64/Kconfig	2004-05-11 07:53:04.000000000 +1000
+++ g5-ppc64/arch/ppc64/Kconfig	2004-05-13 21:08:47.621961712 +1000
@@ -93,6 +93,16 @@
 	bool "Apple PowerMac G5 support"
 	select ADB_PMU
 
+config PPC_SPLPAR
+	depends on PPC_PSERIES
+	bool "Support for shared-processor logical partitions"
+	default n
+	help
+	  Enabling this option will make the kernel run more efficiently
+	  on logically-partitioned pSeries systems which use shared
+	  processors, that is, which share physical processors between
+	  two or more partitions.
+
 config PMAC_DART
 	bool "Enable DART/IOMMU on PowerMac (allow >2G of RAM)"
 	depends on PPC_PMAC
@@ -407,7 +417,17 @@
 	  debugging info resulting in a larger kernel image.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
-	  
+
+config SPINLINE
+	bool "Inline spinlock code at each call site"
+	depends on SMP && !PPC_SPLPAR && !PPC_ISERIES
+	help
+	  Say Y if you want to have the code for acquiring spinlocks
+	  and rwlocks inlined at each call site.  This makes the kernel
+	  somewhat bigger, but can be useful when profiling the kernel.
+
+	  If in doubt, say N.
+
 endmenu
 
 source "security/Kconfig"
