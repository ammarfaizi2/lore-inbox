Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312970AbSDBWIa>; Tue, 2 Apr 2002 17:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSDBWIV>; Tue, 2 Apr 2002 17:08:21 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:28898 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S312970AbSDBWIK>; Tue, 2 Apr 2002 17:08:10 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_55OYZ3GLLGEH5FEV2RRA"
From: Dominik Brodowski <devel@brodo.de>
To: "Luis Falcon" <lfalcon@thymbra.com>, devel@brodo.de
Subject: [patch] Re: IRQ routing conflicts / Assigning IRQ 0 to ethernet
Date: Wed, 3 Apr 2002 00:07:53 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <32954.200.45.226.162.1017776187.squirrel@thymbra.com> <19566.1017784479@www7.gmx.net>
MIME-Version: 1.0
Message-Id: <02040300075302.00816@sonnenschein>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_55OYZ3GLLGEH5FEV2RRA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Luis:

This patch should resolve the remaining issues. Patch is against 
acpi-20020329 + 2.5.7/2.4.18. Please test + tell me if it works.

Dominik

--- linux/arch/i386/kernel/pci-irq.c.original	Tue Apr  2 13:35:24 2002
+++ linux/arch/i386/kernel/pci-irq.c	Tue Apr  2 13:47:23 2002
@@ -576,10 +576,8 @@
 	struct pci_dev *dev2;
 	char *msg = NULL;
 
-	if (!pirq_table)
-		return 0;
 
-	/* Find IRQ routing entry */
+	/* Find IRQ pin */
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
 		DBG(" -> no interrupt pin\n");
@@ -588,10 +586,17 @@
 	pin = pin - 1;
 
 #ifdef CONFIG_ACPI_PCI
+	/* Use ACPI to lookup IRQ */
+
 	if (pci_use_acpi_routing)
 		return acpi_lookup_irq(dev, pin, assign);
 #endif
 	
+	/* Find IRQ routing entry */
+
+	if (!pirq_table)
+		return 0;
+
 	DBG("IRQ for %s:%d", dev->slot_name, pin);
 	info = pirq_get_info(dev);
 	if (!info) {


On Tuesday,  2. April 2002 23:54, Luis Falcon wrote:
> Bryan,
>
> Thanks a lot for your response.
> In fact the IRQ routing conflict has been solved !
>
> What is still pending is the assignment of a valid IRQ to the Ethernet card
> ( device 00:05.0 ) and Sound Card ( 00:07.5 ). So, at this point, the
> ethernet card doesn't work.
>  does not work.
>
> Here's the latest dmesg.
>
> Regards,
> Luis
--------------Boundary-00=_55OYZ3GLLGEH5FEV2RRA
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="pci-irq1.1.acpi.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pci-irq1.1.acpi.diff"

--- linux/arch/i386/kernel/pci-irq.c.original	Tue Apr  2 13:35:24 2002
+++ linux/arch/i386/kernel/pci-irq.c	Tue Apr  2 13:47:23 2002
@@ -576,10 +576,8 @@
 	struct pci_dev *dev2;
 	char *msg = NULL;
 
-	if (!pirq_table)
-		return 0;
 
-	/* Find IRQ routing entry */
+	/* Find IRQ pin */
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
 		DBG(" -> no interrupt pin\n");
@@ -588,10 +586,17 @@
 	pin = pin - 1;
 
 #ifdef CONFIG_ACPI_PCI
+	/* Use ACPI to lookup IRQ */
+
 	if (pci_use_acpi_routing)
 		return acpi_lookup_irq(dev, pin, assign);
 #endif
 	
+	/* Find IRQ routing entry */
+
+	if (!pirq_table)
+		return 0;
+
 	DBG("IRQ for %s:%d", dev->slot_name, pin);
 	info = pirq_get_info(dev);
 	if (!info) {

--------------Boundary-00=_55OYZ3GLLGEH5FEV2RRA--
