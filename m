Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSJYCH2>; Thu, 24 Oct 2002 22:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbSJYCH2>; Thu, 24 Oct 2002 22:07:28 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:39601 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261282AbSJYCGc>; Thu, 24 Oct 2002 22:06:32 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15800.43338.372347.557050@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 25 Oct 2002 11:15:38 +0900
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Forward port of aic7xxx driver to 2.5.44 [2/3]
In-Reply-To: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>
References: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== drivers/scsi/aic7xxx/aic7xxx_core.c 1.10 vs edited =====
--- 1.10/drivers/scsi/aic7xxx/aic7xxx_core.c	Mon Oct  7 23:39:54 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_core.c	Wed Oct 23 16:49:30 2002
@@ -37,9 +37,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#50 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.c#69 $
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.c,v 1.61 2000/11/13 03:35:43 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.c,v 1.41.2.22 2002/04/29 19:36:26 gibbs Exp $
  */
 
 #include "aic7xxx_osm.h"
@@ -244,10 +244,15 @@
 
 	ahc_pause(ahc);
 
+	/* No more pending messages. */
+	ahc_clear_msg_state(ahc);
+
 	ahc_outb(ahc, SCSISIGO, 0);		/* De-assert BSY */
 	ahc_outb(ahc, MSG_OUT, MSG_NOOP);	/* No message to send */
 	ahc_outb(ahc, SXFRCTL1, ahc_inb(ahc, SXFRCTL1) & ~BITBUCKET);
 	ahc_outb(ahc, LASTPHASE, P_BUSFREE);
+	ahc_outb(ahc, SAVED_SCSIID, 0xFF);
+	ahc_outb(ahc, SAVED_LUN, 0xFF);
 
 	/*
 	 * Ensure that the sequencer's idea of TQINPOS
@@ -327,7 +332,7 @@
 		 * Save off the residual
 		 * if there is one.
 		 */
-		ahc_update_residual(scb);
+		ahc_update_residual(ahc, scb);
 		ahc_done(ahc, scb);
 	}
 }
@@ -488,7 +493,7 @@
 			/*
 			 * Save off the residual if there is one.
 			 */
-			ahc_update_residual(scb);
+			ahc_update_residual(ahc, scb);
 #ifdef AHC_DEBUG
 			if (ahc_debug & AHC_SHOWSENSE) {
 				ahc_print_path(ahc, scb);
@@ -810,7 +815,12 @@
 		 * target does a command complete.
 		 */
 		ahc_freeze_devq(ahc, scb);
-		ahc_set_transaction_status(scb, CAM_DATA_RUN_ERR);
+		if ((scb->flags & SCB_SENSE) == 0) {
+			ahc_set_transaction_status(scb, CAM_DATA_RUN_ERR);
+		} else {
+			scb->flags &= ~SCB_SENSE;
+			ahc_set_transaction_status(scb, CAM_AUTOSENSE_FAIL);
+		}
 		ahc_freeze_scb(scb);
 
 		if ((ahc->features & AHC_ULTRA2) != 0) {
@@ -1285,13 +1295,19 @@
 				if (lastphase == ahc_phase_table[i].phase)
 					break;
 			}
+			/*
+			 * Renegotiate with this device at the
+			 * next oportunity just in case this busfree
+			 * is due to a negotiation mismatch with the
+			 * device.
+			 */
+			ahc_force_renegotiation(ahc);
 			printf("Unexpected busfree %s\n"
 			       "SEQADDR == 0x%x\n",
 			       ahc_phase_table[i].phasemsg,
 			       ahc_inb(ahc, SEQADDR0)
 				| (ahc_inb(ahc, SEQADDR1) << 8));
 		}
-		ahc_clear_msg_state(ahc);
 		ahc_outb(ahc, CLRINT, CLRSCSIINT);
 		ahc_restart(ahc);
 	} else {
@@ -1388,9 +1404,8 @@
 			stepping = TRUE;
 		}
 		ahc_outb(ahc, HCNTRL, ahc->unpause);
-		do {
+		while (!ahc_is_paused(ahc))
 			ahc_delay(200);
-		} while (!ahc_is_paused(ahc));
 	}
 	if (stepping) {
 		ahc_outb(ahc, SIMODE0, simode0);
@@ -1409,11 +1424,18 @@
 	ahc_outb(ahc, CLRSINT1, CLRSELTIMEO|CLRATNO|CLRSCSIRSTI
 				|CLRBUSFREE|CLRSCSIPERR|CLRPHASECHG|
 				CLRREQINIT);
+	ahc_flush_device_writes(ahc);
 	ahc_outb(ahc, CLRSINT0, CLRSELDO|CLRSELDI|CLRSELINGO);
+ 	ahc_flush_device_writes(ahc);
 	ahc_outb(ahc, CLRINT, CLRSCSIINT);
+	ahc_flush_device_writes(ahc);
 }
 
 /**************************** Debugging Routines ******************************/
+#ifdef AHC_DEBUG
+int ahc_debug = AHC_DEBUG;
+#endif
+
 void
 ahc_print_scb(struct scb *scb)
 {
@@ -1482,7 +1504,7 @@
 		memcpy(tstate, master_tstate, sizeof(*tstate));
 		memset(tstate->enabled_luns, 0, sizeof(tstate->enabled_luns));
 		tstate->ultraenb = 0;
-		for (i = 0; i < 16; i++) {
+		for (i = 0; i < AHC_NUM_TARGETS; i++) {
 			memset(&tstate->transinfo[i].curr, 0,
 			      sizeof(tstate->transinfo[i].curr));
 			memset(&tstate->transinfo[i].goal, 0,
@@ -1531,7 +1553,8 @@
 struct ahc_syncrate *
 ahc_devlimited_syncrate(struct ahc_softc *ahc,
 			struct ahc_initiator_tinfo *tinfo,
-			u_int *period, u_int *ppr_options, role_t role) {
+			u_int *period, u_int *ppr_options, role_t role)
+{
 	struct	ahc_transinfo *transinfo;
 	u_int	maxsync;
 
@@ -2513,9 +2536,13 @@
 		} else 
 			ahc->msgin_index++;
 
-		/* Ack the byte */
-		ahc_outb(ahc, CLRSINT1, CLRREQINIT);
-		ahc_inb(ahc, SCSIDATL);
+		if (message_done == MSGLOOP_TERMINATED) {
+			end_session = TRUE;
+		} else {
+			/* Ack the byte */
+			ahc_outb(ahc, CLRSINT1, CLRREQINIT);
+			ahc_inb(ahc, SCSIDATL);
+		}
 		break;
 	}
 	case MSG_TYPE_TARGET_MSGIN:
@@ -2726,6 +2753,17 @@
 	 * extended message type.
 	 */
 	switch (ahc->msgin_buf[0]) {
+	case MSG_DISCONNECT:
+	case MSG_SAVEDATAPOINTER:
+	case MSG_CMDCOMPLETE:
+	case MSG_RESTOREPOINTERS:
+	case MSG_IGN_WIDE_RESIDUE:
+		/*
+		 * End our message loop as these are messages
+		 * the sequencer handles on its own.
+		 */
+		done = MSGLOOP_TERMINATED;
+		break;
 	case MSG_MESSAGE_REJECT:
 		response = ahc_handle_msg_reject(ahc, devinfo);
 		/* FALLTHROUGH */
@@ -3515,6 +3553,15 @@
 	ahc = device_get_softc((device_t)platform_arg);
 #endif
 	memset(ahc, 0, sizeof(*ahc));
+	ahc->seep_config = malloc(sizeof(*ahc->seep_config),
+				  M_DEVBUF, M_NOWAIT);
+	if (ahc->seep_config == NULL) {
+#ifndef	__FreeBSD__
+		free(ahc, M_DEVBUF);
+#endif
+		free(name, M_DEVBUF);
+		return (NULL);
+	}
 	LIST_INIT(&ahc->pending_scbs);
 	/* We don't know our unit number until the OSM sets it */
 	ahc->name = name;
@@ -3527,7 +3574,7 @@
 	ahc->bugs = AHC_BUGNONE;
 	ahc->flags = AHC_FNONE;
 
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < AHC_NUM_TARGETS; i++)
 		TAILQ_INIT(&ahc->untagged_queues[i]);
 	if (ahc_platform_alloc(ahc, platform_arg) != 0) {
 		ahc_free(ahc);
@@ -3614,6 +3661,22 @@
 	ahc->init_level++;
 }
 
+/*
+ * Verify that the passed in softc pointer is for a
+ * controller that is still configured.
+ */
+struct ahc_softc *
+ahc_find_softc(struct ahc_softc *ahc)
+{
+	struct ahc_softc *list_ahc;
+
+	TAILQ_FOREACH(list_ahc, &ahc_tailq, links) {
+		if (list_ahc == ahc)
+			return (ahc);
+	}
+	return (NULL);
+}
+
 void
 ahc_set_unit(struct ahc_softc *ahc, int unit)
 {
@@ -3694,6 +3757,8 @@
 #endif
 	if (ahc->name != NULL)
 		free(ahc->name, M_DEVBUF);
+	if (ahc->seep_config != NULL)
+		free(ahc->seep_config, M_DEVBUF);
 #ifndef __FreeBSD__
 	free(ahc, M_DEVBUF);
 #endif
@@ -3714,7 +3779,7 @@
 	ahc_outb(ahc, SXFRCTL0, 0);
 	ahc_outb(ahc, DSPCISTATUS, 0);
 
-	for (i = TARG_SCSIRATE; i < HA_274_BIOSCTRL; i++)
+	for (i = TARG_SCSIRATE; i < SCSICONF; i++)
 		ahc_outb(ahc, i, 0);
 }
 
@@ -3753,7 +3818,10 @@
 	ahc_outb(ahc, HCNTRL, CHIPRST | ahc->pause);
 
 	/*
-	 * Ensure that the reset has finished
+	 * Ensure that the reset has finished.  We delay 1000us
+	 * prior to reading the register to make sure the chip
+	 * has sufficiently completed its reset to handle register
+	 * accesses.
 	 */
 	wait = 1000;
 	do {
@@ -3846,11 +3914,26 @@
 static void
 ahc_build_free_scb_list(struct ahc_softc *ahc)
 {
+	int scbsize;
 	int i;
 
+	scbsize = 32;
+	if ((ahc->flags & AHC_LSCBS_ENABLED) != 0)
+		scbsize = 64;
+
 	for (i = 0; i < ahc->scb_data->maxhscbs; i++) {
+		int j;
+
 		ahc_outb(ahc, SCBPTR, i);
 
+		/*
+		 * Touch all SCB bytes to avoid parity errors
+		 * should one of our debugging routines read
+		 * an otherwise uninitiatlized byte.
+		 */
+		for (j = 0; j < scbsize; j++)
+			ahc_outb(ahc, SCB_BASE+j, 0xFF);
+
 		/* Clear the control byte. */
 		ahc_outb(ahc, SCB_CONTROL, 0);
 
@@ -3860,17 +3943,15 @@
 		else 
 			ahc_outb(ahc, SCB_NEXT, SCB_LIST_NULL);
 
-		/* Make the tag number invalid */
+		/* Make the tag number, SCSIID, and lun invalid */
 		ahc_outb(ahc, SCB_TAG, SCB_LIST_NULL);
+		ahc_outb(ahc, SCB_SCSIID, 0xFF);
+		ahc_outb(ahc, SCB_LUN, 0xFF);
 	}
 
 	/* Make sure that the last SCB terminates the free list */
 	ahc_outb(ahc, SCBPTR, i-1);
 	ahc_outb(ahc, SCB_NEXT, SCB_LIST_NULL);
-
-	/* Ensure we clear the 0 SCB's control byte. */
-	ahc_outb(ahc, SCBPTR, 0);
-	ahc_outb(ahc, SCB_CONTROL, 0);
 }
 
 static int
@@ -4234,6 +4315,12 @@
 		}
 	}
 	printf ("\n");
+	/*
+	 * Reading uninitialized scratch ram may
+	 * generate parity errors.
+	 */
+	ahc_outb(ahc, CLRINT, CLRPARERR);
+	ahc_outb(ahc, CLRINT, CLRBRKADRINT);
 #endif
 	max_targ = 15;
 
@@ -4425,7 +4512,7 @@
 	tagenable = ALL_TARGETS_MASK;
 
 	/* Grab the disconnection disable table and invert it for our needs */
-	if (ahc->flags & AHC_USEDEFAULTS) {
+	if ((ahc->flags & AHC_USEDEFAULTS) != 0) {
 		printf("%s: Host Adapter Bios disabled.  Using default SCSI "
 			"device parameters\n", ahc_name(ahc));
 		ahc->flags |= AHC_EXTENDED_TRANS_A|AHC_EXTENDED_TRANS_B|
@@ -5068,11 +5155,10 @@
 	uint8_t qinstart;
 	uint8_t qinpos;
 	uint8_t qintail;
-	uint8_t next, prev;
+	uint8_t next;
+	uint8_t prev;
 	uint8_t curscbptr;
 	int	found;
-	int	maxtarget;
-	int	i;
 	int	have_qregs;
 
 	qintail = ahc->qinfifonext;
@@ -5083,7 +5169,6 @@
 	} else
 		qinstart = ahc_inb(ahc, QINPOS);
 	qinpos = qinstart;
-	next = ahc_inb(ahc, NEXT_QUEUED_SCB);
 	found = 0;
 	prev_scb = NULL;
 
@@ -5123,8 +5208,7 @@
 
 				ostat = ahc_get_transaction_status(scb);
 				if (ostat == CAM_REQ_INPROG)
-					ahc_set_transaction_status(scb,
-								   status);
+					ahc_set_transaction_status(scb, status);
 				cstat = ahc_get_transaction_status(scb);
 				if (cstat != CAM_REQ_CMP)
 					ahc_freeze_scb(scb);
@@ -5133,9 +5217,9 @@
 				ahc_done(ahc, scb);
 
 				/* FALLTHROUGH */
+			}
 			case SEARCH_REMOVE:
 				break;
-			}
 			case SEARCH_COUNT:
 				ahc_qinfifo_requeue(ahc, prev_scb, scb);
 				prev_scb = scb;
@@ -5262,9 +5346,33 @@
 	}
 	ahc_outb(ahc, SCBPTR, curscbptr);
 
-	/*
-	 * And lastly, the untagged holding queues.
-	 */
+	found += ahc_search_untagged_queues(ahc, /*ahc_io_ctx_t*/NULL, target,
+					    channel, lun, status, action);
+
+	if (action == SEARCH_COMPLETE)
+		ahc_release_untagged_queues(ahc);
+	return (found);
+}
+
+int
+ahc_search_untagged_queues(struct ahc_softc *ahc, ahc_io_ctx_t ctx,
+			   int target, char channel, int lun, uint32_t status,
+			   ahc_search_action action)
+{
+	struct	scb *scb;
+	int	maxtarget;
+	int	found;
+	int	i;
+
+	if (action == SEARCH_COMPLETE) {
+		/*
+		 * Don't attempt to run any queued untagged transactions
+		 * until we are done with the abort process.
+		 */
+		ahc_freeze_untagged_queues(ahc);
+	}
+
+	found = 0;
 	i = 0;
 	if ((ahc->flags & AHC_SCB_BTT) == 0) {
 
@@ -5303,37 +5411,37 @@
 			if ((scb->flags & SCB_ACTIVE) != 0)
 				continue;
 
-			if (ahc_match_scb(ahc, scb, target, channel,
-					  lun, SCB_LIST_NULL, role)) {
-				/*
-				 * We found an scb that needs to be acted on.
-				 */
-				found++;
-				switch (action) {
-				case SEARCH_COMPLETE:
-				{
-					cam_status ostat;
-					cam_status cstat;
-
-					ostat = ahc_get_transaction_status(scb);
-					if (ostat == CAM_REQ_INPROG)
-						ahc_set_transaction_status(scb,
-								   status);
-					cstat = ahc_get_transaction_status(scb);
-					if (cstat != CAM_REQ_CMP)
-						ahc_freeze_scb(scb);
-					if ((scb->flags & SCB_ACTIVE) == 0)
-						printf("Inactive SCB in untaggedQ\n");
-					ahc_done(ahc, scb);
-					break;
-				}
-				case SEARCH_REMOVE:
-					TAILQ_REMOVE(untagged_q, scb,
-						     links.tqe);
-					break;
-				case SEARCH_COUNT:
-					break;
-				}
+			if (ahc_match_scb(ahc, scb, target, channel, lun,
+					  SCB_LIST_NULL, ROLE_INITIATOR) == 0
+			 || (ctx != NULL && ctx != scb->io_ctx))
+				continue;
+
+			/*
+			 * We found an scb that needs to be acted on.
+			 */
+			found++;
+			switch (action) {
+			case SEARCH_COMPLETE:
+			{
+				cam_status ostat;
+				cam_status cstat;
+
+				ostat = ahc_get_transaction_status(scb);
+				if (ostat == CAM_REQ_INPROG)
+					ahc_set_transaction_status(scb, status);
+				cstat = ahc_get_transaction_status(scb);
+				if (cstat != CAM_REQ_CMP)
+					ahc_freeze_scb(scb);
+				if ((scb->flags & SCB_ACTIVE) == 0)
+					printf("Inactive SCB in untaggedQ\n");
+				ahc_done(ahc, scb);
+				break;
+			}
+			case SEARCH_REMOVE:
+				TAILQ_REMOVE(untagged_q, scb, links.tqe);
+				break;
+			case SEARCH_COUNT:
+				break;
 			}
 		}
 	}
@@ -5646,6 +5754,7 @@
 	ahc_outb(ahc, SIMODE1, ahc_inb(ahc, SIMODE1) & ~ENSCSIRST);
 	scsiseq = ahc_inb(ahc, SCSISEQ);
 	ahc_outb(ahc, SCSISEQ, scsiseq | SCSIRSTO);
+	ahc_flush_device_writes(ahc);
 	ahc_delay(AHC_BUSRESET_DELAY);
 	/* Turn off the bus reset */
 	ahc_outb(ahc, SCSISEQ, scsiseq & ~SCSIRSTO);
@@ -5687,6 +5796,16 @@
 	 */
 	ahc_run_qoutfifo(ahc);
 #if AHC_TARGET_MODE
+	/*
+	 * XXX - In Twin mode, the tqinfifo may have commands
+	 *	 for an unaffected channel in it.  However, if
+	 *	 we have run out of ATIO resources to drain that
+	 *	 queue, we may not get them all out here.  Further,
+	 *	 the blocked transactions for the reset channel
+	 *	 should just be killed off, irrespecitve of whether
+	 *	 we are blocked on ATIO resources.  Write a routine
+	 *	 to compact the tqinfifo appropriately.
+	 */
 	if ((ahc->flags & AHC_TARGETROLE) != 0) {
 		ahc_run_tqinfifo(ahc, /*paused*/TRUE);
 	}
@@ -5708,10 +5827,6 @@
 		 */
 		ahc_outb(ahc, SBLKCTL, sblkctl ^ SELBUSB);
 		simode1 = ahc_inb(ahc, SIMODE1) & ~(ENBUSFREE|ENSCSIRST);
-		ahc_outb(ahc, SIMODE1, simode1);
-		if (initiate_reset)
-			ahc_reset_current_bus(ahc);
-		ahc_clear_intstat(ahc);
 #if AHC_TARGET_MODE
 		/*
 		 * Bus resets clear ENSELI, so we cannot
@@ -5719,19 +5834,18 @@
 		 * if we are in target mode.
 		 */
 		if ((ahc->flags & AHC_TARGETROLE) != 0)
-			ahc_outb(ahc, SIMODE1, simode1 | ENSCSIRST);
+			simode1 |= ENSCSIRST;
 #endif
+		ahc_outb(ahc, SIMODE1, simode1);
+		if (initiate_reset)
+			ahc_reset_current_bus(ahc);
+		ahc_clear_intstat(ahc);
 		ahc_outb(ahc, SCSISEQ, scsiseq & (ENSELI|ENRSELI|ENAUTOATNP));
 		ahc_outb(ahc, SBLKCTL, sblkctl);
 		restart_needed = FALSE;
 	} else {
 		/* Case 2: A command from this bus is active or we're idle */
-		ahc_clear_msg_state(ahc);
 		simode1 = ahc_inb(ahc, SIMODE1) & ~(ENBUSFREE|ENSCSIRST);
-		ahc_outb(ahc, SIMODE1, simode1);
-		if (initiate_reset)
-			ahc_reset_current_bus(ahc);
-		ahc_clear_intstat(ahc);
 #if AHC_TARGET_MODE
 		/*
 		 * Bus resets clear ENSELI, so we cannot
@@ -5739,8 +5853,12 @@
 		 * if we are in target mode.
 		 */
 		if ((ahc->flags & AHC_TARGETROLE) != 0)
-			ahc_outb(ahc, SIMODE1, simode1 | ENSCSIRST);
+			simode1 |= ENSCSIRST;
 #endif
+		ahc_outb(ahc, SIMODE1, simode1);
+		if (initiate_reset)
+			ahc_reset_current_bus(ahc);
+		ahc_clear_intstat(ahc);
 		ahc_outb(ahc, SCSISEQ, scsiseq & (ENSELI|ENRSELI|ENAUTOATNP));
 		restart_needed = TRUE;
 	}
@@ -5819,7 +5937,7 @@
  * Calculate the residual for a just completed SCB.
  */
 void
-ahc_calc_residual(struct scb *scb)
+ahc_calc_residual(struct ahc_softc *ahc, struct scb *scb)
 {
 	struct hardware_scb *hscb;
 	struct status_pkt *spkt;
@@ -6299,7 +6417,8 @@
 	printf("ACCUM = 0x%x, SINDEX = 0x%x, DINDEX = 0x%x, ARG_2 = 0x%x\n",
 	       ahc_inb(ahc, ACCUM), ahc_inb(ahc, SINDEX), ahc_inb(ahc, DINDEX),
 	       ahc_inb(ahc, ARG_2));
-	printf("HCNT = 0x%x\n", ahc_inb(ahc, HCNT));
+	printf("HCNT = 0x%x SCBPTR = 0x%x\n", ahc_inb(ahc, HCNT),
+	       ahc_inb(ahc, SCBPTR));
 	printf("SCSISEQ = 0x%x, SBLKCTL = 0x%x\n",
 	       ahc_inb(ahc, SCSISEQ), ahc_inb(ahc, SBLKCTL));
 	printf(" DFCNTRL = 0x%x, DFSTATUS = 0x%x\n",
@@ -6372,6 +6491,17 @@
 	}
 	printf("\n");
 
+	printf("Sequencer SCB Info: ");
+	for (i = 0; i < ahc->scb_data->maxhscbs; i++) {
+		ahc_outb(ahc, SCBPTR, i);
+		printf("%d(c 0x%x, s 0x%x, l %d, t 0x%x) ",
+		       i, ahc_inb(ahc, SCB_CONTROL),
+		       ahc_inb(ahc, SCB_SCSIID),
+		       ahc_inb(ahc, SCB_LUN),
+		       ahc_inb(ahc, SCB_TAG));
+	}
+	printf("\n");
+
 	printf("Pending list: ");
 	i = 0;
 	LIST_FOREACH(scb, &ahc->pending_scbs, pending_links) {
@@ -6379,7 +6509,8 @@
 			break;
 		if (scb != LIST_FIRST(&ahc->pending_scbs))
 			printf(", ");
-		printf("%d", scb->hscb->tag);
+		printf("%d(c 0x%x, s 0x%x, l %d)", scb->hscb->tag,
+		       scb->hscb->control, scb->hscb->scsiid, scb->hscb->lun);
 		if ((ahc->flags & AHC_PAGESCBS) == 0) {
 			ahc_outb(ahc, SCBPTR, scb->hscb->tag);
 			printf("(0x%x, 0x%x)", ahc_inb(ahc, SCB_CONTROL),
@@ -6907,6 +7038,8 @@
 		/*
 		 * Wait for more ATIOs from the peripheral driver for this lun.
 		 */
+		if (bootverbose)
+			printf("%s: ATIOs exhausted\n", ahc_name(ahc));
 		return (1);
 	} else
 		ahc->flags &= ~AHC_TQINFIFO_BLOCKED;
===== drivers/scsi/aic7xxx/aic7xxx.h 1.4 vs edited =====
--- 1.4/drivers/scsi/aic7xxx/aic7xxx.h	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx.h	Thu Oct 24 13:13:51 2002
@@ -37,9 +37,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.h#34 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.h#45 $
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.h,v 1.30 2000/11/10 20:13:40 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.h,v 1.16.2.13 2002/04/29 19:36:29 gibbs Exp $
  */
 
 #ifndef _AIC7XXX_H_
@@ -51,6 +51,7 @@
 /************************* Forward Declarations *******************************/
 struct ahc_platform_data;
 struct scb_platform_data;
+struct seeprom_descriptor;
 
 /****************************** Useful Macros *********************************/
 #ifndef MAX
@@ -350,9 +351,11 @@
 					   */
 	AHC_BIOS_ENABLED      = 0x80000,
 	AHC_ALL_INTERRUPTS    = 0x100000,
-	AHC_PAGESCBS	      = 0x400000, /* Enable SCB paging */
-	AHC_EDGE_INTERRUPT    = 0x800000, /* Device uses edge triggered ints */
-	AHC_39BIT_ADDRESSING  = 0x1000000 /* Use 39 bit addressing scheme. */
+	AHC_PAGESCBS	      = 0x400000,  /* Enable SCB paging */
+	AHC_EDGE_INTERRUPT    = 0x800000,  /* Device uses edge triggered ints */
+	AHC_39BIT_ADDRESSING  = 0x1000000, /* Use 39 bit addressing scheme. */
+	AHC_LSCBS_ENABLED     = 0x2000000, /* 64Byte SCBs enabled */
+	AHC_SCB_CONFIG_USED   = 0x4000000  /* No SEEPROM but SCB2 had info. */
 } ahc_flag;
 
 /************************* Hardware  SCB Definition ***************************/
@@ -941,6 +944,7 @@
 	ahc_feature		  features;
 	ahc_bug			  bugs;
 	ahc_flag		  flags;
+	struct seeprom_config	 *seep_config;
 
 	/* Values to store in the SEQCTL register for pause and unpause */
 	uint8_t			  unpause;
@@ -1093,7 +1097,8 @@
 /*************************** EISA/VL Front End ********************************/
 struct aic7770_identity *aic7770_find_device(uint32_t);
 int			 aic7770_config(struct ahc_softc *ahc,
-					struct aic7770_identity *);
+					struct aic7770_identity *,
+					u_int port);
 
 /************************** SCB and SCB queue management **********************/
 int		ahc_probe_scbs(struct ahc_softc *);
@@ -1116,6 +1121,7 @@
 int			 ahc_suspend(struct ahc_softc *ahc); 
 int			 ahc_resume(struct ahc_softc *ahc);
 void			 ahc_softc_insert(struct ahc_softc *);
+struct ahc_softc	*ahc_find_softc(struct ahc_softc *ahc);
 void			 ahc_set_unit(struct ahc_softc *, int);
 void			 ahc_set_name(struct ahc_softc *, char *);
 void			 ahc_alloc_scbs(struct ahc_softc *ahc);
@@ -1146,6 +1152,11 @@
 					   char channel, int lun, u_int tag,
 					   role_t role, uint32_t status,
 					   ahc_search_action action);
+int			ahc_search_untagged_queues(struct ahc_softc *ahc,
+						   ahc_io_ctx_t ctx,
+						   int target, char channel,
+						   int lun, uint32_t status,
+						   ahc_search_action action);
 int			ahc_search_disc_list(struct ahc_softc *ahc, int target,
 					     char channel, int lun, u_int tag,
 					     int stop_on_first, int remove,
@@ -1157,7 +1168,8 @@
 				       char channel, int lun, u_int tag,
 				       role_t role, uint32_t status);
 void			ahc_restart(struct ahc_softc *ahc);
-void			ahc_calc_residual(struct scb *scb);
+void			ahc_calc_residual(struct ahc_softc *ahc,
+					  struct scb *scb);
 /*************************** Utility Functions ********************************/
 struct ahc_phase_table_entry*
 			ahc_lookup_phase_entry(int phase);
@@ -1219,6 +1231,15 @@
 #endif
 #endif
 /******************************* Debug ***************************************/
+#ifdef AHC_DEBUG
+extern int ahc_debug;
+#define	AHC_SHOWMISC	0x1
+#define	AHC_SHOWSENSE	0x2
+#endif
 void			ahc_print_scb(struct scb *scb);
 void			ahc_dump_card_state(struct ahc_softc *ahc);
+/******************************* SEEPROM *************************************/
+int		ahc_acquire_seeprom(struct ahc_softc *ahc,
+				    struct seeprom_descriptor *sd);
+void		ahc_release_seeprom(struct seeprom_descriptor *sd);
 #endif /* _AIC7XXX_H_ */
===== drivers/scsi/aic7xxx/aic7xxx_reg.h_shipped 1.6 vs edited =====
--- 1.6/drivers/scsi/aic7xxx/aic7xxx_reg.h_shipped	Tue Jun 18 11:55:42 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx_reg.h_shipped	Thu Oct 24 13:51:53 2002
@@ -2,8 +2,8 @@
  * DO NOT EDIT - This file is automatically generated
  *		 from the following source files:
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.seq#37 $
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.reg#24 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.seq#43 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx.reg#30 $
  */
 
 #define	SCSISEQ         		0x00
@@ -184,7 +184,7 @@
 #define		SOFT1           	0x80
 #define		SOFT0           	0x40
 #define		SOFTCMDEN       	0x20
-#define		HAS_BRDCTL      	0x10
+#define		EXT_BRDCTL      	0x10
 #define		SEEPROM         	0x08
 #define		EEPROM          	0x04
 #define		ROM             	0x02
@@ -228,8 +228,6 @@
 #define	BUSY_TARGETS    		0x20
 #define	TARG_SCSIRATE   		0x20
 
-#define	SRAM_BASE       		0x20
-
 #define	ULTRA_ENB       		0x30
 #define	CMDSIZE_TABLE   		0x30
 
@@ -329,7 +327,9 @@
 
 #define	DATA_COUNT_ODD  		0x55
 
+#define	HA_274_BIOSGLOBAL		0x56
 #define	INITIATOR_TAG   		0x56
+#define		HA_274_EXTENDED_TRANS	0x01
 
 #define	SEQ_FLAGS2      		0x57
 #define		TARGET_MSG_PENDING	0x02
@@ -396,6 +396,8 @@
 
 #define	TARG_OFFSET     		0x70
 
+#define	SRAM_BASE       		0x70
+
 #define	BCTL            		0x84
 #define		ACE             	0x08
 #define		ENABLE          	0x01
@@ -714,3 +716,7 @@
 #define	SG_PREFETCH_CNT	0x04
 #define	CACHESIZE_MASK	0x02
 #define	QINFIFO_OFFSET	0x01
+#define	DOWNLOAD_CONST_COUNT	0x07
+
+
+/* Exported Labels */
===== drivers/scsi/aic7xxx/aic7xxx.seq 1.5 vs edited =====
--- 1.5/drivers/scsi/aic7xxx/aic7xxx.seq	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx.seq	Thu Oct 24 14:10:37 2002
@@ -37,10 +37,11 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.seq,v 1.106 2000/11/12 05:19:46 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.seq,v 1.94.2.16 2002/04/29 19:36:30 gibbs Exp $
  */
 
-VERSION = "$Id: //depot/aic7xxx/aic7xxx/aic7xxx.seq#37 $"
+VERSION = "$Id: //depot/aic7xxx/aic7xxx/aic7xxx.seq#43 $"
+PATCH_ARG_LIST = "struct ahc_softc *ahc"
 
 #include "aic7xxx.reg"
 #include "scsi_message.h"
@@ -89,7 +90,7 @@
 	test	SSTAT0, SELDO|SELDI	jnz selection;
 test_queue:
 	/* Has the driver posted any work for us? */
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 	if ((ahc->features & AHC_QUEUE_REGS) != 0) {
 		test	QOFF_CTLSTA, SCB_AVAIL jz poll_for_work_loop;
 	} else {
@@ -110,7 +111,7 @@
 		mov	SCBPTR, ARG_1;
 	}
 	or	SEQ_FLAGS2, SCB_DMA;
-END_CRITICAL
+END_CRITICAL;
 dma_queued_scb:
 	/*
 	 * DMA the SCB from host ram into the current SCB location.
@@ -124,7 +125,7 @@
 	 * value.
 	 */
 	mov	A, ARG_1;
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 	cmp	NEXT_QUEUED_SCB, A jne abort_qinscb;
 	if ((ahc->flags & AHC_SEQUENCER_DEBUG) != 0) {
 		cmp	SCB_TAG, A je . + 2;
@@ -139,7 +140,7 @@
 		inc	QINPOS;
 	}
 	and	SEQ_FLAGS2, ~SCB_DMA;
-END_CRITICAL
+END_CRITICAL;
 start_waiting:
 	/*
 	 * Start the first entry on the waiting SCB list.
@@ -437,7 +438,6 @@
 select_out:
 	/* Turn off the selection hardware */
 	and	SCSISEQ, TEMODE|ENSELI|ENRSELI|ENAUTOATNP, SCSISEQ;
-	mvi	CLRSINT0, CLRSELDO;
 	mov	SCBPTR, WAITING_SCBH;
 	mov	WAITING_SCBH,SCB_NEXT;
 	mov	SAVED_SCSIID, SCB_SCSIID;
@@ -452,6 +452,7 @@
 		 * sending our identify messages.
 		 */
 		mvi	P_MESGIN|BSYO call change_phase;
+		mvi	CLRSINT0, CLRSELDO;
 
 		/*
 		 * Start out with a simple identify message.
@@ -498,6 +499,7 @@
 		}
 		mvi	DMAPARAMS, HDMAEN|DIRECTION|FIFORESET;
 		mov	SCB_TAG	 call dma_scb;
+		call	set_transfer_settings;
 		jmp	target_synccmd;
 
 target_mesgout:
@@ -641,6 +643,7 @@
 	 */
 	mvi	MSG_OUT, MSG_IDENTIFYFLAG;
 	or	SEQ_FLAGS, IDENTIFY_SEEN;
+	mvi	CLRSINT0, CLRSELDO;
 
 	/*
 	 * Main loop for information transfer phases.  Wait for the
@@ -968,12 +971,12 @@
 ultra2_ensure_sg:
 		test	SG_CACHE_SHADOW, LAST_SEG jz ultra2_shvalid;
 		/* Record if we've consumed all S/G entries */
-		test    SSTAT2, SHVALID	jnz residuals_correct;
+		test	SSTAT2, SHVALID	jnz residuals_correct;
 		or	SCB_RESIDUAL_SGPTR[0], SG_LIST_NULL;
 		jmp	residuals_correct;
 
 ultra2_shvalid:
-                test    SSTAT2, SHVALID	jnz sgptr_fixup;
+		test	SSTAT2, SHVALID	jnz sgptr_fixup;
 		call	idle_loop;
 		jmp	ultra2_ensure_sg;
 
@@ -1397,7 +1400,7 @@
 	 * The data fifo seems to require 4 byte aligned
 	 * transfers from the sequencer.  Force this to
 	 * be the case by clearing HADDR[0] even though
-	 * we aren't going to touch host memeory.
+	 * we aren't going to touch host memory.
 	 */
 	clr	HADDR[0];
 	if ((ahc->features & AHC_ULTRA2) != 0) {
@@ -2003,7 +2006,7 @@
  * removal of the found SCB from the disconnected list.
  */
 if ((ahc->flags & AHC_PAGESCBS) != 0) {
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 findSCB:
 	mov	A, SINDEX;			/* Tag passed in SINDEX */
 	cmp	DISCONNECTED_SCBH, SCB_LIST_NULL je findSCB_notFound;
@@ -2025,7 +2028,7 @@
 	mov	SCBPTR, SINDEX ret;
 rHead:
 	mov	DISCONNECTED_SCBH,SCB_NEXT ret;
-END_CRITICAL
+END_CRITICAL;
 findSCB_notFound:
 	/*
 	 * We didn't find it.  Page in the SCB.
@@ -2150,7 +2153,7 @@
 	adc	DINDIR, A, SINDIR ret;
 
 /*
- * Either post or fetch and SCB from host memory based on the
+ * Either post or fetch an SCB from host memory based on the
  * DIRECTION bit in DMAPARAMS. The host SCB index is in SINDEX.
  */
 dma_scb:
@@ -2308,11 +2311,11 @@
 	}
 add_scb_to_free_list:
 	if ((ahc->flags & AHC_PAGESCBS) != 0) {
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 		mov	SCB_NEXT, FREE_SCBH;
 		mvi	SCB_TAG, SCB_LIST_NULL;
 		mov	FREE_SCBH, SCBPTR ret;
-END_CRITICAL
+END_CRITICAL;
 	} else {
 		mvi	SCB_TAG, SCB_LIST_NULL ret;
 	}
@@ -2326,7 +2329,7 @@
 
 if ((ahc->flags & AHC_PAGESCBS) != 0) {
 get_free_or_disc_scb:
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 	cmp	FREE_SCBH, SCB_LIST_NULL jne dequeue_free_scb;
 	cmp	DISCONNECTED_SCBH, SCB_LIST_NULL jne dequeue_disc_scb;
 return_error:
@@ -2335,14 +2338,14 @@
 dequeue_disc_scb:
 	mov	SCBPTR, DISCONNECTED_SCBH;
 	mov	DISCONNECTED_SCBH, SCB_NEXT;
-END_CRITICAL
+END_CRITICAL;
 	mvi	DMAPARAMS, FIFORESET;
 	mov	SCB_TAG	jmp dma_scb;
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 dequeue_free_scb:
 	mov	SCBPTR, FREE_SCBH;
 	mov	FREE_SCBH, SCB_NEXT ret;
-END_CRITICAL
+END_CRITICAL;
 
 add_scb_to_disc_list:
 /*
@@ -2350,10 +2353,10 @@
  * candidates for paging out an SCB if one is needed for a new command.
  * Modifying the disconnected list is a critical(pause dissabled) section.
  */
-BEGIN_CRITICAL
+BEGIN_CRITICAL;
 	mov	SCB_NEXT, DISCONNECTED_SCBH;
 	mov	DISCONNECTED_SCBH, SCBPTR ret;
-END_CRITICAL
+END_CRITICAL;
 }
 set_seqint:
 	mov	INTSTAT, SINDEX;
===== drivers/scsi/aic7xxx/aic7770_linux.c 1.4 vs edited =====
--- 1.4/drivers/scsi/aic7xxx/aic7770_linux.c	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7770_linux.c	Wed Oct 23 14:28:43 2002
@@ -55,9 +55,6 @@
 	int eisaBase;
 	int found;
 
-	if (aic7xxx_no_probe)
-		return (0);
-
 	eisaBase = 0x1000 + AHC_EISA_SLOT_OFFSET;
 	found = 0;
 	for (slot = 1; slot < NUMSLOTS; eisaBase+=0x1000, slot++) {
@@ -103,9 +100,7 @@
 				 */
 				break;
 			}
-			ahc->tag = BUS_SPACE_PIO;
-			ahc->bsh.ioport = eisaBase;
-			error = aic7770_config(ahc, entry);
+			error = aic7770_config(ahc, entry, eisaBase);
 			if (error != 0) {
 				ahc_free(ahc);
 				continue;
@@ -120,18 +115,19 @@
 }
 
 int
-aic7770_map_registers(struct ahc_softc *ahc)
+aic7770_map_registers(struct ahc_softc *ahc, u_int port)
 {
 	/*
 	 * Lock out other contenders for our i/o space.
 	 */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-	request_region(ahc->bsh.ioport, AHC_EISA_IOSIZE, "aic7xxx");
+	request_region(port, AHC_EISA_IOSIZE, "aic7xxx");
 #else
-	if (request_region(ahc->bsh.ioport, AHC_EISA_IOSIZE, "aic7xxx") == 0)
+	if (request_region(port, AHC_EISA_IOSIZE, "aic7xxx") == 0)
 		return (ENOMEM);
 #endif
-
+	ahc->tag = BUS_SPACE_PIO;
+	ahc->bsh.ioport = port;
 	return (0);
 }
 
@@ -145,9 +141,9 @@
 	if ((ahc->flags & AHC_EDGE_INTERRUPT) == 0)
 		shared = SA_SHIRQ;
 
-	ahc->platform_data->irq = irq;
-	error = request_irq(ahc->platform_data->irq, ahc_linux_isr,
-			    shared, "aic7xxx", ahc);
+	error = request_irq(irq, ahc_linux_isr, shared, "aic7xxx", ahc);
+	if (error == 0)
+		ahc->platform_data->irq = irq;
 	
 	return (-error);
 }
===== drivers/scsi/aic7xxx/aic7770.c 1.5 vs edited =====
--- 1.5/drivers/scsi/aic7xxx/aic7770.c	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7770.c	Thu Oct 24 13:12:44 2002
@@ -37,7 +37,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7770.c#14 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7770.c#21 $
  *
  * $FreeBSD: src/sys/dev/aic7xxx/aic7770.c,v 1.1 2000/09/16 20:02:27 gibbs Exp $
  */
@@ -51,7 +51,7 @@
 #define ID_AHA_284xB	0x04907756 /* BIOS enabled */
 #define ID_AHA_284x	0x04907757 /* BIOS disabled*/
 
-static void aha2840_load_seeprom(struct ahc_softc *ahc);
+static int aha2840_load_seeprom(struct ahc_softc *ahc);
 static ahc_device_setup_t ahc_aic7770_VL_setup;
 static ahc_device_setup_t ahc_aic7770_EISA_setup;;
 static ahc_device_setup_t ahc_aic7770_setup;
@@ -96,21 +96,33 @@
 }
 
 int
-aic7770_config(struct ahc_softc *ahc, struct aic7770_identity *entry)
+aic7770_config(struct ahc_softc *ahc, struct aic7770_identity *entry, u_int io)
 {
+	u_long	l;
+	u_long	s;
 	int	error;
+	int	have_seeprom;
 	u_int	hostconf;
 	u_int   irq;
 	u_int	intdef;
 
 	error = entry->setup(ahc);
+	have_seeprom = 0;
 	if (error != 0)
 		return (error);
 
-	error = aic7770_map_registers(ahc);
+	error = aic7770_map_registers(ahc, io);
 	if (error != 0)
 		return (error);
 
+	/*
+	 * Before we continue probing the card, ensure that
+	 * its interrupts are *disabled*.  We don't want
+	 * a misstep to hang the machine in an interrupt
+	 * storm.
+	 */
+	ahc_intr_enable(ahc, FALSE);
+
 	ahc->description = entry->name;
 	error = ahc_softc_init(ahc);
 
@@ -168,21 +180,22 @@
 					ahc->flags |= AHC_TERM_ENB_B;
 			}
 		}
-		/*
-		 * We have no way to tell, so assume extended
-		 * translation is enabled.
-		 */
-		ahc->flags |= AHC_EXTENDED_TRANS_A|AHC_EXTENDED_TRANS_B;
+		if ((ahc_inb(ahc, HA_274_BIOSGLOBAL) & HA_274_EXTENDED_TRANS))
+			ahc->flags |= AHC_EXTENDED_TRANS_A|AHC_EXTENDED_TRANS_B;
 		break;
 	}
 	case AHC_VL:
 	{
-		aha2840_load_seeprom(ahc);
+		have_seeprom = aha2840_load_seeprom(ahc);
 		break;
 	}
 	default:
 		break;
 	}
+	if (have_seeprom == 0) {
+		free(ahc->seep_config, M_DEVBUF);
+		ahc->seep_config = NULL;
+	}
 
 	/*
 	 * Ensure autoflush is enabled
@@ -201,15 +214,16 @@
 	if (error != 0)
 		return (error);
 
+	error = aic7770_map_int(ahc, irq);
+	if (error != 0)
+		return (error);
+
+	ahc_list_lock(&l);
 	/*
 	 * Link this softc in with all other ahc instances.
 	 */
 	ahc_softc_insert(ahc);
 
-	error = aic7770_map_int(ahc, irq);
-	if (error != 0)
-		return (error);
-
 	/*
 	 * Enable the board's BUS drivers
 	 */
@@ -218,7 +232,11 @@
 	/*
 	 * Allow interrupts.
 	 */
+	ahc_lock(ahc, &s);
 	ahc_intr_enable(ahc, TRUE);
+	ahc_unlock(ahc, &s);
+
+	ahc_list_unlock(&l);
 
 	return (0);
 }
@@ -226,14 +244,13 @@
 /*
  * Read the 284x SEEPROM.
  */
-static void
+static int
 aha2840_load_seeprom(struct ahc_softc *ahc)
 {
-	struct	  seeprom_descriptor sd;
-	struct	  seeprom_config sc;
-	uint16_t  checksum = 0;
-	uint8_t   scsi_conf;
-	int	  have_seeprom;
+	struct	seeprom_descriptor sd;
+	struct	seeprom_config *sc;
+	int	have_seeprom;
+	uint8_t scsi_conf;
 
 	sd.sd_ahc = ahc;
 	sd.sd_control_offset = SEECTL_2840;
@@ -246,23 +263,16 @@
 	sd.sd_CK = CK_2840;
 	sd.sd_DO = DO_2840;
 	sd.sd_DI = DI_2840;
+	sc = ahc->seep_config;
 
 	if (bootverbose)
 		printf("%s: Reading SEEPROM...", ahc_name(ahc));
-	have_seeprom = read_seeprom(&sd,
-				    (uint16_t *)&sc,
-				    /*start_addr*/0,
-				    sizeof(sc)/2);
+	have_seeprom = ahc_read_seeprom(&sd, (uint16_t *)sc,
+					/*start_addr*/0, sizeof(*sc)/2);
 
 	if (have_seeprom) {
-		/* Check checksum */
-		int i;
-		int maxaddr = (sizeof(sc)/2) - 1;
-		uint16_t *scarray = (uint16_t *)&sc;
-
-		for (i = 0; i < maxaddr; i++)
-			checksum = checksum + scarray[i];
-		if (checksum != sc.checksum) {
+
+		if (ahc_verify_cksum(sc) == 0) {
 			if(bootverbose)
 				printf ("checksum error\n");
 			have_seeprom = 0;
@@ -280,41 +290,44 @@
 		 * Put the data we've collected down into SRAM
 		 * where ahc_init will find it.
 		 */
-		int i;
-		int max_targ = (ahc->features & AHC_WIDE) != 0 ? 16 : 8;
+		int	 i;
+		int	 max_targ;
 		uint16_t discenable;
 
+		max_targ = (ahc->features & AHC_WIDE) != 0 ? 16 : 8;
 		discenable = 0;
 		for (i = 0; i < max_targ; i++){
-	                uint8_t target_settings;
-			target_settings = (sc.device_flags[i] & CFXFER) << 4;
-			if (sc.device_flags[i] & CFSYNCH)
+			uint8_t target_settings;
+
+			target_settings = (sc->device_flags[i] & CFXFER) << 4;
+			if (sc->device_flags[i] & CFSYNCH)
 				target_settings |= SOFS;
-			if (sc.device_flags[i] & CFWIDEB)
+			if (sc->device_flags[i] & CFWIDEB)
 				target_settings |= WIDEXFER;
-			if (sc.device_flags[i] & CFDISC)
+			if (sc->device_flags[i] & CFDISC)
 				discenable |= (0x01 << i);
 			ahc_outb(ahc, TARG_SCSIRATE + i, target_settings);
 		}
 		ahc_outb(ahc, DISC_DSB, ~(discenable & 0xff));
 		ahc_outb(ahc, DISC_DSB + 1, ~((discenable >> 8) & 0xff));
 
-		ahc->our_id = sc.brtime_id & CFSCSIID;
+		ahc->our_id = sc->brtime_id & CFSCSIID;
 
 		scsi_conf = (ahc->our_id & 0x7);
-		if (sc.adapter_control & CFSPARITY)
+		if (sc->adapter_control & CFSPARITY)
 			scsi_conf |= ENSPCHK;
-		if (sc.adapter_control & CFRESETB)
+		if (sc->adapter_control & CFRESETB)
 			scsi_conf |= RESET_SCSI;
 
-		if (sc.bios_control & CF284XEXTEND)		
+		if (sc->bios_control & CF284XEXTEND)		
 			ahc->flags |= AHC_EXTENDED_TRANS_A;
 		/* Set SCSICONF info */
 		ahc_outb(ahc, SCSICONF, scsi_conf);
 
-		if (sc.adapter_control & CF284XSTERM)
+		if (sc->adapter_control & CF284XSTERM)
 			ahc->flags |= AHC_TERM_ENB_A;
 	}
+	return (have_seeprom);
 }
 
 static int
===== drivers/scsi/aic7xxx/aic7xxx.reg 1.5 vs edited =====
--- 1.5/drivers/scsi/aic7xxx/aic7xxx.reg	Tue Feb  5 16:53:47 2002
+++ edited/drivers/scsi/aic7xxx/aic7xxx.reg	Thu Oct 24 13:14:53 2002
@@ -37,9 +37,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.reg,v 1.31 2000/11/10 20:13:40 gibbs Exp $
+ * $FreeBSD: src/sys/dev/aic7xxx/aic7xxx.reg,v 1.20.2.11 2002/04/29 19:36:30 gibbs Exp $
  */
-VERSION = "$Id: //depot/aic7xxx/aic7xxx/aic7xxx.reg#24 $"
+VERSION = "$Id: //depot/aic7xxx/aic7xxx/aic7xxx.reg#30 $"
 
 /*
  * This file is processed by the aic7xxx_asm utility for use in assembling
@@ -474,7 +474,7 @@
 	bit	SOFT1		0x80
 	bit	SOFT0		0x40
 	bit	SOFTCMDEN	0x20	
-	bit	HAS_BRDCTL	0x10	/* External Board control */
+	bit	EXT_BRDCTL	0x10	/* External Board control */
 	bit	SEEPROM		0x08	/* External serial eeprom logic */
 	bit	EEPROM		0x04	/* Writable external BIOS ROM */
 	bit	ROM		0x02	/* Logic for accessing external ROM */
@@ -1009,7 +1009,9 @@
  * SCB Definition (p. 5-4)
  */
 scb {
-	address			0x0a0
+	address		0x0a0
+	size		64
+
 	SCB_CDB_PTR {
 		size	4
 		alias	SCB_RESIDUAL_DATACNT
@@ -1254,7 +1256,8 @@
  */
 
 scratch_ram {
-	address			0x020
+	address		0x020
+	size		58
 
 	/*
 	 * 1 byte per target starting at this address for configuration values
@@ -1316,7 +1319,7 @@
 		bit	SDMAENACK	0x10
 		bit	HDMAEN		0x08
 		bit	HDMAENACK	0x08
-		bit	DIRECTION	0x04
+		bit	DIRECTION	0x04	/* Set indicates PCI->SCSI */
 		bit	FIFOFLUSH	0x02
 		bit	FIFORESET	0x01
 	}
@@ -1469,26 +1472,46 @@
 	DATA_COUNT_ODD {
 		size		1
 	}
+}
+
+scratch_ram {
+	address		0x056
+	size		4
+	/*
+	 * These scratch ram locations are initialized by the 274X BIOS.
+	 * We reuse them after capturing the BIOS settings during
+	 * initialization.
+	 */
 
 	/*
 	 * The initiator specified tag for this target mode transaction.
 	 */
-	INITIATOR_TAG {
-		size		1
+	HA_274_BIOSGLOBAL {
+		size	1
+		bit	HA_274_EXTENDED_TRANS	0x01
+		alias	INITIATOR_TAG
 	}
 
 	SEQ_FLAGS2 {
-		size		1
-		bit	SCB_DMA			  0x01
-		bit	TARGET_MSG_PENDING	  0x02
+		size	1
+		bit	SCB_DMA			0x01
+		bit	TARGET_MSG_PENDING	0x02
 	}
+}
+
+scratch_ram {
+	address		0x05a
+	size		6
 	/*
-	 * These are reserved registers in the card's scratch ram.  Some of
-	 * the values are specified in the AHA2742 technical reference manual
-	 * and are initialized by the BIOS at boot time.
+	 * These are reserved registers in the card's scratch ram on the 2742.
+	 * The EISA configuraiton chip is mapped here.  On Rev E. of the
+	 * aic7770, the sequencer can use this area for scratch, but the
+	 * host cannot directly access these registers.  On later chips, this
+	 * area can be read and written by both the host and the sequencer.
+	 * Even on later chips, many of these locations are initialized by
+	 * the BIOS.
 	 */
 	SCSICONF {
-		address		0x05a
 		size		1
 		bit	TERM_ENB	0x80
 		bit	RESET_SCSI	0x40
@@ -1513,11 +1536,16 @@
 		mask	BIOSDISABLED		0x30	
 		bit	CHANNEL_B_PRIMARY	0x08
 	}
+}
+
+scratch_ram {
+	address		0x070
+	size		16
+
 	/*
 	 * Per target SCSI offset values for Ultra2 controllers.
 	 */
 	TARG_OFFSET {
-		address		0x070
 		size		16
 	}
 }

