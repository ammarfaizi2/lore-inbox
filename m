Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWDJFo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDJFo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWDJFo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:44:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18360 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750857AbWDJFo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:44:56 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-scsi@vger.kernel.org, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] deinline some functions in aic7xxx drivers, save 80k of text
Date: Mon, 10 Apr 2006 08:44:12 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sCfOEzXnQ1zcDBP"
Message-Id: <200604100844.12151.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_sCfOEzXnQ1zcDBP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Justin, hi scsi crowd,

I moved a bunch of inlined functions from
aic79xx_osm.h and aic79xx_inline.h to
aic79xx_osm_o.c and aic79xx_inline.c and #included
them from aic79xx_core.c. This is a bit ugly,
but I was not sure where would maintainer
like them to be moved to.

Same for aic7xxx. End result is:

# size */aic7*xx.o
   text    data     bss     dec     hex filename
 144078   11617     600  156295   26287 aic7xxx.old/aic79xx.o
 108610   16289     564  125463   1ea17 aic7xxx.old/aic7xxx.o
  85255   11617     600   97472   17cc0 aic7xxx/aic79xx.o
  83395   16289     564  100248   18798 aic7xxx/aic7xxx.o

I also spotted two bugs in the process, patches
for those will follow.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_sCfOEzXnQ1zcDBP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.16.aic7_4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.aic7_4.patch"

# size */aic7*xx.o
   text    data     bss     dec     hex filename
 144078   11617     600  156295   26287 aic7xxx.old/aic79xx.o
 108610   16289     564  125463   1ea17 aic7xxx.old/aic7xxx.o
  85255   11617     600   97472   17cc0 aic7xxx/aic79xx.o
  83395   16289     564  100248   18798 aic7xxx/aic7xxx.o

diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_core.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_core.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_core.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_core.c	Sun Apr  9 21:49:25 2006
@@ -50,6 +50,9 @@
 #include <dev/aic7xxx/aicasm/aicasm_insformat.h>
 #endif
 
+/* Were inlined, but moved out-of-line because they are HUGE: */
+#include "aic79xx_osm_o.c"
+#include "aic79xx_inline.c"
 
 /***************************** Lookup Tables **********************************/
 char *ahd_chip_names[] =
@@ -241,7 +244,7 @@ static int		ahd_handle_target_cmd(struct
 /******************************** Private Inlines *****************************/
 static __inline void	ahd_assert_atn(struct ahd_softc *ahd);
 static __inline int	ahd_currently_packetized(struct ahd_softc *ahd);
-static __inline int	ahd_set_active_fifo(struct ahd_softc *ahd);
+static int		ahd_set_active_fifo(struct ahd_softc *ahd);
 
 static __inline void
 ahd_assert_atn(struct ahd_softc *ahd)
@@ -278,7 +281,7 @@ ahd_currently_packetized(struct ahd_soft
 	return (packetized);
 }
 
-static __inline int
+static int
 ahd_set_active_fifo(struct ahd_softc *ahd)
 {
 	u_int active_fifo;
@@ -7131,7 +7134,7 @@ ahd_resume(struct ahd_softc *ahd)
  * scbid that should be restored once manipualtion
  * of the TCL entry is complete.
  */
-static __inline u_int
+static u_int
 ahd_index_busy_tcl(struct ahd_softc *ahd, u_int *saved_scbid, u_int tcl)
 {
 	/*
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_inline.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_inline.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_inline.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_inline.c	Sun Apr  9 21:49:25 2006
@@ -0,0 +1,460 @@
+/*
+ * Routines shareable across OS platforms.
+ *
+ * Formerly inlined routines from aic79xx_inline.h are moved here.
+ * This file is #included into aic79xx_core.c
+ */
+
+/************************ Sequencer Execution Control *************************/
+void
+ahd_set_modes(struct ahd_softc *ahd, ahd_mode src, ahd_mode dst)
+{
+	if (ahd->src_mode == src && ahd->dst_mode == dst)
+		return;
+#ifdef AHD_DEBUG
+	if (ahd->src_mode == AHD_MODE_UNKNOWN
+	 || ahd->dst_mode == AHD_MODE_UNKNOWN)
+		panic("Setting mode prior to saving it.\n");
+	if ((ahd_debug & AHD_SHOW_MODEPTR) != 0)
+		printf("%s: Setting mode 0x%x\n", ahd_name(ahd),
+		       ahd_build_mode_state(ahd, src, dst));
+#endif
+	ahd_outb(ahd, MODE_PTR, ahd_build_mode_state(ahd, src, dst));
+	ahd->src_mode = src;
+	ahd->dst_mode = dst;
+}
+
+void
+ahd_update_modes(struct ahd_softc *ahd)
+{
+	ahd_mode_state mode_ptr;
+	ahd_mode src;
+	ahd_mode dst;
+
+	mode_ptr = ahd_inb(ahd, MODE_PTR);
+#ifdef AHD_DEBUG
+	if ((ahd_debug & AHD_SHOW_MODEPTR) != 0)
+		printf("Reading mode 0x%x\n", mode_ptr);
+#endif
+	ahd_extract_mode_state(ahd, mode_ptr, &src, &dst);
+	ahd_known_modes(ahd, src, dst);
+}
+
+ahd_mode_state
+ahd_save_modes(struct ahd_softc *ahd)
+{
+	if (ahd->src_mode == AHD_MODE_UNKNOWN
+	 || ahd->dst_mode == AHD_MODE_UNKNOWN)
+		ahd_update_modes(ahd);
+
+	return (ahd_build_mode_state(ahd, ahd->src_mode, ahd->dst_mode));
+}
+
+void
+ahd_restore_modes(struct ahd_softc *ahd, ahd_mode_state state)
+{
+	ahd_mode src;
+	ahd_mode dst;
+
+	ahd_extract_mode_state(ahd, state, &src, &dst);
+	ahd_set_modes(ahd, src, dst);
+}
+
+/*
+ * Allow the sequencer to continue program execution.
+ * We check here to ensure that no additional interrupt
+ * sources that would cause the sequencer to halt have been
+ * asserted.  If, for example, a SCSI bus reset is detected
+ * while we are fielding a different, pausing, interrupt type,
+ * we don't want to release the sequencer before going back
+ * into our interrupt handler and dealing with this new
+ * condition.
+ */
+void
+ahd_unpause(struct ahd_softc *ahd)
+{
+	/*
+	 * Automatically restore our modes to those saved
+	 * prior to the first change of the mode.
+	 */
+	if (ahd->saved_src_mode != AHD_MODE_UNKNOWN
+	 && ahd->saved_dst_mode != AHD_MODE_UNKNOWN) {
+		if ((ahd->flags & AHD_UPDATE_PEND_CMDS) != 0)
+			ahd_reset_cmds_pending(ahd);
+		ahd_set_modes(ahd, ahd->saved_src_mode, ahd->saved_dst_mode);
+	}
+
+	if ((ahd_inb(ahd, INTSTAT) & ~CMDCMPLT) == 0)
+		ahd_outb(ahd, HCNTRL, ahd->unpause);
+
+	ahd_known_modes(ahd, AHD_MODE_UNKNOWN, AHD_MODE_UNKNOWN);
+}
+
+/*********************** Scatter Gather List Handling *************************/
+void *
+ahd_sg_setup(struct ahd_softc *ahd, struct scb *scb,
+	     void *sgptr, dma_addr_t addr, bus_size_t len, int last)
+{
+	scb->sg_count++;
+	if (sizeof(dma_addr_t) > 4
+	 && (ahd->flags & AHD_64BIT_ADDRESSING) != 0) {
+		struct ahd_dma64_seg *sg;
+
+		sg = (struct ahd_dma64_seg *)sgptr;
+		sg->addr = ahd_htole64(addr);
+		sg->len = ahd_htole32(len | (last ? AHD_DMA_LAST_SEG : 0));
+		return (sg + 1);
+	} else {
+		struct ahd_dma_seg *sg;
+
+		sg = (struct ahd_dma_seg *)sgptr;
+		sg->addr = ahd_htole32(addr & 0xFFFFFFFF);
+		sg->len = ahd_htole32(len | ((addr >> 8) & 0x7F000000)
+				    | (last ? AHD_DMA_LAST_SEG : 0));
+		return (sg + 1);
+	}
+}
+
+void
+ahd_setup_scb_common(struct ahd_softc *ahd, struct scb *scb)
+{
+	/* XXX Handle target mode SCBs. */
+	scb->crc_retry_count = 0;
+	if ((scb->flags & SCB_PACKETIZED) != 0) {
+		/* XXX what about ACA??  It is type 4, but TAG_TYPE == 0x3. */
+		scb->hscb->task_attribute = scb->hscb->control & SCB_TAG_TYPE;
+	} else {
+		if (ahd_get_transfer_length(scb) & 0x01)
+			scb->hscb->task_attribute = SCB_XFERLEN_ODD;
+		else
+			scb->hscb->task_attribute = 0;
+	}
+
+	if (scb->hscb->cdb_len <= MAX_CDB_LEN_WITH_SENSE_ADDR
+	 || (scb->hscb->cdb_len & SCB_CDB_LEN_PTR) != 0)
+		scb->hscb->shared_data.idata.cdb_plus_saddr.sense_addr =
+		    ahd_htole32(scb->sense_busaddr);
+}
+
+void
+ahd_setup_data_scb(struct ahd_softc *ahd, struct scb *scb)
+{
+	/*
+	 * Copy the first SG into the "current" data ponter area.
+	 */
+	if ((ahd->flags & AHD_64BIT_ADDRESSING) != 0) {
+		struct ahd_dma64_seg *sg;
+
+		sg = (struct ahd_dma64_seg *)scb->sg_list;
+		scb->hscb->dataptr = sg->addr;
+		scb->hscb->datacnt = sg->len;
+	} else {
+		struct ahd_dma_seg *sg;
+		uint32_t *dataptr_words;
+
+		sg = (struct ahd_dma_seg *)scb->sg_list;
+		dataptr_words = (uint32_t*)&scb->hscb->dataptr;
+		dataptr_words[0] = sg->addr;
+		dataptr_words[1] = 0;
+		if ((ahd->flags & AHD_39BIT_ADDRESSING) != 0) {
+			uint64_t high_addr;
+
+			high_addr = ahd_le32toh(sg->len) & 0x7F000000;
+			scb->hscb->dataptr |= ahd_htole64(high_addr << 8);
+		}
+		scb->hscb->datacnt = sg->len;
+	}
+	/*
+	 * Note where to find the SG entries in bus space.
+	 * We also set the full residual flag which the 
+	 * sequencer will clear as soon as a data transfer
+	 * occurs.
+	 */
+	scb->hscb->sgptr = ahd_htole32(scb->sg_list_busaddr|SG_FULL_RESID);
+}
+
+/*********************** Miscelaneous Support Functions ***********************/
+uint16_t
+ahd_inw(struct ahd_softc *ahd, u_int port)
+{
+	/*
+	 * Read high byte first as some registers increment
+	 * or have other side effects when the low byte is
+	 * read.
+	 */
+	return ((ahd_inb(ahd, port+1) << 8) | ahd_inb(ahd, port));
+}
+
+void
+ahd_outw(struct ahd_softc *ahd, u_int port, u_int value)
+{
+	/*
+	 * Write low byte first to accomodate registers
+	 * such as PRGMCNT where the order maters.
+	 */
+	ahd_outb(ahd, port, value & 0xFF);
+	ahd_outb(ahd, port+1, (value >> 8) & 0xFF);
+}
+
+uint32_t
+ahd_inl(struct ahd_softc *ahd, u_int port)
+{
+	return ((ahd_inb(ahd, port))
+	      | (ahd_inb(ahd, port+1) << 8)
+	      | (ahd_inb(ahd, port+2) << 16)
+	      | (ahd_inb(ahd, port+3) << 24));
+}
+
+void
+ahd_outl(struct ahd_softc *ahd, u_int port, uint32_t value)
+{
+	ahd_outb(ahd, port, (value) & 0xFF);
+	ahd_outb(ahd, port+1, ((value) >> 8) & 0xFF);
+	ahd_outb(ahd, port+2, ((value) >> 16) & 0xFF);
+	ahd_outb(ahd, port+3, ((value) >> 24) & 0xFF);
+}
+
+uint64_t
+ahd_inq(struct ahd_softc *ahd, u_int port)
+{
+	return ((ahd_inb(ahd, port))
+	      | (ahd_inb(ahd, port+1) << 8)
+	      | (ahd_inb(ahd, port+2) << 16)
+	      | (ahd_inb(ahd, port+3) << 24)
+	      | (((uint64_t)ahd_inb(ahd, port+4)) << 32)
+	      | (((uint64_t)ahd_inb(ahd, port+5)) << 40)
+	      | (((uint64_t)ahd_inb(ahd, port+6)) << 48)
+	      | (((uint64_t)ahd_inb(ahd, port+7)) << 56));
+}
+
+void
+ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value)
+{
+	ahd_outb(ahd, port, value & 0xFF);
+	ahd_outb(ahd, port+1, (value >> 8) & 0xFF);
+	ahd_outb(ahd, port+2, (value >> 16) & 0xFF);
+	ahd_outb(ahd, port+3, (value >> 24) & 0xFF);
+	ahd_outb(ahd, port+4, (value >> 32) & 0xFF);
+	ahd_outb(ahd, port+5, (value >> 40) & 0xFF);
+	ahd_outb(ahd, port+6, (value >> 48) & 0xFF);
+	ahd_outb(ahd, port+7, (value >> 56) & 0xFF);
+}
+
+struct scb *
+ahd_lookup_scb(struct ahd_softc *ahd, u_int tag)
+{
+	struct scb* scb;
+
+	if (tag >= AHD_SCB_MAX)
+		return (NULL);
+	scb = ahd->scb_data.scbindex[tag];
+	if (scb != NULL)
+		ahd_sync_scb(ahd, scb,
+			     BUS_DMASYNC_POSTREAD|BUS_DMASYNC_POSTWRITE);
+	return (scb);
+}
+
+void
+ahd_swap_with_next_hscb(struct ahd_softc *ahd, struct scb *scb)
+{
+	struct	 hardware_scb *q_hscb;
+	struct	 map_node *q_hscb_map;
+	uint32_t saved_hscb_busaddr;
+
+	/*
+	 * Our queuing method is a bit tricky.  The card
+	 * knows in advance which HSCB (by address) to download,
+	 * and we can't disappoint it.  To achieve this, the next
+	 * HSCB to download is saved off in ahd->next_queued_hscb.
+	 * When we are called to queue "an arbitrary scb",
+	 * we copy the contents of the incoming HSCB to the one
+	 * the sequencer knows about, swap HSCB pointers and
+	 * finally assign the SCB to the tag indexed location
+	 * in the scb_array.  This makes sure that we can still
+	 * locate the correct SCB by SCB_TAG.
+	 */
+	q_hscb = ahd->next_queued_hscb;
+	q_hscb_map = ahd->next_queued_hscb_map;
+	saved_hscb_busaddr = q_hscb->hscb_busaddr;
+	memcpy(q_hscb, scb->hscb, sizeof(*scb->hscb));
+	q_hscb->hscb_busaddr = saved_hscb_busaddr;
+	q_hscb->next_hscb_busaddr = scb->hscb->hscb_busaddr;
+
+	/* Now swap HSCB pointers. */
+	ahd->next_queued_hscb = scb->hscb;
+	ahd->next_queued_hscb_map = scb->hscb_map;
+	scb->hscb = q_hscb;
+	scb->hscb_map = q_hscb_map;
+
+	/* Now define the mapping from tag to SCB in the scbindex */
+	ahd->scb_data.scbindex[SCB_GET_TAG(scb)] = scb;
+}
+
+/*
+ * Tell the sequencer about a new transaction to execute.
+ */
+void
+ahd_queue_scb(struct ahd_softc *ahd, struct scb *scb)
+{
+	ahd_swap_with_next_hscb(ahd, scb);
+
+	if (SCBID_IS_NULL(SCB_GET_TAG(scb)))
+		panic("Attempt to queue invalid SCB tag %x\n",
+		      SCB_GET_TAG(scb));
+
+	/*
+	 * Keep a history of SCBs we've downloaded in the qinfifo.
+	 */
+	ahd->qinfifo[AHD_QIN_WRAP(ahd->qinfifonext)] = SCB_GET_TAG(scb);
+	ahd->qinfifonext++;
+
+	if (scb->sg_count != 0)
+		ahd_setup_data_scb(ahd, scb);
+	else
+		ahd_setup_noxfer_scb(ahd, scb);
+	ahd_setup_scb_common(ahd, scb);
+
+	/*
+	 * Make sure our data is consistent from the
+	 * perspective of the adapter.
+	 */
+	ahd_sync_scb(ahd, scb, BUS_DMASYNC_PREREAD|BUS_DMASYNC_PREWRITE);
+
+#ifdef AHD_DEBUG
+	if ((ahd_debug & AHD_SHOW_QUEUE) != 0) {
+		uint64_t host_dataptr;
+
+		host_dataptr = ahd_le64toh(scb->hscb->dataptr);
+		printf("%s: Queueing SCB %d:0x%x bus addr 0x%x - 0x%x%x/0x%x\n",
+		       ahd_name(ahd),
+		       SCB_GET_TAG(scb), scb->hscb->scsiid,
+		       ahd_le32toh(scb->hscb->hscb_busaddr),
+		       (u_int)((host_dataptr >> 32) & 0xFFFFFFFF),
+		       (u_int)(host_dataptr & 0xFFFFFFFF),
+		       ahd_le32toh(scb->hscb->datacnt));
+	}
+#endif
+	/* Tell the adapter about the newly queued SCB */
+	ahd_set_hnscb_qoff(ahd, ahd->qinfifonext);
+}
+
+/************************** Interrupt Processing ******************************/
+/*
+ * See if the firmware has posted any completed commands
+ * into our in-core command complete fifos.
+ */
+#define AHD_RUN_QOUTFIFO 0x1
+#define AHD_RUN_TQINFIFO 0x2
+u_int
+ahd_check_cmdcmpltqueues(struct ahd_softc *ahd)
+{
+	u_int retval;
+
+	retval = 0;
+	ahd_dmamap_sync(ahd, ahd->shared_data_dmat, ahd->shared_data_map.dmamap,
+			/*offset*/ahd->qoutfifonext * sizeof(*ahd->qoutfifo),
+			/*len*/sizeof(*ahd->qoutfifo), BUS_DMASYNC_POSTREAD);
+	if (ahd->qoutfifo[ahd->qoutfifonext].valid_tag
+	  == ahd->qoutfifonext_valid_tag)
+		retval |= AHD_RUN_QOUTFIFO;
+#ifdef AHD_TARGET_MODE
+	if ((ahd->flags & AHD_TARGETROLE) != 0
+	 && (ahd->flags & AHD_TQINFIFO_BLOCKED) == 0) {
+		ahd_dmamap_sync(ahd, ahd->shared_data_dmat,
+				ahd->shared_data_map.dmamap,
+				ahd_targetcmd_offset(ahd, ahd->tqinfifofnext),
+				/*len*/sizeof(struct target_cmd),
+				BUS_DMASYNC_POSTREAD);
+		if (ahd->targetcmds[ahd->tqinfifonext].cmd_valid != 0)
+			retval |= AHD_RUN_TQINFIFO;
+	}
+#endif
+	return (retval);
+}
+
+/*
+ * Catch an interrupt from the adapter
+ */
+int
+ahd_intr(struct ahd_softc *ahd)
+{
+	u_int	intstat;
+
+	if ((ahd->pause & INTEN) == 0) {
+		/*
+		 * Our interrupt is not enabled on the chip
+		 * and may be disabled for re-entrancy reasons,
+		 * so just return.  This is likely just a shared
+		 * interrupt.
+		 */
+		return (0);
+	}
+
+	/*
+	 * Instead of directly reading the interrupt status register,
+	 * infer the cause of the interrupt by checking our in-core
+	 * completion queues.  This avoids a costly PCI bus read in
+	 * most cases.
+	 */
+	if ((ahd->flags & AHD_ALL_INTERRUPTS) == 0
+	 && (ahd_check_cmdcmpltqueues(ahd) != 0))
+		intstat = CMDCMPLT;
+	else
+		intstat = ahd_inb(ahd, INTSTAT);
+
+	if ((intstat & INT_PEND) == 0)
+		return (0);
+
+	if (intstat & CMDCMPLT) {
+		ahd_outb(ahd, CLRINT, CLRCMDINT);
+
+		/*
+		 * Ensure that the chip sees that we've cleared
+		 * this interrupt before we walk the output fifo.
+		 * Otherwise, we may, due to posted bus writes,
+		 * clear the interrupt after we finish the scan,
+		 * and after the sequencer has added new entries
+		 * and asserted the interrupt again.
+		 */
+		if ((ahd->bugs & AHD_INTCOLLISION_BUG) != 0) {
+			if (ahd_is_paused(ahd)) {
+				/*
+				 * Potentially lost SEQINT.
+				 * If SEQINTCODE is non-zero,
+				 * simulate the SEQINT.
+				 */
+				if (ahd_inb(ahd, SEQINTCODE) != NO_SEQINT)
+					intstat |= SEQINT;
+			}
+		} else {
+			ahd_flush_device_writes(ahd);
+		}
+		ahd_run_qoutfifo(ahd);
+		ahd->cmdcmplt_counts[ahd->cmdcmplt_bucket]++;
+		ahd->cmdcmplt_total++;
+#ifdef AHD_TARGET_MODE
+		if ((ahd->flags & AHD_TARGETROLE) != 0)
+			ahd_run_tqinfifo(ahd, /*paused*/FALSE);
+#endif
+	}
+
+	/*
+	 * Handle statuses that may invalidate our cached
+	 * copy of INTSTAT separately.
+	 */
+	if (intstat == 0xFF && (ahd->features & AHD_REMOVABLE) != 0) {
+		/* Hot eject.  Do nothing */
+	} else if (intstat & HWERRINT) {
+		ahd_handle_hwerrint(ahd);
+	} else if ((intstat & (PCIINT|SPLTINT)) != 0) {
+		ahd->bus_intr(ahd);
+	} else {
+
+		if ((intstat & SEQINT) != 0)
+			ahd_handle_seqint(ahd, intstat);
+
+		if ((intstat & SCSIINT) != 0)
+			ahd_handle_scsiint(ahd, intstat);
+	}
+	return (1);
+}
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_inline.h linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_inline.h
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_inline.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_inline.h	Sun Apr  9 21:49:25 2006
@@ -63,18 +63,18 @@ static __inline ahd_mode_state ahd_build
 static __inline void ahd_extract_mode_state(struct ahd_softc *ahd,
 					    ahd_mode_state state,
 					    ahd_mode *src, ahd_mode *dst);
-static __inline void ahd_set_modes(struct ahd_softc *ahd, ahd_mode src,
+void ahd_set_modes(struct ahd_softc *ahd, ahd_mode src,
 				   ahd_mode dst);
-static __inline void ahd_update_modes(struct ahd_softc *ahd);
+void ahd_update_modes(struct ahd_softc *ahd);
 static __inline void ahd_assert_modes(struct ahd_softc *ahd, ahd_mode srcmode,
 				      ahd_mode dstmode, const char *file,
 				      int line);
-static __inline ahd_mode_state ahd_save_modes(struct ahd_softc *ahd);
-static __inline void ahd_restore_modes(struct ahd_softc *ahd,
+ahd_mode_state ahd_save_modes(struct ahd_softc *ahd);
+void ahd_restore_modes(struct ahd_softc *ahd,
 				       ahd_mode_state state);
 static __inline int  ahd_is_paused(struct ahd_softc *ahd);
 static __inline void ahd_pause(struct ahd_softc *ahd);
-static __inline void ahd_unpause(struct ahd_softc *ahd);
+void ahd_unpause(struct ahd_softc *ahd);
 
 static __inline void
 ahd_known_modes(struct ahd_softc *ahd, ahd_mode src, ahd_mode dst)
@@ -100,40 +100,6 @@ ahd_extract_mode_state(struct ahd_softc 
 }
 
 static __inline void
-ahd_set_modes(struct ahd_softc *ahd, ahd_mode src, ahd_mode dst)
-{
-	if (ahd->src_mode == src && ahd->dst_mode == dst)
-		return;
-#ifdef AHD_DEBUG
-	if (ahd->src_mode == AHD_MODE_UNKNOWN
-	 || ahd->dst_mode == AHD_MODE_UNKNOWN)
-		panic("Setting mode prior to saving it.\n");
-	if ((ahd_debug & AHD_SHOW_MODEPTR) != 0)
-		printf("%s: Setting mode 0x%x\n", ahd_name(ahd),
-		       ahd_build_mode_state(ahd, src, dst));
-#endif
-	ahd_outb(ahd, MODE_PTR, ahd_build_mode_state(ahd, src, dst));
-	ahd->src_mode = src;
-	ahd->dst_mode = dst;
-}
-
-static __inline void
-ahd_update_modes(struct ahd_softc *ahd)
-{
-	ahd_mode_state mode_ptr;
-	ahd_mode src;
-	ahd_mode dst;
-
-	mode_ptr = ahd_inb(ahd, MODE_PTR);
-#ifdef AHD_DEBUG
-	if ((ahd_debug & AHD_SHOW_MODEPTR) != 0)
-		printf("Reading mode 0x%x\n", mode_ptr);
-#endif
-	ahd_extract_mode_state(ahd, mode_ptr, &src, &dst);
-	ahd_known_modes(ahd, src, dst);
-}
-
-static __inline void
 ahd_assert_modes(struct ahd_softc *ahd, ahd_mode srcmode,
 		 ahd_mode dstmode, const char *file, int line)
 {
@@ -146,26 +112,6 @@ ahd_assert_modes(struct ahd_softc *ahd, 
 #endif
 }
 
-static __inline ahd_mode_state
-ahd_save_modes(struct ahd_softc *ahd)
-{
-	if (ahd->src_mode == AHD_MODE_UNKNOWN
-	 || ahd->dst_mode == AHD_MODE_UNKNOWN)
-		ahd_update_modes(ahd);
-
-	return (ahd_build_mode_state(ahd, ahd->src_mode, ahd->dst_mode));
-}
-
-static __inline void
-ahd_restore_modes(struct ahd_softc *ahd, ahd_mode_state state)
-{
-	ahd_mode src;
-	ahd_mode dst;
-
-	ahd_extract_mode_state(ahd, state, &src, &dst);
-	ahd_set_modes(ahd, src, dst);
-}
-
 #define AHD_ASSERT_MODES(ahd, source, dest) \
 	ahd_assert_modes(ahd, source, dest, __FILE__, __LINE__);
 
@@ -199,129 +145,17 @@ ahd_pause(struct ahd_softc *ahd)
 		;
 }
 
-/*
- * Allow the sequencer to continue program execution.
- * We check here to ensure that no additional interrupt
- * sources that would cause the sequencer to halt have been
- * asserted.  If, for example, a SCSI bus reset is detected
- * while we are fielding a different, pausing, interrupt type,
- * we don't want to release the sequencer before going back
- * into our interrupt handler and dealing with this new
- * condition.
- */
-static __inline void
-ahd_unpause(struct ahd_softc *ahd)
-{
-	/*
-	 * Automatically restore our modes to those saved
-	 * prior to the first change of the mode.
-	 */
-	if (ahd->saved_src_mode != AHD_MODE_UNKNOWN
-	 && ahd->saved_dst_mode != AHD_MODE_UNKNOWN) {
-		if ((ahd->flags & AHD_UPDATE_PEND_CMDS) != 0)
-			ahd_reset_cmds_pending(ahd);
-		ahd_set_modes(ahd, ahd->saved_src_mode, ahd->saved_dst_mode);
-	}
-
-	if ((ahd_inb(ahd, INTSTAT) & ~CMDCMPLT) == 0)
-		ahd_outb(ahd, HCNTRL, ahd->unpause);
-
-	ahd_known_modes(ahd, AHD_MODE_UNKNOWN, AHD_MODE_UNKNOWN);
-}
-
 /*********************** Scatter Gather List Handling *************************/
-static __inline void	*ahd_sg_setup(struct ahd_softc *ahd, struct scb *scb,
+void	*ahd_sg_setup(struct ahd_softc *ahd, struct scb *scb,
 				      void *sgptr, dma_addr_t addr,
 				      bus_size_t len, int last);
-static __inline void	 ahd_setup_scb_common(struct ahd_softc *ahd,
+void	 ahd_setup_scb_common(struct ahd_softc *ahd,
 					      struct scb *scb);
-static __inline void	 ahd_setup_data_scb(struct ahd_softc *ahd,
+void	 ahd_setup_data_scb(struct ahd_softc *ahd,
 					    struct scb *scb);
 static __inline void	 ahd_setup_noxfer_scb(struct ahd_softc *ahd,
 					      struct scb *scb);
 
-static __inline void *
-ahd_sg_setup(struct ahd_softc *ahd, struct scb *scb,
-	     void *sgptr, dma_addr_t addr, bus_size_t len, int last)
-{
-	scb->sg_count++;
-	if (sizeof(dma_addr_t) > 4
-	 && (ahd->flags & AHD_64BIT_ADDRESSING) != 0) {
-		struct ahd_dma64_seg *sg;
-
-		sg = (struct ahd_dma64_seg *)sgptr;
-		sg->addr = ahd_htole64(addr);
-		sg->len = ahd_htole32(len | (last ? AHD_DMA_LAST_SEG : 0));
-		return (sg + 1);
-	} else {
-		struct ahd_dma_seg *sg;
-
-		sg = (struct ahd_dma_seg *)sgptr;
-		sg->addr = ahd_htole32(addr & 0xFFFFFFFF);
-		sg->len = ahd_htole32(len | ((addr >> 8) & 0x7F000000)
-				    | (last ? AHD_DMA_LAST_SEG : 0));
-		return (sg + 1);
-	}
-}
-
-static __inline void
-ahd_setup_scb_common(struct ahd_softc *ahd, struct scb *scb)
-{
-	/* XXX Handle target mode SCBs. */
-	scb->crc_retry_count = 0;
-	if ((scb->flags & SCB_PACKETIZED) != 0) {
-		/* XXX what about ACA??  It is type 4, but TAG_TYPE == 0x3. */
-		scb->hscb->task_attribute = scb->hscb->control & SCB_TAG_TYPE;
-	} else {
-		if (ahd_get_transfer_length(scb) & 0x01)
-			scb->hscb->task_attribute = SCB_XFERLEN_ODD;
-		else
-			scb->hscb->task_attribute = 0;
-	}
-
-	if (scb->hscb->cdb_len <= MAX_CDB_LEN_WITH_SENSE_ADDR
-	 || (scb->hscb->cdb_len & SCB_CDB_LEN_PTR) != 0)
-		scb->hscb->shared_data.idata.cdb_plus_saddr.sense_addr =
-		    ahd_htole32(scb->sense_busaddr);
-}
-
-static __inline void
-ahd_setup_data_scb(struct ahd_softc *ahd, struct scb *scb)
-{
-	/*
-	 * Copy the first SG into the "current" data ponter area.
-	 */
-	if ((ahd->flags & AHD_64BIT_ADDRESSING) != 0) {
-		struct ahd_dma64_seg *sg;
-
-		sg = (struct ahd_dma64_seg *)scb->sg_list;
-		scb->hscb->dataptr = sg->addr;
-		scb->hscb->datacnt = sg->len;
-	} else {
-		struct ahd_dma_seg *sg;
-		uint32_t *dataptr_words;
-
-		sg = (struct ahd_dma_seg *)scb->sg_list;
-		dataptr_words = (uint32_t*)&scb->hscb->dataptr;
-		dataptr_words[0] = sg->addr;
-		dataptr_words[1] = 0;
-		if ((ahd->flags & AHD_39BIT_ADDRESSING) != 0) {
-			uint64_t high_addr;
-
-			high_addr = ahd_le32toh(sg->len) & 0x7F000000;
-			scb->hscb->dataptr |= ahd_htole64(high_addr << 8);
-		}
-		scb->hscb->datacnt = sg->len;
-	}
-	/*
-	 * Note where to find the SG entries in bus space.
-	 * We also set the full residual flag which the 
-	 * sequencer will clear as soon as a data transfer
-	 * occurs.
-	 */
-	scb->hscb->sgptr = ahd_htole32(scb->sg_list_busaddr|SG_FULL_RESID);
-}
-
 static __inline void
 ahd_setup_noxfer_scb(struct ahd_softc *ahd, struct scb *scb)
 {
@@ -427,18 +261,12 @@ static __inline struct ahd_initiator_tin
 					    char channel, u_int our_id,
 					    u_int remote_id,
 					    struct ahd_tmode_tstate **tstate);
-static __inline uint16_t
-			ahd_inw(struct ahd_softc *ahd, u_int port);
-static __inline void	ahd_outw(struct ahd_softc *ahd, u_int port,
-				 u_int value);
-static __inline uint32_t
-			ahd_inl(struct ahd_softc *ahd, u_int port);
-static __inline void	ahd_outl(struct ahd_softc *ahd, u_int port,
-				 uint32_t value);
-static __inline uint64_t
-			ahd_inq(struct ahd_softc *ahd, u_int port);
-static __inline void	ahd_outq(struct ahd_softc *ahd, u_int port,
-				 uint64_t value);
+uint16_t ahd_inw(struct ahd_softc *ahd, u_int port);
+void	ahd_outw(struct ahd_softc *ahd, u_int port, u_int value);
+uint32_t ahd_inl(struct ahd_softc *ahd, u_int port);
+void	ahd_outl(struct ahd_softc *ahd, u_int port, uint32_t value);
+uint64_t ahd_inq(struct ahd_softc *ahd, u_int port);
+void	ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value);
 static __inline u_int	ahd_get_scbptr(struct ahd_softc *ahd);
 static __inline void	ahd_set_scbptr(struct ahd_softc *ahd, u_int scbptr);
 static __inline u_int	ahd_get_hnscb_qoff(struct ahd_softc *ahd);
@@ -457,9 +285,11 @@ static __inline uint32_t
 			ahd_inl_scbram(struct ahd_softc *ahd, u_int offset);
 static __inline uint64_t
 			ahd_inq_scbram(struct ahd_softc *ahd, u_int offset);
-static __inline void	ahd_swap_with_next_hscb(struct ahd_softc *ahd,
+struct scb *
+			ahd_lookup_scb(struct ahd_softc *ahd, u_int tag);
+void	ahd_swap_with_next_hscb(struct ahd_softc *ahd,
 						struct scb *scb);
-static __inline void	ahd_queue_scb(struct ahd_softc *ahd, struct scb *scb);
+void	ahd_queue_scb(struct ahd_softc *ahd, struct scb *scb);
 static __inline uint8_t *
 			ahd_get_sense_buf(struct ahd_softc *ahd,
 					  struct scb *scb);
@@ -519,72 +349,6 @@ do {								\
 	dst->hscb->lun = src->hscb->lun;			\
 } while (0)
 
-static __inline uint16_t
-ahd_inw(struct ahd_softc *ahd, u_int port)
-{
-	/*
-	 * Read high byte first as some registers increment
-	 * or have other side effects when the low byte is
-	 * read.
-	 */
-	return ((ahd_inb(ahd, port+1) << 8) | ahd_inb(ahd, port));
-}
-
-static __inline void
-ahd_outw(struct ahd_softc *ahd, u_int port, u_int value)
-{
-	/*
-	 * Write low byte first to accomodate registers
-	 * such as PRGMCNT where the order maters.
-	 */
-	ahd_outb(ahd, port, value & 0xFF);
-	ahd_outb(ahd, port+1, (value >> 8) & 0xFF);
-}
-
-static __inline uint32_t
-ahd_inl(struct ahd_softc *ahd, u_int port)
-{
-	return ((ahd_inb(ahd, port))
-	      | (ahd_inb(ahd, port+1) << 8)
-	      | (ahd_inb(ahd, port+2) << 16)
-	      | (ahd_inb(ahd, port+3) << 24));
-}
-
-static __inline void
-ahd_outl(struct ahd_softc *ahd, u_int port, uint32_t value)
-{
-	ahd_outb(ahd, port, (value) & 0xFF);
-	ahd_outb(ahd, port+1, ((value) >> 8) & 0xFF);
-	ahd_outb(ahd, port+2, ((value) >> 16) & 0xFF);
-	ahd_outb(ahd, port+3, ((value) >> 24) & 0xFF);
-}
-
-static __inline uint64_t
-ahd_inq(struct ahd_softc *ahd, u_int port)
-{
-	return ((ahd_inb(ahd, port))
-	      | (ahd_inb(ahd, port+1) << 8)
-	      | (ahd_inb(ahd, port+2) << 16)
-	      | (ahd_inb(ahd, port+3) << 24)
-	      | (((uint64_t)ahd_inb(ahd, port+4)) << 32)
-	      | (((uint64_t)ahd_inb(ahd, port+5)) << 40)
-	      | (((uint64_t)ahd_inb(ahd, port+6)) << 48)
-	      | (((uint64_t)ahd_inb(ahd, port+7)) << 56));
-}
-
-static __inline void
-ahd_outq(struct ahd_softc *ahd, u_int port, uint64_t value)
-{
-	ahd_outb(ahd, port, value & 0xFF);
-	ahd_outb(ahd, port+1, (value >> 8) & 0xFF);
-	ahd_outb(ahd, port+2, (value >> 16) & 0xFF);
-	ahd_outb(ahd, port+3, (value >> 24) & 0xFF);
-	ahd_outb(ahd, port+4, (value >> 32) & 0xFF);
-	ahd_outb(ahd, port+5, (value >> 40) & 0xFF);
-	ahd_outb(ahd, port+6, (value >> 48) & 0xFF);
-	ahd_outb(ahd, port+7, (value >> 56) & 0xFF);
-}
-
 static __inline u_int
 ahd_get_scbptr(struct ahd_softc *ahd)
 {
@@ -719,104 +483,6 @@ ahd_inq_scbram(struct ahd_softc *ahd, u_
 	      | ((uint64_t)ahd_inl_scbram(ahd, offset+4)) << 32);
 }
 
-static __inline struct scb *
-ahd_lookup_scb(struct ahd_softc *ahd, u_int tag)
-{
-	struct scb* scb;
-
-	if (tag >= AHD_SCB_MAX)
-		return (NULL);
-	scb = ahd->scb_data.scbindex[tag];
-	if (scb != NULL)
-		ahd_sync_scb(ahd, scb,
-			     BUS_DMASYNC_POSTREAD|BUS_DMASYNC_POSTWRITE);
-	return (scb);
-}
-
-static __inline void
-ahd_swap_with_next_hscb(struct ahd_softc *ahd, struct scb *scb)
-{
-	struct	 hardware_scb *q_hscb;
-	struct	 map_node *q_hscb_map;
-	uint32_t saved_hscb_busaddr;
-
-	/*
-	 * Our queuing method is a bit tricky.  The card
-	 * knows in advance which HSCB (by address) to download,
-	 * and we can't disappoint it.  To achieve this, the next
-	 * HSCB to download is saved off in ahd->next_queued_hscb.
-	 * When we are called to queue "an arbitrary scb",
-	 * we copy the contents of the incoming HSCB to the one
-	 * the sequencer knows about, swap HSCB pointers and
-	 * finally assign the SCB to the tag indexed location
-	 * in the scb_array.  This makes sure that we can still
-	 * locate the correct SCB by SCB_TAG.
-	 */
-	q_hscb = ahd->next_queued_hscb;
-	q_hscb_map = ahd->next_queued_hscb_map;
-	saved_hscb_busaddr = q_hscb->hscb_busaddr;
-	memcpy(q_hscb, scb->hscb, sizeof(*scb->hscb));
-	q_hscb->hscb_busaddr = saved_hscb_busaddr;
-	q_hscb->next_hscb_busaddr = scb->hscb->hscb_busaddr;
-
-	/* Now swap HSCB pointers. */
-	ahd->next_queued_hscb = scb->hscb;
-	ahd->next_queued_hscb_map = scb->hscb_map;
-	scb->hscb = q_hscb;
-	scb->hscb_map = q_hscb_map;
-
-	/* Now define the mapping from tag to SCB in the scbindex */
-	ahd->scb_data.scbindex[SCB_GET_TAG(scb)] = scb;
-}
-
-/*
- * Tell the sequencer about a new transaction to execute.
- */
-static __inline void
-ahd_queue_scb(struct ahd_softc *ahd, struct scb *scb)
-{
-	ahd_swap_with_next_hscb(ahd, scb);
-
-	if (SCBID_IS_NULL(SCB_GET_TAG(scb)))
-		panic("Attempt to queue invalid SCB tag %x\n",
-		      SCB_GET_TAG(scb));
-
-	/*
-	 * Keep a history of SCBs we've downloaded in the qinfifo.
-	 */
-	ahd->qinfifo[AHD_QIN_WRAP(ahd->qinfifonext)] = SCB_GET_TAG(scb);
-	ahd->qinfifonext++;
-
-	if (scb->sg_count != 0)
-		ahd_setup_data_scb(ahd, scb);
-	else
-		ahd_setup_noxfer_scb(ahd, scb);
-	ahd_setup_scb_common(ahd, scb);
-
-	/*
-	 * Make sure our data is consistent from the
-	 * perspective of the adapter.
-	 */
-	ahd_sync_scb(ahd, scb, BUS_DMASYNC_PREREAD|BUS_DMASYNC_PREWRITE);
-
-#ifdef AHD_DEBUG
-	if ((ahd_debug & AHD_SHOW_QUEUE) != 0) {
-		uint64_t host_dataptr;
-
-		host_dataptr = ahd_le64toh(scb->hscb->dataptr);
-		printf("%s: Queueing SCB %d:0x%x bus addr 0x%x - 0x%x%x/0x%x\n",
-		       ahd_name(ahd),
-		       SCB_GET_TAG(scb), scb->hscb->scsiid,
-		       ahd_le32toh(scb->hscb->hscb_busaddr),
-		       (u_int)((host_dataptr >> 32) & 0xFFFFFFFF),
-		       (u_int)(host_dataptr & 0xFFFFFFFF),
-		       ahd_le32toh(scb->hscb->datacnt));
-	}
-#endif
-	/* Tell the adapter about the newly queued SCB */
-	ahd_set_hnscb_qoff(ahd, ahd->qinfifonext);
-}
-
 static __inline uint8_t *
 ahd_get_sense_buf(struct ahd_softc *ahd, struct scb *scb)
 {
@@ -832,8 +498,8 @@ ahd_get_sense_bufaddr(struct ahd_softc *
 /************************** Interrupt Processing ******************************/
 static __inline void	ahd_sync_qoutfifo(struct ahd_softc *ahd, int op);
 static __inline void	ahd_sync_tqinfifo(struct ahd_softc *ahd, int op);
-static __inline u_int	ahd_check_cmdcmpltqueues(struct ahd_softc *ahd);
-static __inline int	ahd_intr(struct ahd_softc *ahd);
+u_int	ahd_check_cmdcmpltqueues(struct ahd_softc *ahd);
+int	ahd_intr(struct ahd_softc *ahd);
 
 static __inline void
 ahd_sync_qoutfifo(struct ahd_softc *ahd, int op)
@@ -855,126 +521,6 @@ ahd_sync_tqinfifo(struct ahd_softc *ahd,
 				op);
 	}
 #endif
-}
-
-/*
- * See if the firmware has posted any completed commands
- * into our in-core command complete fifos.
- */
-#define AHD_RUN_QOUTFIFO 0x1
-#define AHD_RUN_TQINFIFO 0x2
-static __inline u_int
-ahd_check_cmdcmpltqueues(struct ahd_softc *ahd)
-{
-	u_int retval;
-
-	retval = 0;
-	ahd_dmamap_sync(ahd, ahd->shared_data_dmat, ahd->shared_data_map.dmamap,
-			/*offset*/ahd->qoutfifonext * sizeof(*ahd->qoutfifo),
-			/*len*/sizeof(*ahd->qoutfifo), BUS_DMASYNC_POSTREAD);
-	if (ahd->qoutfifo[ahd->qoutfifonext].valid_tag
-	  == ahd->qoutfifonext_valid_tag)
-		retval |= AHD_RUN_QOUTFIFO;
-#ifdef AHD_TARGET_MODE
-	if ((ahd->flags & AHD_TARGETROLE) != 0
-	 && (ahd->flags & AHD_TQINFIFO_BLOCKED) == 0) {
-		ahd_dmamap_sync(ahd, ahd->shared_data_dmat,
-				ahd->shared_data_map.dmamap,
-				ahd_targetcmd_offset(ahd, ahd->tqinfifofnext),
-				/*len*/sizeof(struct target_cmd),
-				BUS_DMASYNC_POSTREAD);
-		if (ahd->targetcmds[ahd->tqinfifonext].cmd_valid != 0)
-			retval |= AHD_RUN_TQINFIFO;
-	}
-#endif
-	return (retval);
-}
-
-/*
- * Catch an interrupt from the adapter
- */
-static __inline int
-ahd_intr(struct ahd_softc *ahd)
-{
-	u_int	intstat;
-
-	if ((ahd->pause & INTEN) == 0) {
-		/*
-		 * Our interrupt is not enabled on the chip
-		 * and may be disabled for re-entrancy reasons,
-		 * so just return.  This is likely just a shared
-		 * interrupt.
-		 */
-		return (0);
-	}
-
-	/*
-	 * Instead of directly reading the interrupt status register,
-	 * infer the cause of the interrupt by checking our in-core
-	 * completion queues.  This avoids a costly PCI bus read in
-	 * most cases.
-	 */
-	if ((ahd->flags & AHD_ALL_INTERRUPTS) == 0
-	 && (ahd_check_cmdcmpltqueues(ahd) != 0))
-		intstat = CMDCMPLT;
-	else
-		intstat = ahd_inb(ahd, INTSTAT);
-
-	if ((intstat & INT_PEND) == 0)
-		return (0);
-
-	if (intstat & CMDCMPLT) {
-		ahd_outb(ahd, CLRINT, CLRCMDINT);
-
-		/*
-		 * Ensure that the chip sees that we've cleared
-		 * this interrupt before we walk the output fifo.
-		 * Otherwise, we may, due to posted bus writes,
-		 * clear the interrupt after we finish the scan,
-		 * and after the sequencer has added new entries
-		 * and asserted the interrupt again.
-		 */
-		if ((ahd->bugs & AHD_INTCOLLISION_BUG) != 0) {
-			if (ahd_is_paused(ahd)) {
-				/*
-				 * Potentially lost SEQINT.
-				 * If SEQINTCODE is non-zero,
-				 * simulate the SEQINT.
-				 */
-				if (ahd_inb(ahd, SEQINTCODE) != NO_SEQINT)
-					intstat |= SEQINT;
-			}
-		} else {
-			ahd_flush_device_writes(ahd);
-		}
-		ahd_run_qoutfifo(ahd);
-		ahd->cmdcmplt_counts[ahd->cmdcmplt_bucket]++;
-		ahd->cmdcmplt_total++;
-#ifdef AHD_TARGET_MODE
-		if ((ahd->flags & AHD_TARGETROLE) != 0)
-			ahd_run_tqinfifo(ahd, /*paused*/FALSE);
-#endif
-	}
-
-	/*
-	 * Handle statuses that may invalidate our cached
-	 * copy of INTSTAT separately.
-	 */
-	if (intstat == 0xFF && (ahd->features & AHD_REMOVABLE) != 0) {
-		/* Hot eject.  Do nothing */
-	} else if (intstat & HWERRINT) {
-		ahd_handle_hwerrint(ahd);
-	} else if ((intstat & (PCIINT|SPLTINT)) != 0) {
-		ahd->bus_intr(ahd);
-	} else {
-
-		if ((intstat & SEQINT) != 0)
-			ahd_handle_seqint(ahd, intstat);
-
-		if ((intstat & SCSIINT) != 0)
-			ahd_handle_scsiint(ahd, intstat);
-	}
-	return (1);
 }
 
 #endif  /* _AIC79XX_INLINE_H_ */
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_osm.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_osm.c	Sun Apr  9 21:49:25 2006
@@ -468,7 +468,7 @@ ahd_linux_queue(struct scsi_cmnd * cmd, 
 	return rtn;
 }
 
-static inline struct scsi_target **
+static struct scsi_target **
 ahd_linux_target_in_softc(struct scsi_target *starget)
 {
 	struct	ahd_softc *ahd =
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_osm.h linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_osm.h
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_osm.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_osm.h	Sun Apr  9 22:00:31 2006
@@ -226,22 +226,9 @@ typedef struct timer_list ahd_timer_t;
 #define ahd_timer_init init_timer
 #define ahd_timer_stop del_timer_sync
 typedef void ahd_linux_callback_t (u_long);  
-static __inline void ahd_timer_reset(ahd_timer_t *timer, int usec,
+void ahd_timer_reset(ahd_timer_t *timer, int usec,
 				     ahd_callback_t *func, void *arg);
 
-static __inline void
-ahd_timer_reset(ahd_timer_t *timer, int usec, ahd_callback_t *func, void *arg)
-{
-	struct ahd_softc *ahd;
-
-	ahd = (struct ahd_softc *)arg;
-	del_timer(timer);
-	timer->data = (u_long)arg;
-	timer->expires = jiffies + (usec * HZ)/1000000;
-	timer->function = (ahd_linux_callback_t*)func;
-	add_timer(timer);
-}
-
 /***************************** SMP support ************************************/
 #include <linux/spinlock.h>
 
@@ -399,111 +386,19 @@ struct ahd_platform_data {
 #define malloc(size, type, flags) kmalloc(size, flags)
 #define free(ptr, type) kfree(ptr)
 
-static __inline void ahd_delay(long);
-static __inline void
-ahd_delay(long usec)
-{
-	/*
-	 * udelay on Linux can have problems for
-	 * multi-millisecond waits.  Wait at most
-	 * 1024us per call.
-	 */
-	while (usec > 0) {
-		udelay(usec % 1024);
-		usec -= 1024;
-	}
-}
-
+void ahd_delay(long);
 
 /***************************** Low Level I/O **********************************/
-static __inline uint8_t ahd_inb(struct ahd_softc * ahd, long port);
-static __inline uint16_t ahd_inw_atomic(struct ahd_softc * ahd, long port);
-static __inline void ahd_outb(struct ahd_softc * ahd, long port, uint8_t val);
-static __inline void ahd_outw_atomic(struct ahd_softc * ahd,
+uint8_t ahd_inb(struct ahd_softc * ahd, long port);
+uint16_t ahd_inw_atomic(struct ahd_softc * ahd, long port);
+void ahd_outb(struct ahd_softc * ahd, long port, uint8_t val);
+void ahd_outw_atomic(struct ahd_softc * ahd,
 				     long port, uint16_t val);
-static __inline void ahd_outsb(struct ahd_softc * ahd, long port,
+void ahd_outsb(struct ahd_softc * ahd, long port,
 			       uint8_t *, int count);
-static __inline void ahd_insb(struct ahd_softc * ahd, long port,
+void ahd_insb(struct ahd_softc * ahd, long port,
 			       uint8_t *, int count);
 
-static __inline uint8_t
-ahd_inb(struct ahd_softc * ahd, long port)
-{
-	uint8_t x;
-
-	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
-		x = readb(ahd->bshs[0].maddr + port);
-	} else {
-		x = inb(ahd->bshs[(port) >> 8].ioport + ((port) & 0xFF));
-	}
-	mb();
-	return (x);
-}
-
-static __inline uint16_t
-ahd_inw_atomic(struct ahd_softc * ahd, long port)
-{
-	uint8_t x;
-
-	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
-		x = readw(ahd->bshs[0].maddr + port);
-	} else {
-		x = inw(ahd->bshs[(port) >> 8].ioport + ((port) & 0xFF));
-	}
-	mb();
-	return (x);
-}
-
-static __inline void
-ahd_outb(struct ahd_softc * ahd, long port, uint8_t val)
-{
-	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
-		writeb(val, ahd->bshs[0].maddr + port);
-	} else {
-		outb(val, ahd->bshs[(port) >> 8].ioport + (port & 0xFF));
-	}
-	mb();
-}
-
-static __inline void
-ahd_outw_atomic(struct ahd_softc * ahd, long port, uint16_t val)
-{
-	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
-		writew(val, ahd->bshs[0].maddr + port);
-	} else {
-		outw(val, ahd->bshs[(port) >> 8].ioport + (port & 0xFF));
-	}
-	mb();
-}
-
-static __inline void
-ahd_outsb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
-{
-	int i;
-
-	/*
-	 * There is probably a more efficient way to do this on Linux
-	 * but we don't use this for anything speed critical and this
-	 * should work.
-	 */
-	for (i = 0; i < count; i++)
-		ahd_outb(ahd, port, *array++);
-}
-
-static __inline void
-ahd_insb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
-{
-	int i;
-
-	/*
-	 * There is probably a more efficient way to do this on Linux
-	 * but we don't use this for anything speed critical and this
-	 * should work.
-	 */
-	for (i = 0; i < count; i++)
-		*array++ = ahd_inb(ahd, port);
-}
-
 /**************************** Initialization **********************************/
 int		ahd_linux_register_host(struct ahd_softc *,
 					struct scsi_host_template *);
@@ -613,6 +508,7 @@ void			 ahd_linux_pci_exit(void);
 int			 ahd_pci_map_registers(struct ahd_softc *ahd);
 int			 ahd_pci_map_int(struct ahd_softc *ahd);
 
+void ahd_BUG_bad_pci_rw_size(void);
 static __inline uint32_t ahd_pci_read_config(ahd_dev_softc_t pci,
 					     int reg, int width);
 
@@ -640,7 +536,7 @@ ahd_pci_read_config(ahd_dev_softc_t pci,
 		return (retval);
 	}
 	default:
-		panic("ahd_pci_read_config: Read size too big");
+		ahd_BUG_bad_pci_rw_size();
 		/* NOTREACHED */
 		return (0);
 	}
@@ -664,7 +560,7 @@ ahd_pci_write_config(ahd_dev_softc_t pci
 		pci_write_config_dword(pci, reg, value);
 		break;
 	default:
-		panic("ahd_pci_write_config: Write size too big");
+		ahd_BUG_bad_pci_rw_size();
 		/* NOTREACHED */
 	}
 }
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_osm_o.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_osm_o.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic79xx_osm_o.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic79xx_osm_o.c	Sun Apr  9 21:53:01 2006
@@ -0,0 +1,114 @@
+/*
+ * Adaptec AIC79xx device driver for Linux.
+ *
+ * Formerly inlined routines from aic79xx_osm.h are moved here.
+ * This file is #included into aic79xx_core.c
+ */
+
+/***************************** Timer Facilities *******************************/
+void
+ahd_timer_reset(ahd_timer_t *timer, int usec, ahd_callback_t *func, void *arg)
+{
+	struct ahd_softc *ahd;
+
+	ahd = (struct ahd_softc *)arg;
+	del_timer(timer);
+	timer->data = (u_long)arg;
+	timer->expires = jiffies + (usec * HZ)/1000000;
+	timer->function = (ahd_linux_callback_t*)func;
+	add_timer(timer);
+}
+
+/************************** OS Utility Wrappers *******************************/
+void
+ahd_delay(long usec)
+{
+	/*
+	 * udelay on Linux can have problems for
+	 * multi-millisecond waits.  Wait at most
+	 * 1024us per call.
+	 */
+	while (usec > 0) {
+		udelay(usec % 1024);
+		usec -= 1024;
+	}
+}
+
+/***************************** Low Level I/O **********************************/
+uint8_t
+ahd_inb(struct ahd_softc * ahd, long port)
+{
+	uint8_t x;
+
+	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
+		x = readb(ahd->bshs[0].maddr + port);
+	} else {
+		x = inb(ahd->bshs[(port) >> 8].ioport + ((port) & 0xFF));
+	}
+	mb();
+	return (x);
+}
+
+uint16_t
+ahd_inw_atomic(struct ahd_softc * ahd, long port)
+{
+	uint8_t x;
+
+	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
+		x = readw(ahd->bshs[0].maddr + port);
+	} else {
+		x = inw(ahd->bshs[(port) >> 8].ioport + ((port) & 0xFF));
+	}
+	mb();
+	return (x);
+}
+
+void
+ahd_outb(struct ahd_softc * ahd, long port, uint8_t val)
+{
+	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
+		writeb(val, ahd->bshs[0].maddr + port);
+	} else {
+		outb(val, ahd->bshs[(port) >> 8].ioport + (port & 0xFF));
+	}
+	mb();
+}
+
+void
+ahd_outw_atomic(struct ahd_softc * ahd, long port, uint16_t val)
+{
+	if (ahd->tags[0] == BUS_SPACE_MEMIO) {
+		writew(val, ahd->bshs[0].maddr + port);
+	} else {
+		outw(val, ahd->bshs[(port) >> 8].ioport + (port & 0xFF));
+	}
+	mb();
+}
+
+void
+ahd_outsb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
+{
+	int i;
+
+	/*
+	 * There is probably a more efficient way to do this on Linux
+	 * but we don't use this for anything speed critical and this
+	 * should work.
+	 */
+	for (i = 0; i < count; i++)
+		ahd_outb(ahd, port, *array++);
+}
+
+void
+ahd_insb(struct ahd_softc * ahd, long port, uint8_t *array, int count)
+{
+	int i;
+
+	/*
+	 * There is probably a more efficient way to do this on Linux
+	 * but we don't use this for anything speed critical and this
+	 * should work.
+	 */
+	for (i = 0; i < count; i++)
+		*array++ = ahd_inb(ahd, port);
+}
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_core.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_core.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_core.c	Sun Apr  9 21:49:25 2006
@@ -50,6 +50,10 @@
 #include <dev/aic7xxx/aicasm/aicasm_insformat.h>
 #endif
 
+/* Were inlined, but moved out-of-line because they are HUGE: */
+#include "aic7xxx_osm_o.c"
+#include "aic7xxx_inline.c"
+
 /***************************** Lookup Tables **********************************/
 char *ahc_chip_names[] =
 {
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_inline.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_inline.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_inline.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_inline.c	Sun Apr  9 21:49:25 2006
@@ -0,0 +1,311 @@
+/*
+ * Routines shareable across OS platforms.
+ *
+ * Formerly inlined routines from aic7xxx_inline.h are moved here.
+ * This file is #included into aic7xxx_core.c
+ */
+
+/*********************** Miscelaneous Support Functions ***********************/
+uint16_t
+ahc_inw(struct ahc_softc *ahc, u_int port)
+{
+	return ((ahc_inb(ahc, port+1) << 8) | ahc_inb(ahc, port));
+}
+
+void
+ahc_outw(struct ahc_softc *ahc, u_int port, u_int value)
+{
+	ahc_outb(ahc, port, value & 0xFF);
+	ahc_outb(ahc, port+1, (value >> 8) & 0xFF);
+}
+
+uint32_t
+ahc_inl(struct ahc_softc *ahc, u_int port)
+{
+	return ((ahc_inb(ahc, port))
+	      | (ahc_inb(ahc, port+1) << 8)
+	      | (ahc_inb(ahc, port+2) << 16)
+	      | (ahc_inb(ahc, port+3) << 24));
+}
+
+void
+ahc_outl(struct ahc_softc *ahc, u_int port, uint32_t value)
+{
+	ahc_outb(ahc, port, (value) & 0xFF);
+	ahc_outb(ahc, port+1, ((value) >> 8) & 0xFF);
+	ahc_outb(ahc, port+2, ((value) >> 16) & 0xFF);
+	ahc_outb(ahc, port+3, ((value) >> 24) & 0xFF);
+}
+
+uint64_t
+ahc_inq(struct ahc_softc *ahc, u_int port)
+{
+	return ((ahc_inb(ahc, port))
+	      | (ahc_inb(ahc, port+1) << 8)
+	      | (ahc_inb(ahc, port+2) << 16)
+	      | (ahc_inb(ahc, port+3) << 24)
+	      | (((uint64_t)ahc_inb(ahc, port+4)) << 32)
+	      | (((uint64_t)ahc_inb(ahc, port+5)) << 40)
+	      | (((uint64_t)ahc_inb(ahc, port+6)) << 48)
+	      | (((uint64_t)ahc_inb(ahc, port+7)) << 56));
+}
+
+void
+ahc_outq(struct ahc_softc *ahc, u_int port, uint64_t value)
+{
+	ahc_outb(ahc, port, value & 0xFF);
+	ahc_outb(ahc, port+1, (value >> 8) & 0xFF);
+	ahc_outb(ahc, port+2, (value >> 16) & 0xFF);
+	ahc_outb(ahc, port+3, (value >> 24) & 0xFF);
+	ahc_outb(ahc, port+4, (value >> 32) & 0xFF);
+	ahc_outb(ahc, port+5, (value >> 40) & 0xFF);
+	ahc_outb(ahc, port+6, (value >> 48) & 0xFF);
+	ahc_outb(ahc, port+7, (value >> 56) & 0xFF);
+}
+
+/*
+ * Get a free scb. If there are none, see if we can allocate a new SCB.
+ */
+struct scb *
+ahc_get_scb(struct ahc_softc *ahc)
+{
+	struct scb *scb;
+
+	if ((scb = SLIST_FIRST(&ahc->scb_data->free_scbs)) == NULL) {
+		ahc_alloc_scbs(ahc);
+		scb = SLIST_FIRST(&ahc->scb_data->free_scbs);
+		if (scb == NULL)
+			return (NULL);
+	}
+	SLIST_REMOVE_HEAD(&ahc->scb_data->free_scbs, links.sle);
+	return (scb);
+}
+
+/*
+ * Return an SCB resource to the free list.
+ */
+void
+ahc_free_scb(struct ahc_softc *ahc, struct scb *scb)
+{       
+	struct hardware_scb *hscb;
+
+	hscb = scb->hscb;
+	/* Clean up for the next user */
+	ahc->scb_data->scbindex[hscb->tag] = NULL;
+	scb->flags = SCB_FREE;
+	hscb->control = 0;
+
+	SLIST_INSERT_HEAD(&ahc->scb_data->free_scbs, scb, links.sle);
+
+	/* Notify the OSM that a resource is now available. */
+	ahc_platform_scb_free(ahc, scb);
+}
+
+struct scb *
+ahc_lookup_scb(struct ahc_softc *ahc, u_int tag)
+{
+	struct scb* scb;
+
+	scb = ahc->scb_data->scbindex[tag];
+	if (scb != NULL)
+		ahc_sync_scb(ahc, scb,
+			     BUS_DMASYNC_POSTREAD|BUS_DMASYNC_POSTWRITE);
+	return (scb);
+}
+
+void
+ahc_swap_with_next_hscb(struct ahc_softc *ahc, struct scb *scb)
+{
+	struct hardware_scb *q_hscb;
+	u_int  saved_tag;
+
+	/*
+	 * Our queuing method is a bit tricky.  The card
+	 * knows in advance which HSCB to download, and we
+	 * can't disappoint it.  To achieve this, the next
+	 * SCB to download is saved off in ahc->next_queued_scb.
+	 * When we are called to queue "an arbitrary scb",
+	 * we copy the contents of the incoming HSCB to the one
+	 * the sequencer knows about, swap HSCB pointers and
+	 * finally assign the SCB to the tag indexed location
+	 * in the scb_array.  This makes sure that we can still
+	 * locate the correct SCB by SCB_TAG.
+	 */
+	q_hscb = ahc->next_queued_scb->hscb;
+	saved_tag = q_hscb->tag;
+	memcpy(q_hscb, scb->hscb, sizeof(*scb->hscb));
+	if ((scb->flags & SCB_CDB32_PTR) != 0) {
+		q_hscb->shared_data.cdb_ptr =
+		    ahc_htole32(ahc_hscb_busaddr(ahc, q_hscb->tag)
+			      + offsetof(struct hardware_scb, cdb32));
+	}
+	q_hscb->tag = saved_tag;
+	q_hscb->next = scb->hscb->tag;
+
+	/* Now swap HSCB pointers. */
+	ahc->next_queued_scb->hscb = scb->hscb;
+	scb->hscb = q_hscb;
+
+	/* Now define the mapping from tag to SCB in the scbindex */
+	ahc->scb_data->scbindex[scb->hscb->tag] = scb;
+}
+
+/*
+ * Tell the sequencer about a new transaction to execute.
+ */
+void
+ahc_queue_scb(struct ahc_softc *ahc, struct scb *scb)
+{
+	ahc_swap_with_next_hscb(ahc, scb);
+
+	if (scb->hscb->tag == SCB_LIST_NULL
+	 || scb->hscb->next == SCB_LIST_NULL)
+		panic("Attempt to queue invalid SCB tag %x:%x\n",
+		      scb->hscb->tag, scb->hscb->next);
+
+	/*
+	 * Setup data "oddness".
+	 */
+	scb->hscb->lun &= LID;
+	if (ahc_get_transfer_length(scb) & 0x1)
+		scb->hscb->lun |= SCB_XFERLEN_ODD;
+
+	/*
+	 * Keep a history of SCBs we've downloaded in the qinfifo.
+	 */
+	ahc->qinfifo[ahc->qinfifonext++] = scb->hscb->tag;
+
+	/*
+	 * Make sure our data is consistent from the
+	 * perspective of the adapter.
+	 */
+	ahc_sync_scb(ahc, scb, BUS_DMASYNC_PREREAD|BUS_DMASYNC_PREWRITE);
+
+	/* Tell the adapter about the newly queued SCB */
+	if ((ahc->features & AHC_QUEUE_REGS) != 0) {
+		ahc_outb(ahc, HNSCB_QOFF, ahc->qinfifonext);
+	} else {
+		if ((ahc->features & AHC_AUTOPAUSE) == 0)
+			ahc_pause(ahc);
+		ahc_outb(ahc, KERNEL_QINPOS, ahc->qinfifonext);
+		if ((ahc->features & AHC_AUTOPAUSE) == 0)
+			ahc_unpause(ahc);
+	}
+}
+
+/************************** Interrupt Processing ******************************/
+/*
+ * See if the firmware has posted any completed commands
+ * into our in-core command complete fifos.
+ */
+#define AHC_RUN_QOUTFIFO 0x1
+#define AHC_RUN_TQINFIFO 0x2
+u_int
+ahc_check_cmdcmpltqueues(struct ahc_softc *ahc)
+{
+	u_int retval;
+
+	retval = 0;
+	ahc_dmamap_sync(ahc, ahc->shared_data_dmat, ahc->shared_data_dmamap,
+			/*offset*/ahc->qoutfifonext, /*len*/1,
+			BUS_DMASYNC_POSTREAD);
+	if (ahc->qoutfifo[ahc->qoutfifonext] != SCB_LIST_NULL)
+		retval |= AHC_RUN_QOUTFIFO;
+#ifdef AHC_TARGET_MODE
+	if ((ahc->flags & AHC_TARGETROLE) != 0
+	 && (ahc->flags & AHC_TQINFIFO_BLOCKED) == 0) {
+		ahc_dmamap_sync(ahc, ahc->shared_data_dmat,
+				ahc->shared_data_dmamap,
+				ahc_targetcmd_offset(ahc, ahc->tqinfifofnext),
+				/*len*/sizeof(struct target_cmd),
+				BUS_DMASYNC_POSTREAD);
+		if (ahc->targetcmds[ahc->tqinfifonext].cmd_valid != 0)
+			retval |= AHC_RUN_TQINFIFO;
+	}
+#endif
+	return (retval);
+}
+
+/*
+ * Catch an interrupt from the adapter
+ */
+int
+ahc_intr(struct ahc_softc *ahc)
+{
+	u_int	intstat;
+
+	if ((ahc->pause & INTEN) == 0) {
+		/*
+		 * Our interrupt is not enabled on the chip
+		 * and may be disabled for re-entrancy reasons,
+		 * so just return.  This is likely just a shared
+		 * interrupt.
+		 */
+		return (0);
+	}
+	/*
+	 * Instead of directly reading the interrupt status register,
+	 * infer the cause of the interrupt by checking our in-core
+	 * completion queues.  This avoids a costly PCI bus read in
+	 * most cases.
+	 */
+	if ((ahc->flags & (AHC_ALL_INTERRUPTS|AHC_EDGE_INTERRUPT)) == 0
+	 && (ahc_check_cmdcmpltqueues(ahc) != 0))
+		intstat = CMDCMPLT;
+	else {
+		intstat = ahc_inb(ahc, INTSTAT);
+	}
+
+	if ((intstat & INT_PEND) == 0) {
+#if AHC_PCI_CONFIG > 0
+		if (ahc->unsolicited_ints > 500) {
+			ahc->unsolicited_ints = 0;
+			if ((ahc->chip & AHC_PCI) != 0
+			 && (ahc_inb(ahc, ERROR) & PCIERRSTAT) != 0)
+				ahc->bus_intr(ahc);
+		}
+#endif
+		ahc->unsolicited_ints++;
+		return (0);
+	}
+	ahc->unsolicited_ints = 0;
+
+	if (intstat & CMDCMPLT) {
+		ahc_outb(ahc, CLRINT, CLRCMDINT);
+
+		/*
+		 * Ensure that the chip sees that we've cleared
+		 * this interrupt before we walk the output fifo.
+		 * Otherwise, we may, due to posted bus writes,
+		 * clear the interrupt after we finish the scan,
+		 * and after the sequencer has added new entries
+		 * and asserted the interrupt again.
+		 */
+		ahc_flush_device_writes(ahc);
+		ahc_run_qoutfifo(ahc);
+#ifdef AHC_TARGET_MODE
+		if ((ahc->flags & AHC_TARGETROLE) != 0)
+			ahc_run_tqinfifo(ahc, /*paused*/FALSE);
+#endif
+	}
+
+	/*
+	 * Handle statuses that may invalidate our cached
+	 * copy of INTSTAT separately.
+	 */
+	if (intstat == 0xFF && (ahc->features & AHC_REMOVABLE) != 0) {
+		/* Hot eject.  Do nothing */
+	} else if (intstat & BRKADRINT) {
+		ahc_handle_brkadrint(ahc);
+	} else if ((intstat & (SEQINT|SCSIINT)) != 0) {
+
+		ahc_pause_bug_fix(ahc);
+
+		if ((intstat & SEQINT) != 0)
+			ahc_handle_seqint(ahc, intstat);
+
+		if ((intstat & SCSIINT) != 0)
+			ahc_handle_scsiint(ahc, intstat);
+	}
+	return (1);
+}
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_inline.h linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_inline.h
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_inline.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_inline.h	Sun Apr  9 21:49:25 2006
@@ -238,24 +238,20 @@ static __inline struct ahc_initiator_tin
 					    char channel, u_int our_id,
 					    u_int remote_id,
 					    struct ahc_tmode_tstate **tstate);
-static __inline uint16_t
-			ahc_inw(struct ahc_softc *ahc, u_int port);
-static __inline void	ahc_outw(struct ahc_softc *ahc, u_int port,
-				 u_int value);
-static __inline uint32_t
-			ahc_inl(struct ahc_softc *ahc, u_int port);
-static __inline void	ahc_outl(struct ahc_softc *ahc, u_int port,
-				 uint32_t value);
-static __inline uint64_t
-			ahc_inq(struct ahc_softc *ahc, u_int port);
-static __inline void	ahc_outq(struct ahc_softc *ahc, u_int port,
-				 uint64_t value);
-static __inline struct scb*
-			ahc_get_scb(struct ahc_softc *ahc);
-static __inline void	ahc_free_scb(struct ahc_softc *ahc, struct scb *scb);
-static __inline void	ahc_swap_with_next_hscb(struct ahc_softc *ahc,
+uint16_t ahc_inw(struct ahc_softc *ahc, u_int port);
+void	ahc_outw(struct ahc_softc *ahc, u_int port, u_int value);
+uint32_t ahc_inl(struct ahc_softc *ahc, u_int port);
+void	ahc_outl(struct ahc_softc *ahc, u_int port, uint32_t value);
+uint64_t ahc_inq(struct ahc_softc *ahc, u_int port);
+void	ahc_outq(struct ahc_softc *ahc, u_int port, uint64_t value);
+struct scb*
+	ahc_get_scb(struct ahc_softc *ahc);
+void	ahc_free_scb(struct ahc_softc *ahc, struct scb *scb);
+struct scb *
+	ahc_lookup_scb(struct ahc_softc *ahc, u_int tag);
+void	ahc_swap_with_next_hscb(struct ahc_softc *ahc,
 						struct scb *scb);
-static __inline void	ahc_queue_scb(struct ahc_softc *ahc, struct scb *scb);
+void	ahc_queue_scb(struct ahc_softc *ahc, struct scb *scb);
 static __inline struct scsi_sense_data *
 			ahc_get_sense_buf(struct ahc_softc *ahc,
 					  struct scb *scb);
@@ -297,193 +293,6 @@ ahc_fetch_transinfo(struct ahc_softc *ah
 	return (&(*tstate)->transinfo[remote_id]);
 }
 
-static __inline uint16_t
-ahc_inw(struct ahc_softc *ahc, u_int port)
-{
-	return ((ahc_inb(ahc, port+1) << 8) | ahc_inb(ahc, port));
-}
-
-static __inline void
-ahc_outw(struct ahc_softc *ahc, u_int port, u_int value)
-{
-	ahc_outb(ahc, port, value & 0xFF);
-	ahc_outb(ahc, port+1, (value >> 8) & 0xFF);
-}
-
-static __inline uint32_t
-ahc_inl(struct ahc_softc *ahc, u_int port)
-{
-	return ((ahc_inb(ahc, port))
-	      | (ahc_inb(ahc, port+1) << 8)
-	      | (ahc_inb(ahc, port+2) << 16)
-	      | (ahc_inb(ahc, port+3) << 24));
-}
-
-static __inline void
-ahc_outl(struct ahc_softc *ahc, u_int port, uint32_t value)
-{
-	ahc_outb(ahc, port, (value) & 0xFF);
-	ahc_outb(ahc, port+1, ((value) >> 8) & 0xFF);
-	ahc_outb(ahc, port+2, ((value) >> 16) & 0xFF);
-	ahc_outb(ahc, port+3, ((value) >> 24) & 0xFF);
-}
-
-static __inline uint64_t
-ahc_inq(struct ahc_softc *ahc, u_int port)
-{
-	return ((ahc_inb(ahc, port))
-	      | (ahc_inb(ahc, port+1) << 8)
-	      | (ahc_inb(ahc, port+2) << 16)
-	      | (ahc_inb(ahc, port+3) << 24)
-	      | (((uint64_t)ahc_inb(ahc, port+4)) << 32)
-	      | (((uint64_t)ahc_inb(ahc, port+5)) << 40)
-	      | (((uint64_t)ahc_inb(ahc, port+6)) << 48)
-	      | (((uint64_t)ahc_inb(ahc, port+7)) << 56));
-}
-
-static __inline void
-ahc_outq(struct ahc_softc *ahc, u_int port, uint64_t value)
-{
-	ahc_outb(ahc, port, value & 0xFF);
-	ahc_outb(ahc, port+1, (value >> 8) & 0xFF);
-	ahc_outb(ahc, port+2, (value >> 16) & 0xFF);
-	ahc_outb(ahc, port+3, (value >> 24) & 0xFF);
-	ahc_outb(ahc, port+4, (value >> 32) & 0xFF);
-	ahc_outb(ahc, port+5, (value >> 40) & 0xFF);
-	ahc_outb(ahc, port+6, (value >> 48) & 0xFF);
-	ahc_outb(ahc, port+7, (value >> 56) & 0xFF);
-}
-
-/*
- * Get a free scb. If there are none, see if we can allocate a new SCB.
- */
-static __inline struct scb *
-ahc_get_scb(struct ahc_softc *ahc)
-{
-	struct scb *scb;
-
-	if ((scb = SLIST_FIRST(&ahc->scb_data->free_scbs)) == NULL) {
-		ahc_alloc_scbs(ahc);
-		scb = SLIST_FIRST(&ahc->scb_data->free_scbs);
-		if (scb == NULL)
-			return (NULL);
-	}
-	SLIST_REMOVE_HEAD(&ahc->scb_data->free_scbs, links.sle);
-	return (scb);
-}
-
-/*
- * Return an SCB resource to the free list.
- */
-static __inline void
-ahc_free_scb(struct ahc_softc *ahc, struct scb *scb)
-{       
-	struct hardware_scb *hscb;
-
-	hscb = scb->hscb;
-	/* Clean up for the next user */
-	ahc->scb_data->scbindex[hscb->tag] = NULL;
-	scb->flags = SCB_FREE;
-	hscb->control = 0;
-
-	SLIST_INSERT_HEAD(&ahc->scb_data->free_scbs, scb, links.sle);
-
-	/* Notify the OSM that a resource is now available. */
-	ahc_platform_scb_free(ahc, scb);
-}
-
-static __inline struct scb *
-ahc_lookup_scb(struct ahc_softc *ahc, u_int tag)
-{
-	struct scb* scb;
-
-	scb = ahc->scb_data->scbindex[tag];
-	if (scb != NULL)
-		ahc_sync_scb(ahc, scb,
-			     BUS_DMASYNC_POSTREAD|BUS_DMASYNC_POSTWRITE);
-	return (scb);
-}
-
-static __inline void
-ahc_swap_with_next_hscb(struct ahc_softc *ahc, struct scb *scb)
-{
-	struct hardware_scb *q_hscb;
-	u_int  saved_tag;
-
-	/*
-	 * Our queuing method is a bit tricky.  The card
-	 * knows in advance which HSCB to download, and we
-	 * can't disappoint it.  To achieve this, the next
-	 * SCB to download is saved off in ahc->next_queued_scb.
-	 * When we are called to queue "an arbitrary scb",
-	 * we copy the contents of the incoming HSCB to the one
-	 * the sequencer knows about, swap HSCB pointers and
-	 * finally assign the SCB to the tag indexed location
-	 * in the scb_array.  This makes sure that we can still
-	 * locate the correct SCB by SCB_TAG.
-	 */
-	q_hscb = ahc->next_queued_scb->hscb;
-	saved_tag = q_hscb->tag;
-	memcpy(q_hscb, scb->hscb, sizeof(*scb->hscb));
-	if ((scb->flags & SCB_CDB32_PTR) != 0) {
-		q_hscb->shared_data.cdb_ptr =
-		    ahc_htole32(ahc_hscb_busaddr(ahc, q_hscb->tag)
-			      + offsetof(struct hardware_scb, cdb32));
-	}
-	q_hscb->tag = saved_tag;
-	q_hscb->next = scb->hscb->tag;
-
-	/* Now swap HSCB pointers. */
-	ahc->next_queued_scb->hscb = scb->hscb;
-	scb->hscb = q_hscb;
-
-	/* Now define the mapping from tag to SCB in the scbindex */
-	ahc->scb_data->scbindex[scb->hscb->tag] = scb;
-}
-
-/*
- * Tell the sequencer about a new transaction to execute.
- */
-static __inline void
-ahc_queue_scb(struct ahc_softc *ahc, struct scb *scb)
-{
-	ahc_swap_with_next_hscb(ahc, scb);
-
-	if (scb->hscb->tag == SCB_LIST_NULL
-	 || scb->hscb->next == SCB_LIST_NULL)
-		panic("Attempt to queue invalid SCB tag %x:%x\n",
-		      scb->hscb->tag, scb->hscb->next);
-
-	/*
-	 * Setup data "oddness".
-	 */
-	scb->hscb->lun &= LID;
-	if (ahc_get_transfer_length(scb) & 0x1)
-		scb->hscb->lun |= SCB_XFERLEN_ODD;
-
-	/*
-	 * Keep a history of SCBs we've downloaded in the qinfifo.
-	 */
-	ahc->qinfifo[ahc->qinfifonext++] = scb->hscb->tag;
-
-	/*
-	 * Make sure our data is consistent from the
-	 * perspective of the adapter.
-	 */
-	ahc_sync_scb(ahc, scb, BUS_DMASYNC_PREREAD|BUS_DMASYNC_PREWRITE);
-
-	/* Tell the adapter about the newly queued SCB */
-	if ((ahc->features & AHC_QUEUE_REGS) != 0) {
-		ahc_outb(ahc, HNSCB_QOFF, ahc->qinfifonext);
-	} else {
-		if ((ahc->features & AHC_AUTOPAUSE) == 0)
-			ahc_pause(ahc);
-		ahc_outb(ahc, KERNEL_QINPOS, ahc->qinfifonext);
-		if ((ahc->features & AHC_AUTOPAUSE) == 0)
-			ahc_unpause(ahc);
-	}
-}
-
 static __inline struct scsi_sense_data *
 ahc_get_sense_buf(struct ahc_softc *ahc, struct scb *scb)
 {
@@ -506,8 +315,8 @@ ahc_get_sense_bufaddr(struct ahc_softc *
 /************************** Interrupt Processing ******************************/
 static __inline void	ahc_sync_qoutfifo(struct ahc_softc *ahc, int op);
 static __inline void	ahc_sync_tqinfifo(struct ahc_softc *ahc, int op);
-static __inline u_int	ahc_check_cmdcmpltqueues(struct ahc_softc *ahc);
-static __inline int	ahc_intr(struct ahc_softc *ahc);
+u_int	ahc_check_cmdcmpltqueues(struct ahc_softc *ahc);
+int	ahc_intr(struct ahc_softc *ahc);
 
 static __inline void
 ahc_sync_qoutfifo(struct ahc_softc *ahc, int op)
@@ -528,122 +337,6 @@ ahc_sync_tqinfifo(struct ahc_softc *ahc,
 				op);
 	}
 #endif
-}
-
-/*
- * See if the firmware has posted any completed commands
- * into our in-core command complete fifos.
- */
-#define AHC_RUN_QOUTFIFO 0x1
-#define AHC_RUN_TQINFIFO 0x2
-static __inline u_int
-ahc_check_cmdcmpltqueues(struct ahc_softc *ahc)
-{
-	u_int retval;
-
-	retval = 0;
-	ahc_dmamap_sync(ahc, ahc->shared_data_dmat, ahc->shared_data_dmamap,
-			/*offset*/ahc->qoutfifonext, /*len*/1,
-			BUS_DMASYNC_POSTREAD);
-	if (ahc->qoutfifo[ahc->qoutfifonext] != SCB_LIST_NULL)
-		retval |= AHC_RUN_QOUTFIFO;
-#ifdef AHC_TARGET_MODE
-	if ((ahc->flags & AHC_TARGETROLE) != 0
-	 && (ahc->flags & AHC_TQINFIFO_BLOCKED) == 0) {
-		ahc_dmamap_sync(ahc, ahc->shared_data_dmat,
-				ahc->shared_data_dmamap,
-				ahc_targetcmd_offset(ahc, ahc->tqinfifofnext),
-				/*len*/sizeof(struct target_cmd),
-				BUS_DMASYNC_POSTREAD);
-		if (ahc->targetcmds[ahc->tqinfifonext].cmd_valid != 0)
-			retval |= AHC_RUN_TQINFIFO;
-	}
-#endif
-	return (retval);
-}
-
-/*
- * Catch an interrupt from the adapter
- */
-static __inline int
-ahc_intr(struct ahc_softc *ahc)
-{
-	u_int	intstat;
-
-	if ((ahc->pause & INTEN) == 0) {
-		/*
-		 * Our interrupt is not enabled on the chip
-		 * and may be disabled for re-entrancy reasons,
-		 * so just return.  This is likely just a shared
-		 * interrupt.
-		 */
-		return (0);
-	}
-	/*
-	 * Instead of directly reading the interrupt status register,
-	 * infer the cause of the interrupt by checking our in-core
-	 * completion queues.  This avoids a costly PCI bus read in
-	 * most cases.
-	 */
-	if ((ahc->flags & (AHC_ALL_INTERRUPTS|AHC_EDGE_INTERRUPT)) == 0
-	 && (ahc_check_cmdcmpltqueues(ahc) != 0))
-		intstat = CMDCMPLT;
-	else {
-		intstat = ahc_inb(ahc, INTSTAT);
-	}
-
-	if ((intstat & INT_PEND) == 0) {
-#if AHC_PCI_CONFIG > 0
-		if (ahc->unsolicited_ints > 500) {
-			ahc->unsolicited_ints = 0;
-			if ((ahc->chip & AHC_PCI) != 0
-			 && (ahc_inb(ahc, ERROR) & PCIERRSTAT) != 0)
-				ahc->bus_intr(ahc);
-		}
-#endif
-		ahc->unsolicited_ints++;
-		return (0);
-	}
-	ahc->unsolicited_ints = 0;
-
-	if (intstat & CMDCMPLT) {
-		ahc_outb(ahc, CLRINT, CLRCMDINT);
-
-		/*
-		 * Ensure that the chip sees that we've cleared
-		 * this interrupt before we walk the output fifo.
-		 * Otherwise, we may, due to posted bus writes,
-		 * clear the interrupt after we finish the scan,
-		 * and after the sequencer has added new entries
-		 * and asserted the interrupt again.
-		 */
-		ahc_flush_device_writes(ahc);
-		ahc_run_qoutfifo(ahc);
-#ifdef AHC_TARGET_MODE
-		if ((ahc->flags & AHC_TARGETROLE) != 0)
-			ahc_run_tqinfifo(ahc, /*paused*/FALSE);
-#endif
-	}
-
-	/*
-	 * Handle statuses that may invalidate our cached
-	 * copy of INTSTAT separately.
-	 */
-	if (intstat == 0xFF && (ahc->features & AHC_REMOVABLE) != 0) {
-		/* Hot eject.  Do nothing */
-	} else if (intstat & BRKADRINT) {
-		ahc_handle_brkadrint(ahc);
-	} else if ((intstat & (SEQINT|SCSIINT)) != 0) {
-
-		ahc_pause_bug_fix(ahc);
-
-		if ((intstat & SEQINT) != 0)
-			ahc_handle_seqint(ahc, intstat);
-
-		if ((intstat & SCSIINT) != 0)
-			ahc_handle_scsiint(ahc, intstat);
-	}
-	return (1);
 }
 
 #endif  /* _AIC7XXX_INLINE_H_ */
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_osm.c	Sun Apr  9 21:49:25 2006
@@ -393,7 +393,7 @@ static int ahc_linux_unit;
 /********************************* Inlines ************************************/
 static __inline void ahc_linux_unmap_scb(struct ahc_softc*, struct scb*);
 
-static __inline int ahc_linux_map_seg(struct ahc_softc *ahc, struct scb *scb,
+static int ahc_linux_map_seg(struct ahc_softc *ahc, struct scb *scb,
 		 		      struct ahc_dma_seg *sg,
 				      dma_addr_t addr, bus_size_t len);
 
@@ -418,7 +418,7 @@ ahc_linux_unmap_scb(struct ahc_softc *ah
 	}
 }
 
-static __inline int
+static int
 ahc_linux_map_seg(struct ahc_softc *ahc, struct scb *scb,
 		  struct ahc_dma_seg *sg, dma_addr_t addr, bus_size_t len)
 {
@@ -492,7 +492,7 @@ ahc_linux_queue(struct scsi_cmnd * cmd, 
 	return rtn;
 }
 
-static inline struct scsi_target **
+static struct scsi_target **
 ahc_linux_target_in_softc(struct scsi_target *starget)
 {
 	struct	ahc_softc *ahc =
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_osm.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_osm.h	Sun Apr  9 22:00:33 2006
@@ -387,82 +387,15 @@ struct ahc_platform_data {
 #define malloc(size, type, flags) kmalloc(size, flags)
 #define free(ptr, type) kfree(ptr)
 
-static __inline void ahc_delay(long);
-static __inline void
-ahc_delay(long usec)
-{
-	/*
-	 * udelay on Linux can have problems for
-	 * multi-millisecond waits.  Wait at most
-	 * 1024us per call.
-	 */
-	while (usec > 0) {
-		udelay(usec % 1024);
-		usec -= 1024;
-	}
-}
-
+void ahc_delay(long);
 
 /***************************** Low Level I/O **********************************/
-static __inline uint8_t ahc_inb(struct ahc_softc * ahc, long port);
-static __inline void ahc_outb(struct ahc_softc * ahc, long port, uint8_t val);
-static __inline void ahc_outsb(struct ahc_softc * ahc, long port,
-			       uint8_t *, int count);
-static __inline void ahc_insb(struct ahc_softc * ahc, long port,
-			       uint8_t *, int count);
-
-static __inline uint8_t
-ahc_inb(struct ahc_softc * ahc, long port)
-{
-	uint8_t x;
-
-	if (ahc->tag == BUS_SPACE_MEMIO) {
-		x = readb(ahc->bsh.maddr + port);
-	} else {
-		x = inb(ahc->bsh.ioport + port);
-	}
-	mb();
-	return (x);
-}
-
-static __inline void
-ahc_outb(struct ahc_softc * ahc, long port, uint8_t val)
-{
-	if (ahc->tag == BUS_SPACE_MEMIO) {
-		writeb(val, ahc->bsh.maddr + port);
-	} else {
-		outb(val, ahc->bsh.ioport + port);
-	}
-	mb();
-}
-
-static __inline void
-ahc_outsb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
-{
-	int i;
-
-	/*
-	 * There is probably a more efficient way to do this on Linux
-	 * but we don't use this for anything speed critical and this
-	 * should work.
-	 */
-	for (i = 0; i < count; i++)
-		ahc_outb(ahc, port, *array++);
-}
-
-static __inline void
-ahc_insb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
-{
-	int i;
-
-	/*
-	 * There is probably a more efficient way to do this on Linux
-	 * but we don't use this for anything speed critical and this
-	 * should work.
-	 */
-	for (i = 0; i < count; i++)
-		*array++ = ahc_inb(ahc, port);
-}
+uint8_t ahc_inb(struct ahc_softc * ahc, long port);
+void ahc_outb(struct ahc_softc * ahc, long port, uint8_t val);
+void ahc_outsb(struct ahc_softc * ahc, long port,
+	       uint8_t *, int count);
+void ahc_insb(struct ahc_softc * ahc, long port,
+	       uint8_t *, int count);
 
 /**************************** Initialization **********************************/
 int		ahc_linux_register_host(struct ahc_softc *,
@@ -569,6 +502,7 @@ void			 ahc_linux_pci_exit(void);
 int			 ahc_pci_map_registers(struct ahc_softc *ahc);
 int			 ahc_pci_map_int(struct ahc_softc *ahc);
 
+void ahc_BUG_bad_pci_rw_size(void);
 static __inline uint32_t ahc_pci_read_config(ahc_dev_softc_t pci,
 					     int reg, int width);
 
@@ -596,7 +530,7 @@ ahc_pci_read_config(ahc_dev_softc_t pci,
 		return (retval);
 	}
 	default:
-		panic("ahc_pci_read_config: Read size too big");
+		ahc_BUG_bad_pci_rw_size();
 		/* NOTREACHED */
 		return (0);
 	}
@@ -620,7 +554,7 @@ ahc_pci_write_config(ahc_dev_softc_t pci
 		pci_write_config_dword(pci, reg, value);
 		break;
 	default:
-		panic("ahc_pci_write_config: Write size too big");
+		ahc_BUG_bad_pci_rw_size();
 		/* NOTREACHED */
 	}
 }
diff -urpN linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_osm_o.c linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_osm_o.c
--- linux-2.6.16.org/drivers/scsi/aic7xxx/aic7xxx_osm_o.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_osm_o.c	Sun Apr  9 21:54:39 2006
@@ -0,0 +1,75 @@
+/*
+ * Adaptec AIC7xxx device driver for Linux.
+ *
+ * Formerly inlined routines from aic7xxx_osm.h are moved here.
+ * This file is #included into aic7xxx_core.c
+ */
+
+/************************** OS Utility Wrappers *******************************/
+void
+ahc_delay(long usec)
+{
+	/*
+	 * udelay on Linux can have problems for
+	 * multi-millisecond waits.  Wait at most
+	 * 1024us per call.
+	 */
+	while (usec > 0) {
+		udelay(usec % 1024);
+		usec -= 1024;
+	}
+}
+
+/***************************** Low Level I/O **********************************/
+uint8_t
+ahc_inb(struct ahc_softc * ahc, long port)
+{
+	uint8_t x;
+
+	if (ahc->tag == BUS_SPACE_MEMIO) {
+		x = readb(ahc->bsh.maddr + port);
+	} else {
+		x = inb(ahc->bsh.ioport + port);
+	}
+	mb();
+	return (x);
+}
+
+void
+ahc_outb(struct ahc_softc * ahc, long port, uint8_t val)
+{
+	if (ahc->tag == BUS_SPACE_MEMIO) {
+		writeb(val, ahc->bsh.maddr + port);
+	} else {
+		outb(val, ahc->bsh.ioport + port);
+	}
+	mb();
+}
+
+void
+ahc_outsb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
+{
+	int i;
+
+	/*
+	 * There is probably a more efficient way to do this on Linux
+	 * but we don't use this for anything speed critical and this
+	 * should work.
+	 */
+	for (i = 0; i < count; i++)
+		ahc_outb(ahc, port, *array++);
+}
+
+void
+ahc_insb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
+{
+	int i;
+
+	/*
+	 * There is probably a more efficient way to do this on Linux
+	 * but we don't use this for anything speed critical and this
+	 * should work.
+	 */
+	for (i = 0; i < count; i++)
+		*array++ = ahc_inb(ahc, port);
+}

--Boundary-00=_sCfOEzXnQ1zcDBP--
