Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWH2FYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWH2FYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWH2FYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:24:06 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:28550 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751114AbWH2FYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:24:04 -0400
Message-ID: <44F3CF6E.1070000@us.ibm.com>
Date: Mon, 28 Aug 2006 22:23:58 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Konrad Rzeszutek <konrad@darnok.org>
Subject: [PATCH] aic94xx: Increase can_queue and cmds_per_lun
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Below is a patch that sets cmd_per_lun and can_queue in the aic94xx
driver's scsi_host_template to better performing values than what's
there currently.  The cmd_per_lun setting is stolen straight out of the
adp94xx source, and can_queue is derived from the max_scb value that we
calculate in asd_init_hw.  To the best of my (admittedly limited)
knowledge, this method provides the correct values (can_queue = 443 in
both adp94xx and aic94xx on my 9405W) but if anybody knows better,
please enlighten me. :)

That said, the effect of leaving these values set to 1 is terrible
performance in the case of either (a) certain Maxtor SAS drives flying
solo or (b) flooding several disks with I/O simultaneously (md-raid).
There may be more scenarios where we see similar problems that I
haven't uncovered.

Just for grins, I ran bogodisk (an O_DIRECT-enabled read speed test)
against three different scenarios:

1) adp94xx 1.0.8-6, pounded into 2.6.18-rc4 [green]
2) aic94xx 1.0.2, without this patch        [red]
3) aic94xx 1.0.2, with this                 [blue]

...with these results:

http://sweaglesw.net/~djwong/programs/bogodisk/bd_graphs/bad_sas.0.png

As you can see, the read performance is cut in half by the aic94xx
driver not getting a chance to have multiple I/Os in flight at any given 
time.  With the patch, the two drivers are fairly close bandwidth-wise.
Also thanks to Mike Anderson for helping me figure this out.

--D

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.h b/drivers/scsi/aic94xx/aic94xx_hwi.h
index c7d5053..a2d8881 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.h
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.h
@@ -36,6 +36,9 @@
 #include "aic94xx.h"
 #include "aic94xx_sas.h"
 
+/* Leave a few empty data buffers. */
+#define ASD_FREE_SCBS      3
+
 /* Define ASD_MAX_PHYS to the maximum phys ever. Currently 8. */
 #define ASD_MAX_PHYS       8
 #define ASD_PCBA_SN_SIZE   12
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 3ec2e46..34a7b4b 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -71,7 +72,7 @@ static struct scsi_host_template aic94xx
 	.change_queue_type	= sas_change_queue_type,
 	.bios_param		= sas_bios_param,
 	.can_queue		= 1,
-	.cmd_per_lun		= 1,
+	.cmd_per_lun		= 2,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
@@ -612,13 +616,17 @@ static int __devinit asd_pci_probe(struc
 		goto Err_free_cache;
 
 	asd_printk("device %s: SAS addr %llx, PCBA SN %s, %d phys, %d enabled "
-		   "phys, flash %s, BIOS %s%d\n",
+		   "phys, flash %s, BIOS %s%d, SCBs %d\n",
 		   pci_name(dev), SAS_ADDR(asd_ha->hw_prof.sas_addr),
 		   asd_ha->hw_prof.pcba_sn, asd_ha->hw_prof.max_phys,
 		   asd_ha->hw_prof.num_phys,
 		   asd_ha->hw_prof.flash.present ? "present" : "not present",
 		   asd_ha->hw_prof.bios.present ? "build " : "not present",
-		   asd_ha->hw_prof.bios.bld);
+		   asd_ha->hw_prof.bios.bld,
+		   asd_ha->hw_prof.max_scbs);
+
+	aic94xx_sht.can_queue = asd_ha->hw_prof.max_scbs - ASD_FREE_SCBS;
+	shost->can_queue = aic94xx_sht.can_queue;
 
 	if (use_msi)
 		pci_enable_msi(asd_ha->pcidev);
