Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270111AbUJSXb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270111AbUJSXb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270114AbUJSXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:25:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:18570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270162AbUJSWqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:40 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257363619@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <1098225736517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.34, 2004/10/06 12:55:35-07:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: Bug fixes for shpchp driver

Can you please apply the following patch that has bug fixes for shpchp
driver? One bug was writing 1's to RsvdZ in Slot Status register
causing hot-plugging of PCI-X cards not working in some slots.  The
other fix is for getting the correct bus number.


Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/shpchp_hpc.c    |    4 ++--
 drivers/pci/hotplug/shpchprm_acpi.c |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:24:39 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:24:39 -07:00
@@ -1539,7 +1539,7 @@
 		slot_reg = readl(php_ctlr->creg + SLOT1 + 4*hp_slot );
 		dbg("%s: Default Logical Slot Register %d value %x\n", __FUNCTION__,
 			hp_slot, slot_reg);
-		tempdword = 0xffffffff;  
+		tempdword = 0xffff3fff;  
 		writel(tempdword, php_ctlr->creg + SLOT1 + (4*hp_slot));
 	}
 	
@@ -1592,7 +1592,7 @@
 		slot_reg = readl(php_ctlr->creg + SLOT1 + 4*hp_slot );
 		dbg("%s: Default Logical Slot Register %d value %x\n", __FUNCTION__,
 			hp_slot, slot_reg);
-		tempdword = 0xe01fffff;  
+		tempdword = 0xe01f3fff;  
 		writel(tempdword, php_ctlr->creg + SLOT1 + (4*hp_slot));
 	}
 	if (!shpchp_poll_mode) {
diff -Nru a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c	2004-10-19 15:24:39 -07:00
+++ b/drivers/pci/hotplug/shpchprm_acpi.c	2004-10-19 15:24:39 -07:00
@@ -1396,17 +1396,19 @@
 static int bind_pci_resources_to_slots ( struct controller *ctrl)
 {
 	struct pci_func *func, new_func;
-	int busn = ctrl->bus;
+	int busn = ctrl->slot_bus;
 	int devn, funn;
 	u32	vid;
 
 	for (devn = 0; devn < 32; devn++) {
 		for (funn = 0; funn < 8; funn++) {
+			/*
 			if (devn == ctrl->device && funn == ctrl->function)
 				continue;
+			*/
 			/* find out if this entry is for an occupied slot */
 			vid = 0xFFFFFFFF;
-			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(devn, funn), PCI_VENDOR_ID, &vid);
+			pci_bus_read_config_dword(ctrl->pci_dev->subordinate, PCI_DEVFN(devn, funn), PCI_VENDOR_ID, &vid);
 
 			if (vid != 0xFFFFFFFF) {
 				func = shpchp_slot_find(busn, devn, funn);

