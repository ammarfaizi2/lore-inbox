Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270150AbUJSXW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270150AbUJSXW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269833AbUJSXSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:18:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:22922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270175AbUJSWqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:43 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257332302@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <10982257332250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.12, 2004/10/06 11:48:43-07:00, johnpol@2ka.mipt.ru

[PATCH] scx200: pci_find_device() removal.

Remove pci_find_device() in arch/i386/kernel/scx200.c.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/scx200.c |   67 +++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 27 deletions(-)


diff -Nru a/arch/i386/kernel/scx200.c b/arch/i386/kernel/scx200.c
--- a/arch/i386/kernel/scx200.c	2004-10-19 15:26:54 -07:00
+++ b/arch/i386/kernel/scx200.c	2004-10-19 15:26:54 -07:00
@@ -22,9 +22,47 @@
 unsigned scx200_gpio_base = 0;
 long scx200_gpio_shadow[2];
 
+static struct pci_device_id scx200_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci,scx200_tbl);
+
+static int __devinit scx200_probe(struct pci_dev *, const struct pci_device_id *);
+
+static struct pci_driver scx200_pci_driver = {
+	.name = "scx200",
+	.id_table = scx200_tbl,
+	.probe = scx200_probe,
+};
+
 spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
 
+static int __devinit scx200_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int bank;
+	unsigned base;
+
+	base = pci_resource_start(pdev, 0);
+	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
+
+	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
+		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
+		return -EBUSY;
+	}
+
+	scx200_gpio_base = base;
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+
+	return 0;
+
+}
+
 u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
 {
 	u32 config, new_config;
@@ -77,39 +115,14 @@
 
 int __init scx200_init(void)
 {
-	struct pci_dev *bridge;
-	int bank;
-	unsigned base;
-
 	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
 
-	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
-				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
-				      NULL)) == NULL
-	    && (bridge = pci_find_device(PCI_VENDOR_ID_NS,
-					 PCI_DEVICE_ID_NS_SC1100_BRIDGE,
-					 NULL)) == NULL)
-		return -ENODEV;
-
-	base = pci_resource_start(bridge, 0);
-	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
-
-	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
-		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
-		return -EBUSY;
-	}
-
-	scx200_gpio_base = base;
-
-	/* read the current values driven on the GPIO signals */
-	for (bank = 0; bank < 2; ++bank)
-		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
-
-	return 0;
+	return pci_module_init(&scx200_pci_driver);
 }
 
 void __exit scx200_cleanup(void)
 {
+	pci_unregister_driver(&scx200_pci_driver);
 	release_region(scx200_gpio_base, SCx200_GPIO_SIZE);
 }
 

