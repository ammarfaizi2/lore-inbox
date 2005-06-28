Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVF1F6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVF1F6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVF1FrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:47:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:14060 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261650AbVF1Fdh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:37 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Take the PCI lock when modifying pci bus or device lists
In-Reply-To: <11199367724120@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:52 -0700
Message-Id: <11199367722672@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Take the PCI lock when modifying pci bus or device lists

With root bridge and pci bridge hot-plug, new buses and devices can be added
or removed at run time.  Protect the pci bus and device lists with the pci
lock when doing so.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e4ea9bb7e9f177e03a917b1f1213de0315f819ee
tree 482599b5f367e997dfe30590860091bb06219882
parent cc57450f5c044270d2cf1dd437c1850422262109
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:48 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:40 -0700

 drivers/pci/probe.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -374,8 +374,11 @@ struct pci_bus * __devinit pci_add_new_b
 	struct pci_bus *child;
 
 	child = pci_alloc_child_bus(parent, dev, busnr);
-	if (child)
+	if (child) {
+		spin_lock(&pci_bus_lock);
 		list_add_tail(&child->node, &parent->children);
+		spin_unlock(&pci_bus_lock);
+	}
 	return child;
 }
 
@@ -765,7 +768,9 @@ pci_scan_single_device(struct pci_bus *b
 	 * and the bus list for fixup functions, etc.
 	 */
 	INIT_LIST_HEAD(&dev->global_list);
+	spin_lock(&pci_bus_lock);
 	list_add_tail(&dev->bus_list, &bus->devices);
+	spin_unlock(&pci_bus_lock);
 
 	return dev;
 }
@@ -886,7 +891,9 @@ struct pci_bus * __devinit pci_scan_bus_
 		pr_debug("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
 		goto err_out;
 	}
+	spin_lock(&pci_bus_lock);
 	list_add_tail(&b->node, &pci_root_buses);
+	spin_unlock(&pci_bus_lock);
 
 	memset(dev, 0, sizeof(*dev));
 	dev->parent = parent;
@@ -928,7 +935,9 @@ class_dev_create_file_err:
 class_dev_reg_err:
 	device_unregister(dev);
 dev_reg_err:
+	spin_lock(&pci_bus_lock);
 	list_del(&b->node);
+	spin_unlock(&pci_bus_lock);
 err_out:
 	kfree(dev);
 	kfree(b);

