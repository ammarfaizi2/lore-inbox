Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbTAYA11>; Fri, 24 Jan 2003 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTAYA11>; Fri, 24 Jan 2003 19:27:27 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:21001 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265909AbTAYA10>; Fri, 24 Jan 2003 19:27:26 -0500
Date: Fri, 24 Jan 2003 19:33:53 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ink@jurassic.park.msu.ru, jgarzik@pobox.com, willy@debian.org,
       linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124193353.A6814@dsnt25.mro.cpqcorp.net>
References: <20030124163341.A4366@dsnt25.mro.cpqcorp.net> <20030124.133434.66251483.davem@redhat.com> <20030125014102.A825@localhost.park.msu.ru> <20030124.143252.97527503.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124.143252.97527503.davem@redhat.com>; from davem@redhat.com on Fri, Jan 24, 2003 at 02:32:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 02:32:52PM -0800, David S. Miller wrote:
>    From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>    Date: Sat, 25 Jan 2003 01:41:02 +0300
>    
>    I don't understand the issue, really. The config register says:
>    "MSIs are enabled". Which means: "My platform is *really* going to
>    use MSI". Why do you want to ignore that?
> 
> I see, why not code up a generic pci_using_msi(pdev) that
> does this?
> 
> I suggested a per-arch version because I was not clear on how
> this exactly worked.

You mean something like this? My reading of the PCI spec says that if
the enable bit in Message Command (part of which is PCI_MSI_FLAGS as
defined in pci.h) is that if the enable bit is set, MSIs are being
used... 

Then the tg3 code after the pci_restore_extended_state could be
     if (pci_using_msi(tp->pdev))
        tw32(MSGINT_MODE, MSGINT_MODE_ENABLE);

/jeff
------
diff -Nuar linux-2.5.59/drivers/pci/pci.c pci_using_msi/drivers/pci/pci.c
--- linux-2.5.59/drivers/pci/pci.c	Thu Jan 16 21:21:48 2003
+++ pci_using_msi/drivers/pci/pci.c	Fri Jan 24 19:00:53 2003
@@ -679,6 +679,26 @@
 	}
 }
 
+/**
+ * pci_using_msi - is this pci device configured to use MSI?
+ * @dev: PCI device structure of device being queried
+ *
+ * Tells whether or not a pci device is configured to use Message Signalled
+ * Interrupts. Returns non-zero if configured for MSI, else 0.
+ */
+int
+pci_using_msi(struct pci_dev *dev)
+{
+	int msi = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	u8 flags;
+
+	if (!msi)
+		return 0;
+
+	pci_read_config_byte(dev, msi + PCI_MSI_FLAGS, &flags);
+	return (flags & PCI_MSI_FLAGS_ENABLE);
+}
+
 int
 pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
@@ -749,6 +769,7 @@
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
+EXPORT_SYMBOL(pci_using_msi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
diff -Nuar linux-2.5.59/include/linux/pci.h pci_using_msi/include/linux/pci.h
--- linux-2.5.59/include/linux/pci.h	Thu Jan 16 21:22:08 2003
+++ pci_using_msi/include/linux/pci.h	Fri Jan 24 19:01:26 2003
@@ -622,6 +622,7 @@
 #define HAVE_PCI_SET_MWI
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
+int pci_using_msi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);

