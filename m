Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVJ3L0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVJ3L0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJ3L0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:26:15 -0500
Received: from mail.dvmed.net ([216.237.124.58]:12425 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750986AbVJ3L0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:26:15 -0500
Message-ID: <4364ADCE.60906@pobox.com>
Date: Sun, 30 Oct 2005 06:26:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Kellermann <max@duempel.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: 2.6.14-rc4-mm1 and later: second ata_piix controller
 is invisible
References: <20051025095646.GA24977@roonstrasse.net>
In-Reply-To: <20051025095646.GA24977@roonstrasse.net>
Content-Type: multipart/mixed;
 boundary="------------040506080800080800010105"
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506080800080800010105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Max Kellermann wrote:
> Hi Andrew,
> 
> since 2.6.14-rc4-mm1, my second ata_piix (SATA) controller does not
> show up in dmesg, effectively hiding /dev/sdb.  2.6.14-rc2-mm2 and
> older (with the same kernel config) were ok, the same for Linus'
> kernels: 2.6.14-rc5 without -mm1 has /dev/sdb, too.
> 
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150
> Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
> 0000:00:1f.2 0101: 8086:24d1 (rev 02)
> 
> This PCI device (on-board on an Asus P4 mainboard) has two SATA
> connectors, showing up as ata1/sda and ata2/sdb.

I think I found the bug.  ata_pci_init_one() got confused about the 
meaning of 'n_ports'.  I also found another bug in the same area, 
related to legacy initialization.

See the attached patch for a suggested fix (ignore ata_piix changes, 
which are obviously unrelated).

	Jeff



--------------040506080800080800010105
Content-Type: text/plain;
 name="patch.fix-piix-probe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.fix-piix-probe"

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index be02147..b7fbf11 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -45,6 +45,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -625,7 +626,8 @@ static int piix_init_one (struct pci_dev
 	unsigned int pata_chan = 0, sata_chan = 0;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "version " DRV_VERSION "\n");
 
 	/* no hotplugging support (FIXME) */
 	if (!in_module_init)
@@ -672,7 +674,9 @@ static int piix_init_one (struct pci_dev
 		port_info[pata_chan] = &piix_port_info[ich5_pata];
 		n_ports++;
 
-		printk(KERN_WARNING DRV_NAME ": combined mode detected\n");
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "combined mode detected (p=%u, s=%u)\n",
+			   pata_chan, sata_chan);
 	}
 
 	return ata_pci_init_one(pdev, port_info, n_ports);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index cc089f1..4fa3621 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4491,10 +4491,10 @@ void ata_pci_host_stop (struct ata_host_
  */
 
 struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int ports)
+ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info *port, int ports)
 {
 	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	int p = 0;
 
 	if (!probe_ent)
@@ -4527,11 +4527,11 @@ ata_pci_init_native_mode(struct pci_dev 
 	return probe_ent;
 }
 
-static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev, struct ata_port_info **port, int port_num)
+static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev, struct ata_port_info *port, int port_num)
 {
 	struct ata_probe_ent *probe_ent;
 
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;
 
@@ -4678,14 +4678,19 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	if (legacy_mode) {
 		if (legacy_mode & (1 << 0))
-			probe_ent = ata_pci_init_legacy_port(pdev, port, 0);
+			probe_ent = ata_pci_init_legacy_port(pdev, port[0], 0);
 		if (legacy_mode & (1 << 1))
-			probe_ent2 = ata_pci_init_legacy_port(pdev, port, 1);
+			probe_ent2 = ata_pci_init_legacy_port(pdev, port[1], 1);
 	} else {
-		if (n_ports == 2)
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-		else
-			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
+		if (n_ports == 1)
+			probe_ent = ata_pci_init_native_mode(pdev, port[0],
+					ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+		else {
+			probe_ent = ata_pci_init_native_mode(pdev, port[0],
+					ATA_PORT_PRIMARY);
+			probe_ent2 = ata_pci_init_native_mode(pdev, port[1],
+					ATA_PORT_PRIMARY);
+		}
 	}
 	if (!probe_ent && !probe_ent2) {
 		rc = -ENOMEM;
@@ -4695,13 +4700,10 @@ int ata_pci_init_one (struct pci_dev *pd
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return */
-	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
-			ata_device_add(probe_ent);
-		if (legacy_mode & (1 << 1))
-			ata_device_add(probe_ent2);
-	} else
+	if (probe_ent)
 		ata_device_add(probe_ent);
+	if (probe_ent2)
+		ata_device_add(probe_ent2);
 
 	kfree(probe_ent);
 	kfree(probe_ent2);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 1a56d6c..596a4e0 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -405,7 +405,7 @@ static int nv_init_one (struct pci_dev *
 	rc = -ENOMEM;
 
 	ppi = &nv_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		goto err_out_regions;
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 057f7b9..d3bcd38 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -263,7 +263,7 @@ static int sis_init_one (struct pci_dev 
 		goto err_out_regions;
 
 	ppi = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index d68dc7d..145405a 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -202,7 +202,7 @@ static int uli_init_one (struct pci_dev 
 		goto err_out_regions;
 
 	ppi = &uli_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 80e291a..f2a2736 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -212,7 +212,7 @@ static struct ata_probe_ent *vt6420_init
 	struct ata_probe_ent *probe_ent;
 	struct ata_port_info *ppi = &svia_port_info;
 
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		return NULL;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0ba3af7..e75112d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -506,7 +506,7 @@ struct pci_bits {
 
 extern void ata_pci_host_stop (struct ata_host_set *host_set);
 extern struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
+ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info *port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 
 #endif /* CONFIG_PCI */

--------------040506080800080800010105--
