Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVFIQuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVFIQuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVFIQt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:49:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:30133 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262273AbVFIQpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:45:04 -0400
Cc: scottm@somanetworks.com
Subject: [PATCH] PCI Hotplug: fix CPCI reference counting bug
In-Reply-To: <20050609164345.GA9538@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 9 Jun 2005 09:44:53 -0700
Message-Id: <11183354931589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: fix CPCI reference counting bug

Here's a patch that fixes up the pci_dev refcounting in the CPCI code.
I've done some testing against it and it seems fine here.

Signed-off-by: Scott Murray <scottm@somanetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 03e49d40ea3436cae0fe43708f11584130ee4a0c
tree acaa11b11c0ff1d4c9f743c0d8df2bc5a865a440
parent 5273a00d9c763108397658d440618f7ac3e40f83
author Scott Murray <scottm@somanetworks.com> Mon, 06 Jun 2005 15:48:04 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 01:37:59 -0700

 drivers/pci/hotplug/cpci_hotplug_core.c |    2 ++
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -217,6 +217,8 @@ static void release_slot(struct hotplug_
 	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot->name);
 	kfree(slot->hotplug_slot);
+	if (slot->dev)
+		pci_dev_put(slot->dev);
 	kfree(slot);
 }
 
diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -315,9 +315,12 @@ int cpci_unconfigure_slot(struct slot* s
 				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
 		if (dev) {
 			pci_remove_bus_device(dev);
-			slot->dev = NULL;
+			pci_dev_put(dev);
 		}
 	}
+	pci_dev_put(slot->dev);
+	slot->dev = NULL;
+
 	dbg("%s - exit", __FUNCTION__);
 	return 0;
 }
scottm@somanetworks.com
[PATCH] PCI Hotplug: fix CPCI reference counting bug
[PATCH] PCI Hotplug: fix CPCI reference counting bug

Here's a patch that fixes up the pci_dev refcounting in the CPCI code.
I've done some testing against it and it seems fine here.

Signed-off-by: Scott Murray <scottm@somanetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 03e49d40ea3436cae0fe43708f11584130ee4a0c
tree acaa11b11c0ff1d4c9f743c0d8df2bc5a865a440
parent 5273a00d9c763108397658d440618f7ac3e40f83
author Scott Murray <scottm@somanetworks.com> Mon, 06 Jun 2005 15:48:04 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 01:37:59 -0700

 drivers/pci/hotplug/cpci_hotplug_core.c |    2 ++
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -217,6 +217,8 @@ static void release_slot(struct hotplug_
 	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot->name);
 	kfree(slot->hotplug_slot);
+	if (slot->dev)
+		pci_dev_put(slot->dev);
 	kfree(slot);
 }
 
diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -315,9 +315,12 @@ int cpci_unconfigure_slot(struct slot* s
 				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
 		if (dev) {
 			pci_remove_bus_device(dev);
-			slot->dev = NULL;
+			pci_dev_put(dev);
 		}
 	}
+	pci_dev_put(slot->dev);
+	slot->dev = NULL;
+
 	dbg("%s - exit", __FUNCTION__);
 	return 0;
 }

