Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270104AbUJTHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270104AbUJTHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUJSXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:03:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:62601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269819AbUJSWqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:22 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225735893@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257353938@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.25, 2004/10/06 12:25:07-07:00, akpm@osdl.org

[PATCH] add-pci_fixup_enable-pass.patch

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Nick Piggin's USB driver stopped working when I removed the unconditional
PCI ACPI IRQ routing stuff.  He has verified that the attached patch fixes
it.  I sort of hate to add another pass of PCI fixups, so I'm open to
alternate solutions if anybody suggests one.

Add a "pci_fixup_enable" pass of PCI fixups.  These are run at the end of
pci_enable_device() to fix up things like IRQs that are not set up until
then.  Some VIA boards require a fixup after the IRQ is set up.  Found by
Nick Piggin, initial patch by Bjorn Helgaas, reworked to fit into current
-mm by Nick.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c                 |    7 ++++++-
 drivers/pci/quirks.c              |   15 ++++++++++++---
 include/asm-generic/vmlinux.lds.h |    3 +++
 include/linux/pci.h               |    7 +++++++
 4 files changed, 28 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-10-19 15:25:30 -07:00
+++ b/drivers/pci/pci.c	2004-10-19 15:25:30 -07:00
@@ -382,8 +382,13 @@
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
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-10-19 15:25:30 -07:00
+++ b/drivers/pci/quirks.c	2004-10-19 15:25:30 -07:00
@@ -491,9 +491,9 @@
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
@@ -1003,6 +1003,9 @@
 extern struct pci_fixup __end_pci_fixups_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
 extern struct pci_fixup __end_pci_fixups_final[];
+extern struct pci_fixup __start_pci_fixups_enable[];
+extern struct pci_fixup __end_pci_fixups_enable[];
+
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 {
@@ -1018,6 +1021,12 @@
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
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	2004-10-19 15:25:30 -07:00
+++ b/include/asm-generic/vmlinux.lds.h	2004-10-19 15:25:30 -07:00
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
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:25:30 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:25:30 -07:00
@@ -1001,6 +1001,7 @@
 enum pci_fixup_pass {
 	pci_fixup_header,	/* Called immediately after reading configuration header */
 	pci_fixup_final,	/* Final phase of device fixups */
+	pci_fixup_enable,	/* pci_enable_device() time */
 };
 
 /* Anonymous variables would be nice... */
@@ -1013,6 +1014,12 @@
 	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
 	__attribute__((__section__(".pci_fixup_final"))) = {				\
 		vendor, device, hook };
+
+#define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)				\
+	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
+	__attribute__((__section__(".pci_fixup_enable"))) = {				\
+		vendor, device, hook };
+
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 

