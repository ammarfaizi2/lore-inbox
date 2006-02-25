Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWBYBJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWBYBJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWBYBJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:09:20 -0500
Received: from physics.harvard.edu ([128.103.101.20]:45495 "EHLO
	physics.harvard.edu") by vger.kernel.org with ESMTP id S964832AbWBYBJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:09:19 -0500
Message-ID: <43FFAE3D.7010002@physics.harvard.edu>
Date: Fri, 24 Feb 2006 20:09:17 -0500
From: Milan Kupcevic <milan@physics.harvard.edu>
Organization: Harvard University
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       torvalds@osdl.org
Subject: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4, SATA
 300 TX4 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Kupcevic <milan@physics.harvard.edu>

Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4 
(PDC40718-GP) wrong port enumeration order that makes it (nearly) 
impossible to deal with boot problems using two or more drives.

Signed-off-by: Milan Kupcevic <milan@physics.harvard.edu>
---

The current kernel driver assumes:

port 1 - scsi3
port 2 - scsi1
port 3 - scsi0
port 4 - scsi2

Having 4 hard drives connected to the controller grub recognizes the 
port 1 connected drive as "(hd0)" but kernel recognizes the port 3 
connected drive as scsi0:0:0:0 (/dev/sda). There is no clean way to make 
it boot correctly.

 sata_promise.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff -uprN ./drivers/scsi/sata_promise.c 
../linux/drivers/scsi/sata_promise.c
--- ./drivers/scsi/sata_promise.c       2006-02-17 17:23:45.000000000 -0500
+++ ../linux/drivers/scsi/sata_promise.c        2006-02-24 
19:35:16.000000000 -0500
@@ -707,14 +707,18 @@ static int pdc_ata_init_one (struct pci_
 
        /* notice 4-port boards */
        switch (board_idx) {
-       case board_20319:
+       case board_20319: /* tx4  */
                        probe_ent->n_ports = 4;
 
-               pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
-               pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
-
-               probe_ent->port[2].scr_addr = base + 0x600;
-               probe_ent->port[3].scr_addr = base + 0x700;
+               pdc_ata_setup_port(&probe_ent->port[0], base + 0x380);
+               pdc_ata_setup_port(&probe_ent->port[1], base + 0x280);
+               pdc_ata_setup_port(&probe_ent->port[2], base + 0x200);
+               pdc_ata_setup_port(&probe_ent->port[3], base + 0x300);
+
+               probe_ent->port[0].scr_addr = base + 0x700;
+               probe_ent->port[1].scr_addr = base + 0x500;
+               probe_ent->port[2].scr_addr = base + 0x400;
+               probe_ent->port[3].scr_addr = base + 0x600;
                break;
        case board_2037x:
                probe_ent->n_ports = 2;

-- 
Milan Kupcevic
System Administrator
Harvard University
Department of Physics

