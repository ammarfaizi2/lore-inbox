Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVH3Vwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVH3Vwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVH3Vwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:52:35 -0400
Received: from havoc.gtf.org ([69.61.125.42]:50897 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932487AbVH3Vwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:52:35 -0400
Date: Tue, 30 Aug 2005 17:52:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata: add ATAPI module option
Message-ID: <20050830215234.GA6991@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Though DMA alignment, CDB interrupt, DMADIR, and PIO support issues
keep libata's ATAPI support turned off by default, as of 2.6.13-git1
PATA users with non-ancient CDROM and DVD drives can start testing
the ATAPI code.

I just checked the following patch into the 'upstream' branch of
libata-dev.git, to be sent to Linus in a few days.

To emphasize, however: DO NOT use libata ATAPI in a production setting.



 [libata] allow ATAPI to be enabled with new atapi_enabled module option
    
 ATAPI is getting close to being ready.  To increase exposure, we enable
 the code in the upstream kernel, but default it to off (present
 behavior).  Users must pass atapi_enabled=1 as a module option (if
 module) or on the kernel command line (if built in) to turn on
 discovery of their ATAPI devices.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -75,6 +75,10 @@ static void __ata_qc_complete(struct ata
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+int atapi_enabled = 0;
+module_param(atapi_enabled, int, 0444);
+MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1470,10 +1470,10 @@ ata_scsi_find_dev(struct ata_port *ap, s
 	if (unlikely(!ata_dev_present(dev)))
 		return NULL;
 
-#ifndef ATA_ENABLE_ATAPI
-	if (unlikely(dev->class == ATA_DEV_ATAPI))
-		return NULL;
-#endif
+	if (atapi_enabled) {
+		if (unlikely(dev->class == ATA_DEV_ATAPI))
+			return NULL;
+	}
 
 	return dev;
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -38,6 +38,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern int atapi_enabled;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -40,7 +40,6 @@
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
 #undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
