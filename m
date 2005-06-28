Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVF1IBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVF1IBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVF1GXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:23:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:39916 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261938AbVF1Fd4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:56 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: use the MCFG table to properly access pci devices (x86-64)
In-Reply-To: <11199367751620@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <11199367751784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: use the MCFG table to properly access pci devices (x86-64)

Now that we have access to the whole MCFG table, let's properly use it
for all pci device accesses (as that's what it is there for, some boxes
don't put all the busses into one entry.)

If, for some reason, the table is incorrect, we fallback to the "old
style" of mmconfig accesses, namely, we just assume the first entry in
the table is the one for us, and blindly use it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1cde8a16815bd85c8137d1ea556398983c597c11
tree c43ab735f7fd96d0576dfb7749c8ded74f9b63b7
parent d57e26ceb7dbf44cd08128cb6146116d4281b58b
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 23 Jun 2005 17:35:56 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:48 -0700

 arch/x86_64/pci/mmconfig.c |   58 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -13,17 +13,44 @@
 #define MMCONFIG_APER_SIZE (256*1024*1024)
 
 /* Static virtual mapping of the MMCONFIG aperture */
-static char *pci_mmcfg_virt;
+struct mmcfg_virt {
+	struct acpi_table_mcfg_config *cfg;
+	char *virt;
+};
+static struct mmcfg_virt *pci_mmcfg_virt;
+
+static char *get_virt(unsigned int seg, int bus)
+{
+	int cfg_num = -1;
+	struct acpi_table_mcfg_config *cfg;
+
+	while (1) {
+		++cfg_num;
+		if (cfg_num >= pci_mmcfg_config_num) {
+			/* something bad is going on, no cfg table is found. */
+			/* so we fall back to the old way we used to do this */
+			/* and just rely on the first entry to be correct. */
+			return pci_mmcfg_virt[0].virt;
+		}
+		cfg = pci_mmcfg_virt[cfg_num].cfg;
+		if (cfg->pci_segment_group_number != seg)
+			continue;
+		if ((cfg->start_bus_number <= bus) &&
+		    (cfg->end_bus_number >= bus))
+			return pci_mmcfg_virt[cfg_num].virt;
+	}
+}
 
-static inline char *pci_dev_base(unsigned int bus, unsigned int devfn)
+static inline char *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
-	return pci_mmcfg_virt + ((bus << 20) | (devfn << 12));
+
+	return get_virt(seg, bus) + ((bus << 20) | (devfn << 12));
 }
 
 static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
-	char *addr = pci_dev_base(bus, devfn); 
+	char *addr = pci_dev_base(seg, bus, devfn);
 
 	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
@@ -46,7 +73,7 @@ static int pci_mmcfg_read(unsigned int s
 static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
-	char *addr = pci_dev_base(bus,devfn);
+	char *addr = pci_dev_base(seg, bus, devfn);
 
 	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
@@ -73,6 +100,8 @@ static struct pci_raw_ops pci_mmcfg = {
 
 static int __init pci_mmcfg_init(void)
 {
+	int i;
+
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 0;
 
@@ -90,13 +119,22 @@ static int __init pci_mmcfg_init(void)
 		return 0; 
 
 	/* RED-PEN i386 doesn't do _nocache right now */
-	pci_mmcfg_virt = ioremap_nocache(pci_mmcfg_config[0].base_address, MMCONFIG_APER_SIZE);
-	if (!pci_mmcfg_virt) { 
-		printk("PCI: Cannot map mmconfig aperture\n");
+	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
+	if (pci_mmcfg_virt == NULL) {
+		printk("PCI: Can not allocate memory for mmconfig structures\n");
 		return 0;
-	}	
+	}
+	for (i = 0; i < pci_mmcfg_config_num; ++i) {
+		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
+		if (!pci_mmcfg_virt[i].virt) {
+			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
+			       pci_mmcfg_config[i].pci_segment_group_number);
+			return 0;
+		}
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
+	}
 
-	printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[0].base_address);
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 

