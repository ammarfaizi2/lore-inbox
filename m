Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272169AbTHIAg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272167AbTHIAcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:32:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:64447 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272166AbTHIAcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:32 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1060389134261@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.6.0-test2
In-Reply-To: <1060389134592@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 17:32:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1119.1.4, 2003/08/08 17:03:19-07:00, ink@jurassic.park.msu.ru

[PATCH] PCI: pci_enable_device vs bridges bugs

Bug #1 (found by Jay Estabrook).
On Alpha, under certain circumstances the firmware may close the IO
window of PCI-to-PCI bridge even if there is IO behind.
This wouldn't be a problem - linux PCI setup code does set up this
window properly, but in addition the firmware clears the IO-enable
bit in the PCI_COMMAND register of the bridge.
Since we don't call pci_enable_* routines for bridges in non-hotplug
path, we end up with disabled IO. Fixed by adding pci_enable_bridges()
to pci_assign_unassigned_resources().
Architectures which don't use the latter, but do use other setup-bus
code (parisc?) also should call pci_enable_bridges() for each root bus.

Bug #2 (closely related to #1).
As it turns out, pci_enable_device() doesn't work for bridges at all,
only for regular devices (header type 0) due to 0x3f mask passed to
pci_enable_device_bars(). The mask should be (1 << PCI_NUM_RESOURCES) - 1.

Bug #3 (quite a few archs, including i386).
pcibios_enable_device() does only check first 6 resources (regardless
of the mask) to decide whether or not to enable IO and MEM.
Bridge resources start at 7.

#2 and #3 affect hotplug. I wonder, has anybody ever tried *bridged*
PCI card behind a hot-plug controller?


 drivers/pci/pci.c       |    2 +-
 drivers/pci/setup-bus.c |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri Aug  8 17:25:03 2003
+++ b/drivers/pci/pci.c	Fri Aug  8 17:25:03 2003
@@ -359,7 +359,7 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
-	return pci_enable_device_bars(dev, 0x3F);
+	return pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
 }
 
 /**
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Fri Aug  8 17:25:03 2003
+++ b/drivers/pci/setup-bus.c	Fri Aug  8 17:25:03 2003
@@ -530,6 +530,8 @@
 	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next)
 		pci_bus_size_bridges(pci_bus_b(ln));
 	/* Depth last, allocate resources and update the hardware. */
-	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next)
+	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
 		pci_bus_assign_resources(pci_bus_b(ln));
+		pci_enable_bridges(pci_bus_b(ln));
+	}
 }

