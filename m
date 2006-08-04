Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWHDNOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWHDNOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWHDNOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:14:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:47830 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030300AbWHDNOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:14:06 -0400
Date: Fri, 4 Aug 2006 07:14:03 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131403.21401.32153.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/10] hot-add-mem x86_64: Kconfig changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

Create Kconfig namespace for MEMORY_HOTPLUG_RESERVE and MEMORY_HOTPLUG_SPARSE. 
This is needed to create a disticiton between the 2 paths. Selecting the high 
level opiton of MEMORY_HOTPLUG will get you MEMORY_HOTPLUG_SPARSE if you have 
sparsemem enabled or MEMORY_HOTPLUG_RESERVE if you are x86_64 with discontig 
and ACPI numa support. 


Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 arch/x86_64/Kconfig |    4 ++++
 mm/Kconfig          |    7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff -urN linux-2.6.18-rc3-stock/arch/x86_64/Kconfig linux-2.6.17/arch/x86_64/Kconfig
--- linux-2.6.18-rc3-stock/arch/x86_64/Kconfig	2006-07-31 21:08:04.000000000 -0400
+++ linux-2.6.17/arch/x86_64/Kconfig	2006-07-31 21:24:54.000000000 -0400
@@ -349,6 +349,10 @@
 
 source "mm/Kconfig"
 
+config MEMORY_HOTPLUG_RESERVE
+	def_bool y
+	depends on (MEMORY_HOTPLUG && DISCONTIGMEM)
+
 config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NUMA
diff -urN linux-2.6.18-rc3-stock/mm/Kconfig linux-2.6.17/mm/Kconfig
--- linux-2.6.18-rc3-stock/mm/Kconfig	2006-07-31 21:08:04.000000000 -0400
+++ linux-2.6.17/mm/Kconfig	2006-07-31 21:25:18.000000000 -0400
@@ -115,12 +115,17 @@
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
-	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND && ARCH_ENABLE_MEMORY_HOTPLUG
+	depends on SPARSEMEM || X86_64_ACPI_NUMA 
+	depends on HOTPLUG && !SOFTWARE_SUSPEND && ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on (IA64 || X86 || PPC64)
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND
 
+config MEMORY_HOTPLUG_SPARSE
+	def_bool y
+	depends on SPARSEMEM && MEMORY_HOTPLUG
+
 # Heavily threaded applications may benefit from splitting the mm-wide
 # page_table_lock, so that faults on different parts of the user address
 # space can be handled with less contention: split it at this NR_CPUS.
