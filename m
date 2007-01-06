Return-Path: <linux-kernel-owner+w=401wt.eu-S932173AbXAFUbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXAFUbP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbXAFUbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:31:15 -0500
Received: from aun.it.uu.se ([130.238.12.36]:40890 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbXAFUbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:31:14 -0500
Date: Sat, 6 Jan 2007 21:31:06 +0100 (MET)
Message-Id: <200701062031.l06KV64q022234@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH libata #promise-sata-pata] sata_promise: unbreak 20619
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PATA support patch for sata_promise appears, from
code inspection, to break the PATA-only 20619 chip.

The patch removes the SATA flag from the TX2plus SATA+PATA
boards' common flags, with the intention of adding it back
via the _port_flags[] entries for those boards' SATA ports.

However, it unconditionally marks ports 0 and 1 as SATA
for all boards. This causes the 20619 (TX4000) to announce
its first two PATA ports as SATA | ATA_FLAG_SLAVE_POSS.

I don't have a TX4000 so I don't know what the actual
consequences of this bug are, but surely this isn't Ok.

Fixed by moving the port 0 and 1 settings as SATA into
the TX4 and TX2plus specific initialisation code.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.20-rc3/drivers/ata/sata_promise.c.~1~	2007-01-06 17:05:29.000000000 +0100
+++ linux-2.6.20-rc3/drivers/ata/sata_promise.c	2007-01-06 17:10:56.000000000 +0100
@@ -957,9 +957,6 @@ static int pdc_ata_init_one (struct pci_
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
 
-	probe_ent->_port_flags[0] = ATA_FLAG_SATA;
-	probe_ent->_port_flags[1] = ATA_FLAG_SATA;
-	
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_40518:
@@ -974,6 +971,8 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
 	
+		probe_ent->_port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->_port_flags[1] = ATA_FLAG_SATA;
 		probe_ent->_port_flags[2] = ATA_FLAG_SATA;
 		probe_ent->_port_flags[3] = ATA_FLAG_SATA;
 		break;
@@ -995,6 +994,8 @@ static int pdc_ata_init_one (struct pci_
 		}
 		else
        			probe_ent->n_ports = 2;
+		probe_ent->_port_flags[0] = ATA_FLAG_SATA;
+		probe_ent->_port_flags[1] = ATA_FLAG_SATA;
 		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
