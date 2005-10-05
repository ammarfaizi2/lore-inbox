Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVJERE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVJERE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVJERE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:04:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:6106 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030262AbVJERE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:04:57 -0400
Message-ID: <434407A2.6010605@pobox.com>
Date: Wed, 05 Oct 2005 13:04:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeny Rodichev <er@sai.msu.su>, Brett Russ <russb@emc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode) (resend:
 v0.22)
References: <20050930053600.F3B821CDD0@lns1058.lss.emc.com> <4341E420.6070808@pobox.com> <Pine.GSO.4.63.0510051912230.10241@ra.sai.msu.su>
In-Reply-To: <Pine.GSO.4.63.0510051912230.10241@ra.sai.msu.su>
Content-Type: multipart/mixed;
 boundary="------------080008000100000608050309"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008000100000608050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Evgeny Rodichev wrote:
> On Mon, 3 Oct 2005, Jeff Garzik wrote:
> 
>> applied
>>
> 
> This patch leads to freeze with Marvell MV88SX6041 4-port SATA II PCI-X 
> Controller (rev 03), as I wrote already
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0510.0/0203.html)
> 
> It is impossible to reboot the system without  harware reset (after 
> modprobe).

I'm betting a temporary workaround should be to disable CONFIG_SMP.

The first attached patch (patch.1) fixes one of the lockups.  The second 
attached patch (patch.2) should fix all the lockups, but that's just a 
guess, and it's a very ugly patch.

Note that patch.2 depends on patch.1.

	Jeff



--------------080008000100000608050309
Content-Type: text/plain;
 name="patch.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.1"

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -409,14 +409,8 @@ static void mv_irq_clear(struct ata_port
 static void mv_start_dma(void __iomem *base, struct mv_port_priv *pp,
 			 struct ata_port *ap)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	
 	writelfl(EDMA_EN, base + EDMA_CMD_OFS);
 	pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
 static void mv_stop_dma(struct ata_port *ap)

--------------080008000100000608050309
Content-Type: text/plain;
 name="patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.2"

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -413,16 +413,13 @@ static void mv_start_dma(void __iomem *b
 	pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 }
 
-static void mv_stop_dma(struct ata_port *ap)
+static void __mv_stop_dma(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp	= ap->private_data;
-	unsigned long flags;
 	u32 reg;
 	int i;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	
 	if (!(MV_PP_FLAG_EDMA_DS_ACT & pp->pp_flags) &&
 	    ((MV_PP_FLAG_EDMA_EN & pp->pp_flags) ||
 	     (EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)))) {
@@ -433,7 +430,6 @@ static void mv_stop_dma(struct ata_port 
 		writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 	}
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	
 	/* now properly wait for the eDMA to stop */
 	for (i = 1000; i > 0; i--) {
@@ -444,15 +440,22 @@ static void mv_stop_dma(struct ata_port 
 		udelay(100);
 	}
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
 	pp->pp_flags &= ~MV_PP_FLAG_EDMA_DS_ACT;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (EDMA_EN & reg) {
 		printk(KERN_ERR "ata%u: Unable to stop eDMA\n", ap->id);
 	}
 }
 
+static void mv_stop_dma(struct ata_port *ap)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	__mv_stop_dma(ap);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
 static void mv_dump_mem(void __iomem *start, unsigned bytes)
 {
 #ifdef ATA_DEBUG
@@ -845,7 +848,7 @@ static int mv_qc_issue(struct ata_queued
 		 * port.  Turn off EDMA so there won't be problems accessing
 		 * shadow block, etc registers.
 		 */
-		mv_stop_dma(qc->ap);
+		__mv_stop_dma(qc->ap);
 		return ata_qc_issue_prot(qc);
 	}
 

--------------080008000100000608050309--
