Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274889AbRIVCA0>; Fri, 21 Sep 2001 22:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274890AbRIVCAS>; Fri, 21 Sep 2001 22:00:18 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:5972
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S274889AbRIVB76>; Fri, 21 Sep 2001 21:59:58 -0400
Message-Id: <200109220200.f8M203E04606@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 53c700 driver completion (against 2.4.10-pre13)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_2480271390"
Date: Fri, 21 Sep 2001 21:00:02 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_2480271390
Content-Type: text/plain; charset=us-ascii

This patch should complete the essential functionality of the 53c700 chip 
driver  (mainly for parisc).  I've tested it on a 53c700 (parisc 715/50) a 
53c700-66 (NCR D700 microchannel) and on a lasi 710 (parisc 712/60).  I've 
done some fairly extensive corruption testing on the parisc architecture 
looking for memory coherency problems and none has shown up so far.  I've also 
cleaned up the driver so it seems to compile OK with the 64 bit parisc 
compiler and made it use the pci mapping functions necessary for the 64 bit 
architecture.

James Bottomley


--==_Exmh_2480271390
Content-Type: text/plain ; name="53c700-2.4.10-pre13.diff"; charset=us-ascii
Content-Description: 53c700-2.4.10-pre13.diff
Content-Disposition: attachment; filename="53c700-2.4.10-pre13.diff"

Index: Documentation/Configure.help
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/Documentation/Configure.help,v
retrieving revision 1.1.1.25
diff -u -r1.1.1.25 Configure.help
--- Documentation/Configure.help	2001/09/21 19:07:16	1.1.1.25
+++ Documentation/Configure.help	2001/09/22 00:36:20
@@ -5991,6 +5991,23 @@
   port or memory mapped. You should know what you have. The most
   common card, Trantor T130B, uses port mapped mode.
 
+NCR Dual 700 MCA SCSI support
+CONFIG_SCSI_NCR_D700
+  This is a driver for the MicroChannel Dual 700 card produced by
+  NCR and commonly used in 345x/35xx/4100 class machines.  It always
+  tries to negotiate sync and uses tag command queueing.
+
+  Unless you have an NCR manufactured machine, the chances are that
+  you do not have this SCSI card, so say N.
+
+HP LASI SCSI support for 53c700
+CONFIG_SCSI_LASI700
+  This is a driver for the lasi baseboard in some parisc machines
+  which is based on the 53c700 chip.  Will also support LASI subsystems
+  based on the 710 chip using 700 emulation mode.
+
+  Unless you know you have a 53c700 or 53c710 based lasi, say N here
+
 NCR53c7,8xx SCSI support
 CONFIG_SCSI_NCR53C7xx
   This is a driver for the 53c7 and 8xx NCR family of SCSI
Index: drivers/scsi/53c700.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/53c700.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 53c700.c
--- drivers/scsi/53c700.c	2001/09/08 01:39:47	1.1.1.3
+++ drivers/scsi/53c700.c	2001/09/22 00:36:28
@@ -51,6 +51,19 @@
 
 /* CHANGELOG
  *
+ * Version 2.5
+ * 
+ * More Compatibility changes for 710 (now actually works).  Enhanced
+ * support for odd clock speeds which constrain SDTR negotiations.
+ * correct cacheline separation for scsi messages and status for
+ * incoherent architectures.  Use of the pci mapping functions on
+ * buffers to begin support for 64 bit drivers.
+ *
+ * Version 2.4
+ *
+ * Added support for the 53c710 chip (in 53c700 emulation mode only---no 
+ * special 53c710 instructions or registers are used).
+ *
  * Version 2.3
  *
  * More endianness/cache coherency changes.
@@ -77,7 +90,7 @@
  * Initial modularisation from the D700.  See NCR_D700.c for the rest of
  * the changelog.
  * */
-#define NCR_700_VERSION "2.3"
+#define NCR_700_VERSION "2.5"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -98,6 +111,7 @@
 #include <asm/byteorder.h>
 #include <linux/blk.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 
 #include "scsi.h"
 #include "hosts.h"
@@ -105,6 +119,14 @@
 
 #include "53c700.h"
 
+/* NOTE: For 64 bit drivers there are points in the code where we use
+ * a non dereferenceable pointer to point to a structure in dma-able
+ * memory (which is 32 bits) so that we can use all of the structure
+ * operations but take the address at the end.  This macro allows us
+ * to truncate the 64 bit pointer down to 32 bits without the compiler
+ * complaining */
+#define to32bit(x)	((__u32)((unsigned long)(x)))
+
 #ifdef NCR_700_DEBUG
 #define STATIC
 #else
@@ -195,12 +217,19 @@
 NCR_700_detect(Scsi_Host_Template *tpnt,
 	       struct NCR_700_Host_Parameters *hostdata)
 {
-	__u32 *script = kmalloc(sizeof(SCRIPT), GFP_KERNEL);
-	__u32 pScript;
+	dma_addr_t pScript, pSlots;
+	__u32 *script;
 	struct Scsi_Host *host;
 	static int banner = 0;
 	int j;
 
+	/* This separation of pScript and script is not strictly
+	 * necessay, but may be useful in architectures which can
+	 * allocate consistent memory on which virt_to_bus will not
+	 * work */
+	script = kmalloc(sizeof(SCRIPT), GFP_KERNEL);
+	pScript = virt_to_bus(script);
+
 	/* Fill in the missing routines from the host template */
 	tpnt->queuecommand = NCR_700_queuecommand;
 	tpnt->eh_abort_handler = NCR_700_abort;
@@ -228,40 +257,57 @@
 		return NULL;
 	}
 
-	hostdata->slots = kmalloc(sizeof(struct NCR_700_command_slot) * NCR_700_COMMAND_SLOTS_PER_HOST, GFP_KERNEL);
-	if(hostdata->slots == NULL) {
-		printk(KERN_ERR "53c700: Failed to allocate command slots, detatching\n");
+	/* This separation of slots and pSlots may facilitate later
+	 * migration to consistent memory on architectures which
+	 * support it */
+	hostdata->slots = kmalloc(sizeof(struct NCR_700_command_slot)
+				  * NCR_700_COMMAND_SLOTS_PER_HOST,
+				  GFP_KERNEL);
+	pSlots = virt_to_bus(hostdata->slots);
+
+	hostdata->msgin = kmalloc(MSG_ARRAY_SIZE, GFP_KERNEL);
+	hostdata->msgout = kmalloc(MSG_ARRAY_SIZE, GFP_KERNEL);
+	hostdata->status = kmalloc(MSG_ARRAY_SIZE, GFP_KERNEL);
+	if(hostdata->slots == NULL || hostdata->msgin == NULL
+	   || hostdata->msgout == NULL || hostdata->status==NULL) {
+		printk(KERN_ERR "53c700: Failed to allocate command slots or message buffers, detatching\n");
 		scsi_unregister(host);
 		return NULL;
 	}
-	memset(hostdata->slots, 0, sizeof(struct NCR_700_command_slot) * NCR_700_COMMAND_SLOTS_PER_HOST);
+	memset(hostdata->slots, 0, sizeof(struct NCR_700_command_slot)
+	       * NCR_700_COMMAND_SLOTS_PER_HOST);
 	for(j = 0; j < NCR_700_COMMAND_SLOTS_PER_HOST; j++) {
+		dma_addr_t offset = (dma_addr_t)((unsigned long)&hostdata->slots[j].SG[0]
+					  - (unsigned long)&hostdata->slots[0].SG[0]);
+		hostdata->slots[j].pSG = (struct NCR_700_SG_List *)((unsigned long)(pSlots + offset));
 		if(j == 0)
 			hostdata->free_list = &hostdata->slots[j];
 		else
 			hostdata->slots[j-1].ITL_forw = &hostdata->slots[j];
 		hostdata->slots[j].state = NCR_700_SLOT_FREE;
 	}
-	host->hostdata[0] = (__u32)hostdata;
+
 	for(j = 0; j < sizeof(SCRIPT)/sizeof(SCRIPT[0]); j++) {
 		script[j] = bS_to_host(SCRIPT[j]);
 	}
-	/* bus physical address of script */
-	pScript = virt_to_bus(script);
+
 	/* adjust all labels to be bus physical */
 	for(j = 0; j < PATCHES; j++) {
 		script[LABELPATCHES[j]] = bS_to_host(pScript + SCRIPT[LABELPATCHES[j]]);
 	}
-	/* now patch up fixed addresses */
+	/* now patch up fixed addresses. 
+	 * NOTE: virt_to_bus may be wrong if consistent memory is used
+	 * for these in the future */
 	script_patch_32(script, MessageLocation,
 			virt_to_bus(&hostdata->msgout[0]));
 	script_patch_32(script, StatusAddress,
-			virt_to_bus(&hostdata->status));
+			virt_to_bus(&hostdata->status[0]));
 	script_patch_32(script, ReceiveMsgAddress,
 			virt_to_bus(&hostdata->msgin[0]));
 
 	hostdata->script = script;
 	hostdata->pScript = pScript;
+	dma_cache_wback((unsigned long)script, sizeof(SCRIPT));
 	hostdata->state = NCR_700_HOST_FREE;
 	spin_lock_init(&hostdata->lock);
 	hostdata->cmd = NULL;
@@ -272,19 +318,22 @@
 	host->hostdata[0] = (unsigned long)hostdata;
 	/* kick the chip */
 	NCR_700_writeb(0xff, host, CTEST9_REG);
-	hostdata->rev = (NCR_700_readb(host, CTEST7_REG)<<4) & 0x0f;
+	if(hostdata->chip710) 
+		hostdata->rev = (NCR_700_readb(host, CTEST8_REG)>>4) & 0x0f;
+	else
+		hostdata->rev = (NCR_700_readb(host, CTEST7_REG)>>4) & 0x0f;
 	hostdata->fast = (NCR_700_readb(host, CTEST9_REG) == 0);
 	if(banner == 0) {
 		printk(KERN_NOTICE "53c700: Version " NCR_700_VERSION " By James.Bottomley@HansenPartnership.com\n");
 		banner = 1;
 	}
 	printk(KERN_NOTICE "scsi%d: %s rev %d %s\n", host->host_no,
-	       hostdata->fast ? "53c700-66" : "53c700",
+	       hostdata->chip710 ? "53c710" : 
+	       (hostdata->fast ? "53c700-66" : "53c700"),
 	       hostdata->rev, hostdata->differential ?
 	       "(Differential)" : "");
 	/* reset the chip */
 	NCR_700_chip_reset(host);
-	NCR_700_writeb(ASYNC_OPERATION , host, SXFER_REG);
 
 	return host;
 }
@@ -295,7 +344,13 @@
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 
+	/* NOTE: these may be NULL if we weren't fully initialised before
+	 * the scsi_unregister was called */
 	kfree(hostdata->script);
+	kfree(hostdata->slots);
+	kfree(hostdata->msgin);
+	kfree(hostdata->msgout);
+	kfree(hostdata->status);
 	return 1;
 }
 
@@ -308,24 +363,32 @@
 }
 
 /*
- * Function : static int datapath_residual (Scsi_Host *host)
+ * Function : static int data_residual (Scsi_Host *host)
  *
  * Purpose : return residual data count of what's in the chip.  If you
  * really want to know what this function is doing, it's almost a
  * direct transcription of the algorithm described in the 53c710
  * guide, except that the DBC and DFIFO registers are only 6 bits
- * wide.
+ * wide on a 53c700.
  *
  * Inputs : host - SCSI host */
 static inline int
 NCR_700_data_residual (struct Scsi_Host *host) {
-	int count, synchronous;
+	struct NCR_700_Host_Parameters *hostdata = 
+		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+	int count, synchronous = 0;
 	unsigned int ddir;
 
-	count = ((NCR_700_readb(host, DFIFO_REG) & 0x3f) -
-		 (NCR_700_readl(host, DBC_REG) & 0x3f)) & 0x3f;
+	if(hostdata->chip710) {
+		count = ((NCR_700_readb(host, DFIFO_REG) & 0x7f) -
+			 (NCR_700_readl(host, DBC_REG) & 0x7f)) & 0x7f;
+	} else {
+		count = ((NCR_700_readb(host, DFIFO_REG) & 0x3f) -
+			 (NCR_700_readl(host, DBC_REG) & 0x3f)) & 0x3f;
+	}
 	
-	synchronous = NCR_700_readb(host, SXFER_REG) & 0x0f;
+	if(hostdata->fast)
+		synchronous = NCR_700_readb(host, SXFER_REG) & 0x0f;
 	
 	/* get the data direction */
 	ddir = NCR_700_readb(host, CTEST0_REG) & 0x01;
@@ -345,6 +408,10 @@
 		if (synchronous && (sstat & SODR_REG_FULL))
 			++count;
 	}
+#ifdef NCR_700_DEBUG
+	if(count)
+		printk("RESIDUAL IS %d (ddir %d)\n", count, ddir);
+#endif
 	return count;
 }
 
@@ -530,21 +597,26 @@
 			       __u8 offset, __u8 period)
 {
 	int XFERP;
-
-	if(period*4 < NCR_700_MIN_PERIOD) {
-		printk(KERN_WARNING "53c700: Period %dns is less than SCSI-2 minimum, setting to %d\n", period*4, NCR_700_MIN_PERIOD);
-		period = NCR_700_MIN_PERIOD/4;
+	__u8 min_xferp = (hostdata->chip710
+			  ? NCR_710_MIN_XFERP : NCR_700_MIN_XFERP);
+	__u8 max_offset = (hostdata->chip710
+			   ? NCR_710_MAX_OFFSET : NCR_700_MAX_OFFSET);
+	/* NOTE: NCR_700_SDTR_msg[3] contains our offer of the minimum
+	 * period.  It is set in NCR_700_chip_setup() */
+	if(period < NCR_700_SDTR_msg[3]) {
+		printk(KERN_WARNING "53c700: Period %dns is less than this chip's minimum, setting to %d\n", period*4, NCR_700_SDTR_msg[3]*4);
+		period = NCR_700_SDTR_msg[3];
 	}
 	XFERP = (period*4 * hostdata->sync_clock)/1000 - 4;
-	if(offset > NCR_700_MAX_OFFSET) {
-		printk(KERN_WARNING "53c700: Offset %d exceeds maximum, setting to %d\n",
-		       offset, NCR_700_MAX_OFFSET);
-		offset = NCR_700_MAX_OFFSET;
+	if(offset > max_offset) {
+		printk(KERN_WARNING "53c700: Offset %d exceeds chip maximum, setting to %d\n",
+		       offset, max_offset);
+		offset = max_offset;
 	}
-	if(XFERP < NCR_700_MIN_XFERP) {
+	if(XFERP < min_xferp) {
 		printk(KERN_WARNING "53c700: XFERP %d is less than minium, setting to %d\n",
-		       XFERP,  NCR_700_MIN_XFERP);
-		XFERP =  NCR_700_MIN_XFERP;
+		       XFERP,  min_xferp);
+		XFERP =  min_xferp;
 	}
 	return (offset & 0x0f) | (XFERP & 0x07)<<4;
 }
@@ -563,14 +635,28 @@
 
 		if(SCp->cmnd[0] == REQUEST_SENSE && SCp->cmnd[6] == NCR_700_INTERNAL_SENSE_MAGIC) {
 #ifdef NCR_700_DEBUG
-			printk(" ORIGINAL CMD %p RETURNED %d, new return is %d sense is",
+			printk(" ORIGINAL CMD %p RETURNED %d, new return is %d sense is\n",
 			       SCp, SCp->cmnd[7], result);
 			print_sense("53c700", SCp);
 #endif
 			if(result == 0)
 				result = SCp->cmnd[7];
 		}
-			
+
+		if(SCp->sc_data_direction != SCSI_DATA_NONE &&
+		   SCp->sc_data_direction != SCSI_DATA_UNKNOWN) {
+			int pci_direction = scsi_to_pci_dma_dir(SCp->sc_data_direction);
+			if(SCp->use_sg) {
+				pci_unmap_sg(hostdata->pci_dev, SCp->buffer,
+					     SCp->use_sg, pci_direction);
+			} else {
+				pci_unmap_single(hostdata->pci_dev,
+						 slot->dma_handle,
+						 SCp->request_bufflen,
+						 pci_direction);
+			}
+		}
+
 		free_slot(slot, hostdata);
 
 		SCp->host_scribble = NULL;
@@ -602,19 +688,47 @@
 {
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+	__u32 dcntl_extra = 0;
+	__u8 min_period;
+	__u8 min_xferp = (hostdata->chip710 ? NCR_710_MIN_XFERP : NCR_700_MIN_XFERP);
+
+	if(hostdata->chip710) {
+		__u8 burst_disable = hostdata->burst_disable
+			? BURST_DISABLE : 0;
+		dcntl_extra = COMPAT_700_MODE;
+
+		NCR_700_writeb(dcntl_extra, host, DCNTL_REG);
+		NCR_700_writeb(BURST_LENGTH_8  | hostdata->dmode_extra,
+			       host, DMODE_710_REG);
+		NCR_700_writeb(burst_disable | (hostdata->differential ? 
+						DIFF : 0), host, CTEST7_REG);
+		NCR_700_writeb(BTB_TIMER_DISABLE, host, CTEST0_REG);
+		NCR_700_writeb(FULL_ARBITRATION | ENABLE_PARITY | PARITY
+			       | AUTO_ATN, host, SCNTL0_REG);
+	} else {
+		NCR_700_writeb(BURST_LENGTH_8 | hostdata->dmode_extra,
+			       host, DMODE_700_REG);
+		NCR_700_writeb(hostdata->differential ? 
+			       DIFF : 0, host, CTEST7_REG);
+		if(hostdata->fast) {
+			/* this is for 700-66, does nothing on 700 */
+			NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION 
+				       | GENERATE_RECEIVE_PARITY, host,
+				       CTEST8_REG);
+		} else {
+			NCR_700_writeb(FULL_ARBITRATION | ENABLE_PARITY
+				       | PARITY | AUTO_ATN, host, SCNTL0_REG);
+		}
+	}
 
 	NCR_700_writeb(1 << host->this_id, host, SCID_REG);
 	NCR_700_writeb(0, host, SBCL_REG);
-	NCR_700_writeb(0, host, SXFER_REG);
+	NCR_700_writeb(ASYNC_OPERATION, host, SXFER_REG);
 
 	NCR_700_writeb(PHASE_MM_INT | SEL_TIMEOUT_INT | GROSS_ERR_INT | UX_DISC_INT
 	     | RST_INT | PAR_ERR_INT | SELECT_INT, host, SIEN_REG);
 
 	NCR_700_writeb(ABORT_INT | INT_INST_INT | ILGL_INST_INT, host, DIEN_REG);
-	NCR_700_writeb(BURST_LENGTH_8, host, DMODE_REG);
-	NCR_700_writeb(FULL_ARBITRATION | PARITY | AUTO_ATN, host, SCNTL0_REG);
-	NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION|GENERATE_RECEIVE_PARITY,
-	     host, CTEST8_REG);
 	NCR_700_writeb(ENABLE_SELECT, host, SCNTL1_REG);
 	if(hostdata->clock > 75) {
 		printk(KERN_ERR "53c700: Clock speed %dMHz is too high: 75Mhz is the maximum this chip can be driven at\n", hostdata->clock);
@@ -622,13 +736,13 @@
 		 * of spec: sync divider 2, async divider 3 */
 		DEBUG(("53c700: sync 2 async 3\n"));
 		NCR_700_writeb(SYNC_DIV_2_0, host, SBCL_REG);
-		NCR_700_writeb(ASYNC_DIV_3_0, host, DCNTL_REG);
+		NCR_700_writeb(ASYNC_DIV_3_0 | dcntl_extra, host, DCNTL_REG);
 		hostdata->sync_clock = hostdata->clock/2;
 	} else	if(hostdata->clock > 50  && hostdata->clock <= 75) {
 		/* sync divider 1.5, async divider 3 */
 		DEBUG(("53c700: sync 1.5 async 3\n"));
 		NCR_700_writeb(SYNC_DIV_1_5, host, SBCL_REG);
-		NCR_700_writeb(ASYNC_DIV_3_0, host, DCNTL_REG);
+		NCR_700_writeb(ASYNC_DIV_3_0 | dcntl_extra, host, DCNTL_REG);
 		hostdata->sync_clock = hostdata->clock*2;
 		hostdata->sync_clock /= 3;
 		
@@ -636,30 +750,49 @@
 		/* sync divider 1, async divider 2 */
 		DEBUG(("53c700: sync 1 async 2\n"));
 		NCR_700_writeb(SYNC_DIV_1_0, host, SBCL_REG);
-		NCR_700_writeb(ASYNC_DIV_2_0, host, DCNTL_REG);
+		NCR_700_writeb(ASYNC_DIV_2_0 | dcntl_extra, host, DCNTL_REG);
 		hostdata->sync_clock = hostdata->clock;
 	} else if(hostdata->clock > 25 && hostdata->clock <=37) {
 		/* sync divider 1, async divider 1.5 */
 		DEBUG(("53c700: sync 1 async 1.5\n"));
 		NCR_700_writeb(SYNC_DIV_1_0, host, SBCL_REG);
-		NCR_700_writeb(ASYNC_DIV_1_5, host, DCNTL_REG);
+		NCR_700_writeb(ASYNC_DIV_1_5 | dcntl_extra, host, DCNTL_REG);
 		hostdata->sync_clock = hostdata->clock;
 	} else {
 		DEBUG(("53c700: sync 1 async 1\n"));
 		NCR_700_writeb(SYNC_DIV_1_0, host, SBCL_REG);
-		NCR_700_writeb(ASYNC_DIV_1_0, host, DCNTL_REG);
+		NCR_700_writeb(ASYNC_DIV_1_0 | dcntl_extra, host, DCNTL_REG);
 		/* sync divider 1, async divider 1 */
+		hostdata->sync_clock = hostdata->clock;
+	}
+	/* Calculate the actual minimum period that can be supported
+	 * by our synchronous clock speed.  See the 710 manual for
+	 * exact details of this calculation which is based on a
+	 * setting of the SXFER register */
+	min_period = 1000*(4+min_xferp)/(4*hostdata->sync_clock);
+	if(min_period > NCR_700_MIN_PERIOD) {
+		NCR_700_SDTR_msg[3] = min_period;
 	}
+	if(hostdata->chip710)
+		NCR_700_SDTR_msg[4] = NCR_710_MAX_OFFSET;
 }
 
 STATIC void
 NCR_700_chip_reset(struct Scsi_Host *host)
 {
-	/* Chip reset */
-	NCR_700_writeb(SOFTWARE_RESET, host, DCNTL_REG);
-	udelay(100);
+	struct NCR_700_Host_Parameters *hostdata = 
+		(struct NCR_700_Host_Parameters *)host->hostdata[0];
+	if(hostdata->chip710) {
+		NCR_700_writeb(SOFTWARE_RESET_710, host, ISTAT_REG);
+		udelay(100);
 
-	NCR_700_writeb(0, host, DCNTL_REG);
+		NCR_700_writeb(0, host, ISTAT_REG);
+	} else {
+		NCR_700_writeb(SOFTWARE_RESET, host, DCNTL_REG);
+		udelay(100);
+		
+		NCR_700_writeb(0, host, DCNTL_REG);
+	}
 
 	mdelay(1000);
 
@@ -717,7 +850,7 @@
 			printk(KERN_WARNING "scsi%d Unexpected SDTR msg\n",
 			       host->host_no);
 			hostdata->msgout[0] = A_REJECT_MSG;
-			dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
+			dma_cache_wback((unsigned long)hostdata->msgout, 1);
 			script_patch_16(hostdata->script, MessageCount, 1);
 			/* SendMsgOut returns, so set up the return
 			 * address */
@@ -729,7 +862,7 @@
 		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
 		       host->host_no, pun, lun);
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
+		dma_cache_wback((unsigned long)hostdata->msgout, 1);
 		script_patch_16(hostdata->script, MessageCount, 1);
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 
@@ -743,7 +876,7 @@
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
+		dma_cache_wback((unsigned long)hostdata->msgout, 1);
 		script_patch_16(hostdata->script, MessageCount, 1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
@@ -761,8 +894,6 @@
 	__u32 temp = dsp + 8, resume_offset = dsp;
 	__u8 pun = 0xff, lun = 0xff;
 
-	dma_cache_inv((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
-
 	if(SCp != NULL) {
 		pun = SCp->target;
 		lun = SCp->lun;
@@ -778,8 +909,9 @@
 	switch(hostdata->msgin[0]) {
 
 	case A_EXTENDED_MSG:
-		return process_extended_message(host, hostdata, SCp,
-						dsp, dsps);
+		resume_offset =  process_extended_message(host, hostdata, SCp,
+							  dsp, dsps);
+		break;
 
 	case A_REJECT_MSG:
 		if(SCp != NULL && NCR_700_is_flag_set(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION)) {
@@ -792,6 +924,8 @@
 			printk(KERN_WARNING "scsi%d (%d:%d) Rejected first tag queue attempt, turning off tag queueing\n", host->host_no, pun, lun);
 			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
 			hostdata->tag_negotiated &= ~(1<<SCp->target);
+			SCp->device->tagged_queue = 0;
+			SCp->device->tagged_supported = 0;
 		} else {
 			printk(KERN_WARNING "scsi%d (%d:%d) Unexpected REJECT Message %s\n",
 			       host->host_no, pun, lun,
@@ -820,7 +954,7 @@
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_wback((unsigned long)hostdata->msgout, sizeof(hostdata->msgout));
+		dma_cache_wback((unsigned long)hostdata->msgout, 1);
 		script_patch_16(hostdata->script, MessageCount, 1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
@@ -829,6 +963,8 @@
 		break;
 	}
 	NCR_700_writel(temp, host, TEMP_REG);
+	/* set us up to receive another message */
+	dma_cache_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
 	return resume_offset;
 }
 
@@ -846,25 +982,26 @@
 	}
 
 	if(dsps == A_GOOD_STATUS_AFTER_STATUS) {
-		dma_cache_inv((unsigned long)hostdata->status, sizeof(hostdata->status));
 		DEBUG(("  COMMAND COMPLETE, status=%02x\n",
-		       hostdata->status));
+		       hostdata->status[0]));
 		/* OK, if TCQ still on, we know it works */
 		NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
 		/* check for contingent allegiance contitions */
-		if(status_byte(hostdata->status) == CHECK_CONDITION ||
-		   status_byte(hostdata->status) == COMMAND_TERMINATED) {
+		if(status_byte(hostdata->status[0]) == CHECK_CONDITION ||
+		   status_byte(hostdata->status[0]) == COMMAND_TERMINATED) {
 			struct NCR_700_command_slot *slot =
 				(struct NCR_700_command_slot *)SCp->host_scribble;
 			if(SCp->cmnd[0] == REQUEST_SENSE) {
 				/* OOPS: bad device, returning another
 				 * contingent allegiance condition */
 				printk(KERN_ERR "scsi%d (%d:%d) broken device is looping in contingent allegiance: ignoring\n", host->host_no, pun, lun);
-				NCR_700_scsi_done(hostdata, SCp, hostdata->status);
+				NCR_700_scsi_done(hostdata, SCp, hostdata->status[0]);
 			} else {
-
-				DEBUG(("  cmd %p has status %d, requesting sense\n",
-				       SCp, hostdata->status));
+#ifdef NCR_DEBUG
+				print_command(SCp->cmnd);
+				printk("  cmd %p has status %d, requesting sense\n",
+				       SCp, hostdata->status[0]);
+#endif
 				/* we can destroy the command here because the
 				 * contingent allegiance condition will cause a 
 				 * retry which will re-copy the command from the
@@ -881,7 +1018,9 @@
 				 * was an internal sense request and the original
 				 * status at the end of the command */
 				SCp->cmnd[6] = NCR_700_INTERNAL_SENSE_MAGIC;
-				SCp->cmnd[7] = hostdata->status;
+				SCp->cmnd[7] = hostdata->status[0];
+				SCp->sc_data_direction = SCSI_DATA_READ;
+				dma_cache_wback((unsigned long)SCp->cmnd, SCp->cmd_len);
 				slot->SG[0].ins = bS_to_host(SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer));
 				slot->SG[0].pAddr = bS_to_host(virt_to_bus(SCp->sense_buffer));
 				slot->SG[1].ins = bS_to_host(SCRIPT_RETURN);
@@ -896,20 +1035,27 @@
 				hostdata->cmd = NULL;
 			}
 		} else {
-			if(status_byte(hostdata->status) == GOOD &&
-			   SCp->cmnd[0] == INQUIRY && SCp->use_sg == 0) {
-				/* Piggy back the tag queueing support
-				 * on this command */
-				if(((char *)SCp->request_buffer)[7] & 0x02) {
-					printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", host->host_no, pun, lun);
-					hostdata->tag_negotiated |= (1<<SCp->target);
-					NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
-				} else {
-					NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
-					hostdata->tag_negotiated &= ~(1<<SCp->target);
-				}
-			}
-			NCR_700_scsi_done(hostdata, SCp, hostdata->status);
+			// Currently rely on the mid layer evaluation
+			// of the tag queuing capability
+			//
+			//if(status_byte(hostdata->status[0]) == GOOD &&
+			//   SCp->cmnd[0] == INQUIRY && SCp->use_sg == 0) {
+			//	/* Piggy back the tag queueing support
+			//	 * on this command */
+			//	pci_dma_sync_single(hostdata->pci_dev,
+			//			    slot->dma_handle,
+			//			    SCp->request_bufflen,
+			//			    PCI_DMA_FROMDEVICE);
+			//	if(((char *)SCp->request_buffer)[7] & 0x02) {
+			//		printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", host->host_no, pun, lun);
+			//		hostdata->tag_negotiated |= (1<<SCp->target);
+			//		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
+			//	} else {
+			//		NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
+			//		hostdata->tag_negotiated &= ~(1<<SCp->target);
+			//	}
+			//}
+			NCR_700_scsi_done(hostdata, SCp, hostdata->status[0]);
 		}
 	} else if((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE) {
 		__u8 i = (dsps & 0xf00) >> 8;
@@ -947,8 +1093,6 @@
 		struct NCR_700_command_slot *slot;
 		__u8 reselection_id = hostdata->reselection_id;
 
-		dma_cache_inv((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
-
 		lun = hostdata->msgin[0] & 0x1f;
 
 		hostdata->reselection_id = 0xff;
@@ -996,7 +1140,7 @@
 			script_patch_16(hostdata->script,
 					CommandCount, slot->cmnd->cmd_len);
 			script_patch_32_abs(hostdata->script, SGScriptStartAddress,
-					    virt_to_bus(&slot->SG[0].ins));
+					    to32bit(&slot->pSG[0].ins));
 
 			/* Note: setting SXFER only works if we're
 			 * still in the MESSAGE phase, so it is vital
@@ -1005,6 +1149,16 @@
 			 * should therefore always clear ACK */
 			NCR_700_writeb(NCR_700_get_SXFER(hostdata->cmd->device),
 				       host, SXFER_REG);
+			dma_cache_inv((unsigned long)hostdata->msgin,
+				      MSG_ARRAY_SIZE);
+			dma_cache_wback((unsigned long)hostdata->msgout,
+					MSG_ARRAY_SIZE);
+			/* I'm just being paranoid here, the command should
+			 * already have been flushed from the cache */
+			dma_cache_wback((unsigned long)slot->cmnd->cmnd,
+					slot->cmnd->cmd_len);
+
+
 			
 		}
 	} else if(dsps == A_RESELECTED_DURING_SELECTION) {
@@ -1022,20 +1176,22 @@
 		/* Take out our own ID */
 		reselection_id &= ~(1<<host->this_id);
 		
-		printk(KERN_INFO "scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%p[%04x] state=%d, count=%d\n",
-		       host->host_no, reselection_id, lun, (void *)dsp, dsp - hostdata->pScript, hostdata->state, hostdata->command_slot_count);
+		/* I've never seen this happen, so keep this as a printk rather
+		 * than a debug */
+		printk(KERN_INFO "scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%08x[%04x] state=%d, count=%d\n",
+		       host->host_no, reselection_id, lun, dsp, dsp - hostdata->pScript, hostdata->state, hostdata->command_slot_count);
 
 		{
 			/* FIXME: DEBUGGING CODE */
-			__u32 SG = (__u32)bus_to_virt(hostdata->script[A_SGScriptStartAddress_used[0]]);
+			__u32 SG = (__u32)bS_to_cpu(hostdata->script[A_SGScriptStartAddress_used[0]]);
 			int i;
 
 			for(i=0; i< NCR_700_COMMAND_SLOTS_PER_HOST; i++) {
-				if(SG >= (__u32)(&hostdata->slots[i].SG[0])
-				   && SG <= (__u32)(&hostdata->slots[i].SG[NCR_700_SG_SEGMENTS]))
+				if(SG >= to32bit(&hostdata->slots[i].pSG[0])
+				   && SG <= to32bit(&hostdata->slots[i].pSG[NCR_700_SG_SEGMENTS]))
 					break;
 			}
-			printk(KERN_INFO "IDENTIFIED SG segment as being %p in slot %p, cmd %p, slot->resume_offset=%p\n", (void *)SG, &hostdata->slots[i], hostdata->slots[i].cmnd, (void *)hostdata->slots[i].resume_offset);
+			printk(KERN_INFO "IDENTIFIED SG segment as being %08x in slot %p, cmd %p, slot->resume_offset=%08x\n", SG, &hostdata->slots[i], hostdata->slots[i].cmnd, hostdata->slots[i].resume_offset);
 			SCp =  hostdata->slots[i].cmnd;
 		}
 
@@ -1061,8 +1217,9 @@
 			reselection_id = bitmap_to_number(reselection_id);
 		}
 		hostdata->reselection_id = reselection_id;
+		/* just in case we have a stale simple tag message, clear it */
 		hostdata->msgin[1] = 0;
-		dma_cache_wback((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
+		dma_cache_wback_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
 		if(hostdata->tag_negotiated & (1<<reselection_id)) {
 			resume_offset = hostdata->pScript + Ent_GetReselectionWithTag;
 		} else {
@@ -1092,8 +1249,8 @@
 		}	       
 		NCR_700_internal_bus_reset(host);
 	} else if((dsps & 0xfffff000) == A_DEBUG_INTERRUPT) {
-		printk(KERN_NOTICE "scsi%d (%d:%d) DEBUG INTERRUPT %d AT %p[%04x], continuing\n",
-		       host->host_no, pun, lun, dsps & 0xfff, (void *)dsp, dsp - hostdata->pScript);
+		printk(KERN_NOTICE "scsi%d (%d:%d) DEBUG INTERRUPT %d AT %08x[%04x], continuing\n",
+		       host->host_no, pun, lun, dsps & 0xfff, dsp, dsp - hostdata->pScript);
 		resume_offset = dsp;
 	} else {
 		printk(KERN_ERR "scsi%d: (%d:%d), unidentified script interrupt 0x%x at %04x\n",
@@ -1122,7 +1279,8 @@
 	__u8 sbcl;
 
 	for(count = 0; count < 5; count++) {
-		id = NCR_700_readb(host, SFBR_REG);
+		id = NCR_700_readb(host, hostdata->chip710 ?
+				   CTEST9_REG : SFBR_REG);
 
 		/* Take out our own ID */
 		id &= ~(1<<host->this_id);
@@ -1174,8 +1332,9 @@
 	}
 	hostdata->state = NCR_700_HOST_BUSY;
 	hostdata->cmd = NULL;
+	/* clear any stale simple tag message */
 	hostdata->msgin[1] = 0;
-	dma_cache_wback((unsigned long)hostdata->msgin, sizeof(hostdata->msgin));
+	dma_cache_wback_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
 
 	if(id == 0xff) {
 		/* Selected as target, Ignore */
@@ -1188,7 +1347,33 @@
 	return resume_offset;
 }
 
+static inline void
+NCR_700_clear_fifo(struct Scsi_Host *host) {
+	const struct NCR_700_Host_Parameters *hostdata
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+	if(hostdata->chip710) {
+		NCR_700_writeb(CLR_FIFO_710, host, CTEST8_REG);
+	} else {
+		NCR_700_writeb(CLR_FIFO, host, DFIFO_REG);
+	}
+}
+
+static inline void
+NCR_700_flush_fifo(struct Scsi_Host *host) {
+	const struct NCR_700_Host_Parameters *hostdata
+		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
+	if(hostdata->chip710) {
+		NCR_700_writeb(FLUSH_DMA_FIFO_710, host, CTEST8_REG);
+		udelay(10);
+		NCR_700_writeb(0, host, CTEST8_REG);
+	} else {
+		NCR_700_writeb(FLUSH_DMA_FIFO, host, DFIFO_REG);
+		udelay(10);
+		NCR_700_writeb(0, host, DFIFO_REG);
+	}
+}
 
+
 STATIC int
 NCR_700_start_command(Scsi_Cmnd *SCp)
 {
@@ -1227,9 +1412,10 @@
 		NCR_700_clear_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
 	}
 
-	/* REQUEST_SENSE is asking for contingent I_T_L status.  If a
-	 * contingent allegiance condition exists, the device will
-	 * refuse all tags, so send the request sense as untagged */
+	/* REQUEST_SENSE is asking for contingent I_T_L(_Q) status.
+	 * If a contingent allegiance condition exists, the device
+	 * will refuse all tags, so send the request sense as untagged
+	 * */
 	if((hostdata->tag_negotiated & (1<<SCp->target))
 	   && (slot->tag != NCR_700_NO_TAG && SCp->cmnd[0] != REQUEST_SENSE)) {
 		hostdata->msgout[count++] = A_SIMPLE_TAG_MSG;
@@ -1244,8 +1430,6 @@
 		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
 	}
 
-	dma_cache_wback((unsigned long)hostdata->msgout, count);
-
 	script_patch_16(hostdata->script, MessageCount, count);
 
 
@@ -1258,20 +1442,27 @@
 	/* finally plumb the beginning of the SG list into the script
 	 * */
 	script_patch_32_abs(hostdata->script, SGScriptStartAddress,
-			    virt_to_bus(&slot->SG[0].ins));
-	NCR_700_writeb(CLR_FIFO, SCp->host, DFIFO_REG);
+			    to32bit(&slot->pSG[0].ins));
+	NCR_700_clear_fifo(SCp->host);
 
-	/* set the synchronous period/offset */
 	if(slot->resume_offset == 0)
 		slot->resume_offset = hostdata->pScript;
+	/* now perform all the writebacks and invalidates */
+	dma_cache_wback((unsigned long)hostdata->msgout, count);
+	dma_cache_inv((unsigned long)hostdata->msgin, MSG_ARRAY_SIZE);
+	dma_cache_wback((unsigned long)SCp->cmnd, SCp->cmd_len);
+	dma_cache_inv((unsigned long)hostdata->status, 1);
+
+	/* set the synchronous period/offset */
 	NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
-	     SCp->host, SXFER_REG);
+		       SCp->host, SXFER_REG);
+	NCR_700_writel(slot->temp, SCp->host, TEMP_REG);
+	NCR_700_writel(slot->resume_offset, SCp->host, DSP_REG);
+
 	/* allow interrupts here so that if we're selected we can take
 	 * a selection interrupt.  The script start may not be
 	 * effective in this case, but the selection interrupt will
 	 * save our command in that case */
-	NCR_700_writel(slot->temp, SCp->host, TEMP_REG);
-	NCR_700_writel(slot->resume_offset, SCp->host, DSP_REG);
 	restore_flags(flags);
 
 	return 1;
@@ -1342,8 +1533,8 @@
 
 			hostdata->state = NCR_700_HOST_BUSY;
 
-			printk(KERN_ERR "scsi%d: Bus Reset detected, executing command %p, slot %p, dsp %p[%04x]\n",
-			       host->host_no, SCp, SCp == NULL ? NULL : SCp->host_scribble, (void *)dsp, dsp - hostdata->pScript);
+			printk(KERN_ERR "scsi%d: Bus Reset detected, executing command %p, slot %p, dsp %08x[%04x]\n",
+			       host->host_no, SCp, SCp == NULL ? NULL : SCp->host_scribble, dsp, dsp - hostdata->pScript);
 
 			/* clear all the negotiated parameters */
 			for(SDp = host->host_queue; SDp != NULL; SDp = SDp->next)
@@ -1396,13 +1587,15 @@
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= virt_to_bus(&slot->SG[0].ins) &&
-				  dsp <= virt_to_bus(&slot->SG[NCR_700_SG_SEGMENTS].ins)) {
+			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
-				int SGcount = (dsp - virt_to_bus(&slot->SG[0].ins))/sizeof(struct NCR_700_SG_List);
+				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);
 				int residual = NCR_700_data_residual(host);
 				int i;
 #ifdef NCR_700_DEBUG
+				__u32 naddr = NCR_700_readl(host, DNAD_REG);
+
 				printk("scsi%d: (%d:%d) Expected phase mismatch in slot->SG[%d], transferred 0x%x\n",
 				       host->host_no, pun, lun,
 				       SGcount, data_transfer);
@@ -1427,6 +1620,11 @@
 					slot->SG[SGcount].ins |= bS_to_host(data_transfer);
 					pAddr = bS_to_cpu(slot->SG[SGcount].pAddr);
 					pAddr += (count - data_transfer);
+#ifdef NCR_700_DEBUG
+					if(pAddr != naddr) {
+						printk("scsi%d (%d:%d) transfer mismatch pAddr=%lx, naddr=%lx, data_transfer=%d, residual=%d\n", host->host_no, pun, lun, (unsigned long)pAddr, (unsigned long)naddr, data_transfer, residual);
+					}
+#endif
 					slot->SG[SGcount].pAddr = bS_to_host(pAddr);
 				}
 				/* set the executed moves to nops */
@@ -1438,6 +1636,8 @@
 				/* and pretend we disconnected after
 				 * the command phase */
 				resume_offset = hostdata->pScript + Ent_MsgInDuringData;
+				/* make sure all the data is flushed */
+				NCR_700_flush_fifo(host);
 			} else {
 				__u8 sbcl = NCR_700_readb(host, SBCL_REG);
 				printk(KERN_ERR "scsi%d: (%d:%d) phase mismatch at %04x, phase %s\n",
@@ -1449,15 +1649,19 @@
 			printk(KERN_ERR "scsi%d: (%d:%d) GROSS ERROR\n",
 			       host->host_no, pun, lun);
 			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
+		} else if(sstat0 & PARITY_ERROR) {
+			printk(KERN_ERR "scsi%d: (%d:%d) PARITY ERROR\n",
+			       host->host_no, pun, lun);
+			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
 		} else if(dstat & SCRIPT_INT_RECEIVED) {
 			DEBUG(("scsi%d: (%d:%d) ====>SCRIPT INTERRUPT<====\n",
 			       host->host_no, pun, lun));
 			resume_offset = process_script_interrupt(dsps, dsp, SCp, host, hostdata);
 		} else if(dstat & (ILGL_INST_DETECTED)) {
-			printk(KERN_ERR "scsi%d: (%d:%d) Illegal Instruction detected at 0x%p[0x%x]!!!\n"
+			printk(KERN_ERR "scsi%d: (%d:%d) Illegal Instruction detected at 0x%08x[0x%x]!!!\n"
 			       "         Please email James.Bottomley@HansenPartnership.com with the details\n",
 			       host->host_no, pun, lun,
-			       (void *)dsp, dsp - hostdata->pScript);
+			       dsp, dsp - hostdata->pScript);
 			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
 		} else if(dstat & (WATCH_DOG_INTERRUPT|ABORTED)) {
 			printk(KERN_ERR "scsi%d: (%d:%d) serious DMA problem, dstat=%02x\n",
@@ -1495,13 +1699,13 @@
 
 	if(resume_offset) {
 		if(hostdata->state != NCR_700_HOST_BUSY) {
-			printk(KERN_ERR "scsi%d: Driver error: resume at %p [%04x] with non busy host!\n",
-			       host->host_no, (void *)resume_offset, resume_offset - hostdata->pScript);
+			printk(KERN_ERR "scsi%d: Driver error: resume at 0x%08x [0x%04x] with non busy host!\n",
+			       host->host_no, resume_offset, resume_offset - hostdata->pScript);
 			hostdata->state = NCR_700_HOST_BUSY;
 		}
 
 		DEBUG(("Attempting to resume at %x\n", resume_offset));
-		NCR_700_writeb(CLR_FIFO, host, DFIFO_REG);
+		NCR_700_clear_fifo(host);
 		NCR_700_writel(resume_offset, host, DSP_REG);
 	} 
 	/* There is probably a technical no-no about this: If we're a
@@ -1579,6 +1783,7 @@
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
 	__u32 move_ins;
+	int pci_direction;
 	struct NCR_700_command_slot *slot;
 	int hash;
 
@@ -1618,6 +1823,20 @@
 	printk("53c700: scsi%d, command ", SCp->host->host_no);
 	print_command(SCp->cmnd);
 #endif
+	if(SCp->device->tagged_supported && !SCp->device->tagged_queue
+	   && (hostdata->tag_negotiated &(1<<SCp->target)) == 0
+	   && NCR_700_is_flag_clear(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING)) {
+		/* upper layer has indicated tags are supported.  We don't
+		 * necessarily believe it yet.
+		 *
+		 * NOTE: There is a danger here: the mid layer supports
+		 * tag queuing per LUN.  We only support it per PUN because
+		 * of potential reselection issues */
+		printk(KERN_INFO "scsi%d: (%d:%d) Enabling Tag Command Queuing\n", SCp->device->host->host_no, SCp->target, SCp->lun);
+		hostdata->tag_negotiated |= (1<<SCp->target);
+		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_TAG_QUEUEING);
+		SCp->device->tagged_queue = 1;
+	}
 
 	if(hostdata->tag_negotiated &(1<<SCp->target)) {
 
@@ -1681,36 +1900,11 @@
 		hostdata->ITL_Hash_back[hash] = slot;
 	slot->ITL_back = NULL;
 
-		
-	/* This is f****g ridiculous; every low level HBA driver has
-	 * to determine the direction of the commands, why isn't this
-	 * done inside the scsi_lib !!??? */
 	switch (SCp->cmnd[0]) {
 	case REQUEST_SENSE:
 		/* clear the internal sense magic */
 		SCp->cmnd[6] = 0;
 		/* fall through */
-	case INQUIRY:
-	case MODE_SENSE:
-	case READ_6:
-	case READ_10:
-	case READ_12:
-	case READ_CAPACITY:
-	case READ_BLOCK_LIMITS:
-	case READ_TOC:
-		move_ins = SCRIPT_MOVE_DATA_IN;
-		break;
-	case MODE_SELECT:
-	case WRITE_6:
-	case WRITE_10:
-	case WRITE_12:
-		move_ins = SCRIPT_MOVE_DATA_OUT;
-		break;
-	case TEST_UNIT_READY:
-	case ALLOW_MEDIUM_REMOVAL:
-	case START_STOP:
-		move_ins = 0;
-		break;
 	default:
 		/* OK, get it from the command */
 		switch(SCp->sc_data_direction) {
@@ -1734,26 +1928,40 @@
 	}
 
 	/* now build the scatter gather list */
+	pci_direction = scsi_to_pci_dma_dir(SCp->sc_data_direction);
 	if(move_ins != 0) {
 		int i;
+		int sg_count;
+		dma_addr_t vPtr = 0;
+		__u32 count = 0;
+
+		if(SCp->use_sg) {
+			sg_count = pci_map_sg(hostdata->pci_dev, SCp->buffer,
+					      SCp->use_sg, pci_direction);
+		} else {
+			vPtr = pci_map_single(hostdata->pci_dev,
+					      SCp->request_buffer, 
+					      SCp->request_bufflen,
+					      pci_direction);
+			count = SCp->request_bufflen;
+			slot->dma_handle = vPtr;
+			sg_count = 1;
+		}
+			
 
-		for(i = 0; i < (SCp->use_sg ? SCp->use_sg : 1); i++) {
-			void *vPtr;
-			__u32 count;
+		for(i = 0; i < sg_count; i++) {
 
 			if(SCp->use_sg) {
-				vPtr = (((struct scatterlist *)SCp->buffer)[i].address);
-				count = ((struct scatterlist *)SCp->buffer)[i].length;
-			} else {
-				vPtr = SCp->request_buffer;
-				count = SCp->request_bufflen;
+				struct scatterlist *sg = SCp->buffer;
+
+				vPtr = sg_dma_address(&sg[i]);
+				count = sg_dma_len(&sg[i]);
 			}
+
 			slot->SG[i].ins = bS_to_host(move_ins | count);
 			DEBUG((" scatter block %d: move %d[%08x] from 0x%lx\n",
-			       i, count, slot->SG[i].ins, 
-			       virt_to_bus(vPtr)));
-			dma_cache_wback_inv((unsigned long)vPtr, count);
-			slot->SG[i].pAddr = bS_to_host(virt_to_bus(vPtr));
+			       i, count, slot->SG[i].ins, (unsigned long)vPtr));
+			slot->SG[i].pAddr = bS_to_host(vPtr);
 		}
 		slot->SG[i].ins = bS_to_host(SCRIPT_RETURN);
 		slot->SG[i].pAddr = 0;
Index: drivers/scsi/53c700.h
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/53c700.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 53c700.h
--- drivers/scsi/53c700.h	2001/09/08 01:39:47	1.1.1.2
+++ drivers/scsi/53c700.h	2001/09/22 00:36:28
@@ -36,8 +36,8 @@
 /* WARNING: Leave this in for now: the dependency preprocessor doesn't
  * pick up file specific flags, so must define here if they are not
  * set */
-#if !defined(IO_MAPPED) && !defined(MEM_MAPPED)
-#define IO_MAPPED
+#if !defined(CONFIG_53C700_IO_MAPPED) && !defined(CONFIG_53C700_MEM_MAPPED)
+#error "Config.in must define either CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi core."
 #endif
 
 
@@ -90,43 +90,43 @@
 static inline void
 NCR_700_set_SXFER(Scsi_Device *SDp, __u8 sxfer)
 {
-	((__u32)SDp->hostdata) &= 0xffffff00;
-	((__u32)SDp->hostdata) |= sxfer & 0xff;
+	((unsigned long)SDp->hostdata) &= 0xffffff00;
+	((unsigned long)SDp->hostdata) |= sxfer & 0xff;
 }
 static inline __u8 NCR_700_get_SXFER(Scsi_Device *SDp)
 {
-	return (((__u32)SDp->hostdata) & 0xff);
+	return (((unsigned long)SDp->hostdata) & 0xff);
 }
 static inline void
 NCR_700_set_depth(Scsi_Device *SDp, __u8 depth)
 {
-	((__u32)SDp->hostdata) &= 0xffff00ff;
-	((__u32)SDp->hostdata) |= (0xff00 & (depth << 8));
+	((unsigned long)SDp->hostdata) &= 0xffff00ff;
+	((unsigned long)SDp->hostdata) |= (0xff00 & (depth << 8));
 }
 static inline __u8
 NCR_700_get_depth(Scsi_Device *SDp)
 {
-	return ((((__u32)SDp->hostdata) & 0xff00)>>8);
+	return ((((unsigned long)SDp->hostdata) & 0xff00)>>8);
 }
 static inline int
 NCR_700_is_flag_set(Scsi_Device *SDp, __u32 flag)
 {
-	return (((__u32)SDp->hostdata) & flag) == flag;
+	return (((unsigned long)SDp->hostdata) & flag) == flag;
 }
 static inline int
 NCR_700_is_flag_clear(Scsi_Device *SDp, __u32 flag)
 {
-	return (((__u32)SDp->hostdata) & flag) == 0;
+	return (((unsigned long)SDp->hostdata) & flag) == 0;
 }
 static inline void
 NCR_700_set_flag(Scsi_Device *SDp, __u32 flag)
 {
-	((__u32)SDp->hostdata) |= (flag & 0xffff0000);
+	((unsigned long)SDp->hostdata) |= (flag & 0xffff0000);
 }
 static inline void
 NCR_700_clear_flag(Scsi_Device *SDp, __u32 flag)
 {
-	((__u32)SDp->hostdata) &= ~(flag & 0xffff0000);
+	((unsigned long)SDp->hostdata) &= ~(flag & 0xffff0000);
 }
 
 /* These represent the Nexus hashing functions.  A Nexus in SCSI terms
@@ -162,6 +162,8 @@
 }
 
 struct NCR_700_command_slot {
+	struct NCR_700_SG_List	SG[NCR_700_SG_SEGMENTS+1];
+	struct NCR_700_SG_List	*pSG;
 	#define NCR_700_SLOT_MASK 0xFC
 	#define NCR_700_SLOT_MAGIC 0xb8
 	#define	NCR_700_SLOT_FREE (0|NCR_700_SLOT_MAGIC) /* slot may be used */
@@ -170,10 +172,12 @@
 	__u8	state;
 	#define NCR_700_NO_TAG	0xdead
 	__u16	tag;
-	struct NCR_700_SG_List	SG[NCR_700_SG_SEGMENTS+1];
 	__u32	resume_offset;
 	Scsi_Cmnd	*cmnd;
 	__u32		temp;
+	/* if this command is a pci_single mapping, holds the dma address
+	 * for later unmapping in the done routine */
+	dma_addr_t	dma_handle;
 	/* Doubly linked ITL/ITLQ list kept in strict time order
 	 * (latest at the back) */
 	struct NCR_700_command_slot *ITL_forw;
@@ -186,12 +190,16 @@
 	/* These must be filled in by the calling driver */
 	int	clock;			/* board clock speed in MHz */
 	__u32	base;			/* the base for the port (copied to host) */
+	struct pci_dev	*pci_dev;
+	__u8	dmode_extra;	/* adjustable bus settings */
 	__u8	differential:1;	/* if we are differential */
-#ifdef __hppa__
+#ifdef CONFIG_53C700_LE_ON_BE
 	/* This option is for HP only.  Set it if your chip is wired for
 	 * little endian on this platform (which is big endian) */
 	__u8	force_le_on_be:1;
 #endif
+	__u8	chip710:1;	/* set if really a 710 not 700 */
+	__u8	burst_disable:1;	/* set to 1 to disable 710 bursting */
 
 	/* NOTHING BELOW HERE NEEDS ALTERING */
 	__u8	fast:1;		/* if we can alter the SCSI bus clock
@@ -209,10 +217,11 @@
 	enum NCR_700_Host_State state; /* protected by state lock */
 	Scsi_Cmnd *cmd;
 
-	__u8	msgout[8];
+	__u8	*msgout;
+#define	MSG_ARRAY_SIZE	16
 	__u8	tag_negotiated;
-	__u8	status;
-	__u8	msgin[8];
+	__u8	*status;
+	__u8	*msgin;
 	struct NCR_700_command_slot	*slots;
 	int	saved_slot_position;
 	int	command_slot_count; /* protected by state lock */
@@ -237,7 +246,7 @@
 /*
  *	53C700 Register Interface - the offset from the Selected base
  *	I/O address */
-#ifdef __hppa__
+#ifdef CONFIG_53C700_LE_ON_BE
 #define bE	(hostdata->force_le_on_be ? 0 : 3)
 #define	bSWAP	(hostdata->force_le_on_be)
 #elif defined(__BIG_ENDIAN)
@@ -310,6 +319,7 @@
 #define		SODL_REG_FULL		0x20
 #define SSTAT2_REG                      0x0F
 #define CTEST0_REG                      0x14
+#define		BTB_TIMER_DISABLE	0x40
 #define CTEST1_REG                      0x15
 #define CTEST2_REG                      0x16
 #define CTEST3_REG                      0x17
@@ -327,6 +337,8 @@
 #define         MASTER_CONTROL          0x10
 #define         DMA_DIRECTION           0x08
 #define CTEST7_REG                      0x1B
+#define		BURST_DISABLE		0x80 /* 710 only */
+#define		SEL_TIMEOUT_DISABLE	0x10 /* 710 only */
 #define         DFP                     0x08
 #define         EVP                     0x04
 #define		DIFF			0x01
@@ -337,6 +349,7 @@
 #define		CLR_FIFO		0x40
 #define	ISTAT_REG			0x21
 #define		ABORT_OPERATION		0x80
+#define		SOFTWARE_RESET_710	0x40
 #define		DMA_INT_PENDING		0x01
 #define		SCSI_INT_PENDING	0x02
 #define		CONNECTED		0x08
@@ -345,27 +358,34 @@
 #define		SHORTEN_FILTERING	0x04
 #define		ENABLE_ACTIVE_NEGATION	0x10
 #define		GENERATE_RECEIVE_PARITY	0x20
+#define		CLR_FIFO_710		0x04
+#define		FLUSH_DMA_FIFO_710	0x08
 #define CTEST9_REG                      0x23
 #define	DBC_REG				0x24
 #define	DCMD_REG			0x27
 #define	DNAD_REG			0x28
 #define	DIEN_REG			0x39
+#define		BUS_FAULT		0x20
 #define 	ABORT_INT		0x10
 #define 	INT_INST_INT		0x04
 #define 	WD_INT			0x02
 #define 	ILGL_INST_INT		0x01
 #define	DCNTL_REG			0x3B
 #define		SOFTWARE_RESET		0x01
+#define		COMPAT_700_MODE		0x01
 #define 	SCRPTS_16BITS		0x20
 #define		ASYNC_DIV_2_0		0x00
-#define		ASYNC_DIV_1_5		0x01
-#define		ASYNC_DIV_1_0		0x02
-#define		ASYNC_DIV_3_0		0x03
-#define	DMODE_REG			0x34
+#define		ASYNC_DIV_1_5		0x40
+#define		ASYNC_DIV_1_0		0x80
+#define		ASYNC_DIV_3_0		0xc0
+#define DMODE_710_REG			0x38
+#define	DMODE_700_REG			0x34
 #define		BURST_LENGTH_1		0x00
 #define		BURST_LENGTH_2		0x40
 #define		BURST_LENGTH_4		0x80
 #define		BURST_LENGTH_8		0xC0
+#define		DMODE_FC1		0x10
+#define		DMODE_FC2		0x20
 #define 	BW16			32 
 #define 	MODE_286		16
 #define 	IO_XFER			8
@@ -377,7 +397,11 @@
 /* Parameters to begin SDTR negotiations.  Empirically, I find that
  * the 53c700-66 cannot handle an offset >8, so don't change this  */
 #define NCR_700_MAX_OFFSET	8
+/* Was hoping the max offset would be greater for the 710, but
+ * empirically it seems to be 8 also */
+#define NCR_710_MAX_OFFSET	8
 #define NCR_700_MIN_XFERP	1
+#define NCR_710_MIN_XFERP	0
 #define NCR_700_MIN_PERIOD	25 /* for SDTR message, 100ns */
 
 #define script_patch_32(script, symbol, value) \
@@ -427,14 +451,14 @@
 		val |= ((value) & 0xffff); \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
 		dma_cache_wback((unsigned long)&(script)[A_##symbol##_used[i]], 4); \
-		DEBUG((" script, patching ID field %s at %d to 0x%x\n", \
+		DEBUG((" script, patching short field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
 }
 
 #endif
 
-#ifdef MEM_MAPPED
+#ifdef CONFIG_53C700_MEM_MAPPED
 static inline __u8
 NCR_700_readb(struct Scsi_Host *host, __u32 reg)
 {
@@ -482,7 +506,7 @@
 
 	writel(bS_to_host(value), host->base + reg);
 }
-#elif defined(IO_MAPPED)
+#elif defined(CONFIG_53C700_IO_MAPPED)
 static inline __u8
 NCR_700_readb(struct Scsi_Host *host, __u32 reg)
 {
Index: drivers/scsi/53c700.scr
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/53c700.scr,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 53c700.scr
--- drivers/scsi/53c700.scr	2001/05/14 23:48:23	1.1.1.1
+++ drivers/scsi/53c700.scr	2001/09/22 00:36:28
@@ -81,6 +81,7 @@
 ABSOLUTE	DISCONNECT_AFTER_CMD = 0x380
 ABSOLUTE	SDTR_MSG_AFTER_CMD = 0x360
 ABSOLUTE	WDTR_MSG_AFTER_CMD = 0x3A0
+ABSOLUTE	MSG_IN_AFTER_STATUS = 0x440
 ABSOLUTE	DISCONNECT_AFTER_DATA = 0x580
 ABSOLUTE	MSG_IN_AFTER_DATA_IN = 0x550
 ABSOLUTE	MSG_IN_AFTER_DATA_OUT = 0x650
@@ -116,7 +117,8 @@
 
 ;
 ; SCSI Messages we interpret in the script
-; 
+;
+ABSOLUTE	COMMAND_COMPLETE_MSG	= 0x00
 ABSOLUTE	EXTENDED_MSG		= 0x01
 ABSOLUTE	SDTR_MSG		= 0x01
 ABSOLUTE	SAVE_DATA_PTRS_MSG	= 0x02
@@ -393,7 +395,12 @@
 Finish:
 	MOVE	1, StatusAddress, WHEN STATUS
 	INT	NOT_MSG_IN_AFTER_STATUS, WHEN NOT MSG_IN
-	CALL	ReceiveMessage
+	MOVE	1, ReceiveMsgAddress, WHEN MSG_IN
+	JUMP	FinishCommandComplete, IF COMMAND_COMPLETE_MSG
+	CALL	ProcessReceiveMessage
+	INT	MSG_IN_AFTER_STATUS
+	ENTRY	FinishCommandComplete
+FinishCommandComplete:
 	CLEAR	ACK
 	WAIT	DISCONNECT
 	ENTRY	Finish1
Index: drivers/scsi/Config.in
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/Config.in,v
retrieving revision 1.1.1.18
diff -u -r1.1.1.18 Config.in
--- drivers/scsi/Config.in	2001/09/08 01:39:24	1.1.1.18
+++ drivers/scsi/Config.in	2001/09/22 00:36:28
@@ -115,9 +115,18 @@
    fi
 fi
 dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
-dep_tristate 'NCR Dual 700 MCA SCSI support' CONFIG_SCSI_NCR_D700 $CONFIG_SCSI $CONFIG_MCA
+if [ "$CONFIG_MCA" = "y" ]; then
+   dep_tristate 'NCR Dual 700 MCA SCSI support' CONFIG_SCSI_NCR_D700 $CONFIG_SCSI
+   if [ "$CONFIG_SCSI_NCR_D700" != "n" ]; then
+      define_bool CONFIG_53C700_IO_MAPPED y
+   fi
+fi
 if [ "$CONFIG_PARISC" = "y" ]; then
-   dep_tristate 'HP LASI SCSI support for 53c700' CONFIG_SCSI_LASI70 $CONFIG_SCSI
+   dep_tristate 'HP LASI SCSI support for 53c700' CONFIG_SCSI_LASI700 $CONFIG_SCSI
+   if [ "$CONFIG_SCSI_LASI700" != "n" ]; then
+      define_bool CONFIG_53C700_MEM_MAPPED y
+      define_bool CONFIG_53C700_LE_ON_BE y
+   fi
 fi
 dep_tristate 'NCR53c7,8xx SCSI support'  CONFIG_SCSI_NCR53C7xx $CONFIG_SCSI $CONFIG_PCI
 if [ "$CONFIG_SCSI_NCR53C7xx" != "n" ]; then
Index: drivers/scsi/Makefile
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/Makefile,v
retrieving revision 1.1.1.18
diff -u -r1.1.1.18 Makefile
--- drivers/scsi/Makefile	2001/09/21 19:04:46	1.1.1.18
+++ drivers/scsi/Makefile	2001/09/22 00:36:28
@@ -31,7 +31,7 @@
   endif
 endif
 
-export-objs	:= scsi_syms.o 53c700.o 53c700-mem.o
+export-objs	:= scsi_syms.o 53c700.o
 
 CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
 CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
@@ -125,7 +125,7 @@
 obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 obj-$(CONFIG_SCSI_FCAL)		+= fcal.o
 obj-$(CONFIG_SCSI_CPQFCTS)	+= cpqfc.o
-obj-$(CONFIG_SCSI_LASI700)	+= lasi700.o 53c700-mem.o
+obj-$(CONFIG_SCSI_LASI700)	+= lasi700.o 53c700.o
 
 ifeq ($(CONFIG_ARCH_ACORN),y)
 mod-subdirs	+= ../acorn/scsi
@@ -209,10 +209,3 @@
 	mv script.h 53c700_d.h
 
 53c700.o: 53c700_d.h
-
-53c700-mem.o: 53c700_d.h
-
-53c700-mem.c: 53c700.c
-	echo "/* WARNING: GENERATED FILE (from $<), DO NOT MODIFY */" > $@
-	echo "#define MEM_MAPPED" >> $@
-	cat $< >> $@
Index: drivers/scsi/lasi700.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/lasi700.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 lasi700.c
--- drivers/scsi/lasi700.c	2001/09/08 01:39:48	1.1.1.1
+++ drivers/scsi/lasi700.c	2001/09/22 00:36:28
@@ -109,6 +109,7 @@
 static int __initdata host_count = 0;
 static struct parisc_device_id lasi700_scsi_tbl[] = {
 	LASI700_ID_TABLE,
+	LASI710_ID_TABLE,
 	{ 0 }
 };
 
@@ -136,32 +137,48 @@
 {
 	unsigned long base = dev->hpa + LASI_SCSI_CORE_OFFSET;
 	int irq = busdevice_alloc_irq(dev);
+	char *driver_name;
 	struct Scsi_Host *host;
 	struct NCR_700_Host_Parameters *hostdata =
 		kmalloc(sizeof(struct NCR_700_Host_Parameters),
 			GFP_KERNEL);
+	if(dev->id.sversion == LASI_700_SVERSION) {
+		driver_name = "lasi700";
+	} else {
+		driver_name = "lasi710";
+	}
 	if(hostdata == NULL) {
-		printk(KERN_ERR "lasi700: Failed to allocate host data\n");
+		printk(KERN_ERR "%s: Failed to allocate host data\n",
+		       driver_name);
 		return 1;
 	}
 	memset(hostdata, 0, sizeof(struct NCR_700_Host_Parameters));
-	if(request_mem_region(base, 64, "lasi700") == NULL) {
-		printk(KERN_ERR "lasi700: Failed to claim memory region\n");
+	if(request_mem_region(base, 64, driver_name) == NULL) {
+		printk(KERN_ERR "%s: Failed to claim memory region\n",
+		       driver_name);
 		kfree(hostdata);
 		return 1;
 	}
 	hostdata->base = base;
 	hostdata->differential = 0;
-	hostdata->clock = LASI700_CLOCK;
-	hostdata->force_le_on_be = 1;
+	if(dev->id.sversion == LASI_700_SVERSION) {
+		hostdata->clock = LASI700_CLOCK;
+		hostdata->force_le_on_be = 1;
+	} else {
+		hostdata->clock = LASI710_CLOCK;
+		hostdata->force_le_on_be = 0;
+		hostdata->chip710 = 1;
+		hostdata->dmode_extra = DMODE_FC2;
+	}
 	if((host = NCR_700_detect(host_tpnt, hostdata)) == NULL) {
 		kfree(hostdata);
 		release_mem_region(host->base, 64);
 		return 1;
 	}
 	host->irq = irq;
-	if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "lasi700", host)) {
-		printk(KERN_ERR "lasi700: irq problem, detatching\n");
+	if(request_irq(irq, NCR_700_intr, SA_SHIRQ, driver_name, host)) {
+		printk(KERN_ERR "%s: irq problem, detatching\n",
+		       driver_name);
 		scsi_unregister(host);
 		NCR_700_release(host);
 		return 1;
Index: drivers/scsi/lasi700.h
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/scsi/lasi700.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 lasi700.h
--- drivers/scsi/lasi700.h	2001/09/08 01:39:48	1.1.1.1
+++ drivers/scsi/lasi700.h	2001/09/22 00:36:28
@@ -38,9 +38,19 @@
 	this_id:	7,			\
 }
 
+#define LASI_710_SVERSION	0x082
+#define LASI_700_SVERSION	0x071
+
 #define LASI700_ID_TABLE {			\
+	hw_type:	HPHW_FIO,		\
+	sversion:	LASI_700_SVERSION,	\
+	hversion:	HVERSION_ANY_ID,	\
+	hversion_rev:	HVERSION_REV_ANY_ID,	\
+}
+
+#define LASI710_ID_TABLE {			\
 	hw_type:	HPHW_FIO,		\
-	sversion:	0x071,			\
+	sversion:	LASI_710_SVERSION,	\
 	hversion:	HVERSION_ANY_ID,	\
 	hversion_rev:	HVERSION_REV_ANY_ID,	\
 }
@@ -52,6 +62,7 @@
 }
 
 #define LASI700_CLOCK	25
+#define LASI710_CLOCK	40
 #define LASI_SCSI_CORE_OFFSET 0x100
 
 #endif

--==_Exmh_2480271390--


