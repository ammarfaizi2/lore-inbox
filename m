Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270482AbUJUBki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270482AbUJUBki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270441AbUJUBi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:38:29 -0400
Received: from ozlabs.org ([203.10.76.45]:49614 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270657AbUJUBgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:36:52 -0400
Date: Thu, 21 Oct 2004 11:32:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Don't build virtual IO drivers for PowerMac
Message-ID: <20041021013207.GH17760@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Only compile vio.c on iSeries and pSeries, since other PPC64 platforms
(PowerMac) don't use virtual IO.  The resulting #ifdefs in dma.c are
kind of ugly, but at least contained, and I can't see a nicer way of
doing it for the time being.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/kernel/Makefile
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/Makefile	2004-09-28 10:22:13.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/Makefile	2004-10-05 15:47:16.541962864 +1000
@@ -11,7 +11,7 @@
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
 			ptrace32.o signal32.o rtc.o init_task.o \
 			lmb.o cputable.o cpu_setup_power4.o idle_power4.o \
-			iommu.o sysfs.o vio.o
+			iommu.o sysfs.o
 
 obj-$(CONFIG_PPC_OF) +=	of_device.o
 
@@ -45,6 +45,7 @@
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
+obj-$(CONFIG_IBMVIO)		+= vio.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
Index: working-2.6/arch/ppc64/Kconfig
===================================================================
--- working-2.6.orig/arch/ppc64/Kconfig	2004-09-28 10:22:13.000000000 +1000
+++ working-2.6/arch/ppc64/Kconfig	2004-10-05 15:47:16.541962864 +1000
@@ -110,6 +110,11 @@
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
+config IBMVIO
+	depends on PPC_PSERIES || PPC_ISERIES
+	bool
+	default y
+
 config U3_DART
 	bool 
 	depends on PPC_MULTIPLATFORM
Index: working-2.6/arch/ppc64/kernel/dma.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/dma.c	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/dma.c	2004-10-05 16:02:01.372034952 +1000
@@ -17,8 +17,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		return pci_dma_supported(to_pci_dev(dev), mask);
+#ifdef CONFIG_IBMVIO
 	if (dev->bus == &vio_bus_type)
 		return vio_dma_supported(to_vio_dev(dev), mask);
+#endif /* CONFIG_IBMVIO */
 	BUG();
 	return 0;
 }
@@ -28,8 +30,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+#ifdef CONFIG_IBMVIO
 	if (dev->bus == &vio_bus_type)
 		return vio_set_dma_mask(to_vio_dev(dev), dma_mask);
+#endif /* CONFIG_IBMVIO */
 	BUG();
 	return 0;
 }
@@ -40,8 +44,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
+#ifdef CONFIG_IBMVIO
 	if (dev->bus == &vio_bus_type)
 		return vio_alloc_consistent(to_vio_dev(dev), size, dma_handle);
+#endif /* CONFIG_IBMVIO */
 	BUG();
 	return NULL;
 }
@@ -52,8 +58,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
+#ifdef CONFIG_IBMVIO
 	else if (dev->bus == &vio_bus_type)
 		vio_free_consistent(to_vio_dev(dev), size, cpu_addr, dma_handle);
+#endif /* CONFIG_IBMVIO */
 	else
 		BUG();
 }
@@ -64,8 +72,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
+#ifdef CONFIG_IBMVIO
 	if (dev->bus == &vio_bus_type)
 		return vio_map_single(to_vio_dev(dev), cpu_addr, size, direction);
+#endif /* CONFIG_IBMVIO */
 	BUG();
 	return (dma_addr_t)0;
 }
@@ -76,8 +86,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
+#ifdef CONFIG_IBMVIO
 	else if (dev->bus == &vio_bus_type)
 		vio_unmap_single(to_vio_dev(dev), dma_addr, size, direction);
+#endif /* CONFIG_IBMVIO */
 	else
 		BUG();
 }
@@ -89,8 +101,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
+#ifdef CONFIG_IBMVIO
 	if (dev->bus == &vio_bus_type)
 		return vio_map_page(to_vio_dev(dev), page, offset, size, direction);
+#endif /* CONFIG_IBMVIO */
 	BUG();
 	return (dma_addr_t)0;
 }
@@ -101,8 +115,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
+#ifdef CONFIG_IBMVIO
 	else if (dev->bus == &vio_bus_type)
 		vio_unmap_page(to_vio_dev(dev), dma_address, size, direction);
+#endif /* CONFIG_IBMVIO */
 	else
 		BUG();
 }
@@ -113,8 +129,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
+#ifdef CONFIG_IBMVIO
 	if (dev->bus == &vio_bus_type)
 		return vio_map_sg(to_vio_dev(dev), sg, nents, direction);
+#endif /* CONFIG_IBMVIO */
 	BUG();
 	return 0;
 }
@@ -125,8 +143,10 @@
 {
 	if (dev->bus == &pci_bus_type)
 		pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
+#ifdef CONFIG_IBMVIO
 	else if (dev->bus == &vio_bus_type)
 		vio_unmap_sg(to_vio_dev(dev), sg, nhwentries, direction);
+#endif /* CONFIG_IBMVIO */
 	else
 		BUG();
 }


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
