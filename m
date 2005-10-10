Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVJJRtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVJJRtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVJJRtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:49:17 -0400
Received: from fmr20.intel.com ([134.134.136.19]:29595 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751092AbVJJRtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:49:16 -0400
Subject: RE: [patch 2/2] acpi: add ability to derive irq when doing a
	surpriseremoval of an adapter
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       "Shah, Rajesh" <rajesh.shah@intel.com>, greg@kroah.com,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Oct 2005 10:48:53 -0700
Message-Id: <1128966533.13328.3.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 10 Oct 2005 17:48:57.0733 (UTC) FILETIME=[E3B16350:01C5CDC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 17:56 -0700, Li, Shaohua wrote:
> Hi,
> >
> >If an adapter is surprise removed, the interrupt pin must be guessed,
> as
> >any attempts to read it would obviously be invalid.  cycle through all
> >possible interrupt pin values until we can either lookup or derive the
> >right irq to disable.
> >
> >Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> >
> >diff -uprN -X linux-2.6.14-rc2/Documentation/dontdiff linux-2.6.14-
> >rc2/drivers/acpi/pci_irq.c linux-2.6.14-rc2-kca1/drivers/acpi/pci_irq.c
> >--- linux-2.6.14-rc2/drivers/acpi/pci_irq.c	2005-09-27
> >09:01:28.000000000 -0700
> >+++ linux-2.6.14-rc2-kca1/drivers/acpi/pci_irq.c	2005-09-28
> >10:40:57.000000000 -0700
> >@@ -491,6 +491,79 @@ void __attribute__ ((weak)) acpi_unregis
> > {
> > }
> >
> >+
> >+
> >+/*
> >+ * This function will be called only in the case of
> >+ * a "surprise" hot plug removal.  For surprise removals,
> >+ * the card has either already be yanked out of the slot, or
> >+ * the slot's been powered off, so we have to brute force
> >+ * our way through all the possible interrupt pins to derive
> >+ * the GSI, then we double check with the value stored in the
> >+ * pci_dev structure to make sure we have the GSI that belongs
> >+ * to this IRQ.
> >+ */
> >+void acpi_pci_irq_disable_nodev(struct pci_dev *dev)
> >+{
> >+	int gsi = 0;
> >+	u8  pin = 0;
> >+	int edge_level = ACPI_LEVEL_SENSITIVE;
> >+	int active_high_low = ACPI_ACTIVE_LOW;
> >+	int irq;
> >+
> >+	/*
> >+	 * since our device is not present, we
> >+	 * can't just read the interrupt pin
> >+	 * and use the value to derive the irq.
> >+	 * in this case, we are going to check
> >+	 * each returned irq value to make
> >+	 * sure it matches our already assigned
> >+	 * irq before we use it.
> >+	 */
> >+	for (pin = 0; pin < 4; pin++) {
> >+		/*
> >+	 	 * First we check the PCI IRQ routing table (PRT) for an
> IRQ.
> >+	 	 */
> >+		gsi = acpi_pci_irq_lookup(dev->bus,
> PCI_SLOT(dev->devfn), pin,
> >+				  &edge_level, &active_high_low, NULL,
> >+				  acpi_pci_free_irq);
> acpi_pci_free_irq has side effect. In the link device case, it
> deferences a count. The blind guess will mass the reference count. Could
> you introduce something like 'acpi_pci_find_irq'?
> 
> Thanks,
> Shaohua 

Is the ref count decrement in pci-link.c in this section of code:
#ifdef  FUTURE_USE
        /*
         * The Link reference count allows us to _DISable an unused link
         * and suspend time, and set it again  on resume.
         * However, 2.6.12 still has irq_router.resume
         * which blindly restores the link state.
         * So we disable the reference count method
         * to prevent duplicate acpi_pci_link_set()
         * which would harm some systems
         */
        link->refcnt--;
#endif


Or is it somewhere else?  Just want to make sure I know where I need to
avoid calling into.


