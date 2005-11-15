Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVKOHl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVKOHl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVKOHl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:41:58 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:7484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVKOHl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:41:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=j5CXmSD7JzYW/Yq2R5BVBkjAZmE8jBT0SSdussLCmvV+1uMQNOcoUCHrNtxgNp8TAdTQZJdtc3UjlNgkw9XLXpvj+3o4U9dyIXw9h959v8gQoD4ri14HEgpjF30Ej/1bOllVKu4KMqADUDDwvNF2bmprv+M69iTBc0eohJ3RGYU=
Date: Tue, 15 Nov 2005 16:41:48 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051115074148.GA17459@htj.dyndns.org>
References: <20051114195717.GA24373@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114195717.GA24373@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 02:57:17PM -0500, Jeff Garzik wrote:
> 
> I finally got ATAPI working on my x86-64 AHCI box.
> 
> Just checked the following changes into the 'upstream-fixes' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 

Hi, Jeff.

I've been trying to do about the same thing and here's my version
which only fixes error/sense handling.  This patch makes ahci's
eng_timeout act correctly w.r.t ATAPI sense requesting.  libata ATAPI
request sensing mechanism was not broken.  What's broken was AHCI's
eng_timeout handler.  And, yes, this problem disappears with request
sensing via active qc turn-around in your patch.

As I've written several times, I'm not a big fan of sense requesting
by turning around active qc.  For libata's EH to work any better,
handing-over failed commands to EH is necessary with or without
request sensing.  Hmm... It's true that the current implementation
used for ATAPI request sensing needs improvements.  Remember those
patches which implement generic failed command handover and perform
request sensing from EH with proper timeout and synchronization?

Ah.. also, I'm working on sil24 ATAPI support.  However, it seems that
I need to do a little bit more; unfortunately, I'm not sure which....
INQUIRY succeeds and then my drive fails the first TUR with SK 6h
(UNIT ATTENTION) which is probably due to previous phy reset.  Then,
my drive fails to repsond to following REQUEST SENSE.

With my patched AHCI, REQUEST SENSE works and after SK 06h and several
SK 02h's (NOT READY), it comes online and works okay.

As INQUIRY works okay, my hunch is that I'm not performing TUR
properly (that is ATAPI command with no data) and the drive locks up
after it.  I'll fool around with this more and report.

Thanks.


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 4e96ec5..2d13699 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -611,16 +611,18 @@ static void ahci_eng_timeout(struct ata_
 	struct ata_host_set *host_set = ap->host_set;
 	void __iomem *mmio = host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
+	if (ata_qc_atapi_timeout(qc))
+		goto out;
+
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (!qc) {
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
@@ -636,6 +638,9 @@ static void ahci_eng_timeout(struct ata_
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
+
+ out:
+	DPRINTK("LEAVE\n");
 }
 
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -660,8 +665,18 @@ static inline int ahci_host_intr(struct 
 
 	if (status & PORT_IRQ_FATAL) {
 		ahci_intr_error(ap, status);
-		if (qc)
-			ata_qc_complete(qc, AC_ERR_OTHER);
+		if (qc) {
+			unsigned int err;
+			if (status & PORT_IRQ_TF_ERR)
+				err = AC_ERR_DEV;
+			else if (status & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR))
+				err = AC_ERR_HOST_BUS;
+			else if (status & (PORT_IRQ_IF_ERR))
+				err = AC_ERR_ATA_BUS;
+			else
+				err = AC_ERR_OTHER;
+			ata_qc_complete(qc, err);
+		}
 	}
 
 	return 1;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f606bdd..1bf8479 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3421,6 +3421,33 @@ fsm_start:
 		goto fsm_start;
 }
 
+int ata_qc_atapi_timeout(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_host_set *host_set = ap->host_set;
+	struct ata_device *dev = qc->dev;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	unsigned long flags;
+
+	if (qc->dev->class != ATA_DEV_ATAPI || cmd == NULL)
+		return 0;
+
+	if (cmd->eh_eflags & SCSI_EH_CANCEL_CMD)
+		return 0;
+
+	/* finish completing original command */
+	spin_lock_irqsave(&host_set->lock, flags);
+	__ata_qc_complete(qc);
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	atapi_request_sense(ap, dev, cmd);
+
+	cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
+	scsi_finish_command(cmd);
+
+	return 1;
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -3444,31 +3471,13 @@ static void ata_qc_timeout(struct ata_qu
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
-	struct ata_device *dev = qc->dev;
 	u8 host_stat = 0, drv_stat;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
-	/* FIXME: doesn't this conflict with timeout handling? */
-	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
-		struct scsi_cmnd *cmd = qc->scsicmd;
-
-		if (!(cmd->eh_eflags & SCSI_EH_CANCEL_CMD)) {
-
-			/* finish completing original command */
-			spin_lock_irqsave(&host_set->lock, flags);
-			__ata_qc_complete(qc);
-			spin_unlock_irqrestore(&host_set->lock, flags);
-
-			atapi_request_sense(ap, dev, cmd);
-
-			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
-		}
-	}
+	if (ata_qc_atapi_timeout(qc))
+		goto out;
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 79b7e6f..a10be07 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -478,6 +478,7 @@ extern u8   ata_bmdma_status(struct ata_
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern void ata_eng_timeout(struct ata_port *ap);
+extern int ata_qc_atapi_timeout(struct ata_queued_cmd *qc);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
