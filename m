Return-Path: <linux-kernel-owner+w=401wt.eu-S965237AbXAGWj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbXAGWj7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbXAGWj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:39:58 -0500
Received: from aun.it.uu.se ([130.238.12.36]:48504 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965230AbXAGWj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:39:57 -0500
Date: Sun, 7 Jan 2007 23:39:45 +0100 (MET)
Message-Id: <200701072239.l07Mdju7028895@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jeff@garzik.org
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI support
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 21:32:03 +0100 (MET), Mikael Pettersson wrote:
>This patch adds ATAPI support for the PATA port on Promise 2037x chips.
>It depends on the common sata_promise ATAPI support patch.
>
>First-generation chips don't support ATAPI on their SATA ports, so
>the patch removes ATA_FLAG_NO_ATAPI from the 2037x common host flags,
>and adds it back via the _port_flags[] entries for the SATA ports.

Update: SATAPI works on first-generation chips, but only in PIO mode.

To verify that DMA doesn't work I also tried Promise's pdc-ultra
driver for their first-generation chips. It doesn't want to support
ATAPI without an explicit option. Enabling that option makes it
recognise ATAPI devices, but even a simple "eject" command triggers
command timeouts and eventually a kernel oops due to the NMI watchdog.
So I'm fairly sure that DMA simply doesn't work.

This patch enables ATAPI on 20319 and 2037x chips, but forces SATA
ports to always use PIO. As a side-effect, ATAPI support is now free
of any dependencies on the #promise-sata-pata branch.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.20-rc4/drivers/ata/sata_promise.c.~1~	2007-01-07 22:58:01.000000000 +0100
+++ linux-2.6.20-rc4/drivers/ata/sata_promise.c	2007-01-07 23:06:22.000000000 +0100
@@ -197,7 +197,7 @@ static const struct ata_port_info pdc_po
 	/* board_20319 */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_NO_ATAPI | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -789,8 +789,14 @@ static void pdc_exec_command_mmio(struct
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	u8 *scsicmd = qc->scsicmd->cmnd;
+	struct ata_port *ap = qc->ap;
+	struct pdc_host_priv *hp = ap->host->private_data;
 	int pio = 1; /* atapi dma off by default */
 
+	/* First generation chips cannot use ATAPI DMA on SATA ports */
+	if (!(hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap))
+		return 1;
+
 	/* Whitelist commands that may use DMA. */
 	switch (scsicmd[0]) {
 	case WRITE_12:
@@ -996,10 +1002,6 @@ static int pdc_ata_init_one (struct pci_
        			probe_ent->n_ports = 2;
 		probe_ent->_port_flags[0] = ATA_FLAG_SATA;
 		probe_ent->_port_flags[1] = ATA_FLAG_SATA;
-		if (board_idx == board_2037x) {
-			probe_ent->_port_flags[0] |= ATA_FLAG_NO_ATAPI;
-			probe_ent->_port_flags[1] |= ATA_FLAG_NO_ATAPI;
-		}
 		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
