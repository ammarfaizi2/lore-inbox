Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbULAASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbULAASX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbULAARv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:17:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:45796 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261246AbULAAOW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:22 -0500
X-Fake: the user-agent is fake
Subject: [PATCH] More PCI fixes for 2.6.10-rc2
User-Agent: Mutt/1.5.6i
In-Reply-To: <20041201000904.GA27422@kroah.com>
Date: Tue, 30 Nov 2004 16:10:03 -0800
Message-Id: <11018598032113@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.1, 2004/11/24 14:43:45-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: Add pci_enable_device() in hot-plug drivers

Here is the patch to add pci_enable_device() to the two hot-plug
drivers.  In 2.6.10-rc2, the unconditional PCI ACPI IRQ routing
has been removed.  Without this patch, the drivers won't work in
INTx mode with ACPI enabled.


Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp_hpc.c |    3 +++
 drivers/pci/hotplug/shpchp_hpc.c |    3 +++
 2 files changed, 6 insertions(+)


diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-11-30 15:47:30 -08:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-11-30 15:47:30 -08:00
@@ -1347,6 +1347,9 @@
 	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, 
 		pdev->subsystem_vendor, pdev->subsystem_device);
 
+	if (pci_enable_device(pdev))
+		goto abort_free_ctlr;
+	
 	init_MUTEX(&ctrl->crit_sect);
 	/* setup wait queue */
 	init_waitqueue_head(&ctrl->queue);
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-11-30 15:47:30 -08:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-11-30 15:47:30 -08:00
@@ -1487,6 +1487,9 @@
 
 	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, pdev->subsystem_vendor, 
 		pdev->subsystem_device);
+	
+	if (pci_enable_device(pdev))
+		goto abort_free_ctlr;
 
 	if (!request_mem_region(pci_resource_start(pdev, 0) + shpc_base_offset, pci_resource_len(pdev, 0), MY_NAME)) {
 		err("%s: cannot reserve MMIO region\n", __FUNCTION__);

