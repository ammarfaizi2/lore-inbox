Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFCXQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFCXQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVFCXQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:16:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28096 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261155AbVFCXQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:16:18 -0400
Message-ID: <42A0E4B4.3050309@pobox.com>
Date: Fri, 03 Jun 2005 19:16:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com, davem@davemloft.net,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pci_enable_msi() for everyone?
References: <20050603224551.GA10014@kroah.com>
In-Reply-To: <20050603224551.GA10014@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------010301080608040003050101"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010301080608040003050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> In talking with a few people about the MSI kernel code, they asked why
> we can't just do the pci_enable_msi() call for every pci device in the
> system (at somewhere like pci_enable_device() time or so).  That would
> let all drivers and devices get the MSI functionality without changing
> their code, and probably make the api a whole lot simpler.

Agreed.

And now is a good time to make changes, before bunches of drivers start 
using pci_enable_msi().  I am preparing such a change for the AHCI 
driver (see attached), which will be the standard SATA interface on most 
new motherboards.


> Now I know the e1000 driver would have to specifically disable MSI for
> some of their broken versions, and possibly some other drivers might
> need this, but the downside seems quite small.

tg3 needs to deal with some broken system chipsets as well.  See
tg3_test_msi(), which I would eventually prefer to eliminate in favor of 
PCI quirks and such.

An API note of warning though...   IMO eventually different drivers are 
going to want different behavior from pci_enable_device().  IDE already 
hacks around this, as Alan was required to do a while ago (IDE has a 
weird PCI BAR setup sometimes, requiring care during enabling).

Longer term, I think we will need a

	pci_enable(info on what to enable)

so that drivers can specify ahead of time "don't enable PIO, only MMIO", 
"don't enable MMIO, only PIO", "don't use MSI", etc.  and add a 
pci_disable() to undo all of that.

The more we add singleton functions like pci_enable_msi(), 
pci_set_master(), etc. the more I wish for a single function that 
handled all those details at one atomic point.  There is a lot of 
standard patterns that are hand-coded into every PCI driver's probe 
functions.

	Jeff


--------------010301080608040003050101
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"1.00"
+#define DRV_VERSION	"1.01"
 
 
 enum {
@@ -153,6 +153,7 @@ struct ahci_sg {
 
 struct ahci_host_priv {
 	unsigned long		flags;
+	unsigned int		have_msi; /* is PCI MSI enabled? */
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
 };
@@ -183,6 +184,7 @@ static void ahci_qc_prep(struct ata_queu
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static void ahci_remove_one (struct pci_dev *pdev);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -272,7 +274,7 @@ static struct pci_driver ahci_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= ahci_remove_one,
 };
 
 
@@ -879,15 +881,19 @@ static int ahci_host_init(struct ata_pro
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
+static void pci_intx(struct pci_dev *pdev, int enable)
 {
-	u16 pci_command;
+	u16 pci_command, new;
 
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
 }
 
 static void ahci_print_info(struct ata_probe_ent *probe_ent)
@@ -969,7 +975,7 @@ static int ahci_init_one (struct pci_dev
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
+	int have_msi, pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -987,12 +993,17 @@ static int ahci_init_one (struct pci_dev
 		goto err_out;
 	}
 
-	pci_enable_intx(pdev);
+	if (pci_enable_msi(pdev) == 0)
+		have_msi = 1;
+	else {
+		pci_intx(pdev, 1);
+		have_msi = 0;
+	}
 
 	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
-		goto err_out_regions;
+		goto err_out_msi;
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
@@ -1025,6 +1036,8 @@ static int ahci_init_one (struct pci_dev
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
+	hpriv->have_msi = have_msi;
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
@@ -1044,7 +1057,11 @@ err_out_iounmap:
 	iounmap(mmio_base);
 err_out_free_ent:
 	kfree(probe_ent);
-err_out_regions:
+err_out_msi:
+	if (have_msi)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
 	pci_release_regions(pdev);
 err_out:
 	if (!pci_dev_busy)
@@ -1052,6 +1069,42 @@ err_out:
 	return rc;
 }
 
+static void ahci_remove_one (struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	struct ata_port *ap;
+	unsigned int i;
+	int have_msi;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		scsi_remove_host(ap->host);
+	}
+
+	have_msi = hpriv->have_msi;
+	free_irq(host_set->irq, host_set);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		ata_scsi_release(ap->host);
+		scsi_host_put(ap->host);
+	}
+
+	host_set->ops->host_stop(host_set);
+	kfree(host_set);
+
+	if (have_msi)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	dev_set_drvdata(dev, NULL);
+}
 
 static int __init ahci_init(void)
 {

--------------010301080608040003050101--
