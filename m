Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWEERgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWEERgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWEERgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:36:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:12725 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751685AbWEERgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:36:18 -0400
Date: Fri, 5 May 2006 13:36:06 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 6/6] kconfigurable resources arch dependent changes (arch/[q-z]*)
Message-ID: <20060505173606.GH6450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060505172847.GC6450@in.ibm.com> <20060505173002.GD6450@in.ibm.com> <20060505173102.GE6450@in.ibm.com> <20060505173326.GF6450@in.ibm.com> <20060505173434.GG6450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505173434.GG6450@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes to arch specific code for  kconfigurable resources. This
  patch contains changes for arch/[q-z]*

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/s390/Kconfig                  |    8 ++++++++
 arch/sh/Kconfig                    |    7 +++++++
 arch/sh/boards/mpc1211/pci.c       |    4 ++--
 arch/sh/boards/overdrive/galileo.c |    2 +-
 arch/sh/drivers/pci/pci.c          |    6 +++---
 arch/sh64/kernel/pcibios.c         |    4 ++--
 arch/sparc/Kconfig                 |    7 +++++++
 arch/sparc/kernel/pcic.c           |    2 +-
 arch/sparc64/kernel/pci.c          |    2 +-
 arch/v850/Kconfig                  |    7 +++++++
 arch/v850/kernel/rte_mb_a_pci.c    |    2 +-
 arch/xtensa/Kconfig                |    7 +++++++
 arch/xtensa/kernel/pci.c           |    6 +++---
 13 files changed, 50 insertions(+), 14 deletions(-)

diff -puN arch/s390/Kconfig~kconfigurable-resources-arch-changes-q-z arch/s390/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/s390/Kconfig~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/s390/Kconfig	2006-05-05 12:00:08.000000000 -0400
@@ -218,6 +218,14 @@ config WARN_STACK_SIZE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on !64BIT
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
diff -puN arch/sh64/kernel/pcibios.c~kconfigurable-resources-arch-changes-q-z arch/sh64/kernel/pcibios.c
--- linux-2.6.17-rc3-mm1-1M/arch/sh64/kernel/pcibios.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sh64/kernel/pcibios.c	2006-05-05 12:00:08.000000000 -0400
@@ -69,10 +69,10 @@ pcibios_update_resource(struct pci_dev *
  * modulo 0x400.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/sh/boards/mpc1211/pci.c~kconfigurable-resources-arch-changes-q-z arch/sh/boards/mpc1211/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/sh/boards/mpc1211/pci.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sh/boards/mpc1211/pci.c	2006-05-05 12:00:08.000000000 -0400
@@ -273,9 +273,9 @@ void __init pcibios_fixup_irqs(void)
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		if (start >= 0x10000UL) {
diff -puN arch/sh/boards/overdrive/galileo.c~kconfigurable-resources-arch-changes-q-z arch/sh/boards/overdrive/galileo.c
--- linux-2.6.17-rc3-mm1-1M/arch/sh/boards/overdrive/galileo.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sh/boards/overdrive/galileo.c	2006-05-05 12:00:08.000000000 -0400
@@ -536,7 +536,7 @@ void __init pcibios_fixup_bus(struct pci
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size)
+			    resource_size_t size)
 {
 }
 
diff -puN arch/sh/drivers/pci/pci.c~kconfigurable-resources-arch-changes-q-z arch/sh/drivers/pci/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/sh/drivers/pci/pci.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sh/drivers/pci/pci.c	2006-05-05 12:00:08.000000000 -0400
@@ -75,7 +75,7 @@ pcibios_update_resource(struct pci_dev *
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 			    __attribute__ ((weak));
 
 /*
@@ -85,10 +85,10 @@ void pcibios_align_resource(void *data, 
  * modulo 0x400.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/sh/Kconfig~kconfigurable-resources-arch-changes-q-z arch/sh/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/sh/Kconfig~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sh/Kconfig	2006-05-05 12:00:08.000000000 -0400
@@ -532,6 +532,13 @@ config NODES_SHIFT
 	default "1"
 	depends on NEED_MULTIPLE_NODES
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "Boot options"
diff -puN arch/sparc64/kernel/pci.c~kconfigurable-resources-arch-changes-q-z arch/sparc64/kernel/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/sparc64/kernel/pci.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sparc64/kernel/pci.c	2006-05-05 12:00:08.000000000 -0400
@@ -388,7 +388,7 @@ void pcibios_update_irq(struct pci_dev *
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 }
 
diff -puN arch/sparc/Kconfig~kconfigurable-resources-arch-changes-q-z arch/sparc/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/sparc/Kconfig~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sparc/Kconfig	2006-05-05 12:00:08.000000000 -0400
@@ -67,6 +67,13 @@ config SPARC32
 	  maintains both the SPARC32 and SPARC64 ports; its web page is
 	  available at <http://www.ultralinux.org/>.
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 # Global things across all Sun machines.
 config ISA
 	bool
diff -puN arch/sparc/kernel/pcic.c~kconfigurable-resources-arch-changes-q-z arch/sparc/kernel/pcic.c
--- linux-2.6.17-rc3-mm1-1M/arch/sparc/kernel/pcic.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/sparc/kernel/pcic.c	2006-05-05 12:00:08.000000000 -0400
@@ -859,7 +859,7 @@ char * __init pcibios_setup(char *str)
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    u64 size, u64 align)
+			    resource_size_t size, resource_size_t align)
 {
 }
 
diff -puN arch/v850/Kconfig~kconfigurable-resources-arch-changes-q-z arch/v850/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/v850/Kconfig~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/v850/Kconfig	2006-05-05 12:00:08.000000000 -0400
@@ -235,6 +235,13 @@ menu "Processor type and features"
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 
diff -puN arch/v850/kernel/rte_mb_a_pci.c~kconfigurable-resources-arch-changes-q-z arch/v850/kernel/rte_mb_a_pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/v850/kernel/rte_mb_a_pci.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/v850/kernel/rte_mb_a_pci.c	2006-05-05 12:00:08.000000000 -0400
@@ -329,7 +329,7 @@ void pcibios_fixup_bus(struct pci_bus *b
 
 void
 pcibios_align_resource (void *data, struct resource *res,
-			unsigned long size, unsigned long align)
+			resource_size_t size, resource_size_t align)
 {
 }
 
diff -puN arch/xtensa/Kconfig~kconfigurable-resources-arch-changes-q-z arch/xtensa/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/xtensa/Kconfig~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/xtensa/Kconfig	2006-05-05 12:00:08.000000000 -0400
@@ -99,6 +99,13 @@ config MATH_EMULATION
 config HIGHMEM
 	bool "High memory support"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "Platform options"
diff -puN arch/xtensa/kernel/pci.c~kconfigurable-resources-arch-changes-q-z arch/xtensa/kernel/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/xtensa/kernel/pci.c~kconfigurable-resources-arch-changes-q-z	2006-05-05 12:00:08.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/xtensa/kernel/pci.c	2006-05-05 12:00:08.000000000 -0400
@@ -71,13 +71,13 @@ static int pci_bus_count;
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-    		       unsigned long align)
+pcibios_align_resource(void *data, struct resource *res, resource_size_t size,
+    		       resource_size_t align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
_
