Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVC2Uso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVC2Uso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVC2Uso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:48:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57024 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261419AbVC2Uqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:46:38 -0500
Message-ID: <4249BE9A.6020304@pobox.com>
Date: Tue, 29 Mar 2005 15:46:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x libata fixes
Content-Type: multipart/mixed;
 boundary="------------040903080302070106010003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040903080302070106010003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040903080302070106010003
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c        |    2 --
 drivers/scsi/libata-scsi.c |    7 ++++++-
 drivers/scsi/sata_sil.c    |   32 +++++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 4 deletions(-)

through these ChangeSets:

<carlos.pardo:siliconimage.com>:
  o sata_sil: Fix FIFO PCI Bus Arbitration

Brett Russ:
  o libata: support descriptor sense in ctrl page

Jason Gaston:
  o SATA AHCI correction Intel ICH7R

Jeff Garzik:
  o [libata sata_sil] Don't presume PCI cache-line-size reg is > 0


--------------040903080302070106010003
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-03-29 15:45:18 -05:00
+++ b/drivers/scsi/ahci.c	2005-03-29 15:45:18 -05:00
@@ -253,8 +253,6 @@
 	  board_ahci }, /* ICH7 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7M */
-	{ PCI_VENDOR_ID_INTEL, 0x27c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-03-29 15:45:18 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-03-29 15:45:18 -05:00
@@ -1038,7 +1038,12 @@
 
 static unsigned int ata_msense_ctl_mode(u8 **ptr_io, const u8 *last)
 {
-	const u8 page[] = {0xa, 0xa, 2, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+	const u8 page[] = {0xa, 0xa, 6, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+
+	/* byte 2: set the descriptor format sense data bit (bit 2)
+	 * since we need to support returning this format for SAT
+	 * commands and any SCSI commands against a 48b LBA device.
+	 */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
 	return sizeof(page);
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-03-29 15:45:18 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-03-29 15:45:18 -05:00
@@ -38,12 +38,21 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
-#define DRV_VERSION	"0.8"
+#define DRV_VERSION	"0.9"
 
 enum {
 	sil_3112		= 0,
 	sil_3114		= 1,
 
+	SIL_FIFO_R0		= 0x40,
+	SIL_FIFO_W0		= 0x41,
+	SIL_FIFO_R1		= 0x44,
+	SIL_FIFO_W1		= 0x45,
+	SIL_FIFO_R2		= 0x240,
+	SIL_FIFO_W2		= 0x241,
+	SIL_FIFO_R3		= 0x244,
+	SIL_FIFO_W3		= 0x245,
+
 	SIL_SYSCFG		= 0x48,
 	SIL_MASK_IDE0_INT	= (1 << 22),
 	SIL_MASK_IDE1_INT	= (1 << 23),
@@ -199,6 +208,13 @@
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
+{
+	u8 cache_line = 0;
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache_line);
+	return cache_line;
+}
+
 static void sil_post_set_mode (struct ata_port *ap)
 {
 	struct ata_host_set *host_set = ap->host_set;
@@ -341,6 +357,7 @@
 	unsigned int i;
 	int pci_dev_busy = 0;
 	u32 tmp, irq_mask;
+	u8 cls;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -404,6 +421,19 @@
 		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
 		ata_std_ports(&probe_ent->port[i]);
 	}
+
+	/* Initialize FIFO PCI bus arbitration */
+	cls = sil_get_device_cache_line(pdev);
+	if (cls) {
+		cls >>= 3;
+		cls++;  /* cls = (line_size/8)+1 */
+		writeb(cls, mmio_base + SIL_FIFO_R0);
+		writeb(cls, mmio_base + SIL_FIFO_W0);
+		writeb(cls, mmio_base + SIL_FIFO_R1);
+		writeb(cls, mmio_base + SIL_FIFO_W2);
+	} else
+		printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
+			pci_name(pdev));
 
 	if (ent->driver_data == sil_3114) {
 		irq_mask = SIL_MASK_4PORT;

--------------040903080302070106010003--
