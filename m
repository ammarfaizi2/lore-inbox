Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266874AbUHISuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUHISuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUHISrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:47:47 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:21698 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S266850AbUHISqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:46:16 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] Fwd: Re: USB IRQ routing problem
Date: Mon, 9 Aug 2004 12:45:50 -0600
User-Agent: KMail/1.6.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091245.50335.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin's USB driver stopped working when I removed the
unconditional PCI ACPI IRQ routing stuff.  He has verified
that the attached patch fixes it.  I sort of hate to add
another pass of PCI fixups, so I'm open to alternate solutions
if anybody suggests one.



Add a "pci_fixup_enable" pass of PCI fixups.  These are run at the end
of pci_enable_device() to fix up things like IRQs that are not set up
until then.  Some VIA boards require a fixup after the IRQ is set up.
Found by Nick Piggin, initial patch by Bjorn Helgaas, reworked to fit
into current -mm by Nick.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

 linux-2.6-npiggin/drivers/pci/pci.c                 |    7 ++++++-
 linux-2.6-npiggin/drivers/pci/quirks.c              |   15 ++++++++++++---
 linux-2.6-npiggin/include/asm-generic/vmlinux.lds.h |    3 +++
 linux-2.6-npiggin/include/linux/pci.h               |    7 +++++++
 4 files changed, 28 insertions(+), 4 deletions(-)

diff -puN drivers/pci/pci.c~irq-routing drivers/pci/pci.c
--- linux-2.6/drivers/pci/pci.c~irq-routing	2004-08-07 12:01:02.000000000 +1000
+++ linux-2.6-npiggin/drivers/pci/pci.c	2004-08-07 12:08:14.000000000 +1000
@@ -382,8 +382,13 @@ pci_enable_device_bars(struct pci_dev *d
 int
 pci_enable_device(struct pci_dev *dev)
 {
+	int err;
+
 	dev->is_enabled = 1;
-	return pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
+	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
+		return err;
+	pci_fixup_device(pci_fixup_enable, dev);
+	return 0;
 }
 
 /**
diff -puN drivers/pci/quirks.c~irq-routing drivers/pci/quirks.c
--- linux-2.6/drivers/pci/quirks.c~irq-routing	2004-08-07 12:01:04.000000000 +1000
+++ linux-2.6-npiggin/drivers/pci/quirks.c	2004-08-07 12:18:55.000000000 +1000
@@ -491,9 +491,9 @@ static void __devinit quirk_via_irqpic(s
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic );
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic );
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic );
 
 
 /*
@@ -1001,6 +1001,9 @@ extern struct pci_fixup __start_pci_fixu
 extern struct pci_fixup __end_pci_fixups_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
 extern struct pci_fixup __end_pci_fixups_final[];
+extern struct pci_fixup __start_pci_fixups_enable[];
+extern struct pci_fixup __end_pci_fixups_enable[];
+
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 {
@@ -1016,6 +1019,12 @@ void pci_fixup_device(enum pci_fixup_pas
 		start = __start_pci_fixups_final;
 		end = __end_pci_fixups_final;
 		break;
+
+	case pci_fixup_enable:
+		start = __start_pci_fixups_enable;
+		end = __end_pci_fixups_enable;
+		break;
+
 	default:
 		/* stupid compiler warning, you would think with an enum... */
 		return;
diff -puN include/linux/pci.h~irq-routing include/linux/pci.h
--- linux-2.6/include/linux/pci.h~irq-routing	2004-08-07 12:01:07.000000000 +1000
+++ linux-2.6-npiggin/include/linux/pci.h	2004-08-07 12:06:00.000000000 +1000
@@ -1008,6 +1008,7 @@ struct pci_fixup {
 enum pci_fixup_pass {
 	pci_fixup_header,	/* Called immediately after reading configuration header */
 	pci_fixup_final,	/* Final phase of device fixups */
+	pci_fixup_enable,	/* pci_enable_device() time */
 };
 
 /* Anonymous variables would be nice... */
@@ -1021,6 +1022,12 @@ enum pci_fixup_pass {
 	__attribute__((__section__(".pci_fixup_final"))) = {				\
 		vendor, device, hook };
 
+#define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)				\
+	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
+	__attribute__((__section__(".pci_fixup_enable"))) = {				\
+		vendor, device, hook };
+
+
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 
 extern int pci_pci_problems;
diff -puN include/asm-generic/vmlinux.lds.h~irq-routing include/asm-generic/vmlinux.lds.h
--- linux-2.6/include/asm-generic/vmlinux.lds.h~irq-routing	2004-08-07 12:21:28.000000000 +1000
+++ linux-2.6-npiggin/include/asm-generic/vmlinux.lds.h	2004-08-07 12:22:13.000000000 +1000
@@ -24,6 +24,9 @@
 		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
 		*(.pci_fixup_final)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
+		*(.pci_fixup_enable)					\
+		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\

_
