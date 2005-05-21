Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVEUAdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVEUAdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEUAdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:33:40 -0400
Received: from fmr19.intel.com ([134.134.136.18]:15844 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261619AbVEUAde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:33:34 -0400
Message-Id: <20050521004506.842235000@csdlinux-1>
References: <20050521004239.581618000@csdlinux-1>
Date: Fri, 20 May 2005 17:42:41 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, len.brown@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net, Rajesh Shah <rajesh.shah@intel.com>
Subject: [patch 2/2] x86_64: Collect host bridge resources
Content-Disposition: inline; filename=x86_64-host-bridge-resources.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reads and stores host bridge resources reported by
ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
code now uses the PCI core for resource management. This patch
simply adds the boot parameter (acpi=root_resources) to enable
the functionality that is implemented in arch/i386.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

Index: linux-2.6.12-rc4-mm2/include/asm-x86_64/acpi.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/asm-x86_64/acpi.h
+++ linux-2.6.12-rc4-mm2/include/asm-x86_64/acpi.h
@@ -143,10 +143,16 @@ static inline void acpi_disable_pci(void
 	acpi_noirq_set();
 }
 extern int acpi_irq_balance_set(char *str);
+extern int acpi_read_root_resources;
+static inline void acpi_set_read_root_resources(void)
+{
+	acpi_read_root_resources = 1;
+}
 #else
 static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
 static inline int acpi_irq_balance_set(char *str) { return 0; }
+static inline void acpi_set_read_root_resources(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_SLEEP
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c
@@ -319,6 +319,9 @@ static __init void parse_cmdline_early (
 			acpi_disable_pci();
 		else if (!memcmp(from, "acpi=noirq", 10))
 			acpi_noirq_set();
+		/* Use ACPI to read host bridge resources */
+		else if (!memcmp(from, "acpi=root_resources", 19))
+			acpi_set_read_root_resources();
 
 		else if (!memcmp(from, "acpi_sci=edge", 13))
 			acpi_sci_flags.trigger =  1;

--
