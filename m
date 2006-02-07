Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWBGWYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWBGWYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWBGWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:24:48 -0500
Received: from fmr17.intel.com ([134.134.136.16]:31413 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030207AbWBGWYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:24:47 -0500
Subject: Re: [Pcihpd-discuss] [patch] shpchp: support driver remove
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <1139349479.30996.18.camel@whizzy>
References: <1139349479.30996.18.camel@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 14:28:55 -0800
Message-Id: <1139351335.30996.30.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 07 Feb 2006 22:24:39.0801 (UTC) FILETIME=[491AA690:01C62C35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will add remove support to the shpchp driver.  It also changes
where the shpchpd thread is started, so that the thread is only started if
a valid controller is enabled. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
Apparently __devexit is useless for hotplug controller drivers - so 
this patch is the same, only just uses __exit for the remove function.

 drivers/pci/hotplug/shpchp_core.c |   59 ++++++++++++++++++--------------------
 1 files changed, 29 insertions(+), 30 deletions(-)

--- linux-shpchp-mm.orig/drivers/pci/hotplug/shpchp_core.c
+++ linux-shpchp-mm/drivers/pci/hotplug/shpchp_core.c
@@ -437,13 +437,21 @@ static int shpc_probe(struct pci_dev *pd
 
 	/* Finish setting up the hot plug ctrl device */
 	ctrl->next_event = 0;
+	if (list_empty(&shpchp_ctrl_list)) {
+		rc = shpc_start_thread();
+		if (rc) {
+			err(SHPC_MODULE_NAME ": Can't start event thread.\n");
+			goto err_out_stop_thread;
+		}
+	}
 
 	list_add(&ctrl->ctrl_list, &shpchp_ctrl_list);
-
 	shpchp_create_ctrl_files(ctrl);
 
 	return 0;
 
+err_out_stop_thread:
+	shpchp_event_stop_thread();
 err_out_free_ctrl_slot:
 	cleanup_slots(ctrl);
 err_out_free_ctrl_bus:
@@ -471,26 +479,29 @@ static int shpc_start_thread(void)
 	return retval;
 }
 
-static void __exit unload_shpchpd(void)
+
+static void __exit shpc_remove_ctrl(struct controller *ctrl)
 {
-	struct list_head *tmp;
-	struct list_head *next;
-	struct controller *ctrl;
-
-	list_for_each_safe(tmp, next, &shpchp_ctrl_list) {
-		ctrl = list_entry(tmp, struct controller, ctrl_list);
-		shpchp_remove_ctrl_files(ctrl);
-		cleanup_slots(ctrl);
-		kfree (ctrl->pci_bus);
-		ctrl->hpc_ops->release_ctlr(ctrl);
-		kfree(ctrl);
-	}
+	shpchp_remove_ctrl_files(ctrl);
+	cleanup_slots(ctrl);
+	kfree(ctrl->pci_bus);
+	ctrl->hpc_ops->release_ctlr(ctrl);
+	list_del(&ctrl->ctrl_list);
+	kfree(ctrl);
+}
 
-	/* Stop the notification mechanism */
-	shpchp_event_stop_thread();
 
+
+static void __exit shpc_remove(struct pci_dev *pdev)
+{
+	struct controller *ctrl = pci_get_drvdata(pdev);
+	if (ctrl)
+		shpc_remove_ctrl(ctrl);
+	if (list_empty(&shpchp_ctrl_list))
+		shpchp_event_stop_thread();
 }
 
+
 static struct pci_device_id shpcd_pci_tbl[] = {
 	{PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0)},
 	{ /* end: all zeroes */ }
@@ -501,39 +512,27 @@ static struct pci_driver shpc_driver = {
 	.name =		SHPC_MODULE_NAME,
 	.id_table =	shpcd_pci_tbl,
 	.probe =	shpc_probe,
-	/* remove:	shpc_remove_one, */
+	.remove =	shpc_remove,
 };
 
 static int __init shpcd_init(void)
 {
-	int retval = 0;
+	int retval;
 
 #ifdef CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE
 	shpchp_poll_mode = 1;
 #endif
 
-	retval = shpc_start_thread();
-	if (retval)
-		goto error_hpc_init;
-
 	retval = pci_register_driver(&shpc_driver);
 	dbg("%s: pci_register_driver = %d\n", __FUNCTION__, retval);
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-error_hpc_init:
-	if (retval) {
-		shpchp_event_stop_thread();
-	}
 	return retval;
 }
 
 static void __exit shpcd_cleanup(void)
 {
-	dbg("unload_shpchpd()\n");
-	unload_shpchpd();
-
 	pci_unregister_driver(&shpc_driver);
-
 	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
 }
 

