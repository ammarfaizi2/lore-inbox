Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVF1GUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVF1GUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVF1GSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:18:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:38892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261921AbVF1Fdy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:54 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Make the PCI remove routines safe for failed hot-plug
In-Reply-To: <11199367722672@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <1119936773200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Make the PCI remove routines safe for failed hot-plug

When a root bridge hierarchy is hot-plugged, resource requirements for the new
devices may be greater than what the root bridge is decoding.  In this case,
we want to remove devices that did not get needed resources.  These devices
have been scanned into bus specific lists but not yet added to the global
device list.  Make sure the pci remove functions can handle this case.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 091ca9f06382e46d77213c35a97f7d0be9e350d2
tree a7a63e88279b03c2ba47e8c62c1a40192f3d93b7
parent 6ef6f0e33c4645fc8d23201ad5a6a289b4303cbb
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:49 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:41 -0700

 drivers/pci/remove.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -18,17 +18,21 @@ static void pci_free_resources(struct pc
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
-	pci_proc_detach_device(dev);
-	pci_remove_sysfs_dev_files(dev);
-	device_unregister(&dev->dev);
+	if (!list_empty(&dev->global_list)) {
+		pci_proc_detach_device(dev);
+		pci_remove_sysfs_dev_files(dev);
+		device_unregister(&dev->dev);
+		spin_lock(&pci_bus_lock);
+		list_del(&dev->global_list);
+		dev->global_list.next = dev->global_list.prev = NULL;
+		spin_unlock(&pci_bus_lock);
+	}
 
 	/* Remove the device from the device lists, and prevent any further
 	 * list accesses from this device */
 	spin_lock(&pci_bus_lock);
 	list_del(&dev->bus_list);
-	list_del(&dev->global_list);
 	dev->bus_list.next = dev->bus_list.prev = NULL;
-	dev->global_list.next = dev->global_list.prev = NULL;
 	spin_unlock(&pci_bus_lock);
 
 	pci_free_resources(dev);

