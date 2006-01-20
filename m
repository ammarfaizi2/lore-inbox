Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWATTFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWATTFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWATTFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:36304 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751163AbWATTFF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:05 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)
In-Reply-To: <11377838771790@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:37 -0800
Message-Id: <11377838771056@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)

Removing and then adding a PCI slot to a running partition results in
a kernel panic. The current code attempts to add iospace for an entire
root bus, which is inappropriate, and silently fails.  When a pci device
tries to use the iospace, a page fault is taken, as the iospace had not
been mapped, and of course the page fault cannot be resolved.

This only occurs for PCI adapters using pio, which may be why it hadn't
been seen earlier (this seems to have been broken for a while).
This patch has survived testing of dozens of slot add and removes.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 40ae159c997fbabbf864283dda902850d136d5aa
tree 549811a397be6ac3d4549786e5826233d6dd6c81
parent ac71be89ce24827756ab7f725c01c3f83b9b3851
author linas <linas@austin.ibm.com> Thu, 12 Jan 2006 14:36:25 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 drivers/pci/hotplug/rpadlpar_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 7d93dba..7f504b3 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -152,7 +152,7 @@ static struct pci_dev *dlpar_pci_add_bus
 	pcibios_claim_one_bus(dev->bus);
 
 	/* ioremap() for child bus, which may or may not succeed */
-	(void) remap_bus_range(dev->bus);
+	remap_bus_range(dev->subordinate);
 
 	/* Add new devices to global lists.  Register in proc, sysfs. */
 	pci_bus_add_devices(phb->bus);

