Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVCLEex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVCLEex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 23:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVCLEej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 23:34:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33988 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261852AbVCLEeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 23:34:18 -0500
Message-ID: <4232712C.1080901@pobox.com>
Date: Fri, 11 Mar 2005 23:33:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x libata fixes
Content-Type: multipart/mixed;
 boundary="------------020801020305050505000708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020801020305050505000708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020801020305050505000708
Content-Type: text/plain;
 name="libata.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

through these ChangeSets:

Brett Russ:
  o AHCI: fix fatal error int handling

Jeff Garzik:
  o [libata ahci] support ->tf_read hook


--------------020801020305050505000708
Content-Type: text/x-patch;
 name="libata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.patch"

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-03-11 23:30:59 -05:00
+++ b/drivers/scsi/ahci.c	2005-03-11 23:30:59 -05:00
@@ -177,6 +177,7 @@
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
@@ -210,6 +211,8 @@
 	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
+	.tf_read		= ahci_tf_read,
+
 	.phy_reset		= ahci_phy_reset,
 
 	.qc_prep		= ahci_qc_prep,
@@ -463,6 +466,14 @@
 	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
 }
 
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+	ata_tf_from_fis(d2h_fis, tf);
+}
+
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
@@ -539,7 +550,7 @@
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
 	/* wait for engine to stop.  TODO: this could be
@@ -571,7 +582,7 @@
 
 	/* re-start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 

--------------020801020305050505000708--
