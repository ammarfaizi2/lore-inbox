Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUHWTjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUHWTjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUHWTi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:38:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:53699 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266879AbUHWSga convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:30 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860812984@kroah.com>
Date: Mon, 23 Aug 2004 11:34:41 -0700
Message-Id: <10932860811635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.41.4, 2004/07/14 13:31:39-07:00, lxiep@us.ibm.com

[PATCH] PCI Hotplug: rpaphp_add_slot.patch

I found a bug in rpaphp code during DLPAR I/O testing.   When DLPAR ADD
a non-empty I/O slot to a partition,  an adapter  in the slot  didn't
get configured. The attached patch fixes that.

Signed-off-by: Linda Xie <lxie@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp_pci.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-08-23 11:08:56 -07:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-08-23 11:08:56 -07:00
@@ -341,7 +341,6 @@
 	return rc;
 }
 
-
 static void rpaphp_eeh_remove_bus_device(struct pci_dev *dev)
 {
 	eeh_remove_device(dev);
@@ -430,10 +429,26 @@
 				__FUNCTION__, slot->name);
 			goto exit_rc;
 		}
-		if (init_slot_pci_funcs(slot)) {
-			err("%s: init_slot_pci_funcs failed\n", __FUNCTION__);
+
+		if (slot->hotplug_slot->info->adapter_status == NOT_CONFIGURED) {
+			dbg("%s CONFIGURING pci adapter in slot[%s]\n",  
+				__FUNCTION__, slot->name);
+			if (rpaphp_config_pci_adapter(slot)) {
+				err("%s: CONFIG pci adapter failed\n", __FUNCTION__);
+				goto exit_rc;		
+			}
+		} else if (slot->hotplug_slot->info->adapter_status == CONFIGURED) {
+			if (init_slot_pci_funcs(slot)) {
+				err("%s: init_slot_pci_funcs failed\n", __FUNCTION__);
+				goto exit_rc;
+			}
+
+		} else {
+			err("%s: slot[%s]'s adapter_status is NOT_VALID.\n",
+				__FUNCTION__, slot->name);
 			goto exit_rc;
 		}
+		
 		print_slot_pci_funcs(slot);
 		if (!list_empty(&slot->dev.pci_funcs)) {
 			slot->state = CONFIGURED;

