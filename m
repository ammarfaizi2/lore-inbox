Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVLLUCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVLLUCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVLLUCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:02:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:43173 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932194AbVLLUCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:02:05 -0500
Date: Mon, 12 Dec 2005 12:01:29 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@muc.de
Subject: [patch 3/4] x86_64/i386: Correct for broken MCFG tables on K8 systems
Message-ID: <20051212200129.GD27657@kroah.com>
References: <20051212192030.873030000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86_64-i386-correct-for-broken-mcfg-tables-on-k8-systems.patch"
In-Reply-To: <20051212200044.GA27657@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>

They report all busses as MMCONFIG capable, but it never works for the
internal devices in the CPU's builtin northbridge.

This causes problems - some devices are not visible and on x86-64 the
IOMMU is not detected, causing boot failures on systems with >3GB of
RAM.  It also breaks AGP.

Workaround just probes all func 0 devices on bus 0 (the internal
northbridge is currently always on bus 0) and if they are not accessible
using MCFG they are put into a special fallback bitmap.

On systems where it isn't we assume the BIOS vendor supplied correct
MCFG.

Requires the earlier patch for mmconfig type1 fallback

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/pci/mmconfig.c   |   45 ++++++++++++++++++++++++++++++++++++++++++---
 arch/x86_64/pci/mmconfig.c |   36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

--- greg-2.6.orig/arch/x86_64/pci/mmconfig.c
+++ greg-2.6/arch/x86_64/pci/mmconfig.c
@@ -8,10 +8,13 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/bitmap.h>
 #include "pci.h"
 
 #define MMCONFIG_APER_SIZE (256*1024*1024)
 
+static DECLARE_BITMAP(fallback_slots, 32);
+
 /* Static virtual mapping of the MMCONFIG aperture */
 struct mmcfg_virt {
 	struct acpi_table_mcfg_config *cfg;
@@ -40,9 +43,12 @@ static char *get_virt(unsigned int seg, 
 	}
 }
 
-static inline char *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
+static char *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
-	char *addr = get_virt(seg, bus);
+	char *addr;
+	if (seg == 0 && bus == 0 && test_bit(PCI_SLOT(devfn), &fallback_slots))
+		return NULL;
+	addr = get_virt(seg, bus);
 	if (!addr)
 		return NULL;
  	return addr + ((bus << 20) | (devfn << 12));
@@ -109,6 +115,30 @@ static struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
+/* K8 systems have some devices (typically in the builtin northbridge)
+   that are only accessible using type1
+   Normally this can be expressed in the MCFG by not listing them
+   and assigning suitable _SEGs, but this isn't implemented in some BIOS.
+   Instead try to discover all devices on bus 0 that are unreachable using MM
+   and fallback for them.
+   We only do this for bus 0/seg 0 */
+static __init void unreachable_devices(void)
+{
+	int i;
+	for (i = 0; i < 32; i++) {
+		u32 val1;
+		char *addr;
+
+		pci_conf1_read(0, 0, PCI_DEVFN(i,0), 0, 4, &val1);
+		if (val1 == 0xffffffff)
+			continue;
+		addr = pci_dev_base(0, 0, PCI_DEVFN(i, 0));
+		if (addr == NULL || readl(addr) != val1) {
+			set_bit(i, &fallback_slots);
+		}
+	}
+}
+
 static int __init pci_mmcfg_init(void)
 {
 	int i;
@@ -139,6 +169,8 @@ static int __init pci_mmcfg_init(void)
 		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
 	}
 
+	unreachable_devices();
+
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 
--- greg-2.6.orig/arch/i386/pci/mmconfig.c
+++ greg-2.6/arch/i386/pci/mmconfig.c
@@ -19,14 +19,20 @@
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
 
+static DECLARE_BITMAP(fallback_slots, 32);
+
 /*
  * Functions for accessing PCI configuration space with MMCONFIG accesses
  */
-static u32 get_base_addr(unsigned int seg, int bus)
+static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
 {
 	int cfg_num = -1;
 	struct acpi_table_mcfg_config *cfg;
 
+	if (seg == 0 && bus == 0 &&
+	    test_bit(PCI_SLOT(devfn), fallback_slots))
+		return 0;
+
 	while (1) {
 		++cfg_num;
 		if (cfg_num >= pci_mmcfg_config_num) {
@@ -60,7 +66,7 @@ static int pci_mmcfg_read(unsigned int s
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095))
 		return -EINVAL;
 
-	base = get_base_addr(seg, bus);
+	base = get_base_addr(seg, bus, devfn);
 	if (!base)
 		return pci_conf1_read(seg,bus,devfn,reg,len,value);
 
@@ -94,7 +100,7 @@ static int pci_mmcfg_write(unsigned int 
 	if ((bus > 255) || (devfn > 255) || (reg > 4095)) 
 		return -EINVAL;
 
-	base = get_base_addr(seg, bus);
+	base = get_base_addr(seg, bus, devfn);
 	if (!base)
 		return pci_conf1_write(seg,bus,devfn,reg,len,value);
 
@@ -124,6 +130,37 @@ static struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
+/* K8 systems have some devices (typically in the builtin northbridge)
+   that are only accessible using type1
+   Normally this can be expressed in the MCFG by not listing them
+   and assigning suitable _SEGs, but this isn't implemented in some BIOS.
+   Instead try to discover all devices on bus 0 that are unreachable using MM
+   and fallback for them.
+   We only do this for bus 0/seg 0 */
+static __init void unreachable_devices(void)
+{
+	int i;
+	unsigned long flags;
+
+	for (i = 0; i < 32; i++) {
+		u32 val1;
+		u32 addr;
+
+		pci_conf1_read(0, 0, PCI_DEVFN(i, 0), 0, 4, &val1);
+		if (val1 == 0xffffffff)
+			continue;
+
+		/* Locking probably not needed, but safer */
+		spin_lock_irqsave(&pci_config_lock, flags);
+		addr = get_base_addr(0, 0, PCI_DEVFN(i, 0));
+		if (addr != 0)
+			pci_exp_set_dev_base(addr, 0, PCI_DEVFN(i, 0));
+		if (addr == 0 || readl((u32 *)addr) != val1)
+			set_bit(i, fallback_slots);
+		spin_unlock_irqrestore(&pci_config_lock, flags);
+	}
+}
+
 static int __init pci_mmcfg_init(void)
 {
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
@@ -139,6 +176,8 @@ static int __init pci_mmcfg_init(void)
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 
+	unreachable_devices();
+
  out:
 	return 0;
 }

--
