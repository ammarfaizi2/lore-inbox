Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269833AbUJSXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269833AbUJSXXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270177AbUJSXSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:18:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:22410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270174AbUJSWqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:43 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257352551@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257354198@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.27, 2004/10/06 12:37:44-07:00, greg@kroah.com

[PATCH] PCI: remove pci_find_device() usages from drivers/pci/*

yeah, I ignored the ppc64 hotplug pci driver, they can fix it up themselves...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpcihp_zt5550.c |    3 ++-
 drivers/pci/hotplug/ibmphp_core.c   |    2 +-
 drivers/pci/pci.c                   |    2 +-
 drivers/pci/proc.c                  |    2 +-
 drivers/pci/quirks.c                |   16 +++++++++-------
 drivers/pci/setup-irq.c             |    2 +-
 6 files changed, 15 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
--- a/drivers/pci/hotplug/cpcihp_zt5550.c	2004-10-19 15:25:19 -07:00
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c	2004-10-19 15:25:19 -07:00
@@ -219,12 +219,13 @@
 	dbg("registered controller");
 
 	/* Look for first device matching cPCI bus's bridge vendor and device IDs */
-	if(!(bus0_dev = pci_find_device(PCI_VENDOR_ID_DEC,
+	if(!(bus0_dev = pci_get_device(PCI_VENDOR_ID_DEC,
 					 PCI_DEVICE_ID_DEC_21154, NULL))) {
 		status = -ENODEV;
 		goto init_register_error;
 	}
 	bus0 = bus0_dev->subordinate;
+	pci_dev_put(bus0_dev);
 
 	status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
 	if(status != 0) {
diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	2004-10-19 15:25:19 -07:00
+++ b/drivers/pci/hotplug/ibmphp_core.c	2004-10-19 15:25:19 -07:00
@@ -886,7 +886,7 @@
 				break;
 			case BUS_SPEED_133:
 				/* This is to take care of the bug in CIOBX chip */
-				while ((dev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+				while ((dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
 							      0x0101, dev)) != NULL)
 					ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
 				cmd = HPC_BUS_133PCIXMODE;
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-10-19 15:25:19 -07:00
+++ b/drivers/pci/pci.c	2004-10-19 15:25:19 -07:00
@@ -749,7 +749,7 @@
 {
 	struct pci_dev *dev = NULL;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_fixup_device(pci_fixup_final, dev);
 	}
 	return 0;
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	2004-10-19 15:25:19 -07:00
+++ b/drivers/pci/proc.c	2004-10-19 15:25:19 -07:00
@@ -599,7 +599,7 @@
 	if (entry)
 		entry->proc_fops = &proc_bus_pci_dev_operations;
 	proc_initialized = 1;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_proc_attach_device(dev);
 	}
 	legacy_proc_init();
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-10-19 15:25:19 -07:00
+++ b/drivers/pci/quirks.c	2004-10-19 15:25:19 -07:00
@@ -30,7 +30,7 @@
 
 	/* We have to make sure a particular bit is set in the PIIX3
 	   ISA bridge, so we have to go out and find it. */
-	while ((d = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
+	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
 		pci_read_config_byte(d, 0x82, &dlc);
 		if (!(dlc & 1<<1)) {
 			printk(KERN_ERR "PCI: PIIX3: Enabling Passive Release on %s\n", pci_name(d));
@@ -116,21 +116,21 @@
 	/* Ok we have a potential problem chipset here. Now see if we have
 	   a buggy southbridge */
 	   
-	p = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
+	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
 	if (p!=NULL) {
 		pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
 		/* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis */
 		/* Check for buggy part revisions */
-		if (rev < 0x40 || rev > 0x42) 
-			return;
+		if (rev < 0x40 || rev > 0x42)
+			goto exit;
 	} else {
-		p = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
+		p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
 		if (p==NULL)	/* No problem parts */
-			return;
+			goto exit;
 		pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
 		/* Check for buggy part revisions */
 		if (rev < 0x10 || rev > 0x12) 
-			return;
+			goto exit;
 	}
 	
 	/*
@@ -153,6 +153,8 @@
 	busarb |= (1<<4);
 	pci_write_config_byte(dev, 0x76, busarb);
 	printk(KERN_INFO "Applying VIA southbridge workaround.\n");
+exit:
+	pci_dev_put(p);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency );
diff -Nru a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
--- a/drivers/pci/setup-irq.c	2004-10-19 15:25:19 -07:00
+++ b/drivers/pci/setup-irq.c	2004-10-19 15:25:19 -07:00
@@ -65,7 +65,7 @@
 	       int (*map_irq)(struct pci_dev *, u8, u8))
 {
 	struct pci_dev *dev = NULL;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pdev_fixup_irq(dev, swizzle, map_irq);
 	}
 }

