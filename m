Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVKKQXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVKKQXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKKQXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:23:38 -0500
Received: from havoc.gtf.org ([69.61.125.42]:36557 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750827AbVKKQXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:23:37 -0500
Date: Fri, 11 Nov 2005 11:23:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20051111162335.GA25840@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/ahci.c         |    2 +-
 drivers/scsi/ata_piix.c     |    2 +-
 drivers/scsi/libata-core.c  |    2 ++
 drivers/scsi/libata-scsi.c  |    2 ++
 drivers/scsi/pdc_adma.c     |    2 +-
 drivers/scsi/sata_mv.c      |    4 +++-
 drivers/scsi/sata_nv.c      |    2 +-
 drivers/scsi/sata_promise.c |    2 +-
 drivers/scsi/sata_qstor.c   |    2 +-
 drivers/scsi/sata_sil.c     |    2 +-
 drivers/scsi/sata_sil24.c   |    2 +-
 drivers/scsi/sata_sis.c     |    2 +-
 drivers/scsi/sata_svw.c     |    2 +-
 drivers/scsi/sata_sx4.c     |    2 +-
 drivers/scsi/sata_uli.c     |    2 +-
 drivers/scsi/sata_via.c     |    2 +-
 drivers/scsi/sata_vsc.c     |    2 +-
 include/linux/libata.h      |    2 ++
 18 files changed, 23 insertions(+), 15 deletions(-)

Alan Cox:
      libata: Note a nasty ATA quirk
      libata: propogate host private data from probe function

Andrew Morton:
      libata.h needs dma-mapping.h

Jeff Garzik:
      [libata] constify PCI ID table in several drivers
      [libata sata_mv] add Adaptec 1420SA PCI ID

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 10c470e..57ef7ae 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -255,7 +255,7 @@ static struct ata_port_info ahci_port_in
 	},
 };
 
-static struct pci_device_id ahci_pci_tbl[] = {
+static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH6 */
 	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index a1bd8d9..855428f 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -95,7 +95,7 @@ static void piix_set_dmamode (struct ata
 
 static unsigned int in_module_init = 1;
 
-static struct pci_device_id piix_pci_tbl[] = {
+static const struct pci_device_id piix_pci_tbl[] = {
 #ifdef ATA_ENABLE_PATA
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
 	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a74b407..e51d9a8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4563,6 +4563,7 @@ ata_pci_init_native_mode(struct pci_dev 
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->private_data = port[0]->private_data;
 
 	if (ports & ATA_PORT_PRIMARY) {
 		probe_ent->port[p].cmd_addr = pci_resource_start(pdev, 0);
@@ -4599,6 +4600,7 @@ static struct ata_probe_ent *ata_pci_ini
 	probe_ent->legacy_mode = 1;
 	probe_ent->n_ports = 1;
 	probe_ent->hard_port_no = port_num;
+	probe_ent->private_data = port->private_data;
 
 	switch(port_num)
 	{
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index bb30fcd..7e37f48 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1129,6 +1129,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		 * length 0 means transfer 0 block of data.
 		 * However, for ATA R/W commands, sector count 0 means
 		 * 256 or 65536 sectors, not 0 sectors as in SCSI.
+		 *
+		 * WARNING: one or two older ATA drives treat 0 as 0...
 		 */
 		goto nothing_to_do;
 
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 78b4ff1..f557f17 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -190,7 +190,7 @@ static struct ata_port_info adma_port_in
 	},
 };
 
-static struct pci_device_id adma_ata_pci_tbl[] = {
+static const struct pci_device_id adma_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PDC, 0x1841, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_1841_idx },
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 93d5523..257c128 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -349,7 +349,7 @@ static struct ata_port_info mv_port_info
 	},
 };
 
-static struct pci_device_id mv_pci_tbl[] = {
+static const struct pci_device_id mv_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_508x},
@@ -359,6 +359,8 @@ static struct pci_device_id mv_pci_tbl[]
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
+
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, 0x0241), 0, 0, chip_604x},
 	{}			/* terminate list */
 };
 
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 37a4fae..4954896 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -137,7 +137,7 @@ enum nv_host_type
 	CK804
 };
 
-static struct pci_device_id nv_pci_tbl[] = {
+static const struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE2 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 9edc9d9..242d906 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -193,7 +193,7 @@ static struct ata_port_info pdc_port_inf
 	},
 };
 
-static struct pci_device_id pdc_ata_pci_tbl[] = {
+static const struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index d274ab2..b2f6324 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -184,7 +184,7 @@ static struct ata_port_info qs_port_info
 	},
 };
 
-static struct pci_device_id qs_ata_pci_tbl[] = {
+static const struct pci_device_id qs_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PDC, 0x2068, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2068_idx },
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index d0e3c3c..3609186 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -87,7 +87,7 @@ static void sil_scr_write (struct ata_po
 static void sil_post_set_mode (struct ata_port *ap);
 
 
-static struct pci_device_id sil_pci_tbl[] = {
+static const struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 4682a50..d3198d9 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -240,7 +240,7 @@ static void sil24_port_stop(struct ata_p
 static void sil24_host_stop(struct ata_host_set *host_set);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
-static struct pci_device_id sil24_pci_tbl[] = {
+static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
 	{ 0x1095, 0x3132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3132 },
 	{ 0x1095, 0x3131, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 42d7c4e..32e1262 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -67,7 +67,7 @@ static int sis_init_one (struct pci_dev 
 static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
-static struct pci_device_id sis_pci_tbl[] = {
+static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 9895d1c..57e5a9d 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -466,7 +466,7 @@ err_out:
  * 0x24a is device ID for BCM5785 (aka HT1000) HT southbridge integrated SATA
  * controller
  * */
-static struct pci_device_id k2_sata_pci_tbl[] = {
+static const struct pci_device_id k2_sata_pci_tbl[] = {
 	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index d5a3878..b4bbe48 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -229,7 +229,7 @@ static struct ata_port_info pdc_port_inf
 
 };
 
-static struct pci_device_id pdc_sata_pci_tbl[] = {
+static const struct pci_device_id pdc_sata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x6622, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20621 },
 	{ }	/* terminate list */
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index cf0baaa..b2422a0 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -55,7 +55,7 @@ static int uli_init_one (struct pci_dev 
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
-static struct pci_device_id uli_pci_tbl[] = {
+static const struct pci_device_id uli_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
 	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
 	{ PCI_VENDOR_ID_AL, 0x5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index ab19d2b..c762156 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -75,7 +75,7 @@ static int svia_init_one (struct pci_dev
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
-static struct pci_device_id svia_pci_tbl[] = {
+static const struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index ce8a2fd..77a6e4b 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -400,7 +400,7 @@ err_out:
  * 0x8086/0x3200 is the Intel 31244, which is supposed to be identical
  * compatibility is untested as of yet
  */
-static struct pci_device_id vsc_sata_pci_tbl[] = {
+static const struct pci_device_id vsc_sata_pci_tbl[] = {
 	{ 0x1725, 0x7174, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
 	{ 0x8086, 0x3200, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
 	{ }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6f07522..1464a75 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
@@ -404,6 +405,7 @@ struct ata_port_info {
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
+	void 			*private_data;
 };
 
 struct ata_timing {
