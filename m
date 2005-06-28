Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVF1Ff2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVF1Ff2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVF1Feg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:34:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:6380 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261548AbVF1Fdc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:32 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: use the MCFG table to properly access pci devices (i386)
In-Reply-To: <11199367752277@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <11199367751620@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: use the MCFG table to properly access pci devices (i386)

Now that we have access to the whole MCFG table, let's properly use it
for all pci device accesses (as that's what it is there for, some boxes
don't put all the busses into one entry.)

If, for some reason, the table is incorrect, we fallback to the "old
style" of mmconfig accesses, namely, we just assume the first entry in
the table is the one for us, and blindly use it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d57e26ceb7dbf44cd08128cb6146116d4281b58b
tree 3fd0f4ff6ec93f3b8f4342649a4b717beb97c903
parent 545493917dc90298e1c38f018ad893f5518928e7
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 23 Jun 2005 17:35:56 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:47 -0700

 arch/i386/pci/mmconfig.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -22,10 +22,31 @@ static u32 mmcfg_last_accessed_device;
 /*
  * Functions for accessing PCI configuration space with MMCONFIG accesses
  */
+static u32 get_base_addr(unsigned int seg, int bus)
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
+			return pci_mmcfg_config[0].base_address;
+		}
+		cfg = &pci_mmcfg_config[cfg_num];
+		if (cfg->pci_segment_group_number != seg)
+			continue;
+		if ((cfg->start_bus_number <= bus) &&
+		    (cfg->end_bus_number >= bus))
+			return cfg->base_address;
+	}
+}
 
-static inline void pci_exp_set_dev_base(int bus, int devfn)
+static inline void pci_exp_set_dev_base(unsigned int seg, int bus, int devfn)
 {
-	u32 dev_base = pci_mmcfg_config[0].base_address | (bus << 20) | (devfn << 12);
+	u32 dev_base = get_base_addr(seg, bus) | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
 		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
@@ -42,7 +63,7 @@ static int pci_mmcfg_read(unsigned int s
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	pci_exp_set_dev_base(bus, devfn);
+	pci_exp_set_dev_base(seg, bus, devfn);
 
 	switch (len) {
 	case 1:
@@ -71,7 +92,7 @@ static int pci_mmcfg_write(unsigned int 
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	pci_exp_set_dev_base(bus, devfn);
+	pci_exp_set_dev_base(seg, bus, devfn);
 
 	switch (len) {
 	case 1:

