Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbUKPWua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUKPWua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKPWua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:50:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:21732 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261876AbUKPWrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:47:49 -0500
Message-ID: <419A8088.3010205@osdl.org>
Date: Tue, 16 Nov 2004 14:34:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>, ak@suse.de, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: [PATCH] PCI: fix build errors with CONFIG_PCI=n
Content-Type: multipart/mixed;
 boundary="------------020307050506010503070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307050506010503070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix (most of) kernel build for CONFIG_PCI=n.  Fixes these 3 errors:

1. drivers/parport/parport_pc.c:3162: error: `parport_init_mode'
undeclared (first use in this function)

2. arch/x86_64/kernel/built-in.o(.text+0x8186): In function
`quirk_intel_irqbalance':
: undefined reference to `raw_pci_ops'

Kconfig change:
3. arch/x86_64/kernel/pci-gart.c:194: error: `pci_bus_type' undeclared
(first use in this function)

Still does not fix these 2 (similar):
a.  drivers/built-in.o(.text+0x3dcd8): In function
`pnpacpi_allocated_resource':
: undefined reference to `pcibios_penalize_isa_irq'
b.  drivers/built-in.o(.text+0xb4d4): In function
`pnpbios_parse_allocated_irqresource':
: undefined reference to `pcibios_penalize_isa_irq'

diffstat:=
   arch/i386/kernel/quirks.c    |    3 ++-
   arch/x86_64/Kconfig          |    1 +
   drivers/parport/parport_pc.c |   22 ++++++++++++++++++----
   3 files changed, 21 insertions(+), 5 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


--------------020307050506010503070106
Content-Type: text/x-patch;
 name="config_pci_off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config_pci_off.patch"

diff -Naurp ./drivers/parport/parport_pc.c~config_pci ./drivers/parport/parport_pc.c
--- ./drivers/parport/parport_pc.c~config_pci	2004-11-15 10:02:00.023963736 -0800
+++ ./drivers/parport/parport_pc.c	2004-11-16 11:15:24.546578032 -0800
@@ -3154,8 +3154,9 @@ static int __init parport_parse_dma(cons
 				     PARPORT_DMA_NONE, PARPORT_DMA_NOFIFO);
 }
 
-static int __init parport_init_mode_setup(const char *str) {
-
+#ifdef CONFIG_PCI
+static int __init parport_init_mode_setup(const char *str)
+{
 	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
 
 	if (!strcmp (str, "spp"))
@@ -3170,11 +3171,16 @@ static int __init parport_init_mode_setu
 		parport_init_mode=5;
 	return 1;
 }
+#else
+static int __inline__ __init parport_init_mode_setup(const char *str)
+{
+	return 1;
+}
+#endif
 
 #ifdef MODULE
 static const char *irq[PARPORT_PC_MAX_PORTS];
 static const char *dma[PARPORT_PC_MAX_PORTS];
-static const char *init_mode;
 
 MODULE_PARM_DESC(io, "Base I/O address (SPP regs)");
 module_param_array(io, int, NULL, 0);
@@ -3189,8 +3195,14 @@ module_param_array(dma, charp, NULL, 0);
 MODULE_PARM_DESC(verbose_probing, "Log chit-chat during initialisation");
 module_param(verbose_probing, int, 0644);
 #endif
+
+#ifdef CONFIG_PCI
+static const char *init_mode;
 MODULE_PARM_DESC(init_mode, "Initialise mode for VIA VT8231 port (spp, ps2, epp, ecp or ecpepp)");
 MODULE_PARM(init_mode, "s");
+#else
+#define init_mode	0
+#endif
 
 static int __init parse_parport_params(void)
 {
@@ -3314,7 +3326,9 @@ __setup ("parport=", parport_setup);
  * parport_init_mode=[spp|ps2|epp|ecp|ecpepp]
  */
 
-__setup("parport_init_mode=",parport_init_mode_setup);
+#ifdef CONFIG_PCI
+__setup("parport_init_mode=", parport_init_mode_setup);
+#endif
 
 #endif
 
diff -Naurp ./arch/i386/kernel/quirks.c~config_pci ./arch/i386/kernel/quirks.c
--- ./arch/i386/kernel/quirks.c~config_pci	2004-11-15 10:01:58.430206024 -0800
+++ ./arch/i386/kernel/quirks.c	2004-11-16 11:24:25.204385552 -0800
@@ -1,10 +1,11 @@
 /*
  * This file contains work-arounds for x86 and x86_64 platform bugs.
  */
+#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
 void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
 {
diff -Naurp ./arch/x86_64/Kconfig~config_pci ./arch/x86_64/Kconfig
--- ./arch/x86_64/Kconfig~config_pci	2004-11-15 10:01:58.985121664 -0800
+++ ./arch/x86_64/Kconfig	2004-11-16 10:50:00.987194264 -0800
@@ -306,6 +306,7 @@ config NR_CPUS
 
 config GART_IOMMU
 	bool "IOMMU support"
+	depends on PCI
 	help
 	  Support the K8 IOMMU. Needed to run systems with more than 4GB of memory
 	  properly with 32-bit PCI devices that do not support DAC (Double Address


--------------020307050506010503070106--
