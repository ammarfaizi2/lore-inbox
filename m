Return-Path: <linux-kernel-owner+w=401wt.eu-S1751890AbXARALS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbXARALS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 19:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbXARALS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 19:11:18 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25426 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbXARALR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 19:11:17 -0500
Date: Wed, 17 Jan 2007 18:09:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] sata_nv: cleanup ADMA error handling v2
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: jeff@garzik.org, AMartin@nvidia.com
Message-id: <45AEBAA3.20206@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------050806010503010606020406
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050806010503010606020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Should apply to -mm tree or current libata-dev git tree. This version
leaves out part of a change in the first version which in retrospect
should have been left alone.

---

This cleans up a few issues with the error handling in sata_nv in ADMA
mode to make it more consistent with other NCQ-capable drivers like ahci
and sata_sil24:

-When a command failed, we would effectively set AC_ERR_DEV on the
queued command always. In the case of NCQ commands this prevents libata
from doing a log page query to determine the details of the failed
command, since it thinks we've already analyzed. Just set flags in the
port ehi->err_mask, then freeze or abort and let libata figure out what
went wrong.

-The code handled NV_ADMA_STAT_CPBERR as a "really bad error" which
caused it to set error flags on every queued command. I don't know
exactly what this flag means (no docs, grr!) but from what I can guess
from the standard ADMA spec, it just means that one or more of the CPBs
had an error, so we just need to go through and do our normal checks in
this case.

-In the error_handler function the code would always dump the state of
all the CPBs. This output seems redundant at this point since libata
already dumps the state of all active commands on errors (and it also
triggers at times when it shouldn't, like when suspending). Take this
out.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>


--------------050806010503010606020406
Content-Type: text/plain;
 name="sata_nv-cleanup-error-handling-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv-cleanup-error-handling-v2.patch"

--- linux-2.6.20-rc5/drivers/ata/sata_nv.c	2007-01-12 23:18:08.000000000 -0600
+++ linux-2.6.20-rc5edit/drivers/ata/sata_nv.c	2007-01-17 17:22:05.000000000 -0600
@@ -646,53 +646,64 @@ static unsigned int nv_adma_tf_to_cpb(st
 	return idx;
 }
 
-static void nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
+static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
-	int complete = 0, have_err = 0;
 	u8 flags = pp->cpb[cpb_num].resp_flags;
 
 	VPRINTK("CPB %d, flags=0x%x\n", cpb_num, flags);
 
-	if (flags & NV_CPB_RESP_DONE) {
-		VPRINTK("CPB flags done, flags=0x%x\n", flags);
-		complete = 1;
-	}
-	if (flags & NV_CPB_RESP_ATA_ERR) {
-		ata_port_printk(ap, KERN_ERR, "CPB flags ATA err, flags=0x%x\n", flags);
-		have_err = 1;
-		complete = 1;
-	}
-	if (flags & NV_CPB_RESP_CMD_ERR) {
-		ata_port_printk(ap, KERN_ERR, "CPB flags CMD err, flags=0x%x\n", flags);
-		have_err = 1;
-		complete = 1;
-	}
-	if (flags & NV_CPB_RESP_CPB_ERR) {
-		ata_port_printk(ap, KERN_ERR, "CPB flags CPB err, flags=0x%x\n", flags);
-		have_err = 1;
-		complete = 1;
+	if(unlikely((force_err ||
+		     flags & (NV_CPB_RESP_ATA_ERR |
+			      NV_CPB_RESP_CMD_ERR |
+			      NV_CPB_RESP_CPB_ERR)))) {
+		struct ata_eh_info *ehi = &ap->eh_info;
+		int freeze = 0;
+		ata_ehi_clear_desc(ehi);
+		ata_ehi_push_desc(ehi, "CPB resp_flags 0x%x", flags );
+		if(flags & NV_CPB_RESP_ATA_ERR) {
+			ata_ehi_push_desc(ehi, ": ATA error");
+			ehi->err_mask |= AC_ERR_DEV;
+		}
+		else if(flags & NV_CPB_RESP_CMD_ERR) {
+			ata_ehi_push_desc(ehi, ": CMD error");
+			ehi->err_mask |= AC_ERR_DEV;
+		}
+		else if(flags & NV_CPB_RESP_CPB_ERR) {
+			ata_ehi_push_desc(ehi, ": CPB error");
+			ehi->err_mask |= AC_ERR_SYSTEM;
+			freeze = 1;
+		}
+		else {
+			/* notifier error, but no error in CPB flags? */
+			ehi->err_mask |= AC_ERR_OTHER;
+			freeze = 1;
+		}
+		/* Kill all commands. EH will determine what actually failed. */
+		if(freeze)
+			ata_port_freeze(ap);
+		else
+			ata_port_abort(ap);
+		return 1;
 	}
-	if(complete || force_err)
-	{
+		
+	if (flags & NV_CPB_RESP_DONE) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, cpb_num);
+		VPRINTK("CPB flags done, flags=0x%x\n", flags);
 		if(likely(qc)) {
-			u8 ata_status = 0;
-			/* Only use the ATA port status for non-NCQ commands.
+			/* Grab the ATA port status for non-NCQ commands.
 			   For NCQ commands the current status may have nothing to do with
 			   the command just completed. */
-			if(qc->tf.protocol != ATA_PROT_NCQ)
-				ata_status = readb(pp->ctl_block + (ATA_REG_STATUS * 4));
-
-			if(have_err || force_err)
-				ata_status |= ATA_ERR;
-
-			qc->err_mask |= ac_err_mask(ata_status);
+			if(qc->tf.protocol != ATA_PROT_NCQ) {
+				u8 ata_status = readb(pp->ctl_block + (ATA_REG_STATUS * 4));
+				qc->err_mask |= ac_err_mask(ata_status);
+			}
 			DPRINTK("Completing qc from tag %d with err_mask %u\n",cpb_num,
 				qc->err_mask);
 			ata_qc_complete(qc);
 		}
 	}
+	return 0;
 }
 
 static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
@@ -743,7 +754,6 @@ static irqreturn_t nv_adma_interrupt(int
 			void __iomem *mmio = pp->ctl_block;
 			u16 status;
 			u32 gen_ctl;
-			int have_global_err = 0;
 			u32 notifier, notifier_error;
 
 			/* if in ATA register mode, use standard ata interrupt handler */
@@ -774,42 +784,50 @@ static irqreturn_t nv_adma_interrupt(int
 			readw(mmio + NV_ADMA_STAT); /* flush posted write */
 			rmb();
 
-			/* freeze if hotplugged */
-			if (unlikely(status & (NV_ADMA_STAT_HOTPLUG | NV_ADMA_STAT_HOTUNPLUG))) {
-				ata_port_printk(ap, KERN_NOTICE, "Hotplug event, freezing\n");
+			handled++; /* irq handled if we got here */
+
+			/* freeze if hotplugged or controller error */
+			if (unlikely(status & (NV_ADMA_STAT_HOTPLUG |
+					       NV_ADMA_STAT_HOTUNPLUG |
+					       NV_ADMA_STAT_TIMEOUT))) {
+				struct ata_eh_info *ehi = &ap->eh_info;
+				ata_ehi_clear_desc(ehi);
+				ata_ehi_push_desc(ehi, "ADMA status 0x%08x", status );
+				if(status & NV_ADMA_STAT_TIMEOUT) {
+					ehi->err_mask |= AC_ERR_SYSTEM;
+					ata_ehi_push_desc(ehi, ": timeout");
+				}
+				else if(status & NV_ADMA_STAT_HOTPLUG) {
+					ata_ehi_hotplugged(ehi);
+					ata_ehi_push_desc(ehi, ": hotplug");
+				}
+				else if(status & NV_ADMA_STAT_HOTUNPLUG) {
+					ata_ehi_hotplugged(ehi);
+					ata_ehi_push_desc(ehi, ": hot unplug");
+				}
 				ata_port_freeze(ap);
-				handled++;
 				continue;
 			}
 
-			if (status & NV_ADMA_STAT_TIMEOUT) {
-				ata_port_printk(ap, KERN_ERR, "timeout, stat=0x%x\n", status);
-				have_global_err = 1;
-			}
-			if (status & NV_ADMA_STAT_CPBERR) {
-				ata_port_printk(ap, KERN_ERR, "CPB error, stat=0x%x\n", status);
-				have_global_err = 1;
-			}
-			if ((status & NV_ADMA_STAT_DONE) || have_global_err) {
+			if (status & (NV_ADMA_STAT_DONE |
+				      NV_ADMA_STAT_CPBERR)) {
 				/** Check CPBs for completed commands */
 
 				if(ata_tag_valid(ap->active_tag))
 					/* Non-NCQ command */
-					nv_adma_check_cpb(ap, ap->active_tag, have_global_err ||
-						(notifier_error & (1 << ap->active_tag)));
+					nv_adma_check_cpb(ap, ap->active_tag, 
+						notifier_error & (1 << ap->active_tag));
 				else {
-					int pos;
+					int pos, error = 0;
 					u32 active = ap->sactive;
-					while( (pos = ffs(active)) ) {
+					while( (pos = ffs(active)) && !error) {
 						pos--;
-						nv_adma_check_cpb(ap, pos, have_global_err ||
-							(notifier_error & (1 << pos)) );
+						error = nv_adma_check_cpb(ap, pos,
+							notifier_error & (1 << pos) );
 						active &= ~(1 << pos );
 					}
 				}
 			}
-
-			handled++; /* irq handled if we got here */
 		}
 	}
 	
@@ -1387,28 +1405,9 @@ static void nv_adma_error_handler(struct
 		int i;
 		u16 tmp;
 
-		u32 notifier = readl(mmio + NV_ADMA_NOTIFIER);
-		u32 notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
-		u32 gen_ctl = readl(pp->gen_block + NV_ADMA_GEN_CTL);
-		u32 status = readw(mmio + NV_ADMA_STAT);
-
-		ata_port_printk(ap, KERN_ERR, "EH in ADMA mode, notifier 0x%X "
-			"notifier_error 0x%X gen_ctl 0x%X status 0x%X\n",
-			notifier, notifier_error, gen_ctl, status);
-
-		for( i=0;i<NV_ADMA_MAX_CPBS;i++) {
-			struct nv_adma_cpb *cpb = &pp->cpb[i];
-			if( cpb->ctl_flags || cpb->resp_flags )
-				ata_port_printk(ap, KERN_ERR,
-					"CPB %d: ctl_flags 0x%x, resp_flags 0x%x\n",
-					i, cpb->ctl_flags, cpb->resp_flags);
-		}
-
 		/* Push us back into port register mode for error handling. */
 		nv_adma_register_mode(ap);
 
-		ata_port_printk(ap, KERN_ERR, "Resetting port\n");
-
 		/* Mark all of the CPBs as invalid to prevent them from being executed */
 		for( i=0;i<NV_ADMA_MAX_CPBS;i++)
 			pp->cpb[i].ctl_flags &= ~NV_CPB_CTL_CPB_VALID;


--------------050806010503010606020406--

