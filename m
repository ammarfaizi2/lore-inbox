Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270075AbUJTK0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270075AbUJTK0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270199AbUJSXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:00:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:61833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270077AbUJSWqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:21 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225736517@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <10982257363931@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.35, 2004/10/06 12:56:04-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix the rest of the drivers for __iomem and other sparse issues.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpcihp_zt5550.c |   10 +++++-----
 drivers/pci/hotplug/shpchp.h        |    2 +-
 drivers/pci/hotplug/shpchp_ctrl.c   |    2 +-
 drivers/pci/hotplug/shpchp_hpc.c    |    3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
--- a/drivers/pci/hotplug/cpcihp_zt5550.c	2004-10-19 15:24:32 -07:00
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c	2004-10-19 15:24:32 -07:00
@@ -69,11 +69,11 @@
 static struct pci_dev *hc_dev;
 
 /* Host controller register addresses */
-static void *hc_registers;
-static void *csr_hc_index;
-static void *csr_hc_data;
-static void *csr_int_status;
-static void *csr_int_mask;
+static void __iomem *hc_registers;
+static void __iomem *csr_hc_index;
+static void __iomem *csr_hc_data;
+static void __iomem *csr_int_status;
+static void __iomem *csr_int_mask;
 
 
 static int zt5550_hc_config(struct pci_dev *pdev)
diff -Nru a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
--- a/drivers/pci/hotplug/shpchp.h	2004-10-19 15:24:32 -07:00
+++ b/drivers/pci/hotplug/shpchp.h	2004-10-19 15:24:32 -07:00
@@ -311,7 +311,7 @@
 	php_intr_callback_t presence_change_callback;
 	php_intr_callback_t power_fault_callback;
 	void *callback_instance_id;
-	void *creg;				/* Ptr to controller register space */
+	void __iomem *creg;			/* Ptr to controller register space */
 };
 /* Inline functions */
 
diff -Nru a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
--- a/drivers/pci/hotplug/shpchp_ctrl.c	2004-10-19 15:24:32 -07:00
+++ b/drivers/pci/hotplug/shpchp_ctrl.c	2004-10-19 15:24:32 -07:00
@@ -1661,7 +1661,7 @@
 	event_finished=0;
 
 	init_MUTEX_LOCKED(&event_semaphore);
-	pid = kernel_thread(event_thread, 0, 0);
+	pid = kernel_thread(event_thread, NULL, 0);
 
 	if (pid < 0) {
 		err ("Can't start up our event thread\n");
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:24:32 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:24:32 -07:00
@@ -1492,8 +1492,7 @@
 		goto abort_free_ctlr;
 	}
 
-	php_ctlr->creg = (struct ctrl_reg *)
-		ioremap(pci_resource_start(pdev, 0) + shpc_base_offset, pci_resource_len(pdev, 0));
+	php_ctlr->creg = ioremap(pci_resource_start(pdev, 0) + shpc_base_offset, pci_resource_len(pdev, 0));
 	if (!php_ctlr->creg) {
 		err("%s: cannot remap MMIO region %lx @ %lx\n", __FUNCTION__, pci_resource_len(pdev, 0), 
 			pci_resource_start(pdev, 0) + shpc_base_offset);

