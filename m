Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWDJSur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDJSur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWDJSur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:50:47 -0400
Received: from havoc.gtf.org ([69.61.125.42]:44467 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932090AbWDJSup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:50:45 -0400
Date: Mon, 10 Apr 2006 14:50:39 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [git patch] libata scsi eh fixed to use transport class
Message-ID: <20060410185039.GA32027@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch was submitted before the merge window closed, and acked by
both James and myself.  It was supposed to be merged into a shared
repository with just this patch in this, and pushed upstream, but James
disappeared, then a couple days later the merge window closed.

libata is the _only_ user of ->eh_strategy_handler(), and you could even
justify this as an API fix, since eh_strategy_handler() belonged in the
transport class (presented here) rather than listed in each low-level
driver.  You can see this clearly from the one-line deletion in each
low-level driver, and the two-line addition in libata core.


Please pull from 'scsi-eh' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to receive the following updates:

 Documentation/DocBook/libata.tmpl       |    2 +-
 Documentation/scsi/scsi_eh.txt          |   14 +++++++-------
 Documentation/scsi/scsi_mid_low_api.txt |   19 -------------------
 drivers/scsi/ahci.c                     |    1 -
 drivers/scsi/ata_piix.c                 |    1 -
 drivers/scsi/hosts.c                    |   12 ------------
 drivers/scsi/libata-core.c              |    1 -
 drivers/scsi/libata-scsi.c              |    8 +++-----
 drivers/scsi/libata.h                   |    1 -
 drivers/scsi/pdc_adma.c                 |    1 -
 drivers/scsi/sata_mv.c                  |    2 --
 drivers/scsi/sata_nv.c                  |    1 -
 drivers/scsi/sata_promise.c             |    1 -
 drivers/scsi/sata_qstor.c               |    1 -
 drivers/scsi/sata_sil.c                 |    1 -
 drivers/scsi/sata_sil24.c               |    1 -
 drivers/scsi/sata_sis.c                 |    1 -
 drivers/scsi/sata_svw.c                 |    1 -
 drivers/scsi/sata_sx4.c                 |    1 -
 drivers/scsi/sata_uli.c                 |    1 -
 drivers/scsi/sata_via.c                 |    1 -
 drivers/scsi/sata_vsc.c                 |    1 -
 drivers/scsi/scsi_error.c               |    4 ++--
 include/linux/libata.h                  |    1 -
 include/scsi/scsi_host.h                |    1 -
 include/scsi/scsi_transport.h           |    5 +++++
 26 files changed, 18 insertions(+), 66 deletions(-)

Christoph Hellwig:
      move ->eh_strategy_handler to the transport class

diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
index 5bcbb6e..f869b03 100644
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -705,7 +705,7 @@ and other resources, etc.
 
 	<sect1><title>ata_scsi_error()</title>
 	<para>
-	ata_scsi_error() is the current hostt->eh_strategy_handler()
+	ata_scsi_error() is the current transportt->eh_strategy_handler()
 	for libata.  As discussed above, this will be entered in two
 	cases - timeout and ATAPI error completion.  This function
 	calls low level libata driver's eng_timeout() callback, the
diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
index 331afd7..ce767b9 100644
--- a/Documentation/scsi/scsi_eh.txt
+++ b/Documentation/scsi/scsi_eh.txt
@@ -19,9 +19,9 @@ TABLE OF CONTENTS
 	[2-1-1] Overview
 	[2-1-2] Flow of scmds through EH
 	[2-1-3] Flow of control
-    [2-2] EH through hostt->eh_strategy_handler()
-	[2-2-1] Pre hostt->eh_strategy_handler() SCSI midlayer conditions
-	[2-2-2] Post hostt->eh_strategy_handler() SCSI midlayer conditions
+    [2-2] EH through transportt->eh_strategy_handler()
+	[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
+	[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
 	[2-2-3] Things to consider
 
 
@@ -413,9 +413,9 @@ scmd->allowed.
 	    layer of failure of the scmds.
 
 
-[2-2] EH through hostt->eh_strategy_handler()
+[2-2] EH through transportt->eh_strategy_handler()
 
- hostt->eh_strategy_handler() is invoked in the place of
+ transportt->eh_strategy_handler() is invoked in the place of
 scsi_unjam_host() and it is responsible for whole recovery process.
 On completion, the handler should have made lower layers forget about
 all failed scmds and either ready for new commands or offline.  Also,
@@ -424,7 +424,7 @@ SCSI midlayer.  IOW, of the steps descri
 except for #1 must be implemented by eh_strategy_handler().
 
 
-[2-2-1] Pre hostt->eh_strategy_handler() SCSI midlayer conditions
+[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
 
  The following conditions are true on entry to the handler.
 
@@ -437,7 +437,7 @@ except for #1 must be implemented by eh_
  - shost->host_failed == shost->host_busy
 
 
-[2-2-2] Post hostt->eh_strategy_handler() SCSI midlayer conditions
+[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
 
  The following conditions must be true on exit from the handler.
 
diff --git a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
index 8bbae3e..75a535a 100644
--- a/Documentation/scsi/scsi_mid_low_api.txt
+++ b/Documentation/scsi/scsi_mid_low_api.txt
@@ -804,7 +804,6 @@ Summary:
    eh_bus_reset_handler - issue SCSI bus reset
    eh_device_reset_handler - issue SCSI device reset
    eh_host_reset_handler - reset host (host bus adapter)
-   eh_strategy_handler - driver supplied alternate to scsi_unjam_host()
    info - supply information about given host
    ioctl - driver can respond to ioctls
    proc_info - supports /proc/scsi/{driver_name}/{host_no}
@@ -970,24 +969,6 @@ Details:
 
 
 /**
- *      eh_strategy_handler - driver supplied alternate to scsi_unjam_host()
- *      @shp: host on which error has occurred
- *
- *      Returns TRUE if host unjammed, else FALSE.
- *
- *      Locks: none
- *
- *      Calling context: kernel thread
- *
- *      Notes: Invoked from scsi_eh thread. LLD supplied alternate to 
- *      scsi_unjam_host() found in scsi_error.c
- *
- *      Optionally defined in: LLD
- **/
-     int eh_strategy_handler(struct Scsi_Host * shp)
-
-
-/**
  *      info - supply information about given host: driver name plus data
  *             to distinguish given host
  *      @shp: host to supply information about
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1bd82c4..b4f8fb1 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -207,7 +207,6 @@ static struct scsi_host_template ahci_sh
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 24e71b5..6dc8814 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -209,7 +209,6 @@ static struct scsi_host_template piix_sh
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ef57f25..dfcb96f 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -294,18 +294,6 @@ struct Scsi_Host *scsi_host_alloc(struct
 	if (sht->unchecked_isa_dma && privsize)
 		gfp_mask |= __GFP_DMA;
 
-        /* Check to see if this host has any error handling facilities */
-        if (!sht->eh_strategy_handler && !sht->eh_abort_handler &&
-	    !sht->eh_device_reset_handler && !sht->eh_bus_reset_handler &&
-            !sht->eh_host_reset_handler) {
-		printk(KERN_ERR "ERROR: SCSI host `%s' has no error handling\n"
-				"ERROR: This is not a safe way to run your "
-				        "SCSI host\n"
-				"ERROR: The error handling must be added to "
-				"this driver\n", sht->proc_name);
-		dump_stack();
-        }
-
 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
 	if (!shost)
 		return NULL;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e63c1ff..bd14720 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4938,7 +4938,6 @@ EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
-EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 53f5b0d..a0289ec 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -53,6 +53,7 @@
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev);
+static void ata_scsi_error(struct Scsi_Host *host);
 enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 
 #define RW_RECOVERY_MPAGE 0x1
@@ -99,6 +100,7 @@ static const u8 def_control_mpage[CONTRO
  * It just needs the eh_timed_out hook.
  */
 struct scsi_transport_template ata_scsi_transport_template = {
+	.eh_strategy_handler	= ata_scsi_error,
 	.eh_timed_out		= ata_scsi_timed_out,
 };
 
@@ -772,12 +774,9 @@ enum scsi_eh_timer_return ata_scsi_timed
  *
  *	LOCKING:
  *	Inherited from SCSI layer (none, can sleep)
- *
- *	RETURNS:
- *	Zero.
  */
 
-int ata_scsi_error(struct Scsi_Host *host)
+static void ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap;
 	unsigned long flags;
@@ -805,7 +804,6 @@ int ata_scsi_error(struct Scsi_Host *hos
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	DPRINTK("EXIT\n");
-	return 0;
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 1c755b1..bac8cba 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -60,7 +60,6 @@ extern int ata_cmd_ioctl(struct scsi_dev
 extern struct scsi_transport_template ata_scsi_transport_template;
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
-extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 3c85c4b..5cda16c 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -143,7 +143,6 @@ static struct scsi_host_template adma_at
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index fa901fd..0ebf136 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -378,8 +378,6 @@ static struct scsi_host_template mv_sht 
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
-	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index f77bf18..9f55308 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -201,7 +201,6 @@ static struct scsi_host_template nv_sht 
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index cc928c6..7eb67a6 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -111,7 +111,6 @@ static struct scsi_host_template pdc_ata
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 9ffe1ef..886f344 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -132,7 +132,6 @@ static struct scsi_host_template qs_ata_
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= QS_MAX_PRD,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 18c296c..1066272 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -146,7 +146,6 @@ static struct scsi_host_template sil_sht
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 068c98a..f7264fd 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -281,7 +281,6 @@ static struct scsi_host_template sil24_s
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index acc8439..728530d 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -87,7 +87,6 @@ static struct scsi_host_template sis_sht
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= ATA_MAX_PRD,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 724f0ed..53b0d5c 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -290,7 +290,6 @@ static struct scsi_host_template k2_sata
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index ae70f60..4139ad4 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -182,7 +182,6 @@ static struct scsi_host_template pdc_sat
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 7ac5a5f..38b52bd 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -81,7 +81,6 @@ static struct scsi_host_template uli_sht
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 791bf65..9e7ae4e 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -94,7 +94,6 @@ static struct scsi_host_template svia_sh
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 836bbbb..8a29ce3 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -263,7 +263,6 @@ static struct scsi_host_template vsc_sat
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 5f0fdfb..1c75646 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1537,8 +1537,8 @@ int scsi_error_handler(void *data)
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (shost->hostt->eh_strategy_handler) 
-			shost->hostt->eh_strategy_handler(shost);
+		if (shost->transportt->eh_strategy_handler)
+			shost->transportt->eh_strategy_handler(shost);
 		else
 			scsi_unjam_host(shost);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0d61357..b80d2e7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -523,7 +523,6 @@ extern void ata_host_set_remove(struct a
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern int ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern int ata_scsi_release(struct Scsi_Host *host);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index dc6862d..de6ce54 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -140,7 +140,6 @@ struct scsi_host_template {
 	 *
 	 * Status: REQUIRED	(at least one of them)
 	 */
-	int (* eh_strategy_handler)(struct Scsi_Host *);
 	int (* eh_abort_handler)(struct scsi_cmnd *);
 	int (* eh_device_reset_handler)(struct scsi_cmnd *);
 	int (* eh_bus_reset_handler)(struct scsi_cmnd *);
diff --git a/include/scsi/scsi_transport.h b/include/scsi/scsi_transport.h
index b3657f1..cca1d49 100644
--- a/include/scsi/scsi_transport.h
+++ b/include/scsi/scsi_transport.h
@@ -50,6 +50,11 @@ struct scsi_transport_template {
 	unsigned int create_work_queue : 1;
 
 	/*
+	 * Allows a transport to override the default error handler.
+	 */
+	void (* eh_strategy_handler)(struct Scsi_Host *);
+
+	/*
 	 * This is an optional routine that allows the transport to become
 	 * involved when a scsi io timer fires. The return value tells the
 	 * timer routine how to finish the io timeout handling:
