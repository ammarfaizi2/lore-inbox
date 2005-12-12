Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVLLUDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVLLUDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVLLUCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:02:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:50853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932197AbVLLUCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:02:16 -0500
Date: Mon, 12 Dec 2005 12:01:23 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@muc.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [patch 2/4] i386/x86-64: Implement fallback for PCI mmconfig to type1
Message-ID: <20051212200123.GC27657@kroah.com>
References: <20051212192030.873030000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i386-x86-64-implement-fallback-for-pci-mmconfig-to-type1.patch"
In-Reply-To: <20051212200044.GA27657@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>


When there is no entry for a bus in MCFG fall back to type1.  This is
especially important on K8 systems where always some devices can't be
accessed using mmconfig (in particular the builtin northbridge doesn't
support it for its own devices)

To be complete needs also Jeff's _SEG fixes, but that is something for
after 2.6.15

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/pci/direct.c     |    4 ++--
 arch/i386/pci/mmconfig.c   |   24 ++++++++++++++++--------
 arch/i386/pci/pci.h        |    7 +++++++
 arch/x86_64/pci/mmconfig.c |   29 ++++++++++++++++++++---------
 4 files changed, 45 insertions(+), 19 deletions(-)

--- greg-2.6.orig/arch/i386/pci/direct.c
+++ greg-2.6/arch/i386/pci/direct.c
@@ -13,7 +13,7 @@
 #define PCI_CONF1_ADDRESS(bus, devfn, reg) \
 	(0x80000000 | (bus << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_read(unsigned int seg, unsigned int bus,
+int pci_conf1_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
@@ -42,7 +42,7 @@ static int pci_conf1_read(unsigned int s
 	return 0;
 }
 
-static int pci_conf1_write(unsigned int seg, unsigned int bus,
+int pci_conf1_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
--- greg-2.6.orig/arch/i386/pci/pci.h
+++ greg-2.6/arch/i386/pci/pci.h
@@ -74,3 +74,10 @@ extern spinlock_t pci_config_lock;
 
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
 extern void (*pcibios_disable_irq)(struct pci_dev *dev);
+
+extern int pci_conf1_write(unsigned int seg, unsigned int bus,
+			   unsigned int devfn, int reg, int len, u32 value);
+extern int pci_conf1_read(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 *value);
+
+
--- greg-2.6.orig/arch/i386/pci/mmconfig.c
+++ greg-2.6/arch/i386/pci/mmconfig.c
@@ -30,10 +30,8 @@ static u32 get_base_addr(unsigned int se
 	while (1) {
 		++cfg_num;
 		if (cfg_num >= pci_mmcfg_config_num) {
-			/* something bad is going on, no cfg table is found. */
-			/* so we fall back to the old way we used to do this */
-			/* and just rely on the first entry to be correct. */
-			return pci_mmcfg_config[0].base_address;
+			/* Not found - fallback to type 1 */
+			return 0;
 		}
 		cfg = &pci_mmcfg_config[cfg_num];
 		if (cfg->pci_segment_group_number != seg)
@@ -44,9 +42,9 @@ static u32 get_base_addr(unsigned int se
 	}
 }
 
-static inline void pci_exp_set_dev_base(unsigned int seg, int bus, int devfn)
+static inline void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
 {
-	u32 dev_base = get_base_addr(seg, bus) | (bus << 20) | (devfn << 12);
+	u32 dev_base = base | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
 		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
@@ -57,13 +55,18 @@ static int pci_mmcfg_read(unsigned int s
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
+	u32 base;
 
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095))
 		return -EINVAL;
 
+	base = get_base_addr(seg, bus);
+	if (!base)
+		return pci_conf1_read(seg,bus,devfn,reg,len,value);
+
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	pci_exp_set_dev_base(seg, bus, devfn);
+	pci_exp_set_dev_base(base, bus, devfn);
 
 	switch (len) {
 	case 1:
@@ -86,13 +89,18 @@ static int pci_mmcfg_write(unsigned int 
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
+	u32 base;
 
 	if ((bus > 255) || (devfn > 255) || (reg > 4095)) 
 		return -EINVAL;
 
+	base = get_base_addr(seg, bus);
+	if (!base)
+		return pci_conf1_write(seg,bus,devfn,reg,len,value);
+
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	pci_exp_set_dev_base(seg, bus, devfn);
+	pci_exp_set_dev_base(base, bus, devfn);
 
 	switch (len) {
 	case 1:
--- greg-2.6.orig/arch/x86_64/pci/mmconfig.c
+++ greg-2.6/arch/x86_64/pci/mmconfig.c
@@ -19,7 +19,7 @@ struct mmcfg_virt {
 };
 static struct mmcfg_virt *pci_mmcfg_virt;
 
-static char *get_virt(unsigned int seg, int bus)
+static char *get_virt(unsigned int seg, unsigned bus)
 {
 	int cfg_num = -1;
 	struct acpi_table_mcfg_config *cfg;
@@ -27,10 +27,9 @@ static char *get_virt(unsigned int seg, 
 	while (1) {
 		++cfg_num;
 		if (cfg_num >= pci_mmcfg_config_num) {
-			/* something bad is going on, no cfg table is found. */
-			/* so we fall back to the old way we used to do this */
-			/* and just rely on the first entry to be correct. */
-			return pci_mmcfg_virt[0].virt;
+			/* Not found - fall back to type 1. This happens
+			   e.g. on the internal devices of a K8 northbridge. */
+			return NULL;
 		}
 		cfg = pci_mmcfg_virt[cfg_num].cfg;
 		if (cfg->pci_segment_group_number != seg)
@@ -43,18 +42,25 @@ static char *get_virt(unsigned int seg, 
 
 static inline char *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
-
-	return get_virt(seg, bus) + ((bus << 20) | (devfn << 12));
+	char *addr = get_virt(seg, bus);
+	if (!addr)
+		return NULL;
+ 	return addr + ((bus << 20) | (devfn << 12));
 }
 
 static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
-	char *addr = pci_dev_base(seg, bus, devfn);
+	char *addr;
 
+	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
 	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
 
+	addr = pci_dev_base(seg, bus, devfn);
+	if (!addr)
+		return pci_conf1_read(seg,bus,devfn,reg,len,value);
+
 	switch (len) {
 	case 1:
 		*value = readb(addr + reg);
@@ -73,11 +79,16 @@ static int pci_mmcfg_read(unsigned int s
 static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
-	char *addr = pci_dev_base(seg, bus, devfn);
+	char *addr;
 
+	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
 	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
 
+	addr = pci_dev_base(seg, bus, devfn);
+	if (!addr)
+		return pci_conf1_write(seg,bus,devfn,reg,len,value);
+
 	switch (len) {
 	case 1:
 		writeb(value, addr + reg);

--
