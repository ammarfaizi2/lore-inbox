Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbVJHA5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbVJHA5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbVJHA5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:57:07 -0400
Received: from fmr20.intel.com ([134.134.136.19]:58526 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161028AbVJHA5F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:57:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2/2] acpi: add ability to derive irq when doing a surpriseremoval of an adapter
Date: Sat, 8 Oct 2005 08:56:55 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2/2] acpi: add ability to derive irq when doing a surpriseremoval of an adapter
Thread-Index: AcXLZzwOdcfuzhRmTy2goDJxYFOv9wAO1arQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       <pcihpd-discuss@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
Cc: "Shah, Rajesh" <rajesh.shah@intel.com>, <greg@kroah.com>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 08 Oct 2005 00:56:58.0223 (UTC) FILETIME=[2F37EFF0:01C5CBA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>If an adapter is surprise removed, the interrupt pin must be guessed,
as
>any attempts to read it would obviously be invalid.  cycle through all
>possible interrupt pin values until we can either lookup or derive the
>right irq to disable.
>
>Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>
>diff -uprN -X linux-2.6.14-rc2/Documentation/dontdiff linux-2.6.14-
>rc2/drivers/acpi/pci_irq.c linux-2.6.14-rc2-kca1/drivers/acpi/pci_irq.c
>--- linux-2.6.14-rc2/drivers/acpi/pci_irq.c	2005-09-27
>09:01:28.000000000 -0700
>+++ linux-2.6.14-rc2-kca1/drivers/acpi/pci_irq.c	2005-09-28
>10:40:57.000000000 -0700
>@@ -491,6 +491,79 @@ void __attribute__ ((weak)) acpi_unregis
> {
> }
>
>+
>+
>+/*
>+ * This function will be called only in the case of
>+ * a "surprise" hot plug removal.  For surprise removals,
>+ * the card has either already be yanked out of the slot, or
>+ * the slot's been powered off, so we have to brute force
>+ * our way through all the possible interrupt pins to derive
>+ * the GSI, then we double check with the value stored in the
>+ * pci_dev structure to make sure we have the GSI that belongs
>+ * to this IRQ.
>+ */
>+void acpi_pci_irq_disable_nodev(struct pci_dev *dev)
>+{
>+	int gsi = 0;
>+	u8  pin = 0;
>+	int edge_level = ACPI_LEVEL_SENSITIVE;
>+	int active_high_low = ACPI_ACTIVE_LOW;
>+	int irq;
>+
>+	/*
>+	 * since our device is not present, we
>+	 * can't just read the interrupt pin
>+	 * and use the value to derive the irq.
>+	 * in this case, we are going to check
>+	 * each returned irq value to make
>+	 * sure it matches our already assigned
>+	 * irq before we use it.
>+	 */
>+	for (pin = 0; pin < 4; pin++) {
>+		/*
>+	 	 * First we check the PCI IRQ routing table (PRT) for an
IRQ.
>+	 	 */
>+		gsi = acpi_pci_irq_lookup(dev->bus,
PCI_SLOT(dev->devfn), pin,
>+				  &edge_level, &active_high_low, NULL,
>+				  acpi_pci_free_irq);
acpi_pci_free_irq has side effect. In the link device case, it
deferences a count. The blind guess will mass the reference count. Could
you introduce something like 'acpi_pci_find_irq'?

Thanks,
Shaohua 
