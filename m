Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWBAEON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWBAEON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWBAEON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:14:13 -0500
Received: from havoc.gtf.org ([69.61.125.42]:27321 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964907AbWBAEON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:14:13 -0500
Date: Tue, 31 Jan 2006 23:14:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata updates
Message-ID: <20060201041409.GA17794@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/ahci.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

Jeff Garzik:
      [libata ahci] Isolate Intel-ism, add JMicron JMB360 support
      [libata ahci] add another JMicron pci id

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 19bd346..a800fb5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -286,6 +286,10 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ICH8M */
 	{ PCI_VENDOR_ID_INTEL, 0x282a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH8M */
+	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB360 */
+	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB363 */
 	{ }	/* terminate list */
 };
 
@@ -802,7 +806,6 @@ static int ahci_host_init(struct ata_pro
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->mmio_base;
 	u32 tmp, cap_save;
-	u16 tmp16;
 	unsigned int i, j, using_dac;
 	int rc;
 	void __iomem *port_mmio;
@@ -836,9 +839,13 @@ static int ahci_host_init(struct ata_pro
 	writel(0xf, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 
-	pci_read_config_word(pdev, 0x92, &tmp16);
-	tmp16 |= 0xf;
-	pci_write_config_word(pdev, 0x92, tmp16);
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		u16 tmp16;
+
+		pci_read_config_word(pdev, 0x92, &tmp16);
+		tmp16 |= 0xf;
+		pci_write_config_word(pdev, 0x92, tmp16);
+	}
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
@@ -1082,6 +1089,10 @@ static int ahci_init_one (struct pci_dev
 	if (have_msi)
 		hpriv->flags |= AHCI_FLAG_MSI;
 
+	/* JMicron-specific fixup: make sure we're in AHCI mode */
+	if (pdev->vendor == 0x197b)
+		pci_write_config_byte(pdev, 0x41, 0xa1);
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
