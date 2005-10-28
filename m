Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVJ1GeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVJ1GeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVJ1Gbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:44778 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965145AbVJ1GbY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:24 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] pci device wakeup flags
In-Reply-To: <11304810221338@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <11304810223093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pci device wakeup flags

This patch teaches "pci_dev" about the new driver model wakeup support:

 - It marks devices as supporting wakeup when "can issue PME#" is
   listed in its PCI PM capability.

 - pci_enable_wake() refuses to enable wake if that's been disabled
   (e.g. through sysfs).

NOTE that a recent patch changed PCI probing, and this reverts part
of that change ... so that driver model initialization is again done
before the PCI setup.

(One issue is that the driver model "init + add == register" pattern isn't
being used inside PCI ...  and that probe change worsened the problem by
making "add" do some "init" too.  Maybe PCI should match the driver model
more closely, and just grow a new "pci_dev_init" function.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 454a289c5bc26384c2bdc40c0d232cf47bcf0a5d
tree e012cb9ddae22f2bb7fba37b6834e2123070eaa0
parent f69079c91f8ade0bb306d137d60cc9892e89f35a
author David Brownell <david-b@pacbell.net> Mon, 12 Sep 2005 19:48:14 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 drivers/pci/pci.c   |    4 ++++
 drivers/pci/probe.c |   16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 259d247..6c1c56b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -539,6 +539,10 @@ int pci_enable_wake(struct pci_dev *dev,
 	if (!pm) 
 		return enable ? -EIO : 0; 
 
+	/* don't enable unless policy set through driver core allows it */
+	if (!device_may_wakeup(&dev->dev) && enable)
+		return -EROFS;
+
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0057864..0a7eec1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -589,6 +589,7 @@ static void pci_read_irq(struct pci_dev 
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -616,6 +617,19 @@ static int pci_setup_device(struct pci_d
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+
+		/* PCI PM capable devices may be able to issue PME# (wakeup) */
+		pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+		if (pm) {
+			pci_read_config_word(dev, pm + PCI_PM_PMC, &pm);
+			if (pm & PCI_PM_CAP_PME_MASK)
+				device_init_wakeup(&dev->dev, 1);
+
+			/* REVISIT: if (pm & PCI_PM_CAP_PME_D3cold) then
+			 * pci pm spec 1.2, section 3.2.4 says we should
+			 * init PCI_PM_CTRL_PME_{STATUS,ENABLE} ...
+			 */
+		}
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
@@ -755,6 +769,7 @@ pci_scan_device(struct pci_bus *bus, int
 	memset(dev, 0, sizeof(struct pci_dev));
 	dev->bus = bus;
 	dev->sysdata = bus->sysdata;
+	device_initialize(&dev->dev);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
@@ -777,7 +792,6 @@ pci_scan_device(struct pci_bus *bus, int
 
 void __devinit pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
-	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
 

