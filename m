Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTGASiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTGASiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:38:50 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:54472 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263311AbTGASdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:33:42 -0400
Date: Tue, 1 Jul 2003 20:46:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (5/6): thin interrupts.
Message-ID: <20030701184656.GF12212@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add thin interrupt support to qdio.

diffstat:
 drivers/s390/cio/qdio.c |  738 ++++++++++++++++++++++++++----------------------
 drivers/s390/cio/qdio.h |   19 -
 2 files changed, 417 insertions(+), 340 deletions(-)

diff -urN linux-2.5/drivers/s390/cio/qdio.c linux-2.5-s390/drivers/s390/cio/qdio.c
--- linux-2.5/drivers/s390/cio/qdio.c	Sun Jun 22 20:32:56 2003
+++ linux-2.5-s390/drivers/s390/cio/qdio.c	Tue Jul  1 20:48:28 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.49 $"
+#define VERSION_QDIO_C "$Revision: 1.51 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -74,6 +74,8 @@
 static struct qdio_perf_stats perf_stats;
 #endif /* QDIO_PERFORMANCE_STATS */
 
+static int hydra_thinints;
+
 static int indicator_used[INDICATORS_PER_CACHELINE];
 static __u32 * volatile indicators;
 static __u32 volatile spare_indicator;
@@ -88,12 +90,12 @@
 #endif /* QDIO_DBF_LIKE_HELL */
 
 /* iQDIO stuff: */
-static volatile struct qdio_q *iq_list=NULL; /* volatile as it could change
-						  during a while loop */
-static spinlock_t iq_list_lock=SPIN_LOCK_UNLOCKED;
+static volatile struct qdio_q *tiq_list=NULL; /* volatile as it could change
+						 during a while loop */
+static spinlock_t ttiq_list_lock=SPIN_LOCK_UNLOCKED;
 static int register_thinint_result;
-static void iqdio_tl(unsigned long);
-static DECLARE_TASKLET(iqdio_tasklet,iqdio_tl,0);
+static void tiqdio_tl(unsigned long);
+static DECLARE_TASKLET(tiqdio_tasklet,tiqdio_tl,0);
 
 /* not a macro, as one of the arguments is atomic_read */
 static inline int 
@@ -173,7 +175,7 @@
 /* 
  * unfortunately, we can't just xchg the values; in do_QDIO we want to reserve
  * the q in any case, so that we'll not be interrupted when we are in
- * qdio_mark_iq... shouldn't have a really bad impact, as reserving almost
+ * qdio_mark_tiq... shouldn't have a really bad impact, as reserving almost
  * ever works (last famous words) 
  */
 static inline int 
@@ -195,7 +197,8 @@
 }
 
 static inline int 
-qdio_siga_sync(struct qdio_q *q)
+qdio_siga_sync(struct qdio_q *q, unsigned int gpr2,
+	       unsigned int gpr3)
 {
 	int cc;
 
@@ -206,17 +209,21 @@
 	perf_stats.siga_syncs++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
-	if (q->is_input_q)
-		cc = do_siga_sync(q->irq, 0, q->mask);
-	else
-		cc = do_siga_sync(q->irq, q->mask, 0);
-
+	cc = do_siga_sync(q->irq, gpr2, gpr3);
 	if (cc)
 		QDIO_DBF_HEX3(0,trace,&cc,sizeof(int*));
 
 	return cc;
 }
 
+static inline int
+qdio_siga_sync_q(struct qdio_q *q)
+{
+	if (q->is_input_q)
+		return qdio_siga_sync(q, 0, q->mask);
+	return qdio_siga_sync(q, q->mask, 0);
+}
+
 /* 
  * returns QDIO_SIGA_ERROR_ACCESS_EXCEPTION as cc, when SIGA returns
  * an access exception 
@@ -304,7 +311,7 @@
 }
 
 static inline volatile void 
-iqdio_clear_summary_bit(__u32 *location)
+tiqdio_clear_summary_bit(__u32 *location)
 {
 	QDIO_DBF_TEXT5(0,trace,"clrsummb");
 	QDIO_DBF_HEX5(0,trace,&location,sizeof(void*));
@@ -313,7 +320,7 @@
 }
 
 static inline volatile void
-iqdio_set_summary_bit(__u32 *location)
+tiqdio_set_summary_bit(__u32 *location)
 {
 	QDIO_DBF_TEXT5(0,trace,"setsummb");
 	QDIO_DBF_HEX5(0,trace,&location,sizeof(void*));
@@ -322,21 +329,21 @@
 }
 
 static inline void 
-iqdio_sched_tl(void)
+tiqdio_sched_tl(void)
 {
-	tasklet_hi_schedule(&iqdio_tasklet);
+	tasklet_hi_schedule(&tiqdio_tasklet);
 }
 
 static inline void
-qdio_mark_iq(struct qdio_q *q)
+qdio_mark_tiq(struct qdio_q *q)
 {
 	unsigned long flags;
 
 	QDIO_DBF_TEXT4(0,trace,"mark iq");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	spin_lock_irqsave(&iq_list_lock,flags);
-	if (atomic_read(&q->is_in_shutdown)) 
+	spin_lock_irqsave(&ttiq_list_lock,flags);
+	if (unlikely(atomic_read(&q->is_in_shutdown)))
 		goto out_unlock;
 
 	if (!q->is_input_q)
@@ -345,23 +352,23 @@
 	if ((q->list_prev) || (q->list_next)) 
 		goto out_unlock;
 
-	if (!iq_list) {
-		iq_list=q;
+	if (!tiq_list) {
+		tiq_list=q;
 		q->list_prev=q;
 		q->list_next=q;
 	} else {
-		q->list_next=iq_list;
-		q->list_prev=iq_list->list_prev;
-		iq_list->list_prev->list_next=q;
-		iq_list->list_prev=q;
+		q->list_next=tiq_list;
+		q->list_prev=tiq_list->list_prev;
+		tiq_list->list_prev->list_next=q;
+		tiq_list->list_prev=q;
 	}
-	spin_unlock_irqrestore(&iq_list_lock,flags);
+	spin_unlock_irqrestore(&ttiq_list_lock,flags);
 
-	iqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
-	iqdio_sched_tl();
+	tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
+	tiqdio_sched_tl();
 	return;
 out_unlock:
-	spin_unlock_irqrestore(&iq_list_lock,flags);
+	spin_unlock_irqrestore(&ttiq_list_lock,flags);
 	return;
 }
 
@@ -371,7 +378,7 @@
 	QDIO_DBF_TEXT4(0,trace,"mark q");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	if (atomic_read(&q->is_in_shutdown))
+	if (unlikely(atomic_read(&q->is_in_shutdown)))
 		return;
 
 	tasklet_schedule(&q->tasklet);
@@ -410,7 +417,7 @@
 	 * checking for PRIMED state 
 	 */
 	if (q->is_iqdio_q)
-		iqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
+		tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
 	return 0;
 
 #else /* QDIO_USE_PROCESSING_STATE */
@@ -434,27 +441,27 @@
 	if ((!q->list_prev)||(!q->list_next))
 		return;
 
-	if ((q->is_iqdio_q)&&(q->is_input_q)) {
+	if ((q->is_thinint_q)&&(q->is_input_q)) {
 		/* iQDIO */
-		spin_lock_irqsave(&iq_list_lock,flags);
+		spin_lock_irqsave(&ttiq_list_lock,flags);
 		if (q->list_next==q) {
 			/* q was the only interesting q */
-			iq_list=NULL;
+			tiq_list=NULL;
 			q->list_next=NULL;
 			q->list_prev=NULL;
 		} else {
 			q->list_next->list_prev=q->list_prev;
 			q->list_prev->list_next=q->list_next;
-			iq_list=q->list_next;
+			tiq_list=q->list_next;
 			q->list_next=NULL;
 			q->list_prev=NULL;
 		}
-		spin_unlock_irqrestore(&iq_list_lock,flags);
+		spin_unlock_irqrestore(&ttiq_list_lock,flags);
 	}
 }
 
 static inline unsigned long 
-iqdio_clear_global_summary(void)
+tiqdio_clear_global_summary(void)
 {
 	unsigned long time;
 
@@ -467,6 +474,223 @@
 	return time;
 }
 
+
+/************************* OUTBOUND ROUTINES *******************************/
+
+inline static int
+qdio_get_outbound_buffer_frontier(struct qdio_q *q)
+{
+	int f,f_mod_no;
+	volatile char *slsb;
+	int first_not_to_check;
+	char dbf_text[15];
+
+	QDIO_DBF_TEXT4(0,trace,"getobfro");
+	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+
+	slsb=&q->slsb.acc.val[0];
+	f_mod_no=f=q->first_to_check;
+	/* 
+	 * f points to already processed elements, so f+no_used is correct...
+	 * ... but: we don't check 128 buffers, as otherwise
+	 * qdio_has_outbound_q_moved would return 0 
+	 */
+	first_not_to_check=f+qdio_min(atomic_read(&q->number_of_buffers_used),
+				      (QDIO_MAX_BUFFERS_PER_Q-1));
+
+	if ((!q->is_iqdio_q)&&(!q->hydra_gives_outbound_pcis))
+		SYNC_MEMORY;
+
+check_next:
+	if (f==first_not_to_check) 
+		goto out;
+
+	switch(slsb[f_mod_no]) {
+
+        /* the hydra has not fetched the output yet */
+	case SLSB_CU_OUTPUT_PRIMED:
+		QDIO_DBF_TEXT5(0,trace,"outpprim");
+		break;
+
+	/* the hydra got it */
+	case SLSB_P_OUTPUT_EMPTY:
+		atomic_dec(&q->number_of_buffers_used);
+		f++;
+		f_mod_no=f&(QDIO_MAX_BUFFERS_PER_Q-1);
+		QDIO_DBF_TEXT5(0,trace,"outpempt");
+		goto check_next;
+
+	case SLSB_P_OUTPUT_ERROR:
+		QDIO_DBF_TEXT3(0,trace,"outperr");
+		sprintf(dbf_text,"%x-%x-%x",f_mod_no,
+			q->sbal[f_mod_no]->element[14].sbalf.value,
+			q->sbal[f_mod_no]->element[15].sbalf.value);
+		QDIO_DBF_TEXT3(1,trace,dbf_text);
+		QDIO_DBF_HEX2(1,sbal,q->sbal[f_mod_no],256);
+
+		/* kind of process the buffer */
+		set_slsb(&q->slsb.acc.val[f_mod_no], SLSB_P_OUTPUT_NOT_INIT);
+
+		/* 
+		 * we increment the frontier, as this buffer
+		 * was processed obviously 
+		 */
+		atomic_dec(&q->number_of_buffers_used);
+		f_mod_no=(f_mod_no+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
+
+		if (q->qdio_error)
+			q->error_status_flags|=
+				QDIO_STATUS_MORE_THAN_ONE_QDIO_ERROR;
+		q->qdio_error=SLSB_P_OUTPUT_ERROR;
+		q->error_status_flags|=QDIO_STATUS_LOOK_FOR_ERROR;
+
+		break;
+
+	/* no new buffers */
+	default:
+		QDIO_DBF_TEXT5(0,trace,"outpni");
+	}
+out:
+	return (q->first_to_check=f_mod_no);
+}
+
+/* all buffers are processed */
+inline static int
+qdio_is_outbound_q_done(struct qdio_q *q)
+{
+	int no_used;
+	char dbf_text[15];
+
+	no_used=atomic_read(&q->number_of_buffers_used);
+
+	if (no_used) {
+		sprintf(dbf_text,"oqisnt%02x",no_used);
+		QDIO_DBF_TEXT4(0,trace,dbf_text);
+	} else {
+		QDIO_DBF_TEXT4(0,trace,"oqisdone");
+	}
+	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+	return (no_used==0);
+}
+
+inline static int
+qdio_has_outbound_q_moved(struct qdio_q *q)
+{
+	int i;
+
+	i=qdio_get_outbound_buffer_frontier(q);
+
+	if ( (i!=GET_SAVED_FRONTIER(q)) ||
+	     (q->error_status_flags&QDIO_STATUS_LOOK_FOR_ERROR) ) {
+		SAVE_FRONTIER(q,i);
+		SAVE_TIMESTAMP(q);
+		QDIO_DBF_TEXT4(0,trace,"oqhasmvd");
+		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+		return 1;
+	} else {
+		QDIO_DBF_TEXT4(0,trace,"oqhsntmv");
+		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+		return 0;
+	}
+}
+
+inline static void
+qdio_kick_outbound_q(struct qdio_q *q)
+{
+	int result;
+
+	QDIO_DBF_TEXT4(0,trace,"kickoutq");
+	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+
+	if (!q->siga_out)
+		return;
+
+	result=qdio_siga_output(q);
+
+	if (!result)
+		return;
+
+	if (q->siga_error)
+		q->error_status_flags|=QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR;
+	q->error_status_flags |= QDIO_STATUS_LOOK_FOR_ERROR;
+	q->siga_error=result;
+}
+
+inline static void
+qdio_kick_outbound_handler(struct qdio_q *q)
+{
+	int start, end, real_end, count;
+	char dbf_text[15];
+
+	start = q->first_element_to_kick;
+	/* last_move_ftc was just updated */
+	real_end = GET_SAVED_FRONTIER(q);
+	end = (real_end+QDIO_MAX_BUFFERS_PER_Q-1)&
+		(QDIO_MAX_BUFFERS_PER_Q-1);
+	count = (end+QDIO_MAX_BUFFERS_PER_Q+1-start)&
+		(QDIO_MAX_BUFFERS_PER_Q-1);
+
+	QDIO_DBF_TEXT4(0,trace,"kickouth");
+	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+
+	sprintf(dbf_text,"s=%2xc=%2x",start,count);
+	QDIO_DBF_TEXT4(0,trace,dbf_text);
+
+	if (q->state==QDIO_IRQ_STATE_ACTIVE)
+		q->handler(q->cdev,QDIO_STATUS_OUTBOUND_INT|
+			   q->error_status_flags,
+			   q->qdio_error,q->siga_error,q->q_no,start,count,
+			   q->int_parm);
+
+	/* for the next time: */
+	q->first_element_to_kick=real_end;
+	q->qdio_error=0;
+	q->siga_error=0;
+	q->error_status_flags=0;
+}
+
+static void
+qdio_outbound_processing(struct qdio_q *q)
+{
+	QDIO_DBF_TEXT4(0,trace,"qoutproc");
+	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+
+	if (unlikely(qdio_reserve_q(q))) {
+		qdio_release_q(q);
+#ifdef QDIO_PERFORMANCE_STATS
+		o_p_c++;
+#endif /* QDIO_PERFORMANCE_STATS */
+		/* as we're sissies, we'll check next time */
+		if (likely(!atomic_read(&q->is_in_shutdown))) {
+			qdio_mark_q(q);
+			QDIO_DBF_TEXT4(0,trace,"busy,agn");
+		}
+		return;
+	}
+#ifdef QDIO_PERFORMANCE_STATS
+	o_p_nc++;
+	perf_stats.tl_runs++;
+#endif /* QDIO_PERFORMANCE_STATS */
+
+	if (qdio_has_outbound_q_moved(q))
+		qdio_kick_outbound_handler(q);
+
+	if (q->is_iqdio_q) {
+		/* 
+		 * for asynchronous queues, we better check, if the fill
+		 * level is too high 
+		 */
+		if (atomic_read(&q->number_of_buffers_used)>
+		    IQDIO_FILL_LEVEL_TO_POLL)
+			qdio_mark_q(q);
+
+	} else if (!q->hydra_gives_outbound_pcis)
+		if (!qdio_is_outbound_q_done(q))
+			qdio_mark_q(q);
+
+	qdio_release_q(q);
+}
+
 /************************* INBOUND ROUTINES *******************************/
 
 
@@ -650,8 +874,8 @@
 	 * we will return 0 below, as there is nothing to do, except scheduling
 	 * ourselves for the next time. 
 	 */
-	iqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
-	iqdio_sched_tl();
+	tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
+	tiqdio_sched_tl();
 	return 0;
 }
 
@@ -725,14 +949,15 @@
 	count=0;
  	while (1) {
  		count++;
- 		if (i==end) break;
+ 		if (i==end)
+			break;
  		i=(i+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
  	}
 
 	sprintf(dbf_text,"s=%2xc=%2x",start,count);
 	QDIO_DBF_TEXT4(0,trace,dbf_text);
 
-	if (q->state==QDIO_IRQ_STATE_ACTIVE)
+	if (likely(q->state==QDIO_IRQ_STATE_ACTIVE))
 		q->handler(q->cdev,
 			   QDIO_STATUS_INBOUND_INT|q->error_status_flags,
 			   q->qdio_error,q->siga_error,q->q_no,start,count,
@@ -751,8 +976,12 @@
 }
 
 static inline void
-iqdio_inbound_processing(struct qdio_q *q)
+tiqdio_inbound_processing(struct qdio_q *q)
 {
+	struct qdio_irq *irq_ptr;
+	struct qdio_q *oq;
+	int i;
+
 	QDIO_DBF_TEXT4(0,trace,"iqinproc");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
@@ -761,7 +990,7 @@
 	 * interrupt ourselves and call qdio_unmark_q, as is_in_shutdown might
 	 * be set 
 	 */
-	if (qdio_reserve_q(q)) {
+	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
 #ifdef QDIO_PERFORMANCE_STATS
 		ii_p_c++;
@@ -770,13 +999,13 @@
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
 		 */
-		iqdio_sched_tl();
+		tiqdio_sched_tl();
 		return;
 	}
 #ifdef QDIO_PERFORMANCE_STATS
 	ii_p_nc++;
 #endif /* QDIO_PERFORMANCE_STATS */
-	if (atomic_read(&q->is_in_shutdown)) {
+	if (unlikely(atomic_read(&q->is_in_shutdown))) {
 		qdio_unmark_q(q);
 		goto out;
 	}
@@ -784,10 +1013,34 @@
 	if (!(*(q->dev_st_chg_ind)))
 		goto out;
 
-	iqdio_clear_summary_bit((__u32*)q->dev_st_chg_ind);
+	tiqdio_clear_summary_bit((__u32*)q->dev_st_chg_ind);
 
-	if (!q->siga_sync_done_on_thinints)
-			SYNC_MEMORY;
+	if (q->hydra_gives_outbound_pcis) {
+		if (!q->siga_sync_done_on_thinints) {
+			SYNC_MEMORY_ALL;
+		} else if ((!q->siga_sync_done_on_outb_tis)&&
+			 (q->hydra_gives_outbound_pcis)) {
+			SYNC_MEMORY_ALL_OUTB;
+		}
+	} else {
+		SYNC_MEMORY;
+	}
+	/*
+	 * maybe we have to do work on our outbound queues... at least
+	 * we have to check Hydra outbound-int-capable thinint-capable
+	 * queues
+	 */
+	if (q->hydra_gives_outbound_pcis) {
+		irq_ptr = (struct qdio_irq*)q->irq_ptr;
+		for (i=0;i<irq_ptr->no_output_qs;i++) {
+			oq = irq_ptr->output_qs[i];
+#ifdef QDIO_PERFORMANCE_STATS
+			perf_stats.tl_runs--;
+#endif /* QDIO_PERFORMANCE_STATS */
+			if (!qdio_is_outbound_q_done(oq))
+				qdio_outbound_processing(oq);
+		}
+	}
 
 	if (!qdio_has_inbound_q_moved(q))
 		goto out;
@@ -799,8 +1052,8 @@
 			 * we set the flags to get into the stuff next time,
 			 * see also comment in qdio_stop_polling 
 			 */
-			iqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
-			iqdio_sched_tl();
+			tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
+			tiqdio_sched_tl();
 		}
 out:
 	qdio_release_q(q);
@@ -814,13 +1067,13 @@
 	QDIO_DBF_TEXT4(0,trace,"qinproc");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	if (qdio_reserve_q(q)) {
+	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
 #ifdef QDIO_PERFORMANCE_STATS
 		i_p_c++;
 #endif /* QDIO_PERFORMANCE_STATS */
 		/* as we're sissies, we'll check next time */
-		if (!atomic_read(&q->is_in_shutdown)) {
+		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
 			QDIO_DBF_TEXT4(0,trace,"busy,agn");
 		}
@@ -849,229 +1102,14 @@
 	qdio_release_q(q);
 }
 
-/************************* OUTBOUND ROUTINES *******************************/
-
-inline static int
-qdio_get_outbound_buffer_frontier(struct qdio_q *q)
-{
-	int f,f_mod_no;
-	volatile char *slsb;
-	int first_not_to_check;
-	char dbf_text[15];
-
-	QDIO_DBF_TEXT4(0,trace,"getobfro");
-	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-
-	slsb=&q->slsb.acc.val[0];
-	f_mod_no=f=q->first_to_check;
-	/* 
-	 * f points to already processed elements, so f+no_used is correct...
-	 * ... but: we don't check 128 buffers, as otherwise
-	 * qdio_has_outbound_q_moved would return 0 
-	 */
-	first_not_to_check=f+qdio_min(atomic_read(&q->number_of_buffers_used),
-				      (QDIO_MAX_BUFFERS_PER_Q-1));
-
-	if ((!q->is_iqdio_q)&&(!q->hydra_gives_outbound_pcis))
-		SYNC_MEMORY;
-
-check_next:
-	if (f==first_not_to_check) 
-		goto out;
-
-	switch(slsb[f_mod_no]) {
-
-        /* the hydra has not fetched the output yet */
-	case SLSB_CU_OUTPUT_PRIMED:
-		QDIO_DBF_TEXT5(0,trace,"outpprim");
-		break;
-
-	/* the hydra got it */
-	case SLSB_P_OUTPUT_EMPTY:
-		atomic_dec(&q->number_of_buffers_used);
-		f++;
-		f_mod_no=f&(QDIO_MAX_BUFFERS_PER_Q-1);
-		QDIO_DBF_TEXT5(0,trace,"outpempt");
-		goto check_next;
-
-	case SLSB_P_OUTPUT_ERROR:
-		QDIO_DBF_TEXT3(0,trace,"outperr");
-		sprintf(dbf_text,"%x-%x-%x",f_mod_no,
-			q->sbal[f_mod_no]->element[14].sbalf.value,
-			q->sbal[f_mod_no]->element[15].sbalf.value);
-		QDIO_DBF_TEXT3(1,trace,dbf_text);
-		QDIO_DBF_HEX2(1,sbal,q->sbal[f_mod_no],256);
-
-		/* kind of process the buffer */
-		set_slsb(&q->slsb.acc.val[f_mod_no], SLSB_P_OUTPUT_NOT_INIT);
-
-		/* 
-		 * we increment the frontier, as this buffer
-		 * was processed obviously 
-		 */
-		atomic_dec(&q->number_of_buffers_used);
-		f_mod_no=(f_mod_no+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
-
-		if (q->qdio_error)
-			q->error_status_flags|=
-				QDIO_STATUS_MORE_THAN_ONE_QDIO_ERROR;
-		q->qdio_error=SLSB_P_OUTPUT_ERROR;
-		q->error_status_flags|=QDIO_STATUS_LOOK_FOR_ERROR;
-
-		break;
-
-	/* no new buffers */
-	default:
-		QDIO_DBF_TEXT5(0,trace,"outpni");
-	}
-out:
-	return (q->first_to_check=f_mod_no);
-}
-
-/* all buffers are processed */
-inline static int
-qdio_is_outbound_q_done(struct qdio_q *q)
-{
-	int no_used;
-	char dbf_text[15];
-
-	no_used=atomic_read(&q->number_of_buffers_used);
-
-	if (no_used) {
-		sprintf(dbf_text,"oqisnt%02x",no_used);
-		QDIO_DBF_TEXT4(0,trace,dbf_text);
-	} else {
-		QDIO_DBF_TEXT4(0,trace,"oqisdone");
-	}
-	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-	return (no_used==0);
-}
-
-inline static int
-qdio_has_outbound_q_moved(struct qdio_q *q)
-{
-	int i;
-
-	i=qdio_get_outbound_buffer_frontier(q);
-
-	if ( (i!=GET_SAVED_FRONTIER(q)) ||
-	     (q->error_status_flags&QDIO_STATUS_LOOK_FOR_ERROR) ) {
-		SAVE_FRONTIER(q,i);
-		SAVE_TIMESTAMP(q);
-		QDIO_DBF_TEXT4(0,trace,"oqhasmvd");
-		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-		return 1;
-	} else {
-		QDIO_DBF_TEXT4(0,trace,"oqhsntmv");
-		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-		return 0;
-	}
-}
-
-inline static void
-qdio_kick_outbound_q(struct qdio_q *q)
-{
-	int result;
-
-	QDIO_DBF_TEXT4(0,trace,"kickoutq");
-	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-
-	if (!q->siga_out)
-		return;
-
-	result=qdio_siga_output(q);
-
-	if (!result)
-		return;
-
-	if (q->siga_error)
-		q->error_status_flags|=QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR;
-	q->error_status_flags |= QDIO_STATUS_LOOK_FOR_ERROR;
-	q->siga_error=result;
-}
-
-inline static void
-qdio_kick_outbound_handler(struct qdio_q *q)
-{
-	int start, end, real_end, count;
-	char dbf_text[15];
-
-	start = q->first_element_to_kick;
-	/* last_move_ftc was just updated */
-	real_end = GET_SAVED_FRONTIER(q);
-	end = (real_end+QDIO_MAX_BUFFERS_PER_Q-1)&
-		(QDIO_MAX_BUFFERS_PER_Q-1);
-	count = (end+QDIO_MAX_BUFFERS_PER_Q+1-start)&
-		(QDIO_MAX_BUFFERS_PER_Q-1);
-
-	QDIO_DBF_TEXT4(0,trace,"kickouth");
-	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-
-	sprintf(dbf_text,"s=%2xc=%2x",start,count);
-	QDIO_DBF_TEXT4(0,trace,dbf_text);
-
-	if (q->state==QDIO_IRQ_STATE_ACTIVE)
-		q->handler(q->cdev,QDIO_STATUS_OUTBOUND_INT|
-			   q->error_status_flags,
-			   q->qdio_error,q->siga_error,q->q_no,start,count,
-			   q->int_parm);
-
-	/* for the next time: */
-	q->first_element_to_kick=real_end;
-	q->qdio_error=0;
-	q->siga_error=0;
-	q->error_status_flags=0;
-}
-
-static void qdio_outbound_processing(struct qdio_q *q)
-{
-	QDIO_DBF_TEXT4(0,trace,"qoutproc");
-	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-
-	if (qdio_reserve_q(q)) {
-		qdio_release_q(q);
-#ifdef QDIO_PERFORMANCE_STATS
-		o_p_c++;
-#endif /* QDIO_PERFORMANCE_STATS */
-		/* as we're sissies, we'll check next time */
-		if (!atomic_read(&q->is_in_shutdown)) {
-			qdio_mark_q(q);
-			QDIO_DBF_TEXT4(0,trace,"busy,agn");
-		}
-		return;
-	}
-#ifdef QDIO_PERFORMANCE_STATS
-	o_p_nc++;
-	perf_stats.tl_runs++;
-#endif /* QDIO_PERFORMANCE_STATS */
-
-	if (qdio_has_outbound_q_moved(q))
-		qdio_kick_outbound_handler(q);
-
-	if (q->is_iqdio_q) {
-		/* 
-		 * for asynchronous queues, we better check, if the fill
-		 * level is too high 
-		 */
-		if (atomic_read(&q->number_of_buffers_used)>
-		    IQDIO_FILL_LEVEL_TO_POLL)
-			qdio_mark_q(q);
-
-	} else if (!q->hydra_gives_outbound_pcis)
-		if (!qdio_is_outbound_q_done(q))
-			qdio_mark_q(q);
-
-	qdio_release_q(q);
-}
-
 /************************* MAIN ROUTINES *******************************/
 
 #ifdef QDIO_USE_PROCESSING_STATE
 static inline int
-iqdio_do_inbound_checks(struct qdio_q *q, int q_laps)
+tiqdio_do_inbound_checks(struct qdio_q *q, int q_laps)
 {
 	if (!q) {
-		iqdio_sched_tl();
+		tiqdio_sched_tl();
 		return 0;
 	}
 
@@ -1082,7 +1120,7 @@
 	if (q->siga_sync)
 		return 2;
 
-	if (qdio_reserve_q(q)) {
+	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
 #ifdef QDIO_PERFORMANCE_STATS
 		ii_p_c++;
@@ -1096,8 +1134,8 @@
 		 * sanity -- we'd get here without setting the
 		 * dev st chg ind 
 		 */
-		iqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
-		iqdio_sched_tl();
+		tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
+		tiqdio_sched_tl();
 		return 0;
 	}
 	if (qdio_stop_polling(q)) {
@@ -1112,8 +1150,8 @@
 	 * we set the flags to get into the stuff
 	 * next time, see also comment in qdio_stop_polling 
 	 */
-	iqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
-	iqdio_sched_tl();
+	tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
+	tiqdio_sched_tl();
 	qdio_release_q(q);
 	return 1;
 	
@@ -1121,7 +1159,7 @@
 #endif /* QDIO_USE_PROCESSING_STATE */
 
 static inline void
-iqdio_inbound_checks(void)
+tiqdio_inbound_checks(void)
 {
 	struct qdio_q *q;
 #ifdef QDIO_USE_PROCESSING_STATE
@@ -1135,20 +1173,20 @@
 again:
 #endif /* QDIO_USE_PROCESSING_STATE */
 
-	q=(struct qdio_q*)iq_list;
+	q=(struct qdio_q*)tiq_list;
 	do {
 		if (!q)
 			break;
-		iqdio_inbound_processing(q);
+		tiqdio_inbound_processing(q);
 		q=(struct qdio_q*)q->list_next;
-	} while (q!=(struct qdio_q*)iq_list);
+	} while (q!=(struct qdio_q*)tiq_list);
 
 #ifdef QDIO_USE_PROCESSING_STATE
-	q=(struct qdio_q*)iq_list;
+	q=(struct qdio_q*)tiq_list;
 	do {
 		int ret;
 
-		ret = iqdio_do_inbound_checks(q, q_laps);
+		ret = tiqdio_do_inbound_checks(q, q_laps);
 		switch (ret) {
 		case 0:
 			return;
@@ -1161,17 +1199,12 @@
 			q_laps++;
 			goto again;
 		}
-	} while (q!=(struct qdio_q*)iq_list);
+	} while (q!=(struct qdio_q*)tiq_list);
 #endif /* QDIO_USE_PROCESSING_STATE */
 }
 
 static void
-iqdio_check_for_polling(void)
-{
-}
-
-static void
-iqdio_tl(unsigned long data)
+tiqdio_tl(unsigned long data)
 {
 	QDIO_DBF_TEXT4(0,trace,"iqdio_tl");
 
@@ -1179,8 +1212,7 @@
 	perf_stats.tl_runs++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
-	iqdio_inbound_checks();
-	iqdio_check_for_polling();
+	tiqdio_inbound_checks();
 }
 
 /********************* GENERAL HELPER_ROUTINES ***********************/
@@ -1298,6 +1330,7 @@
 		q->int_parm=int_parm;
 		irq_ptr->input_qs[i]=q;
 		q->irq=irq_ptr->irq;
+		q->irq_ptr = irq_ptr;
 		q->cdev = cdev;
 		q->mask=1<<(31-i);
 		q->q_no=i;
@@ -1308,10 +1341,11 @@
 		q->dev_st_chg_ind=irq_ptr->dev_st_chg_ind;
 
 		q->tasklet.data=(unsigned long)q;
+		/* q->is_thinint_q isn't valid at this time, but
+		 * irq_ptr->is_thinint_irq is */
 		q->tasklet.func=(void(*)(unsigned long))
-			(
-			(q_format==QDIO_IQDIO_QFMT)?&iqdio_inbound_processing:
-			&qdio_inbound_processing);
+			((irq_ptr->is_thinint_irq)?&tiqdio_inbound_processing:
+			 &qdio_inbound_processing);
 
 /*		for (j=0;j<QDIO_STATS_NUMBER;j++)
 			q->timing.last_transfer_times[j]=(qdio_get_micros()/
@@ -1376,6 +1410,7 @@
 		q->is_input_q=0;
 		q->irq=irq_ptr->irq;
 		q->cdev = cdev;
+		q->irq_ptr = irq_ptr;
 		q->mask=1<<(31-i);
 		q->q_no=i;
 		q->first_to_check=0;
@@ -1454,7 +1489,7 @@
 }
 
 static int
-iqdio_thinint_handler(void)
+tiqdio_thinint_handler(void)
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
@@ -1464,10 +1499,9 @@
 #endif /* QDIO_PERFORMANCE_STATS */
 	/* VM will do the SVS for us */
 	if (!MACHINE_IS_VM)
-		iqdio_clear_global_summary();
+		tiqdio_clear_global_summary();
 
-	iqdio_inbound_checks();
-	iqdio_check_for_polling();
+	tiqdio_inbound_checks();
 	return 0;
 }
 
@@ -1814,9 +1848,10 @@
 }
 
 static unsigned int
-iqdio_check_chsc_availability(void)
+tiqdio_check_chsc_availability(void)
 {
 	int result;
+	char dbf_text[15];
 
 	struct {
 		struct chsc_header request;
@@ -1871,6 +1906,12 @@
 		result=-ENOENT;
 		goto exit;
 	}
+
+	/* Check for hydra thin interrupts. */
+	hydra_thinints = ((scsc_area->general_char[2] & 0x10000000)
+		== 0x10000000);
+	sprintf(dbf_text,"hydra_ti%1x", hydra_thinints);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
 exit:
 	free_page ((unsigned long) scsc_area);
 	return result;
@@ -1878,7 +1919,7 @@
 
 
 static unsigned int
-iqdio_set_subchannel_ind(struct qdio_irq *irq_ptr, int reset_to_zero)
+tiqdio_set_subchannel_ind(struct qdio_irq *irq_ptr, int reset_to_zero)
 {
 	unsigned long real_addr_local_summary_bit;
 	unsigned long real_addr_dev_st_chg_ind;
@@ -1907,7 +1948,7 @@
 		u32 reserved7;
 	} *scssc_area;
 
-	if (!irq_ptr->is_iqdio_irq)
+	if (!irq_ptr->is_thinint_irq)
 		return -ENODEV;
 
 	if (reset_to_zero) {
@@ -1936,7 +1977,7 @@
 	scssc_area->subchannel_indicator_addr = real_addr_dev_st_chg_ind;
 	scssc_area->ks = QDIO_STORAGE_KEY;
 	scssc_area->kc = QDIO_STORAGE_KEY;
-	scssc_area->isc = IQDIO_THININT_ISC;
+	scssc_area->isc = TIQDIO_THININT_ISC;
 	scssc_area->subsystem_id = (1<<16) + irq_ptr->irq;
 
 	result = chsc(scssc_area);
@@ -1972,7 +2013,7 @@
 }
 
 static unsigned int
-iqdio_set_delay_target(struct qdio_irq *irq_ptr, unsigned long delay_target)
+tiqdio_set_delay_target(struct qdio_irq *irq_ptr, unsigned long delay_target)
 {
 	unsigned int resp_code;
 	int result;
@@ -1992,7 +2033,7 @@
 		u32 reserved6;
 	} *scsscf_area;
 
-	if (!irq_ptr->is_iqdio_irq)
+	if (!irq_ptr->is_thinint_irq)
 		return -ENODEV;
 
 	scsscf_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
@@ -2082,7 +2123,7 @@
 	for (i=0;i<irq_ptr->no_output_qs;i++)
 		atomic_set(&irq_ptr->output_qs[i]->is_in_shutdown,1);
 
-	tasklet_kill(&iqdio_tasklet);
+	tasklet_kill(&tiqdio_tasklet);
 
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		qdio_unmark_q(irq_ptr->input_qs[i]);
@@ -2145,9 +2186,9 @@
 static inline void
 qdio_cleanup_finish(struct ccw_device *cdev, struct qdio_irq *irq_ptr)
 {
-	if (irq_ptr->is_iqdio_irq) {
+	if (irq_ptr->is_thinint_irq) {
 		qdio_put_indicator((__u32*)irq_ptr->dev_st_chg_ind);
-		iqdio_set_subchannel_ind(irq_ptr,1); 
+		tiqdio_set_subchannel_ind(irq_ptr,1); 
                 /* reset adapter interrupt indicators */
 	}
 
@@ -2156,6 +2197,7 @@
  		cdev->handler=irq_ptr->original_int_handler;
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
+
 }
 
 int
@@ -2228,13 +2270,14 @@
 qdio_allocate_fill_input_desc(struct qdio_irq *irq_ptr, int i, int iqfmt)
 {
 	irq_ptr->input_qs[i]->is_iqdio_q = iqfmt;
+	irq_ptr->input_qs[i]->is_thinint_q = irq_ptr->is_thinint_irq;
 
 	irq_ptr->qdr->qdf0[i].sliba=(unsigned long)(irq_ptr->input_qs[i]->slib);
 
 	irq_ptr->qdr->qdf0[i].sla=(unsigned long)(irq_ptr->input_qs[i]->sl);
 
 	irq_ptr->qdr->qdf0[i].slsba=
-			(unsigned long)(&irq_ptr->input_qs[i]->slsb.acc.val[0]);
+		(unsigned long)(&irq_ptr->input_qs[i]->slsb.acc.val[0]);
 
 	irq_ptr->qdr->qdf0[i].akey=QDIO_STORAGE_KEY;
 	irq_ptr->qdr->qdf0[i].bkey=QDIO_STORAGE_KEY;
@@ -2247,9 +2290,9 @@
 			       int j, int iqfmt)
 {
 	irq_ptr->output_qs[i]->is_iqdio_q = iqfmt;
+	irq_ptr->output_qs[i]->is_thinint_q = irq_ptr->is_thinint_irq;
 
-	irq_ptr->qdr->qdf0[i+j].sliba=
-		(unsigned long)(irq_ptr->output_qs[i]->slib);
+	irq_ptr->qdr->qdf0[i+j].sliba=(unsigned long)(irq_ptr->output_qs[i]->slib);
 
 	irq_ptr->qdr->qdf0[i+j].sla=(unsigned long)(irq_ptr->output_qs[i]->sl);
 
@@ -2279,6 +2322,13 @@
 			irq_ptr->qdioac&CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS;
 		irq_ptr->input_qs[i]->hydra_gives_outbound_pcis=
 			irq_ptr->hydra_gives_outbound_pcis;
+		irq_ptr->input_qs[i]->siga_sync_done_on_outb_tis=
+			((irq_ptr->qdioac&
+			  (CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS|
+			   CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS))==
+			 (CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS|
+			  CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS));
+
 	}
 }
 
@@ -2298,6 +2348,13 @@
 			irq_ptr->qdioac&CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS;
 		irq_ptr->output_qs[i]->hydra_gives_outbound_pcis=
 			irq_ptr->hydra_gives_outbound_pcis;
+		irq_ptr->output_qs[i]->siga_sync_done_on_outb_tis=
+			((irq_ptr->qdioac&
+			  (CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS|
+			   CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS))==
+			 (CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS|
+			  CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS));
+
 	}
 }
 
@@ -2414,6 +2471,7 @@
 	struct ciw *ciw;
 	int result;
 	int is_iqdio;
+	char dbf_text[15];
 
 	if ( (init_data->no_input_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
 	     (init_data->no_output_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
@@ -2460,9 +2518,18 @@
 	irq_ptr->no_input_qs=init_data->no_input_qs;
 	irq_ptr->no_output_qs=init_data->no_output_qs;
 
-	irq_ptr->is_iqdio_irq=(init_data->q_format==QDIO_IQDIO_QFMT)?1:0;
+	if (init_data->q_format==QDIO_IQDIO_QFMT) {
+		irq_ptr->is_iqdio_irq=1;
+		irq_ptr->is_thinint_irq=1;
+	} else {
+		irq_ptr->is_iqdio_irq=0;
+		irq_ptr->is_thinint_irq=hydra_thinints;
+	}
+	sprintf(dbf_text,"is_i_t%1x%1x",
+		irq_ptr->is_iqdio_irq,irq_ptr->is_thinint_irq);
+	QDIO_DBF_TEXT2(0,setup,dbf_text);
 
-	if (irq_ptr->is_iqdio_irq) {
+	if (irq_ptr->is_thinint_irq) {
 		irq_ptr->dev_st_chg_ind=qdio_get_indicator();
 		QDIO_DBF_HEX1(0,setup,&irq_ptr->dev_st_chg_ind,sizeof(void*));
 		if (!irq_ptr->dev_st_chg_ind) {
@@ -2522,10 +2589,10 @@
 
 	/* fill in qib */
 	irq_ptr->qib.qfmt=init_data->q_format;
-	if (init_data->no_input_qs) irq_ptr->qib.isliba=
-				 (unsigned long)(irq_ptr->input_qs[0]->slib);
-	if (init_data->no_output_qs) irq_ptr->qib.osliba=(unsigned long)
-				  (irq_ptr->output_qs[0]->slib);
+	if (init_data->no_input_qs)
+		irq_ptr->qib.isliba=(unsigned long)(irq_ptr->input_qs[0]->slib);
+	if (init_data->no_output_qs)
+		irq_ptr->qib.osliba=(unsigned long)(irq_ptr->output_qs[0]->slib);
 	memcpy(irq_ptr->qib.ebcnam,init_data->adapter_name,8);
 
 	qdio_set_impl_params(irq_ptr,init_data->qib_param_field_format,
@@ -2567,21 +2634,16 @@
 	irq_ptr->original_int_handler = init_data->cdev->handler;
 	init_data->cdev->handler = qdio_handler;
 
-	/* the iqdio CHSC stuff */
-	if (irq_ptr->is_iqdio_irq) {
-/*		iqdio_enable_adapter_int_facility(irq_ptr);*/
-
-		if (iqdio_check_chsc_availability()) {
-			QDIO_PRINT_ERR("Not all CHSCs supported. " \
-				       "Continuing.\n");
-		}
-		result=iqdio_set_subchannel_ind(irq_ptr,0);
+	/* the thinint CHSC stuff */
+	if (irq_ptr->is_thinint_irq) {
+
+		result = tiqdio_set_subchannel_ind(irq_ptr,0);
 		if (result) {
 			up(&irq_ptr->setting_up_sema);
 			qdio_cleanup(init_data->cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 			return result;
 		}
-		iqdio_set_delay_target(irq_ptr,IQDIO_DELAY_TARGET);
+		tiqdio_set_delay_target(irq_ptr,TIQDIO_DELAY_TARGET);
 	}
 
 	up(&irq_ptr->setting_up_sema);
@@ -2620,7 +2682,7 @@
 
 	ccw_device_set_options(cdev, 0);
 	result=ccw_device_start_timeout(cdev,&irq_ptr->ccw,
-					QDIO_DOING_ESTABLISH,0,0,
+					QDIO_DOING_ESTABLISH,0, 0,
 					QDIO_ESTABLISH_TIMEOUT);
 	if (result) {
 		result2=ccw_device_start_timeout(cdev,&irq_ptr->ccw,
@@ -2721,14 +2783,14 @@
 		goto out;
 
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
-		if (irq_ptr->is_iqdio_irq) {
+		if (irq_ptr->is_thinint_irq) {
 			/* 
 			 * that way we know, that, if we will get interrupted
-			 * by iqdio_inbound_processing, qdio_unmark_q will
+			 * by tiqdio_inbound_processing, qdio_unmark_q will
 			 * not be called 
 			 */
 			qdio_reserve_q(irq_ptr->input_qs[i]);
-			qdio_mark_iq(irq_ptr->input_qs[i]);
+			qdio_mark_tiq(irq_ptr->input_qs[i]);
 			qdio_release_q(irq_ptr->input_qs[i]);
 		}
 	}
@@ -2958,7 +3020,7 @@
 		 perf_stats.siga_ins);
 	_OUTP_IT("Number of SIGA out's issued                     : %u\n",
 		 perf_stats.siga_outs);
-	_OUTP_IT("Number of PCI's caught                          : %u\n",
+	_OUTP_IT("Number of PCIs caught                          : %u\n",
 		 perf_stats.pcis);
 	_OUTP_IT("Number of adapter interrupts caught             : %u\n",
 		 perf_stats.thinints);
@@ -3032,11 +3094,11 @@
 }
 
 static void
-iqdio_register_thinints(void)
+tiqdio_register_thinints(void)
 {
 	char dbf_text[20];
 	register_thinint_result=
-		s390_register_adapter_interrupt(&iqdio_thinint_handler);
+		s390_register_adapter_interrupt(&tiqdio_thinint_handler);
 	if (register_thinint_result) {
 		sprintf(dbf_text,"regthn%x",(register_thinint_result&0xff));
 		QDIO_DBF_TEXT0(0,setup,dbf_text);
@@ -3048,10 +3110,10 @@
 }
 
 static void
-iqdio_unregister_thinints(void)
+tiqdio_unregister_thinints(void)
 {
 	if (!register_thinint_result)
-		s390_unregister_adapter_interrupt(&iqdio_thinint_handler);
+		s390_unregister_adapter_interrupt(&tiqdio_thinint_handler);
 }
 
 static int
@@ -3191,7 +3253,11 @@
 #endif /* QDIO_PERFORMANCE_STATS */
 
 	qdio_add_procfs_entry();
-	iqdio_register_thinints();
+
+	if (tiqdio_check_chsc_availability())
+		QDIO_PRINT_ERR("Not all CHSCs supported. Continuing.\n");
+
+	tiqdio_register_thinints();
 
 	return 0;
  }
@@ -3199,7 +3265,7 @@
 static void __exit
 cleanup_QDIO(void)
 {
-	iqdio_unregister_thinints();
+	tiqdio_unregister_thinints();
 	qdio_remove_procfs_entry();
 	qdio_release_qdio_memory();
 	qdio_unregister_dbf_views();
diff -urN linux-2.5/drivers/s390/cio/qdio.h linux-2.5-s390/drivers/s390/cio/qdio.h
--- linux-2.5/drivers/s390/cio/qdio.h	Tue Jul  1 20:48:10 2003
+++ linux-2.5-s390/drivers/s390/cio/qdio.h	Tue Jul  1 20:48:28 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.17 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.18 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -31,8 +31,8 @@
  */
 #define IQDIO_FILL_LEVEL_TO_POLL 4
 
-#define IQDIO_THININT_ISC 3
-#define IQDIO_DELAY_TARGET 0
+#define TIQDIO_THININT_ISC 3
+#define TIQDIO_DELAY_TARGET 0
 #define QDIO_BUSY_BIT_PATIENCE 2000 /* in microsecs */
 #define IQDIO_GLOBAL_LAPS 2 /* GLOBAL_LAPS are not used as we */
 #define IQDIO_GLOBAL_LAPS_INT 1 /* don't global summary */
@@ -473,7 +473,13 @@
 
 #define atomic_swap(a,b) xchg((int*)a.counter,b)
 
-#define SYNC_MEMORY if (q->siga_sync) qdio_siga_sync(q)
+/* unlikely as the later the better */
+#define SYNC_MEMORY if (unlikely(q->siga_sync)) qdio_siga_sync_q(q)
+#define SYNC_MEMORY_ALL if (unlikely(q->siga_sync)) \
+	qdio_siga_sync(q,~0U,~0U)
+#define SYNC_MEMORY_ALL_OUTB if (unlikely(q->siga_sync)) \
+	qdio_siga_sync(q,~0U,0)
+
 #define NOW qdio_get_micros()
 #define SAVE_TIMESTAMP(q) q->timing.last_transfer_time=NOW
 #define GET_SAVED_TIMESTAMP(q) (q->timing.last_transfer_time)
@@ -519,6 +525,7 @@
 	struct ccw_device *cdev;
 
 	unsigned int is_iqdio_q;
+	unsigned int is_thinint_q;
 
 	/* bit 0 means queue 0, bit 1 means queue 1, ... */
 	unsigned int mask;
@@ -540,6 +547,7 @@
 	unsigned int siga_out;
 	unsigned int siga_sync;
 	unsigned int siga_sync_done_on_thinints;
+	unsigned int siga_sync_done_on_outb_tis;
 	unsigned int hydra_gives_outbound_pcis;
 
 	/* used to save beginning position when calling dd_handlers */
@@ -548,6 +556,8 @@
 	atomic_t use_count;
 	atomic_t is_in_shutdown;
 
+	void *irq_ptr;
+
 #ifdef QDIO_USE_TIMERS_FOR_POLLING
 	struct timer_list timer;
 	atomic_t timer_already_set;
@@ -604,6 +614,7 @@
 	int irq;
 
 	unsigned int is_iqdio_irq;
+	unsigned int is_thinint_irq;
 	unsigned int hydra_gives_outbound_pcis;
 	unsigned int sync_done_on_outb_pcis;
 
