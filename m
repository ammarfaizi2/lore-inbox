Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272693AbRIGO5q>; Fri, 7 Sep 2001 10:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272694AbRIGO5h>; Fri, 7 Sep 2001 10:57:37 -0400
Received: from host194.steeleye.com ([216.33.1.194]:53764 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S272693AbRIGO5G>; Fri, 7 Sep 2001 10:57:06 -0400
Message-Id: <200109071457.f87EuqZ01619@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: alan@lxorguk.ukuu.org.uk (Alan Cox), Keith Owens <kaos@ocs.com.au>,
        Rasmus Andersen <rasmus@jaquet.dk>,
        Richard Hirst <rhirst@linuxcare.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 53c700 SCSI driver (for NCRD700 MCA and HPPA lasi)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-2810631070"
Date: Fri, 07 Sep 2001 09:56:52 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-2810631070
Content-Type: text/plain; charset=us-ascii

Hi Alan,

A while ago (14 May) you asked Richard Hirst and I to come to agreement over 
our two drivers for the 53c700 chip.  We've now agreed that I'll maintain both 
the NCR Dual 700 microchannel SCSI card and the PARISC LASI SCSI interface 
which Richard was previously writing.  We've spent most of the last 3+ months 
getting the internals of the core driver to work on the PARISC.

The driver works well on the Dual 700 (I now trust it to be the root filesys 
driver for my voyager system), but it is still rather dangerous on the PARISC 
since we believe there are still lurking memory coherency issues.  Linuxcare 
is shipping me some HP equipment which will hopefully allow me to knock the 
remaining kinks out of the lasi driver.

The changes in this patch are

- Apply the patches suggested by Rasmus Andersen, Keith Owens and others.
- Add the lasi700 driver for PARISC.
- Make the 53c700 core memory mapped as well as io mapped.
- Make the driver endian neutral (to drive the chip little endian on a BE 
arch).
- Add memory coherency instructions.

Any comments will be gratefully received (especially any about missing/needed 
memory coherency instructions).

James Bottomley


--==_Exmh_-2810631070
Content-Type: text/plain ; name="ncr700-2.3.diff"; charset=us-ascii
Content-Description: ncr700-2.3.diff
Content-Disposition: attachment; filename="ncr700-2.3.diff"

Index: linux/2.4/MAINTAINERS
diff -u linux/2.4/MAINTAINERS:1.1.1.23 linux/2.4/MAINTAINERS:1.1.1.23.2.1
--- linux/2.4/MAINTAINERS:1.1.1.23	Sat Sep  1 20:49:53 2001
+++ linux/2.4/MAINTAINERS	Sun Sep  2 22:18:29 2001
@@ -843,6 +843,12 @@
 L:	linux-x25@vger.kernel.org
 S:	Maintained
 
+LASI 53c700 driver for PARISC
+P:	James E.J. Bottomley
+M:	James.Bottomley@HansenPartnership.com
+L:	linux-scsi@vger.kernel.org
+S:	Maintained
+
 LINUX FOR IBM pSERIES (RS/6000)
 P:	Paul Mackerras
 M:	paulus@au.ibm.com
Index: linux/2.4/drivers/scsi/53c700.c
diff -u linux/2.4/drivers/scsi/53c700.c:1.1.1.2 linux/2.4/drivers/scsi/53c700.c:1.1.1.2.2.4
--- linux/2.4/drivers/scsi/53c700.c:1.1.1.2	Sat Sep  1 21:03:09 2001
+++ linux/2.4/drivers/scsi/53c700.c	Tue Sep  4 10:07:45 2001
@@ -51,12 +51,33 @@
 
 /* CHANGELOG
  *
+ * Version 2.3
+ *
+ * More endianness/cache coherency changes.
+ *
+ * Better bad device handling (handles devices lying about tag
+ * queueing support and devices which fail to provide sense data on
+ * contingent allegiance conditions)
+ *
+ * Many thanks to Richard Hirst <rhirst@linuxcare.com> for patiently
+ * debugging this driver on the parisc architecture and suggesting
+ * many improvements and bug fixes.
+ *
+ * Thanks also go to Linuxcare Inc. for providing several PARISC
+ * machines for me to debug the driver on.
+ *
+ * Version 2.2
+ *
+ * Made the driver mem or io mapped; added endian invariance; added
+ * dma cache flushing operations for architectures which need it;
+ * added support for more varied clocking speeds.
+ *
  * Version 2.1
  *
  * Initial modularisation from the D700.  See NCR_D700.c for the rest of
  * the changelog.
  * */
-#define NCR_700_VERSION "2.1"
+#define NCR_700_VERSION "2.3"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -92,6 +113,7 @@
 
 MODULE_AUTHOR("James Bottomley");
 MODULE_DESCRIPTION("53c700 and 53c700-66 Driver");
+MODULE_LICENSE("GPL");
 
 /* This is the script */
 #include "53c700_d.h"
@@ -198,7 +220,8 @@
 		tpnt->proc_name = "53c700";
 	
 
-	host = scsi_register(tpnt, 4);
+	if((host = scsi_register(tpnt, 4)) == NULL)
+		return NULL;
 	if(script == NULL) {
 		printk(KERN_ERR "53c700: Failed to allocate script, detatching\n");
 		scsi_unregister(host);
@@ -220,12 +243,14 @@
 		hostdata->slots[j].state = NCR_700_SLOT_FREE;
 	}
 	host->hostdata[0] = (__u32)hostdata;
-	memcpy(script, SCRIPT, sizeof(SCRIPT));
+	for(j = 0; j < sizeof(SCRIPT)/sizeof(SCRIPT[0]); j++) {
+		script[j] = bS_to_host(SCRIPT[j]);
+	}
 	/* bus physical address of script */
 	pScript = virt_to_bus(script);
 	/* adjust all labels to be bus physical */
 	for(j = 0; j < PATCHES; j++) {
-		script[LABELPATCHES[j]] += pScript;
+		script[LABELPATCHES[j]] = bS_to_host(pScript + SCRIPT[LABELPATCHES[j]]);
 	}
 	/* now patch up fixed addresses */
 	script_patch_32(script, MessageLocation,
@@ -233,8 +258,9 @@
 	script_patch_32(script, StatusAddress,
 			virt_to_bus(&hostdata->status));
 	script_patch_32(script, ReceiveMsgAddress,
-			virt_to_bus(&hostdata->msgin[0]))
-		hostdata->script = script;
+			virt_to_bus(&hostdata->msgin[0]));
+
+	hostdata->script = script;
 	hostdata->pScript = pScript;
 	hostdata->state = NCR_700_HOST_FREE;
 	spin_lock_init(&hostdata->lock);
@@ -245,9 +271,9 @@
 	host->base = hostdata->base;
 	host->hostdata[0] = (unsigned long)hostdata;
 	/* kick the chip */
-	outb(0xff, host->base + CTEST9_REG);
-	hostdata->rev = (inb(host->base + CTEST7_REG)<<4) & 0x0f;
-	hostdata->fast = (inb(host->base + CTEST9_REG) == 0);
+	NCR_700_writeb(0xff, host, CTEST9_REG);
+	hostdata->rev = (NCR_700_readb(host, CTEST7_REG)<<4) & 0x0f;
+	hostdata->fast = (NCR_700_readb(host, CTEST9_REG) == 0);
 	if(banner == 0) {
 		printk(KERN_NOTICE "53c700: Version " NCR_700_VERSION " By James.Bottomley@HansenPartnership.com\n");
 		banner = 1;
@@ -258,7 +284,7 @@
 	       "(Differential)" : "");
 	/* reset the chip */
 	NCR_700_chip_reset(host);
-	outb(ASYNC_OPERATION , host->base + SXFER_REG);
+	NCR_700_writeb(ASYNC_OPERATION , host, SXFER_REG);
 
 	return host;
 }
@@ -295,25 +321,25 @@
 NCR_700_data_residual (struct Scsi_Host *host) {
 	int count, synchronous;
 	unsigned int ddir;
-	
-	count = ((inb(host->base + DFIFO_REG) & 0x3f) -
-		 (inl(host->base + DBC_REG) & 0x3f)) & 0x3f;
+
+	count = ((NCR_700_readb(host, DFIFO_REG) & 0x3f) -
+		 (NCR_700_readl(host, DBC_REG) & 0x3f)) & 0x3f;
 	
-	synchronous = inb(host->base + SXFER_REG) & 0x0f;
+	synchronous = NCR_700_readb(host, SXFER_REG) & 0x0f;
 	
 	/* get the data direction */
-	ddir = inb(host->base + CTEST0_REG) & 0x01;
+	ddir = NCR_700_readb(host, CTEST0_REG) & 0x01;
 
 	if (ddir) {
 		/* Receive */
 		if (synchronous) 
-			count += (inb(host->base + SSTAT2_REG) & 0xf0) >> 4;
+			count += (NCR_700_readb(host, SSTAT2_REG) & 0xf0) >> 4;
 		else
-			if (inb(host->base + SSTAT1_REG) & SIDL_REG_FULL)
+			if (NCR_700_readb(host, SSTAT1_REG) & SIDL_REG_FULL)
 				++count;
 	} else {
 		/* Send */
-		__u8 sstat = inb(host->base + SSTAT1_REG);
+		__u8 sstat = NCR_700_readb(host, SSTAT1_REG);
 		if (sstat & SODL_REG_FULL)
 			++count;
 		if (synchronous && (sstat & SODR_REG_FULL))
@@ -390,10 +416,10 @@
 
 
 	if((slot->state & NCR_700_SLOT_MASK) != NCR_700_SLOT_MAGIC) {
-		printk(" SLOT %p is not MAGIC!!!\n", slot);
+		printk(KERN_ERR "53c700: SLOT %p is not MAGIC!!!\n", slot);
 	}
 	if(slot->state == NCR_700_SLOT_FREE) {
-		printk(" SLOT %p is FREE!!!\n", slot);
+		printk(KERN_ERR "53c700: SLOT %p is FREE!!!\n", slot);
 	}
 	/* remove from queues */
 	if(slot->tag != NCR_700_NO_TAG) {
@@ -484,7 +510,7 @@
 
 		if(n != NULL && n->cmnd->target == pun && n->cmnd->lun == lun
 		   && n->tag == tag) {
-			printk("\n\n**WARNING: DUPLICATE tag %d\n",
+			printk(KERN_WARNING "53c700: WARNING: DUPLICATE tag %d\n",
 			       tag);
 		}
 	}
@@ -497,15 +523,19 @@
 /* This translates the SDTR message offset and period to a value
  * which can be loaded into the SXFER_REG.
  *
- * NOTE: According to SCSI-2, the true transfer period is actually 
- *       four times this period value (in ns) */
+ * NOTE: According to SCSI-2, the true transfer period (in ns) is
+ *       actually four times this period value */
 STATIC inline __u8
 NCR_700_offset_period_to_sxfer(struct NCR_700_Host_Parameters *hostdata,
 			       __u8 offset, __u8 period)
 {
 	int XFERP;
 
-	XFERP = (period*4 * hostdata->clock)/1000 - 4;
+	if(period*4 < NCR_700_MIN_PERIOD) {
+		printk(KERN_WARNING "53c700: Period %dns is less than SCSI-2 minimum, setting to %d\n", period*4, NCR_700_MIN_PERIOD);
+		period = NCR_700_MIN_PERIOD/4;
+	}
+	XFERP = (period*4 * hostdata->sync_clock)/1000 - 4;
 	if(offset > NCR_700_MAX_OFFSET) {
 		printk(KERN_WARNING "53c700: Offset %d exceeds maximum, setting to %d\n",
 		       offset, NCR_700_MAX_OFFSET);
@@ -552,7 +582,7 @@
 			       NCR_700_get_depth(SCp->device));
 		NCR_700_set_depth(SCp->device, NCR_700_get_depth(SCp->device) - 1);
 	} else {
-		printk(KERN_ERR "  SCSI DONE HAS NULL SCp\n");
+		printk(KERN_ERR "53c700: SCSI DONE HAS NULL SCp\n");
 	}
 }
 
@@ -561,9 +591,9 @@
 NCR_700_internal_bus_reset(struct Scsi_Host *host)
 {
 	/* Bus reset */
-	outb(ASSERT_RST, host->base + SCNTL1_REG);
+	NCR_700_writeb(ASSERT_RST, host, SCNTL1_REG);
 	udelay(50);
-	outb(0, host->base + SCNTL1_REG);
+	NCR_700_writeb(0, host, SCNTL1_REG);
 
 }
 
@@ -573,37 +603,63 @@
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 
-	outb(1 << host->this_id, host->base + SCID_REG);
-	outb(0, host->base + SBCL_REG);
-	outb(0, host->base + SXFER_REG);
-
-	outb(PHASE_MM_INT | SEL_TIMEOUT_INT | GROSS_ERR_INT | UX_DISC_INT
-	     | RST_INT | PAR_ERR_INT | SELECT_INT, host->base + SIEN_REG);
-
-	outb(ABORT_INT | INT_INST_INT | ILGL_INST_INT, host->base + DIEN_REG);
-	outb(BURST_LENGTH_8, host->base + DMODE_REG);
-	outb(FULL_ARBITRATION | PARITY | AUTO_ATN, host->base + SCNTL0_REG);
-	outb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION|GENERATE_RECEIVE_PARITY,
-	     host->base + CTEST8_REG);
-	outb(ENABLE_SELECT, host->base + SCNTL1_REG);
-	if(hostdata->clock > 50)
-		printk(KERN_ERR "53c700: Clock speed %dMHz is too high: contact James.Bottomley@HansenPartnership.com to modify the divider\n", hostdata->clock);
-	/* Set the synchronous SCSI divider to 1 so we drive the
-	 * synchronous command clock at this speed */
-	outb(1, host->base + SBCL_REG);
-	/* set the clock bits to 0 which is a divider of 2 so the
-	 * async frequency is exactly half this speed */ 
-	outb(0x00, host->base + DCNTL_REG);
+	NCR_700_writeb(1 << host->this_id, host, SCID_REG);
+	NCR_700_writeb(0, host, SBCL_REG);
+	NCR_700_writeb(0, host, SXFER_REG);
+
+	NCR_700_writeb(PHASE_MM_INT | SEL_TIMEOUT_INT | GROSS_ERR_INT | UX_DISC_INT
+	     | RST_INT | PAR_ERR_INT | SELECT_INT, host, SIEN_REG);
+
+	NCR_700_writeb(ABORT_INT | INT_INST_INT | ILGL_INST_INT, host, DIEN_REG);
+	NCR_700_writeb(BURST_LENGTH_8, host, DMODE_REG);
+	NCR_700_writeb(FULL_ARBITRATION | PARITY | AUTO_ATN, host, SCNTL0_REG);
+	NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION|GENERATE_RECEIVE_PARITY,
+	     host, CTEST8_REG);
+	NCR_700_writeb(ENABLE_SELECT, host, SCNTL1_REG);
+	if(hostdata->clock > 75) {
+		printk(KERN_ERR "53c700: Clock speed %dMHz is too high: 75Mhz is the maximum this chip can be driven at\n", hostdata->clock);
+		/* do the best we can, but the async clock will be out
+		 * of spec: sync divider 2, async divider 3 */
+		DEBUG(("53c700: sync 2 async 3\n"));
+		NCR_700_writeb(SYNC_DIV_2_0, host, SBCL_REG);
+		NCR_700_writeb(ASYNC_DIV_3_0, host, DCNTL_REG);
+		hostdata->sync_clock = hostdata->clock/2;
+	} else	if(hostdata->clock > 50  && hostdata->clock <= 75) {
+		/* sync divider 1.5, async divider 3 */
+		DEBUG(("53c700: sync 1.5 async 3\n"));
+		NCR_700_writeb(SYNC_DIV_1_5, host, SBCL_REG);
+		NCR_700_writeb(ASYNC_DIV_3_0, host, DCNTL_REG);
+		hostdata->sync_clock = hostdata->clock*2;
+		hostdata->sync_clock /= 3;
+		
+	} else if(hostdata->clock > 37 && hostdata->clock <= 50) {
+		/* sync divider 1, async divider 2 */
+		DEBUG(("53c700: sync 1 async 2\n"));
+		NCR_700_writeb(SYNC_DIV_1_0, host, SBCL_REG);
+		NCR_700_writeb(ASYNC_DIV_2_0, host, DCNTL_REG);
+		hostdata->sync_clock = hostdata->clock;
+	} else if(hostdata->clock > 25 && hostdata->clock <=37) {
+		/* sync divider 1, async divider 1.5 */
+		DEBUG(("53c700: sync 1 async 1.5\n"));
+		NCR_700_writeb(SYNC_DIV_1_0, host, SBCL_REG);
+		NCR_700_writeb(ASYNC_DIV_1_5, host, DCNTL_REG);
+		hostdata->sync_clock = hostdata->clock;
+	} else {
+		DEBUG(("53c700: sync 1 async 1\n"));
+		NCR_700_writeb(SYNC_DIV_1_0, host, SBCL_REG);
+		NCR_700_writeb(ASYNC_DIV_1_0, host, DCNTL_REG);
+		/* sync divider 1, async divider 1 */
+	}
 }
 
 STATIC void
 NCR_700_chip_reset(struct Scsi_Host *host)
 {
 	/* Chip reset */
-	outb(SOFTWARE_RESET, host->base + DCNTL_REG);
+	NCR_700_writeb(SOFTWARE_RESET, host, DCNTL_REG);
 	udelay(100);
 
-	outb(0, host->base + DCNTL_REG);
+	NCR_700_writeb(0, host, DCNTL_REG);
 
 	mdelay(1000);
 
@@ -653,14 +709,15 @@
 			NCR_700_set_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
 			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
 			
-			outb(NCR_700_get_SXFER(SCp->device),
-			     host->base + SXFER_REG);
+			NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
+				       host, SXFER_REG);
 
 		} else {
 			/* SDTR message out of the blue, reject it */
 			printk(KERN_WARNING "scsi%d Unexpected SDTR msg\n",
 			       host->host_no);
 			hostdata->msgout[0] = A_REJECT_MSG;
+			dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
 			script_patch_16(hostdata->script, MessageCount, 1);
 			/* SendMsgOut returns, so set up the return
 			 * address */
@@ -672,6 +729,7 @@
 		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
 		       host->host_no, pun, lun);
 		hostdata->msgout[0] = A_REJECT_MSG;
+		dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
 		script_patch_16(hostdata->script, MessageCount, 1);
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 
@@ -685,12 +743,13 @@
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
+		dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
 		script_patch_16(hostdata->script, MessageCount, 1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 	}
-	outl(temp, host->base + TEMP_REG);
+	NCR_700_writel(temp, host, TEMP_REG);
 	return resume_offset;
 }
 
@@ -702,6 +761,8 @@
 	__u32 temp = dsp + 8, resume_offset = dsp;
 	__u8 pun = 0xff, lun = 0xff;
 
+	dma_cache_inv((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
+
 	if(SCp != NULL) {
 		pun = SCp->target;
 		lun = SCp->lun;
@@ -726,6 +787,11 @@
 			NCR_700_set_SXFER(SCp->device, 0);
 			NCR_700_set_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
 			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
+		} else if(SCp != NULL && NCR_700_is_flag_set(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING)) {
+			/* rejected our first simple tag message */
+			printk(KERN_WARNING "scsi%d (%d:%d) Rejected first tag queue attempt, turning off tag queueing\n", host->host_no, pun, lun);
+			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
+			hostdata->tag_negotiated &= ~(1<<SCp->target);
 		} else {
 			printk(KERN_WARNING "scsi%d (%d:%d) Unexpected REJECT Message %s\n",
 			       host->host_no, pun, lun,
@@ -735,12 +801,12 @@
 		break;
 
 	case A_PARITY_ERROR_MSG:
-		printk("scsi%d (%d:%d) Parity Error!\n", host->host_no,
+		printk(KERN_ERR "scsi%d (%d:%d) Parity Error!\n", host->host_no,
 		       pun, lun);
 		NCR_700_internal_bus_reset(host);
 		break;
 	case A_SIMPLE_TAG_MSG:
-		printk("scsi%d (%d:%d) SIMPLE TAG %d %s\n", host->host_no,
+		printk(KERN_INFO "scsi%d (%d:%d) SIMPLE TAG %d %s\n", host->host_no,
 		       pun, lun, hostdata->msgin[1],
 		       NCR_700_phase[(dsps & 0xf00) >> 8]);
 		/* just ignore it */
@@ -754,6 +820,7 @@
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
+		dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
 		script_patch_16(hostdata->script, MessageCount, 1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
@@ -761,7 +828,7 @@
 
 		break;
 	}
-	outl(temp, host->base + TEMP_REG);
+	NCR_700_writel(temp, host, TEMP_REG);
 	return resume_offset;
 }
 
@@ -779,43 +846,55 @@
 	}
 
 	if(dsps == A_GOOD_STATUS_AFTER_STATUS) {
+		dma_cache_inv((unsigned long)hostdata->status, sizeof(hostdata->status));
 		DEBUG(("  COMMAND COMPLETE, status=%02x\n",
 		       hostdata->status));
+		/* OK, if TCQ still on, we know it works */
+		NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
 		/* check for contingent allegiance contitions */
 		if(status_byte(hostdata->status) == CHECK_CONDITION ||
 		   status_byte(hostdata->status) == COMMAND_TERMINATED) {
 			struct NCR_700_command_slot *slot =
 				(struct NCR_700_command_slot *)SCp->host_scribble;
+			if(SCp->cmnd[0] == REQUEST_SENSE) {
+				/* OOPS: bad device, returning another
+				 * contingent allegiance condition */
+				printk(KERN_ERR "scsi%d (%d:%d) broken device is looping in contingent allegiance: ignoring\n", host->host_no, pun, lun);
+				NCR_700_scsi_done(hostdata, SCp, hostdata->status);
+			} else {
 
-			DEBUG(("  cmd %p has status %d, requesting sense\n",
-			       SCp, hostdata->status));
-			/* we can destroy the command here because the
-			 * contingent allegiance condition will cause a 
-			 * retry which will re-copy the command from the
-			 * saved data_cmnd */
-			SCp->cmnd[0] = REQUEST_SENSE;
-			SCp->cmnd[1] = (SCp->lun & 0x7) << 5;
-			SCp->cmnd[2] = 0;
-			SCp->cmnd[3] = 0;
-			SCp->cmnd[4] = sizeof(SCp->sense_buffer);
-			SCp->cmnd[5] = 0;
-			SCp->cmd_len = 6;
-			/* Here's a quiet hack: the REQUEST_SENSE command is
-			 * six bytes, so store a flag indicating that this
-			 * was an internal sense request and the original
-			 * status at the end of the command */
-			SCp->cmnd[6] = NCR_700_INTERNAL_SENSE_MAGIC;
-			SCp->cmnd[7] = hostdata->status;
-			slot->SG[0].ins = SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer);
-			slot->SG[0].pAddr = virt_to_bus(SCp->sense_buffer);
-			slot->SG[1].ins = SCRIPT_RETURN;
-			slot->SG[1].pAddr = 0;
-			slot->resume_offset = hostdata->pScript;
-			
-			/* queue the command for reissue */
-			slot->state = NCR_700_SLOT_QUEUED;
-			hostdata->state = NCR_700_HOST_FREE;
-			hostdata->cmd = NULL;
+				DEBUG(("  cmd %p has status %d, requesting sense\n",
+				       SCp, hostdata->status));
+				/* we can destroy the command here because the
+				 * contingent allegiance condition will cause a 
+				 * retry which will re-copy the command from the
+				 * saved data_cmnd */
+				SCp->cmnd[0] = REQUEST_SENSE;
+				SCp->cmnd[1] = (SCp->lun & 0x7) << 5;
+				SCp->cmnd[2] = 0;
+				SCp->cmnd[3] = 0;
+				SCp->cmnd[4] = sizeof(SCp->sense_buffer);
+				SCp->cmnd[5] = 0;
+				SCp->cmd_len = 6;
+				/* Here's a quiet hack: the REQUEST_SENSE command is
+				 * six bytes, so store a flag indicating that this
+				 * was an internal sense request and the original
+				 * status at the end of the command */
+				SCp->cmnd[6] = NCR_700_INTERNAL_SENSE_MAGIC;
+				SCp->cmnd[7] = hostdata->status;
+				slot->SG[0].ins = bS_to_host(SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer));
+				slot->SG[0].pAddr = bS_to_host(virt_to_bus(SCp->sense_buffer));
+				slot->SG[1].ins = bS_to_host(SCRIPT_RETURN);
+				slot->SG[1].pAddr = 0;
+				slot->resume_offset = hostdata->pScript;
+				dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG[0])*2);
+				dma_cache_inv((unsigned long)SCp->sense_buffer, sizeof(SCp->sense_buffer));
+				
+				/* queue the command for reissue */
+				slot->state = NCR_700_SLOT_QUEUED;
+				hostdata->state = NCR_700_HOST_FREE;
+				hostdata->cmd = NULL;
+			}
 		} else {
 			if(status_byte(hostdata->status) == GOOD &&
 			   SCp->cmnd[0] == INQUIRY && SCp->use_sg == 0) {
@@ -824,7 +903,9 @@
 				if(((char *)SCp->request_buffer)[7] & 0x02) {
 					printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", host->host_no, pun, lun);
 					hostdata->tag_negotiated |= (1<<SCp->target);
+					NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
 				} else {
+					NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
 					hostdata->tag_negotiated &= ~(1<<SCp->target);
 				}
 			}
@@ -836,8 +917,8 @@
 		printk(KERN_ERR "scsi%d: (%d:%d), UNEXPECTED PHASE %s (%s)\n",
 		       host->host_no, pun, lun,
 		       NCR_700_phase[i],
-		       sbcl_to_string(inb(host->base + SBCL_REG)));
-		printk("         len = %d, cmd =", SCp->cmd_len);
+		       sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
+		printk(KERN_ERR "         len = %d, cmd =", SCp->cmd_len);
 		print_command(SCp->cmnd);
 
 		NCR_700_internal_bus_reset(host);
@@ -862,10 +943,14 @@
 		save_for_reselection(hostdata, SCp, dsp);
 
 	} else if(dsps == A_RESELECTION_IDENTIFIED) {
-		__u8 lun = hostdata->msgin[0] & 0x1f;
+		__u8 lun;
 		struct NCR_700_command_slot *slot;
 		__u8 reselection_id = hostdata->reselection_id;
 
+		dma_cache_inv((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
+
+		lun = hostdata->msgin[0] & 0x1f;
+
 		hostdata->reselection_id = 0xff;
 		DEBUG(("scsi%d: (%d:%d) RESELECTED!\n",
 		       host->host_no, reselection_id, lun));
@@ -918,8 +1003,8 @@
 			 * that ACK is still asserted when we process
 			 * the reselection message.  The resume offset
 			 * should therefore always clear ACK */
-			outb(NCR_700_get_SXFER(hostdata->cmd->device),
-			     host->base + SXFER_REG);
+			NCR_700_writeb(NCR_700_get_SXFER(hostdata->cmd->device),
+				       host, SXFER_REG);
 			
 		}
 	} else if(dsps == A_RESELECTED_DURING_SELECTION) {
@@ -931,13 +1016,13 @@
 		 * selection interrupt before we manage to get to the
 		 * reselected script interrupt */
 
-		__u8 reselection_id = inb(host->base + SFBR_REG);
+		__u8 reselection_id = NCR_700_readb(host, SFBR_REG);
 		struct NCR_700_command_slot *slot;
 		
 		/* Take out our own ID */
 		reselection_id &= ~(1<<host->this_id);
 		
-		printk("scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%p[%04x] state=%d, count=%d\n",
+		printk(KERN_INFO "scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%p[%04x] state=%d, count=%d\n",
 		       host->host_no, reselection_id, lun, (void *)dsp, dsp - hostdata->pScript, hostdata->state, hostdata->command_slot_count);
 
 		{
@@ -950,7 +1035,7 @@
 				   && SG <= (__u32)(&hostdata->slots[i].SG[NCR_700_SG_SEGMENTS]))
 					break;
 			}
-			printk("IDENTIFIED SG segment as being %p in slot %p, cmd %p, slot->resume_offset=%p\n", (void *)SG, &hostdata->slots[i], hostdata->slots[i].cmnd, (void *)hostdata->slots[i].resume_offset);
+			printk(KERN_INFO "IDENTIFIED SG segment as being %p in slot %p, cmd %p, slot->resume_offset=%p\n", (void *)SG, &hostdata->slots[i], hostdata->slots[i].cmnd, (void *)hostdata->slots[i].resume_offset);
 			SCp =  hostdata->slots[i].cmnd;
 		}
 
@@ -977,6 +1062,7 @@
 		}
 		hostdata->reselection_id = reselection_id;
 		hostdata->msgin[1] = 0;
+		dma_cache_wback((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
 		if(hostdata->tag_negotiated & (1<<reselection_id)) {
 			resume_offset = hostdata->pScript + Ent_GetReselectionWithTag;
 		} else {
@@ -1000,13 +1086,13 @@
 
 			if(SCp->use_sg) {
 				for(i = 0; i < SCp->use_sg + 1; i++) {
-					printk(" SG[%d].length = %d, move_insn=%08x, addr %08x\n", i, ((struct scatterlist *)SCp->buffer)[i].length, ((struct NCR_700_command_slot *)SCp->host_scribble)->SG[i].ins, ((struct NCR_700_command_slot *)SCp->host_scribble)->SG[i].pAddr);
+					printk(KERN_INFO " SG[%d].length = %d, move_insn=%08x, addr %08x\n", i, ((struct scatterlist *)SCp->buffer)[i].length, ((struct NCR_700_command_slot *)SCp->host_scribble)->SG[i].ins, ((struct NCR_700_command_slot *)SCp->host_scribble)->SG[i].pAddr);
 				}
 			}
 		}	       
 		NCR_700_internal_bus_reset(host);
 	} else if((dsps & 0xfffff000) == A_DEBUG_INTERRUPT) {
-		printk("scsi%d (%d:%d) DEBUG INTERRUPT %d AT %p[%04x], continuing\n",
+		printk(KERN_NOTICE "scsi%d (%d:%d) DEBUG INTERRUPT %d AT %p[%04x], continuing\n",
 		       host->host_no, pun, lun, dsps & 0xfff, (void *)dsp, dsp - hostdata->pScript);
 		resume_offset = dsp;
 	} else {
@@ -1027,7 +1113,7 @@
 STATIC inline __u32
 process_selection(struct Scsi_Host *host, __u32 dsp)
 {
-	__u8 id;
+	__u8 id = 0;	/* Squash compiler warning */
 	int count = 0;
 	__u32 resume_offset = 0;
 	struct NCR_700_Host_Parameters *hostdata =
@@ -1036,7 +1122,7 @@
 	__u8 sbcl;
 
 	for(count = 0; count < 5; count++) {
-		id = inb(host->base + SFBR_REG);
+		id = NCR_700_readb(host, SFBR_REG);
 
 		/* Take out our own ID */
 		id &= ~(1<<host->this_id);
@@ -1044,7 +1130,7 @@
 			break;
 		udelay(5);
 	}
-	sbcl = inb(host->base + SBCL_REG);
+	sbcl = NCR_700_readb(host, SBCL_REG);
 	if((sbcl & SBCL_IO) == 0) {
 		/* mark as having been selected rather than reselected */
 		id = 0xff;
@@ -1057,7 +1143,7 @@
 	if(hostdata->state == NCR_700_HOST_BUSY && SCp != NULL) {
 		struct NCR_700_command_slot *slot =
 			(struct NCR_700_command_slot *)SCp->host_scribble;
-		DEBUG(("  ID %d WARNING: RESELECTION OF BUSY HOST, saving cmd %p, slot %p, addr %p [%04x], resume %p!\n", id, hostdata->cmd, slot, dsp, dsp - hostdata->pScript, resume_offset));
+		DEBUG(("  ID %d WARNING: RESELECTION OF BUSY HOST, saving cmd %p, slot %p, addr %x [%04x], resume %x!\n", id, hostdata->cmd, slot, dsp, dsp - hostdata->pScript, resume_offset));
 		
 		switch(dsp - hostdata->pScript) {
 		case Ent_Disconnect1:
@@ -1089,6 +1175,7 @@
 	hostdata->state = NCR_700_HOST_BUSY;
 	hostdata->cmd = NULL;
 	hostdata->msgin[1] = 0;
+	dma_cache_wback((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
 
 	if(id == 0xff) {
 		/* Selected as target, Ignore */
@@ -1157,6 +1244,8 @@
 		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
 	}
 
+	dma_cache_wback((unsigned long)hostdata->msgout, count);
+
 	script_patch_16(hostdata->script, MessageCount, count);
 
 
@@ -1170,19 +1259,19 @@
 	 * */
 	script_patch_32_abs(hostdata->script, SGScriptStartAddress,
 			    virt_to_bus(&slot->SG[0].ins));
-	outb(CLR_FIFO, SCp->host->base + DFIFO_REG);
+	NCR_700_writeb(CLR_FIFO, SCp->host, DFIFO_REG);
 
 	/* set the synchronous period/offset */
 	if(slot->resume_offset == 0)
 		slot->resume_offset = hostdata->pScript;
-	outb(NCR_700_get_SXFER(SCp->device),
-	     SCp->host->base + SXFER_REG);
+	NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
+	     SCp->host, SXFER_REG);
 	/* allow interrupts here so that if we're selected we can take
 	 * a selection interrupt.  The script start may not be
 	 * effective in this case, but the selection interrupt will
 	 * save our command in that case */
-	outl(slot->temp, SCp->host->base + TEMP_REG);
-	outl(slot->resume_offset, SCp->host->base + DSP_REG);
+	NCR_700_writel(slot->temp, SCp->host, TEMP_REG);
+	NCR_700_writel(slot->resume_offset, SCp->host, DSP_REG);
 	restore_flags(flags);
 
 	return 1;
@@ -1211,7 +1300,7 @@
 	 * hostdata->lock would be the reverse of taking it in this
 	 * routine */
 	spin_lock_irqsave(&io_request_lock, flags);
-	if((istat = inb(host->base + ISTAT_REG))
+	if((istat = NCR_700_readb(host, ISTAT_REG))
 	      & (SCSI_INT_PENDING | DMA_INT_PENDING)) {
 		__u32 dsps;
 		__u8 sstat0 = 0, dstat = 0;
@@ -1225,19 +1314,19 @@
 		if(istat & SCSI_INT_PENDING) {
 			udelay(10);
 
-			sstat0 = inb(host->base + SSTAT0_REG);
+			sstat0 = NCR_700_readb(host, SSTAT0_REG);
 		}
 
 		if(istat & DMA_INT_PENDING) {
 			udelay(10);
 
-			dstat = inb(host->base + DSTAT_REG);
+			dstat = NCR_700_readb(host, DSTAT_REG);
 		}
 
-		dsps = inl(host->base + DSPS_REG);
-		dsp = inl(host->base + DSP_REG);
+		dsps = NCR_700_readl(host, DSPS_REG);
+		dsp = NCR_700_readl(host, DSP_REG);
 
-		DEBUG(("scsi%d: istat %02x sstat0 %02x dstat %02x dsp %04x[%08lx] dsps 0x%x\n",
+		DEBUG(("scsi%d: istat %02x sstat0 %02x dstat %02x dsp %04x[%08x] dsps 0x%x\n",
 		       host->host_no, istat, sstat0, dstat,
 		       (dsp - (__u32)virt_to_bus(hostdata->script))/4,
 		       dsp, dsps));
@@ -1301,14 +1390,15 @@
 			if(dsp == Ent_SendMessage + 8 + hostdata->pScript) {
 				/* It wants to reply to some part of
 				 * our message */
-				__u32 temp = inl(host->base + TEMP_REG);
-
-				int count = (hostdata->script[Ent_SendMessage/4] & 0xffffff) - ((inl(host->base + DBC_REG) & 0xffffff) + NCR_700_data_residual(host));
-				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(inb(host->base + SBCL_REG)));
+#ifdef NCR_700_DEBUG
+				__u32 temp = NCR_700_readl(host, TEMP_REG);
+				int count = (hostdata->script[Ent_SendMessage/4] & 0xffffff) - ((NCR_700_readl(host, DBC_REG) & 0xffffff) + NCR_700_data_residual(host));
+				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
+#endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
 			} else if(dsp >= virt_to_bus(&slot->SG[0].ins) &&
 				  dsp <= virt_to_bus(&slot->SG[NCR_700_SG_SEGMENTS].ins)) {
-				int data_transfer = inl(host->base + DBC_REG) & 0xffffff;
+				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - virt_to_bus(&slot->SG[0].ins))/sizeof(struct NCR_700_SG_List);
 				int residual = NCR_700_data_residual(host);
 				int i;
@@ -1327,24 +1417,29 @@
 
 				if(data_transfer != 0) {
 					int count; 
+					__u32 pAddr;
+
 					SGcount--;
 
-					count = (slot->SG[SGcount].ins & 0x00ffffff);
+					count = (bS_to_cpu(slot->SG[SGcount].ins) & 0x00ffffff);
 					DEBUG(("DATA TRANSFER MISMATCH, count = %d, transferred %d\n", count, count-data_transfer));
-					slot->SG[SGcount].ins &= 0xff000000;
-					slot->SG[SGcount].ins |= data_transfer;
-					slot->SG[SGcount].pAddr += (count - data_transfer);
+					slot->SG[SGcount].ins &= bS_to_host(0xff000000);
+					slot->SG[SGcount].ins |= bS_to_host(data_transfer);
+					pAddr = bS_to_cpu(slot->SG[SGcount].pAddr);
+					pAddr += (count - data_transfer);
+					slot->SG[SGcount].pAddr = bS_to_host(pAddr);
 				}
 				/* set the executed moves to nops */
 				for(i=0; i<SGcount; i++) {
-					slot->SG[i].ins = SCRIPT_NOP;
+					slot->SG[i].ins = bS_to_host(SCRIPT_NOP);
 					slot->SG[i].pAddr = 0;
 				}
+				dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG));
 				/* and pretend we disconnected after
 				 * the command phase */
 				resume_offset = hostdata->pScript + Ent_MsgInDuringData;
 			} else {
-				__u8 sbcl = inb(host->base + SBCL_REG);
+				__u8 sbcl = NCR_700_readb(host, SBCL_REG);
 				printk(KERN_ERR "scsi%d: (%d:%d) phase mismatch at %04x, phase %s\n",
 				       host->host_no, pun, lun, dsp - hostdata->pScript, sbcl_to_string(sbcl));
 				NCR_700_internal_bus_reset(host);
@@ -1406,8 +1501,8 @@
 		}
 
 		DEBUG(("Attempting to resume at %x\n", resume_offset));
-		outb(CLR_FIFO, host->base + DFIFO_REG);
-		outl(resume_offset, host->base + DSP_REG);
+		NCR_700_writeb(CLR_FIFO, host, DFIFO_REG);
+		NCR_700_writel(resume_offset, host, DSP_REG);
 	} 
 	/* There is probably a technical no-no about this: If we're a
 	 * shared interrupt and we got this interrupt because the
@@ -1468,7 +1563,7 @@
 Target	Depth  Active  Next Tag\n\
 ======	=====  ======  ========\n");
 	for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next) {
-		len += sprintf(&buf[len],"%2d:%2d  %4d  %4d  %4d\n", SDp->id, SDp->lun, SDp->queue_depth, NCR_700_get_depth(SDp), SDp->current_tag);
+		len += sprintf(&buf[len]," %2d:%2d   %4d    %4d      %4d\n", SDp->id, SDp->lun, SDp->queue_depth, NCR_700_get_depth(SDp), SDp->current_tag);
 	}
 	if((len -= offset) <= 0)
 		return 0;
@@ -1653,15 +1748,17 @@
 				vPtr = SCp->request_buffer;
 				count = SCp->request_bufflen;
 			}
-			slot->SG[i].ins = move_ins | count;
-			DEBUG((" scatter block %d: move %d[%08lx] from 0x%lx\n",
-			       i, count, slot->SG[i].move_ins, 
+			slot->SG[i].ins = bS_to_host(move_ins | count);
+			DEBUG((" scatter block %d: move %d[%08x] from 0x%lx\n",
+			       i, count, slot->SG[i].ins, 
 			       virt_to_bus(vPtr)));
-			slot->SG[i].pAddr = virt_to_bus(vPtr);
+			dma_cache_wback_inv((unsigned long)vPtr, count);
+			slot->SG[i].pAddr = bS_to_host(virt_to_bus(vPtr));
 		}
-		slot->SG[i].ins = SCRIPT_RETURN;
+		slot->SG[i].ins = bS_to_host(SCRIPT_RETURN);
 		slot->SG[i].pAddr = 0;
-		DEBUG((" SETTING %08x to %x\n",
+		dma_cache_wback((unsigned long)slot->SG, sizeof(slot->SG));
+		DEBUG((" SETTING %08lx to %x\n",
 		       virt_to_bus(&slot->SG[i].ins), 
 		       slot->SG[i].ins));
 	}
@@ -1677,7 +1774,7 @@
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
 
-	printk("scsi%d (%d:%d) New error handler wants to abort command\n\t",
+	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants to abort command\n\t",
 	       SCp->host->host_no, SCp->target, SCp->lun);
 	print_command(SCp->cmnd);
 
@@ -1709,7 +1806,7 @@
 STATIC int
 NCR_700_bus_reset(Scsi_Cmnd * SCp)
 {
-	printk("scsi%d (%d:%d) New error handler wants BUS reset, cmd %p\n\t",
+	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants BUS reset, cmd %p\n\t",
 	       SCp->host->host_no, SCp->target, SCp->lun, SCp);
 	print_command(SCp->cmnd);
 	NCR_700_internal_bus_reset(SCp->host);
@@ -1719,7 +1816,7 @@
 STATIC int
 NCR_700_dev_reset(Scsi_Cmnd * SCp)
 {
-	printk("scsi%d (%d:%d) New error handler wants device reset\n\t",
+	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants device reset\n\t",
 	       SCp->host->host_no, SCp->target, SCp->lun);
 	print_command(SCp->cmnd);
 	
@@ -1729,7 +1826,7 @@
 STATIC int
 NCR_700_host_reset(Scsi_Cmnd * SCp)
 {
-	printk("scsi%d (%d:%d) New error handler wants HOST reset\n\t",
+	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants HOST reset\n\t",
 	       SCp->host->host_no, SCp->target, SCp->lun);
 	print_command(SCp->cmnd);
 
Index: linux/2.4/drivers/scsi/53c700.h
diff -u linux/2.4/drivers/scsi/53c700.h:1.1.1.1 linux/2.4/drivers/scsi/53c700.h:1.1.1.1.12.3
--- linux/2.4/drivers/scsi/53c700.h:1.1.1.1	Mon May 14 18:48:23 2001
+++ linux/2.4/drivers/scsi/53c700.h	Sun Sep  2 22:18:30 2001
@@ -33,7 +33,14 @@
 /* magic byte identifying an internally generated REQUEST_SENSE command */
 #define NCR_700_INTERNAL_SENSE_MAGIC	0x42
 
+/* WARNING: Leave this in for now: the dependency preprocessor doesn't
+ * pick up file specific flags, so must define here if they are not
+ * set */
+#if !defined(IO_MAPPED) && !defined(MEM_MAPPED)
+#define IO_MAPPED
+#endif
 
+
 struct NCR_700_Host_Parameters;
 
 /* These are the externally used routines */
@@ -78,7 +85,7 @@
  * 18 device supports tag queueing */
 #define NCR_700_DEV_NEGOTIATED_SYNC	(1<<16)
 #define NCR_700_DEV_BEGIN_SYNC_NEGOTIATION	(1<<17)
-#define NCR_700_DEV_USES_TAG_QUEUEING	(1<<18)
+#define NCR_700_DEV_BEGIN_TAG_QUEUEING	(1<<18)
 
 static inline void
 NCR_700_set_SXFER(Scsi_Device *SDp, __u8 sxfer)
@@ -180,11 +187,18 @@
 	int	clock;			/* board clock speed in MHz */
 	__u32	base;			/* the base for the port (copied to host) */
 	__u8	differential:1;	/* if we are differential */
+#ifdef __hppa__
+	/* This option is for HP only.  Set it if your chip is wired for
+	 * little endian on this platform (which is big endian) */
+	__u8	force_le_on_be:1;
+#endif
 
 	/* NOTHING BELOW HERE NEEDS ALTERING */
 	__u8	fast:1;		/* if we can alter the SCSI bus clock
                                    speed (so can negiotiate sync) */
 
+	int	sync_clock;	/* The speed of the SYNC core */
+
 	__u32	*script;		/* pointer to script location */
 	__u32	pScript;		/* physical mem addr of script */
 
@@ -196,7 +210,6 @@
 	Scsi_Cmnd *cmd;
 
 	__u8	msgout[8];
-	__u8	msgout_size;
 	__u8	tag_negotiated;
 	__u8	status;
 	__u8	msgin[8];
@@ -224,7 +237,23 @@
 /*
  *	53C700 Register Interface - the offset from the Selected base
  *	I/O address */
+#ifdef __hppa__
+#define bE	(hostdata->force_le_on_be ? 0 : 3)
+#define	bSWAP	(hostdata->force_le_on_be)
+#elif defined(__BIG_ENDIAN)
+#define bE	3
+#define bSWAP	0
+#elif defined(__LITTLE_ENDIAN)
+#define bE	0
+#define bSWAP	0
+#else
+#error "__BIG_ENDIAN or __LITTLE_ENDIAN must be defined, did you include byteorder.h?"
+#endif
+#define bS_to_cpu(x)	(bSWAP ? le32_to_cpu(x) : (x))
+#define bS_to_host(x)	(bSWAP ? cpu_to_le32(x) : (x))
 
+/* NOTE: These registers are in the LE register space only, the required byte
+ * swapping is done by the NCR_700_{read|write}[b] functions */
 #define	SCNTL0_REG			0x00
 #define		FULL_ARBITRATION	0xc0
 #define 	PARITY			0x08
@@ -254,7 +283,13 @@
 #define	SIDL_REG			0x09
 #define	SBDL_REG			0x0A
 #define	SBCL_REG			0x0B
+/* read bits */
 #define		SBCL_IO			0x01
+/*write bits */
+#define		SYNC_DIV_AS_ASYNC	0x00
+#define		SYNC_DIV_1_0		0x01
+#define		SYNC_DIV_1_5		0x02
+#define		SYNC_DIV_2_0		0x03
 #define	DSTAT_REG			0x0C
 #define		ILGL_INST_DETECTED	0x01
 #define		WATCH_DOG_INTERRUPT	0x02
@@ -322,6 +357,10 @@
 #define	DCNTL_REG			0x3B
 #define		SOFTWARE_RESET		0x01
 #define 	SCRPTS_16BITS		0x20
+#define		ASYNC_DIV_2_0		0x00
+#define		ASYNC_DIV_1_5		0x01
+#define		ASYNC_DIV_1_0		0x02
+#define		ASYNC_DIV_3_0		0x03
 #define	DMODE_REG			0x34
 #define		BURST_LENGTH_1		0x00
 #define		BURST_LENGTH_2		0x40
@@ -345,8 +384,10 @@
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
-		(script)[A_##symbol##_used[i]] += (value); \
-		DEBUG((" script, patching %s at %ld to 0x%lx\n", \
+		__u32 val = bS_to_cpu((script)[A_##symbol##_used[i]]) + value; \
+		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
+		dma_cache_wback((unsigned long)&(script)[A_##symbol##_used[i]], 4); \
+		DEBUG((" script, patching %s at %d to 0x%lx\n", \
 		       #symbol, A_##symbol##_used[i], (value))); \
 	} \
 }
@@ -355,8 +396,9 @@
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
-		(script)[A_##symbol##_used[i]] = (value); \
-		DEBUG((" script, patching %s at %ld to 0x%lx\n", \
+		(script)[A_##symbol##_used[i]] = bS_to_host(value); \
+		dma_cache_wback((unsigned long)&(script)[A_##symbol##_used[i]], 4); \
+		DEBUG((" script, patching %s at %d to 0x%lx\n", \
 		       #symbol, A_##symbol##_used[i], (value))); \
 	} \
 }
@@ -366,11 +408,12 @@
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
-		__u32 val = (script)[A_##symbol##_used[i]]; \
+		__u32 val = bS_to_cpu((script)[A_##symbol##_used[i]]); \
 		val &= 0xff00ffff; \
 		val |= ((value) & 0xff) << 16; \
-		(script)[A_##symbol##_used[i]] = val; \
-		DEBUG((" script, patching ID field %s at %ld to 0x%lx\n", \
+		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
+		dma_cache_wback((unsigned long)&(script)[A_##symbol##_used[i]], 4); \
+		DEBUG((" script, patching ID field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
 }
@@ -379,13 +422,113 @@
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
-		__u32 val = (script)[A_##symbol##_used[i]]; \
+		__u32 val = bS_to_cpu((script)[A_##symbol##_used[i]]); \
 		val &= 0xffff0000; \
 		val |= ((value) & 0xffff); \
-		(script)[A_##symbol##_used[i]] = val; \
-		DEBUG((" script, patching ID field %s at %ld to 0x%lx\n", \
+		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
+		dma_cache_wback((unsigned long)&(script)[A_##symbol##_used[i]], 4); \
+		DEBUG((" script, patching ID field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
 }
 
+#endif
+
+#ifdef MEM_MAPPED
+static inline __u8
+NCR_700_readb(struct Scsi_Host *host, __u32 reg)
+{
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+	return readb(host->base + (reg^bE));
+}
+
+static inline __u32
+NCR_700_readl(struct Scsi_Host *host, __u32 reg)
+{
+	__u32 value = readl(host->base + reg);
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+#if 1
+	/* sanity check the register */
+	if((reg & 0x3) != 0)
+		BUG();
+#endif
+
+	return bS_to_cpu(value);
+}
+
+static inline void
+NCR_700_writeb(__u8 value, struct Scsi_Host *host, __u32 reg)
+{
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+	writeb(value, host->base + (reg^bE));
+}
+
+static inline void
+NCR_700_writel(__u32 value, struct Scsi_Host *host, __u32 reg)
+{
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+#if 1
+	/* sanity check the register */
+	if((reg & 0x3) != 0)
+		BUG();
+#endif
+
+	writel(bS_to_host(value), host->base + reg);
+}
+#elif defined(IO_MAPPED)
+static inline __u8
+NCR_700_readb(struct Scsi_Host *host, __u32 reg)
+{
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+	return inb(host->base + (reg^bE));
+}
+
+static inline __u32
+NCR_700_readl(struct Scsi_Host *host, __u32 reg)
+{
+	__u32 value = inl(host->base + reg);
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+#if 1
+	/* sanity check the register */
+	if((reg & 0x3) != 0)
+		BUG();
+#endif
+
+	return bS_to_cpu(value);
+}
+
+static inline void
+NCR_700_writeb(__u8 value, struct Scsi_Host *host, __u32 reg)
+{
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+	outb(value, host->base + (reg^bE));
+}
+
+static inline void
+NCR_700_writel(__u32 value, struct Scsi_Host *host, __u32 reg)
+{
+	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+
+#if 1
+	/* sanity check the register */
+	if((reg & 0x3) != 0)
+		BUG();
+#endif
+
+	outl(bS_to_host(value), host->base + reg);
+}
 #endif
Index: linux/2.4/drivers/scsi/Config.in
diff -u linux/2.4/drivers/scsi/Config.in:1.1.1.17 linux/2.4/drivers/scsi/Config.in:1.1.1.17.2.1
--- linux/2.4/drivers/scsi/Config.in:1.1.1.17	Sat Sep  1 21:03:21 2001
+++ linux/2.4/drivers/scsi/Config.in	Sat Sep  1 23:10:54 2001
@@ -116,6 +116,7 @@
 fi
 dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
 dep_tristate 'NCR Dual 700 MCA SCSI support' CONFIG_SCSI_NCR_D700 $CONFIG_SCSI $CONFIG_MCA
+dep_tristate 'HP LASI SCSI support for 53c700' CONFIG_SCSI_LASI700 $CONFIG_SCSI $CONFIG_PARISC
 dep_tristate 'NCR53c7,8xx SCSI support'  CONFIG_SCSI_NCR53C7xx $CONFIG_SCSI $CONFIG_PCI
 if [ "$CONFIG_SCSI_NCR53C7xx" != "n" ]; then
    bool '  always negotiate synchronous transfers' CONFIG_SCSI_NCR53C7xx_sync
Index: linux/2.4/drivers/scsi/Makefile
diff -u linux/2.4/drivers/scsi/Makefile:1.1.1.16 linux/2.4/drivers/scsi/Makefile:1.1.1.16.2.2
--- linux/2.4/drivers/scsi/Makefile:1.1.1.16	Sat Sep  1 21:02:26 2001
+++ linux/2.4/drivers/scsi/Makefile	Sun Sep  2 22:18:30 2001
@@ -31,7 +31,7 @@
   endif
 endif
 
-export-objs	:= scsi_syms.o 53c700.o
+export-objs	:= scsi_syms.o 53c700.o 53c700-mem.o
 
 CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
 CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
@@ -125,6 +125,7 @@
 obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 obj-$(CONFIG_SCSI_FCAL)		+= fcal.o
 obj-$(CONFIG_SCSI_CPQFCTS)	+= cpqfc.o
+obj-$(CONFIG_SCSI_LASI700)	+= lasi700.o 53c700-mem.o
 
 ifeq ($(CONFIG_ARCH_ACORN),y)
 mod-subdirs	+= ../acorn/scsi
@@ -200,13 +201,19 @@
 
 53c700_d.h: 53c700.scr script_asm.pl
 	$(PERL) -s script_asm.pl -ncr7x0_family < 53c700.scr
+	rm -f scriptu.h
 	mv script.h 53c700_d.h
-	mv scriptu.h 53c700_u.h
 
 53c700.o: 53c700_d.h
 
+53c700-mem.o: 53c700_d.h
+
+53c700-mem.c: 53c700.c
+	echo "/* WARNING: GENERATED FILE (from $<), DO NOT MODIFY */" > $@
+	echo "#define MEM_MAPPED" >> $@
+	cat $< >> $@
+
 cpqfc.o: cpqfcTSinit.o cpqfcTScontrol.o cpqfcTSi2c.o cpqfcTSworker.o \
 	cpqfcTStrigger.o
 	$(LD) -r -o cpqfc.o cpqfcTSinit.o cpqfcTScontrol.o \
 	cpqfcTSi2c.o cpqfcTSworker.o cpqfcTStrigger.o
-
Index: linux/2.4/drivers/scsi/NCR_D700.c
diff -u linux/2.4/drivers/scsi/NCR_D700.c:1.1.1.1 linux/2.4/drivers/scsi/NCR_D700.c:1.1.1.1.12.3
--- linux/2.4/drivers/scsi/NCR_D700.c:1.1.1.1	Mon May 14 18:48:23 2001
+++ linux/2.4/drivers/scsi/NCR_D700.c	Tue Sep  4 10:07:46 2001
@@ -126,16 +126,13 @@
 #define STATIC static
 #endif
 
-#ifdef MODULE
-
 char *NCR_D700;			/* command line from insmod */
 
 MODULE_AUTHOR("James Bottomley");
 MODULE_DESCRIPTION("NCR Dual700 SCSI Driver");
+MODULE_LICENSE("GPL");
 MODULE_PARM(NCR_D700, "s");
 
-#endif
-
 static __u8 __initdata id_array[2*(MCA_MAX_SLOT_NR + 1)] =
 	{ [0 ... 2*(MCA_MAX_SLOT_NR + 1)-1] = 7 };
 
@@ -274,7 +271,11 @@
 				continue;
 			}
 			memset(hostdata, 0, sizeof(struct NCR_700_Host_Parameters));
-			request_region(region, 64, "NCR_D700");
+			if(request_region(region, 64, "NCR_D700") == NULL) {
+				printk(KERN_ERR "NCR D700: Failed to reserve IO region 0x%x\n", region);
+				kfree(hostdata);
+				continue;
+			}
 
 			/* Fill in the three required pieces of hostdata */
 			hostdata->base = region;
@@ -283,6 +284,7 @@
 			/* and register the chip */
 			if((host = NCR_700_detect(tpnt, hostdata)) == NULL) {
 				kfree(hostdata);
+				release_region(host->base, 64);
 				continue;
 			}
 			host->irq = irq;
@@ -292,8 +294,8 @@
 			       i, host->this_id);
 			if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700", host)) {
 				printk(KERN_ERR "NCR D700, channel %d: irq problem, detatching\n", i);
+				scsi_unregister(host);
 				NCR_700_release(host);
-				release_region(host->base, 64);
 				continue;
 			}
 			found++;
Index: linux/2.4/drivers/scsi/lasi700.c
diff -u /dev/null linux/2.4/drivers/scsi/lasi700.c:1.1.4.4
--- /dev/null	Fri Sep  7 09:20:20 2001
+++ linux/2.4/drivers/scsi/lasi700.c	Fri Sep  7 09:16:27 2001
@@ -0,0 +1,188 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* PARISC LASI driver for the 53c700 chip
+ *
+ * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
+**-----------------------------------------------------------------------------
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+ */
+
+/*
+ * Many thanks to Richard Hirst <rhirst@linuxcare.com> for patiently
+ * debugging this driver on the parisc architecture and suggesting
+ * many improvements and bug fixes.
+ *
+ * Thanks also go to Linuxcare Inc. for providing several PARISC
+ * machines for me to debug the driver on.
+ */
+
+#ifndef __hppa__
+#error "lasi700 only compiles on hppa architecture"
+#endif
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/stat.h>
+#include <linux/mm.h>
+#include <linux/blk.h>
+#include <linux/sched.h>
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/ioport.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/delay.h>
+#include <asm/gsc.h>
+
+#include <linux/module.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "constants.h"
+
+#include "lasi700.h"
+#include "53c700.h"
+
+#ifdef MODULE
+
+char *lasi700;			/* command line from insmod */
+
+MODULE_AUTHOR("James Bottomley");
+MODULE_DESCRIPTION("lasi700 SCSI Driver");
+MODULE_LICENSE("GPL");
+MODULE_PARM(lasi700, "s");
+
+#endif
+
+#ifdef MODULE
+#define ARG_SEP ' '
+#else
+#define ARG_SEP ','
+#endif
+
+static unsigned long __initdata opt_base;
+static int __initdata opt_irq;
+
+static int __init
+param_setup(char *string)
+{
+	char *pos = string, *next;
+
+	while(pos != NULL && (next = strchr(pos, ':')) != NULL) {
+		int val = (int)simple_strtoul(++next, NULL, 0);
+		
+		if(!strncmp(pos, "addr:", 5))
+			opt_base = val;
+		else if(!strncmp(pos, "irq:", 4))
+			opt_irq = val;
+
+		if((pos = strchr(pos, ARG_SEP)) != NULL)
+			pos++;
+	}
+	return 1;
+}
+
+#ifndef MODULE
+__setup("lasi700=", param_setup);
+#endif
+
+static Scsi_Host_Template __initdata *host_tpnt = NULL;
+static int __initdata host_count = 0;
+static struct parisc_device_id lasi700_scsi_tbl[] = {
+	LASI700_ID_TABLE,
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(parisc, lasi700_scsi_tbl);
+
+static struct parisc_driver lasi700_driver = LASI700_DRIVER;
+
+static int __init
+lasi700_detect(Scsi_Host_Template *tpnt)
+{
+	host_tpnt = tpnt;
+
+#ifdef MODULE
+	if(lasi700)
+		param_setup(lasi700);
+#endif
+
+	register_parisc_driver(&lasi700_driver);
+
+	return (host_count != 0);
+}
+
+static int __init
+lasi700_driver_callback(struct parisc_device *dev)
+{
+	unsigned long base = dev->hpa + LASI_SCSI_CORE_OFFSET;
+	int irq = busdevice_alloc_irq(dev);
+	struct Scsi_Host *host;
+	struct NCR_700_Host_Parameters *hostdata =
+		kmalloc(sizeof(struct NCR_700_Host_Parameters),
+			GFP_KERNEL);
+	if(hostdata == NULL) {
+		printk(KERN_ERR "lasi700: Failed to allocate host data\n");
+		return 1;
+	}
+	memset(hostdata, 0, sizeof(struct NCR_700_Host_Parameters));
+	if(request_mem_region(base, 64, "lasi700") == NULL) {
+		printk(KERN_ERR "lasi700: Failed to claim memory region\n");
+		kfree(hostdata);
+		return 1;
+	}
+	hostdata->base = base;
+	hostdata->differential = 0;
+	hostdata->clock = LASI700_CLOCK;
+	hostdata->force_le_on_be = 1;
+	if((host = NCR_700_detect(host_tpnt, hostdata)) == NULL) {
+		kfree(hostdata);
+		release_mem_region(host->base, 64);
+		return 1;
+	}
+	host->irq = irq;
+	if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "lasi700", host)) {
+		printk(KERN_ERR "lasi700: irq problem, detatching\n");
+		scsi_unregister(host);
+		NCR_700_release(host);
+		return 1;
+	}
+	host_count++;
+	return 0;
+}
+
+static int
+lasi700_release(struct Scsi_Host *host)
+{
+	struct D700_Host_Parameters *hostdata = 
+		(struct D700_Host_Parameters *)host->hostdata[0];
+
+	NCR_700_release(host);
+	kfree(hostdata);
+	free_irq(host->irq, host);
+	release_mem_region(host->base, 64);
+	return 1;
+}
+
+static Scsi_Host_Template driver_template = LASI700_SCSI;
+
+#include "scsi_module.c"
Index: linux/2.4/drivers/scsi/lasi700.h
diff -u /dev/null linux/2.4/drivers/scsi/lasi700.h:1.1.4.3
--- /dev/null	Fri Sep  7 09:20:20 2001
+++ linux/2.4/drivers/scsi/lasi700.h	Fri Sep  7 09:16:27 2001
@@ -0,0 +1,57 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* PARISC LASI driver for the 53c700 chip
+ *
+ * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
+**-----------------------------------------------------------------------------
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+ */
+
+#ifndef _LASI700_H
+#define _LASI700_H
+
+static int lasi700_detect(Scsi_Host_Template *);
+static int lasi700_driver_callback(struct parisc_device *dev);
+static int lasi700_release(struct Scsi_Host *host);
+
+
+#define LASI700_SCSI {				\
+	name:		"LASI SCSI 53c700",	\
+	proc_name:	"lasi700",		\
+	detect:		lasi700_detect,		\
+	release:	lasi700_release,	\
+	this_id:	7,			\
+}
+
+#define LASI700_ID_TABLE {			\
+	hw_type:	HPHW_FIO,		\
+	sversion:	0x071,			\
+	hversion:	HVERSION_ANY_ID,	\
+	hversion_rev:	HVERSION_REV_ANY_ID,	\
+}
+
+#define LASI700_DRIVER {			\
+	name:		"Lasi SCSI",		\
+	id_table:	lasi700_scsi_tbl,	\
+	probe:		lasi700_driver_callback,\
+}
+
+#define LASI700_CLOCK	25
+#define LASI_SCSI_CORE_OFFSET 0x100
+
+#endif

--==_Exmh_-2810631070--


