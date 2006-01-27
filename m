Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWA0VyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWA0VyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWA0VyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:54:16 -0500
Received: from havoc.gtf.org ([69.61.125.42]:22752 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030346AbWA0VyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:54:15 -0500
Date: Fri, 27 Jan 2006 16:54:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Carlos.Pardo@siliconimage.com
Subject: [PATCH] sata_sil: add 'slow_down' module param
Message-ID: <20060127215405.GA21714@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just checked into 'sii-slow' branch of libata-dev:


commit 51e9f2ff83df6b1c81c5c44f4486c68ed87aa20e
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Fri Jan 27 16:50:27 2006 -0500

    [libata sata_sil] implement 'slow_down' module parameter
    
    On occasion, a user will submit a patch that enables the "mod15write"
    quirk for their device.  Enabling this quirk has the effect of clamping
    all ATA commands to no more than 15 sectors.  The intended use of this
    quirk is to stop the controller from generating FIS's of unusual size
    ("but Wesley, what about the FOUS's?"), which in turn works around
    problems in a <list> of hard drives.
    
    One side effect of this quirk is greatly decreased performance.  Users
    often enable the mod15write quirk to fix various system, power, chip,
    and/or driver problems.  For a few rare problematic cases, enabling this
    has cured lockups or data corruption.
    
    Rather than add bogus listings to the mod15write quirk list (I get a
    patch every month doing such), we add a 'slow_down' module parameter.
    This allows users to employ a performance sledgehammer in the hopes
    of curing a problem.  It defaults to off (0), of course.


 drivers/scsi/sata_sil.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index b017f85..17f74d3 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -231,6 +231,10 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static int slow_down = 0;
+module_param(slow_down, int, 0444);
+MODULE_PARM_DESC(slow_down, "Sledgehammer used to work around random problems, by limiting commands to 15 sectors (0=off, 1=on)");
+
 
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
@@ -354,8 +358,10 @@ static void sil_dev_config(struct ata_po
 		}
 
 	/* limit requests to 15 sectors */
-	if ((ap->flags & SIL_FLAG_MOD15WRITE) && (quirks & SIL_QUIRK_MOD15WRITE)) {
-		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
+	if (slow_down ||
+	    ((ap->flags & SIL_FLAG_MOD15WRITE) &&
+	     (quirks & SIL_QUIRK_MOD15WRITE))) {
+		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix (mod15write workaround)\n",
 		       ap->id, dev->devno);
 		ap->host->max_sectors = 15;
 		ap->host->hostt->max_sectors = 15;
