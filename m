Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVLIP1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVLIP1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbVLIP1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:27:55 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:9153 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964774AbVLIP1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:27:51 -0500
Date: Fri, 9 Dec 2005 16:27:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, pavlic@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 11/17] s390: qdio V=V pass-through.
Message-ID: <20051209152746.GL6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Pavlic <pavlic@de.ibm.com>

[patch 11/17] s390: qdio V=V pass-through.

New feature V=V qdio pass-through.
QDIO and HiperSockets processing in z/VM V=V guest environments
(as well as V=R with z/VM running in LPAR mode) requires shadowing
of all QDIO architecture queue elements. Especially the shadowing of
SBALs and SLSBs structures in the hypervisor, and the need to issue
SIGA SYNC operations to observe state changes, eventually causes
significant CPU processing overhead in the hypervisor. The QDIO
pass-through support for V=V guests avoids the shadowing of SBALs
and SLSBs. This significantly reduces the hypervisor overhead for
QDIO based I/O.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/Kconfig       |    7 
 drivers/s390/cio/chsc.h |    4 
 drivers/s390/cio/qdio.c |  591 ++++++++++++++++++++++++++++++++++++++----------
 drivers/s390/cio/qdio.h |  104 +++++---
 include/asm-s390/qdio.h |    8 
 5 files changed, 557 insertions(+), 157 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2005-12-09 14:25:51.000000000 +0100
@@ -240,8 +240,8 @@ config MACHCHK_WARNING
 config QDIO
 	tristate "QDIO support"
 	---help---
-	  This driver provides the Queued Direct I/O base support for the
-	  IBM S/390 (G5 and G6) and eServer zSeries (z800, z890, z900 and z990).
+	  This driver provides the Queued Direct I/O base support for
+	  IBM mainframes.
 
 	  For details please refer to the documentation provided by IBM at
 	  <http://www10.software.ibm.com/developerworks/opensource/linux390>
@@ -263,7 +263,8 @@ config QDIO_DEBUG
 	bool "Extended debugging information"
 	depends on QDIO
 	help
-	  Say Y here to get extended debugging output in /proc/s390dbf/qdio...
+	  Say Y here to get extended debugging output in
+	    /sys/kernel/debug/s390dbf/qdio...
 	  Warning: this option reduces the performance of the QDIO module.
 
 	  If unsure, say N.
diff -urpN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2005-12-09 14:25:51.000000000 +0100
@@ -43,7 +43,9 @@ struct css_general_char {
 	u32 ext_mb : 1;  /* bit 48 */
 	u32 : 7;
 	u32 aif_tdd : 1; /* bit 56 */
-	u32 : 10;
+	u32 : 1;
+	u32 qebsm : 1;   /* bit 58 */
+	u32 : 8;
 	u32 aif_osa : 1; /* bit 67 */
 	u32 : 28;
 }__attribute__((packed));
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-12-09 14:21:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-12-09 14:25:51.000000000 +0100
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.108 $"
+#define VERSION_QDIO_C "$Revision: 1.113 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -76,6 +76,7 @@ static struct qdio_perf_stats perf_stats
 #endif /* QDIO_PERFORMANCE_STATS */
 
 static int hydra_thinints;
+static int is_passthrough = 0;
 static int omit_svs;
 
 static int indicator_used[INDICATORS_PER_CACHELINE];
@@ -136,12 +137,126 @@ qdio_release_q(struct qdio_q *q)
 	atomic_dec(&q->use_count);
 }
 
-static volatile inline void 
-qdio_set_slsb(volatile char *slsb, unsigned char value)
+/*check ccq  */
+static inline int
+qdio_check_ccq(struct qdio_q *q, unsigned int ccq)
 {
-	xchg((char*)slsb,value);
+	char dbf_text[15];
+
+	if (ccq == 0 || ccq == 32 || ccq == 96)
+		return 0;
+	if (ccq == 97)
+		return 1;
+	/*notify devices immediately*/
+	sprintf(dbf_text,"%d", ccq);
+	QDIO_DBF_TEXT2(1,trace,dbf_text);
+	return -EIO;
 }
+/* EQBS: extract buffer states */
+static inline int
+qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
+	     unsigned int *start, unsigned int *cnt)
+{
+	struct qdio_irq *irq;
+	unsigned int tmp_cnt, q_no, ccq;
+	int rc ;
+	char dbf_text[15];
+
+	ccq = 0;
+	tmp_cnt = *cnt;
+	irq = (struct qdio_irq*)q->irq_ptr;
+	q_no = q->q_no;
+	if(!q->is_input_q)
+		q_no += irq->no_input_qs;
+	ccq = do_eqbs(irq->sch_token, state, q_no, start, cnt);
+	rc = qdio_check_ccq(q, ccq);
+	if (rc < 0) {
+                QDIO_DBF_TEXT2(1,trace,"eqberr");
+                sprintf(dbf_text,"%2x,%2x,%d,%d",tmp_cnt, *cnt, ccq, q_no);
+                QDIO_DBF_TEXT2(1,trace,dbf_text);
+		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
+				QDIO_STATUS_LOOK_FOR_ERROR,
+				0, 0, 0, -1, -1, q->int_parm);
+		return 0;
+	}
+	return (tmp_cnt - *cnt);
+}
+
+/* SQBS: set buffer states */
+static inline int
+qdio_do_sqbs(struct qdio_q *q, unsigned char state,
+	     unsigned int *start, unsigned int *cnt)
+{
+	struct qdio_irq *irq;
+	unsigned int tmp_cnt, q_no, ccq;
+	int rc;
+	char dbf_text[15];
 
+	ccq = 0;
+	tmp_cnt = *cnt;
+	irq = (struct qdio_irq*)q->irq_ptr;
+	q_no = q->q_no;
+	if(!q->is_input_q)
+		q_no += irq->no_input_qs;
+	ccq = do_sqbs(irq->sch_token, state, q_no, start, cnt);
+	rc = qdio_check_ccq(q, ccq);
+	if (rc < 0) {
+                QDIO_DBF_TEXT3(1,trace,"sqberr");
+                sprintf(dbf_text,"%2x,%2x,%d,%d",tmp_cnt,*cnt,ccq,q_no);
+                QDIO_DBF_TEXT3(1,trace,dbf_text);
+		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
+				QDIO_STATUS_LOOK_FOR_ERROR,
+				0, 0, 0, -1, -1, q->int_parm);
+		return 0;
+	}
+	return (tmp_cnt - *cnt);
+}
+
+static inline int
+qdio_set_slsb(struct qdio_q *q, unsigned int *bufno,
+	      unsigned char state, unsigned int *count)
+{
+	volatile char *slsb;
+	struct qdio_irq *irq;
+
+	irq = (struct qdio_irq*)q->irq_ptr;
+	if (!irq->is_qebsm) {
+		slsb = (char *)&q->slsb.acc.val[(*bufno)];
+		xchg(slsb, state);
+		return 1;
+	}
+	return qdio_do_sqbs(q, state, bufno, count);
+}
+
+#ifdef CONFIG_QDIO_DEBUG
+static inline void
+qdio_trace_slsb(struct qdio_q *q)
+{
+	if (q->queue_type==QDIO_TRACE_QTYPE) {
+		if (q->is_input_q)
+			QDIO_DBF_HEX2(0,slsb_in,&q->slsb,
+				      QDIO_MAX_BUFFERS_PER_Q);
+		else
+			QDIO_DBF_HEX2(0,slsb_out,&q->slsb,
+				      QDIO_MAX_BUFFERS_PER_Q);
+	}
+}
+#endif
+
+static inline int
+set_slsb(struct qdio_q *q, unsigned int *bufno,
+	 unsigned char state, unsigned int *count)
+{
+	int rc;
+#ifdef CONFIG_QDIO_DEBUG
+	qdio_trace_slsb(q);
+#endif
+	rc = qdio_set_slsb(q, bufno, state, count);
+#ifdef CONFIG_QDIO_DEBUG
+	qdio_trace_slsb(q);
+#endif
+	return rc;
+}
 static inline int 
 qdio_siga_sync(struct qdio_q *q, unsigned int gpr2,
 	       unsigned int gpr3)
@@ -155,7 +270,7 @@ qdio_siga_sync(struct qdio_q *q, unsigne
 	perf_stats.siga_syncs++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
-	cc = do_siga_sync(q->irq, gpr2, gpr3);
+	cc = do_siga_sync(0x10000|q->irq, gpr2, gpr3);
 	if (cc)
 		QDIO_DBF_HEX3(0,trace,&cc,sizeof(int*));
 
@@ -170,6 +285,19 @@ qdio_siga_sync_q(struct qdio_q *q)
 	return qdio_siga_sync(q, q->mask, 0);
 }
 
+static int
+__do_siga_output(struct qdio_q *q, unsigned int *busy_bit)
+{
+       struct qdio_irq *irq;
+       unsigned int fc = 0;
+
+       irq = (struct qdio_irq *) q->irq_ptr;
+       if (!irq->is_qebsm)
+               return do_siga_output(0x10000|q->irq, q->mask, busy_bit, fc);
+       fc |= 0x80;
+       return do_siga_output(irq->sch_token, q->mask, busy_bit, fc);
+}
+
 /* 
  * returns QDIO_SIGA_ERROR_ACCESS_EXCEPTION as cc, when SIGA returns
  * an access exception 
@@ -189,7 +317,7 @@ qdio_siga_output(struct qdio_q *q)
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
 	for (;;) {
-		cc = do_siga_output(q->irq, q->mask, &busy_bit);
+		cc = __do_siga_output(q, &busy_bit);
 //QDIO_PRINT_ERR("cc=%x, busy=%x\n",cc,busy_bit);
 		if ((cc==2) && (busy_bit) && (q->is_iqdio_q)) {
 			if (!start_time) 
@@ -221,7 +349,7 @@ qdio_siga_input(struct qdio_q *q)
 	perf_stats.siga_ins++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
-	cc = do_siga_input(q->irq, q->mask);
+	cc = do_siga_input(0x10000|q->irq, q->mask);
 	
 	if (cc)
 		QDIO_DBF_HEX3(0,trace,&cc,sizeof(int*));
@@ -230,7 +358,7 @@ qdio_siga_input(struct qdio_q *q)
 }
 
 /* locked by the locks in qdio_activate and qdio_cleanup */
-static __u32 volatile *
+static __u32 *
 qdio_get_indicator(void)
 {
 	int i;
@@ -258,7 +386,7 @@ qdio_put_indicator(__u32 *addr)
 		atomic_dec(&spare_indicator_usecount);
 }
 
-static inline volatile void 
+static inline void
 tiqdio_clear_summary_bit(__u32 *location)
 {
 	QDIO_DBF_TEXT5(0,trace,"clrsummb");
@@ -267,7 +395,7 @@ tiqdio_clear_summary_bit(__u32 *location
 	xchg(location,0);
 }
 
-static inline volatile void
+static inline  void
 tiqdio_set_summary_bit(__u32 *location)
 {
 	QDIO_DBF_TEXT5(0,trace,"setsummb");
@@ -336,7 +464,9 @@ static inline int
 qdio_stop_polling(struct qdio_q *q)
 {
 #ifdef QDIO_USE_PROCESSING_STATE
-	int gsf;
+       unsigned int tmp, gsf, count = 1;
+       unsigned char state = 0;
+       struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
 
 	if (!atomic_swap(&q->polling,0)) 
 		return 1;
@@ -348,17 +478,22 @@ qdio_stop_polling(struct qdio_q *q)
 	if (!q->is_input_q)
 		return 1;
 
-	gsf=GET_SAVED_FRONTIER(q);
-	set_slsb(&q->slsb.acc.val[(gsf+QDIO_MAX_BUFFERS_PER_Q-1)&
-				  (QDIO_MAX_BUFFERS_PER_Q-1)],
-		 SLSB_P_INPUT_NOT_INIT);
+       tmp = gsf = GET_SAVED_FRONTIER(q);
+       tmp = ((tmp + QDIO_MAX_BUFFERS_PER_Q-1) & (QDIO_MAX_BUFFERS_PER_Q-1) );
+       set_slsb(q, &tmp, SLSB_P_INPUT_NOT_INIT, &count);
+
 	/* 
 	 * we don't issue this SYNC_MEMORY, as we trust Rick T and
 	 * moreover will not use the PROCESSING state under VM, so
 	 * q->polling was 0 anyway
 	 */
 	/*SYNC_MEMORY;*/
-	if (q->slsb.acc.val[gsf]!=SLSB_P_INPUT_PRIMED)
+       if (irq->is_qebsm) {
+               count = 1;
+               qdio_do_eqbs(q, &state, &gsf, &count);
+       } else
+               state = q->slsb.acc.val[gsf];
+       if (state != SLSB_P_INPUT_PRIMED)
 		return 1;
 	/* 
 	 * set our summary bit again, as otherwise there is a
@@ -431,18 +566,136 @@ tiqdio_clear_global_summary(void)
 
 
 /************************* OUTBOUND ROUTINES *******************************/
+static int
+qdio_qebsm_get_outbound_buffer_frontier(struct qdio_q *q)
+{
+        struct qdio_irq *irq;
+        unsigned char state;
+        unsigned int cnt, count, ftc;
+
+        irq = (struct qdio_irq *) q->irq_ptr;
+        if ((!q->is_iqdio_q) && (!q->hydra_gives_outbound_pcis))
+                SYNC_MEMORY;
+
+        ftc = q->first_to_check;
+        count = qdio_min(atomic_read(&q->number_of_buffers_used),
+                        (QDIO_MAX_BUFFERS_PER_Q-1));
+        if (count == 0)
+                return q->first_to_check;
+        cnt = qdio_do_eqbs(q, &state, &ftc, &count);
+        if (cnt == 0)
+                return q->first_to_check;
+        switch (state) {
+        case SLSB_P_OUTPUT_ERROR:
+                QDIO_DBF_TEXT3(0,trace,"outperr");
+                atomic_sub(cnt , &q->number_of_buffers_used);
+                if (q->qdio_error)
+                        q->error_status_flags |=
+                                QDIO_STATUS_MORE_THAN_ONE_QDIO_ERROR;
+                q->qdio_error = SLSB_P_OUTPUT_ERROR;
+                q->error_status_flags |= QDIO_STATUS_LOOK_FOR_ERROR;
+                q->first_to_check = ftc;
+                break;
+        case SLSB_P_OUTPUT_EMPTY:
+                QDIO_DBF_TEXT5(0,trace,"outpempt");
+                atomic_sub(cnt, &q->number_of_buffers_used);
+                q->first_to_check = ftc;
+                break;
+        case SLSB_CU_OUTPUT_PRIMED:
+                /* all buffers primed */
+                QDIO_DBF_TEXT5(0,trace,"outpprim");
+                break;
+        default:
+                break;
+        }
+        QDIO_DBF_HEX4(0,trace,&q->first_to_check,sizeof(int));
+        return q->first_to_check;
+}
+
+static int
+qdio_qebsm_get_inbound_buffer_frontier(struct qdio_q *q)
+{
+        struct qdio_irq *irq;
+        unsigned char state;
+        int tmp, ftc, count, cnt;
+        char dbf_text[15];
+
+
+        irq = (struct qdio_irq *) q->irq_ptr;
+        ftc = q->first_to_check;
+        count = qdio_min(atomic_read(&q->number_of_buffers_used),
+                        (QDIO_MAX_BUFFERS_PER_Q-1));
+        if (count == 0)
+                 return q->first_to_check;
+        cnt = qdio_do_eqbs(q, &state, &ftc, &count);
+        if (cnt == 0)
+                 return q->first_to_check;
+        switch (state) {
+        case SLSB_P_INPUT_ERROR :
+#ifdef CONFIG_QDIO_DEBUG
+                QDIO_DBF_TEXT3(1,trace,"inperr");
+                sprintf(dbf_text,"%2x,%2x",ftc,count);
+                QDIO_DBF_TEXT3(1,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
+                if (q->qdio_error)
+                        q->error_status_flags |=
+                                QDIO_STATUS_MORE_THAN_ONE_QDIO_ERROR;
+                q->qdio_error = SLSB_P_INPUT_ERROR;
+                q->error_status_flags |= QDIO_STATUS_LOOK_FOR_ERROR;
+                atomic_sub(cnt, &q->number_of_buffers_used);
+                q->first_to_check = ftc;
+                break;
+        case SLSB_P_INPUT_PRIMED :
+                QDIO_DBF_TEXT3(0,trace,"inptprim");
+                sprintf(dbf_text,"%2x,%2x",ftc,count);
+                QDIO_DBF_TEXT3(1,trace,dbf_text);
+                tmp = 0;
+                ftc = q->first_to_check;
+#ifdef QDIO_USE_PROCESSING_STATE
+		if (cnt > 1) {
+			cnt -= 1;
+			tmp = set_slsb(q, &ftc, SLSB_P_INPUT_NOT_INIT, &cnt);
+			if (!tmp)
+				break;
+		}
+		cnt = 1;
+		tmp += set_slsb(q, &ftc,
+			       SLSB_P_INPUT_PROCESSING, &cnt);
+		atomic_set(&q->polling, 1);
+#else
+                tmp = set_slsb(q, &ftc, SLSB_P_INPUT_NOT_INIT, &cnt);
+#endif
+                atomic_sub(tmp, &q->number_of_buffers_used);
+                q->first_to_check = ftc;
+                break;
+        case SLSB_CU_INPUT_EMPTY:
+        case SLSB_P_INPUT_NOT_INIT:
+        case SLSB_P_INPUT_PROCESSING:
+                QDIO_DBF_TEXT5(0,trace,"inpnipro");
+                break;
+        default:
+                break;
+        }
+        QDIO_DBF_HEX4(0,trace,&q->first_to_check,sizeof(int));
+        return q->first_to_check;
+}
 
 static inline int
 qdio_get_outbound_buffer_frontier(struct qdio_q *q)
 {
-	int f,f_mod_no;
-	volatile char *slsb;
-	int first_not_to_check;
+	struct qdio_irq *irq;
+        volatile char *slsb;
+        unsigned int count = 1;
+        int first_not_to_check, f, f_mod_no;
 	char dbf_text[15];
 
 	QDIO_DBF_TEXT4(0,trace,"getobfro");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
+	irq = (struct qdio_irq *) q->irq_ptr;
+	if (irq->is_qebsm)
+		return qdio_qebsm_get_outbound_buffer_frontier(q);
+
 	slsb=&q->slsb.acc.val[0];
 	f_mod_no=f=q->first_to_check;
 	/* 
@@ -484,7 +737,7 @@ check_next:
 		QDIO_DBF_HEX2(1,sbal,q->sbal[f_mod_no],256);
 
 		/* kind of process the buffer */
-		set_slsb(&q->slsb.acc.val[f_mod_no], SLSB_P_OUTPUT_NOT_INIT);
+		set_slsb(q, &f_mod_no, SLSB_P_OUTPUT_NOT_INIT, &count);
 
 		/* 
 		 * we increment the frontier, as this buffer
@@ -597,48 +850,48 @@ qdio_kick_outbound_q(struct qdio_q *q)
 
 	result=qdio_siga_output(q);
 
-		switch (result) {
-		case 0:
-			/* went smooth this time, reset timestamp */
-#ifdef CONFIG_QDIO_DEBUG
-			QDIO_DBF_TEXT3(0,trace,"cc2reslv");
-			sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
-				atomic_read(&q->busy_siga_counter));
-			QDIO_DBF_TEXT3(0,trace,dbf_text);
+	switch (result) {
+	case 0:
+		/* went smooth this time, reset timestamp */
+#ifdef CONFIG_QDIO_DEBUG
+		QDIO_DBF_TEXT3(0,trace,"cc2reslv");
+		sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
+			atomic_read(&q->busy_siga_counter));
+		QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
-			q->timing.busy_start=0;
+		q->timing.busy_start=0;
+		break;
+	case (2|QDIO_SIGA_ERROR_B_BIT_SET):
+		/* cc=2 and busy bit: */
+		atomic_inc(&q->busy_siga_counter);
+
+		/* if the last siga was successful, save
+		 * timestamp here */
+		if (!q->timing.busy_start)
+			q->timing.busy_start=NOW;
+
+		/* if we're in time, don't touch error_status_flags
+		 * and siga_error */
+		if (NOW-q->timing.busy_start<QDIO_BUSY_BIT_GIVE_UP) {
+			qdio_mark_q(q);
 			break;
-		case (2|QDIO_SIGA_ERROR_B_BIT_SET):
-			/* cc=2 and busy bit: */
-			atomic_inc(&q->busy_siga_counter);
-
-			/* if the last siga was successful, save
-			 * timestamp here */
-			if (!q->timing.busy_start)
-				q->timing.busy_start=NOW;
-
-			/* if we're in time, don't touch error_status_flags
-			 * and siga_error */
-			if (NOW-q->timing.busy_start<QDIO_BUSY_BIT_GIVE_UP) {
-				qdio_mark_q(q);
-				break;
-			}
-			QDIO_DBF_TEXT2(0,trace,"cc2REPRT");
+		}
+		QDIO_DBF_TEXT2(0,trace,"cc2REPRT");
 #ifdef CONFIG_QDIO_DEBUG
-			sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
-				atomic_read(&q->busy_siga_counter));
-			QDIO_DBF_TEXT3(0,trace,dbf_text);
+		sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
+			atomic_read(&q->busy_siga_counter));
+		QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
-			/* else fallthrough and report error */
-		default:
-			/* for plain cc=1, 2 or 3: */
-			if (q->siga_error)
-				q->error_status_flags|=
-					QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR;
+		/* else fallthrough and report error */
+	default:
+		/* for plain cc=1, 2 or 3: */
+		if (q->siga_error)
 			q->error_status_flags|=
-				QDIO_STATUS_LOOK_FOR_ERROR;
-			q->siga_error=result;
-		}
+				QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR;
+		q->error_status_flags|=
+			QDIO_STATUS_LOOK_FOR_ERROR;
+		q->siga_error=result;
+	}
 }
 
 static inline void
@@ -743,8 +996,10 @@ qdio_outbound_processing(struct qdio_q *
 static inline int
 qdio_get_inbound_buffer_frontier(struct qdio_q *q)
 {
+	struct qdio_irq *irq;
 	int f,f_mod_no;
 	volatile char *slsb;
+	unsigned int count = 1;
 	int first_not_to_check;
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
@@ -756,6 +1011,10 @@ qdio_get_inbound_buffer_frontier(struct 
 	QDIO_DBF_TEXT4(0,trace,"getibfro");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
+	irq = (struct qdio_irq *) q->irq_ptr;
+	if (irq->is_qebsm)
+		return qdio_qebsm_get_inbound_buffer_frontier(q);
+
 	slsb=&q->slsb.acc.val[0];
 	f_mod_no=f=q->first_to_check;
 	/* 
@@ -792,19 +1051,19 @@ check_next:
 		 * kill VM in terms of CP overhead 
 		 */
 		if (q->siga_sync) {
-			set_slsb(&slsb[f_mod_no],SLSB_P_INPUT_NOT_INIT);
+			set_slsb(q, &f_mod_no, SLSB_P_INPUT_NOT_INIT, &count);
 		} else {
 			/* set the previous buffer to NOT_INIT. The current
 			 * buffer will be set to PROCESSING at the end of
 			 * this function to avoid further interrupts. */
 			if (last_position>=0)
-				set_slsb(&slsb[last_position],
-					 SLSB_P_INPUT_NOT_INIT);
+				set_slsb(q, &last_position,
+					 SLSB_P_INPUT_NOT_INIT, &count);
 			atomic_set(&q->polling,1);
 			last_position=f_mod_no;
 		}
 #else /* QDIO_USE_PROCESSING_STATE */
-		set_slsb(&slsb[f_mod_no],SLSB_P_INPUT_NOT_INIT);
+		set_slsb(q, &f_mod_no, SLSB_P_INPUT_NOT_INIT, &count);
 #endif /* QDIO_USE_PROCESSING_STATE */
 		/* 
 		 * not needed, as the inbound queue will be synced on the next
@@ -829,7 +1088,7 @@ check_next:
 		QDIO_DBF_HEX2(1,sbal,q->sbal[f_mod_no],256);
 
 		/* kind of process the buffer */
-		set_slsb(&slsb[f_mod_no],SLSB_P_INPUT_NOT_INIT);
+		set_slsb(q, &f_mod_no, SLSB_P_INPUT_NOT_INIT, &count);
 
 		if (q->qdio_error)
 			q->error_status_flags|=
@@ -857,7 +1116,7 @@ out:
 
 #ifdef QDIO_USE_PROCESSING_STATE
 	if (last_position>=0)
-		set_slsb(&slsb[last_position],SLSB_P_INPUT_PROCESSING);
+		set_slsb(q, &last_position, SLSB_P_INPUT_NOT_INIT, &count);
 #endif /* QDIO_USE_PROCESSING_STATE */
 
 	QDIO_DBF_HEX4(0,trace,&q->first_to_check,sizeof(int));
@@ -902,6 +1161,10 @@ static inline int
 tiqdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
+	unsigned int start_buf, count;
+	unsigned char state = 0;
+	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
 #endif
@@ -927,8 +1190,13 @@ tiqdio_is_inbound_q_done(struct qdio_q *
 	if (!q->siga_sync)
 		/* we'll check for more primed buffers in qeth_stop_polling */
 		return 0;
-
-	if (q->slsb.acc.val[q->first_to_check]!=SLSB_P_INPUT_PRIMED)
+	if (irq->is_qebsm) {
+		count = 1;
+		start_buf = q->first_to_check;
+		qdio_do_eqbs(q, &state, &start_buf, &count);
+	} else
+		state = q->slsb.acc.val[q->first_to_check];
+	if (state != SLSB_P_INPUT_PRIMED)
 		/* 
 		 * nothing more to do, if next buffer is not PRIMED.
 		 * note that we did a SYNC_MEMORY before, that there
@@ -955,6 +1223,10 @@ static inline int
 qdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
+	unsigned int start_buf, count;
+	unsigned char state = 0;
+	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
 #endif
@@ -973,8 +1245,13 @@ qdio_is_inbound_q_done(struct qdio_q *q)
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
 		return 1;
 	}
-
-	if (q->slsb.acc.val[q->first_to_check]==SLSB_P_INPUT_PRIMED) {
+	if (irq->is_qebsm) {
+		count = 1;
+		start_buf = q->first_to_check;
+		qdio_do_eqbs(q, &state, &start_buf, &count);
+	} else
+		state = q->slsb.acc.val[q->first_to_check];
+	if (state == SLSB_P_INPUT_PRIMED) {
 		/* we got something to do */
 		QDIO_DBF_TEXT4(0,trace,"inqisntA");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
@@ -1523,11 +1800,11 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 		QDIO_DBF_HEX2(0,setup,&ptr,sizeof(void*));
 
 		/* fill in slsb */
-		for (j=0;j<QDIO_MAX_BUFFERS_PER_Q;j++) {
-			set_slsb(&q->slsb.acc.val[j],
-		   		 SLSB_P_INPUT_NOT_INIT);
-/*			q->sbal[j]->element[1].sbalf.i1.key=QDIO_STORAGE_KEY;*/
-		}
+		if (!irq_ptr->is_qebsm) {
+                        unsigned int count = 1;
+                        for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++)
+                                set_slsb(q, &j, SLSB_P_INPUT_NOT_INIT, &count);
+                }
 	}
 
 	for (i=0;i<no_output_qs;i++) {
@@ -1584,11 +1861,11 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 		QDIO_DBF_HEX2(0,setup,&ptr,sizeof(void*));
 
 		/* fill in slsb */
-		for (j=0;j<QDIO_MAX_BUFFERS_PER_Q;j++) {
-			set_slsb(&q->slsb.acc.val[j],
-		   		 SLSB_P_OUTPUT_NOT_INIT);
-/*			q->sbal[j]->element[1].sbalf.i1.key=QDIO_STORAGE_KEY;*/
-		}
+                if (!irq_ptr->is_qebsm) {
+                        unsigned int count = 1;
+                        for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++)
+                                set_slsb(q, &j, SLSB_P_OUTPUT_NOT_INIT, &count);
+                }
 	}
 }
 
@@ -1905,7 +2182,7 @@ int
 qdio_synchronize(struct ccw_device *cdev, unsigned int flags,
 		 unsigned int queue_number)
 {
-	int cc;
+	int cc = 0;
 	struct qdio_q *q;
 	struct qdio_irq *irq_ptr;
 	void *ptr;
@@ -1929,12 +2206,14 @@ qdio_synchronize(struct ccw_device *cdev
 		q=irq_ptr->input_qs[queue_number];
 		if (!q)
 			return -EINVAL;
-		cc = do_siga_sync(q->irq, 0, q->mask);
+		if (!(irq_ptr->is_qebsm))
+			cc = do_siga_sync(0x10000|q->irq, 0, q->mask);
 	} else if (flags&QDIO_FLAG_SYNC_OUTPUT) {
 		q=irq_ptr->output_qs[queue_number];
 		if (!q)
 			return -EINVAL;
-		cc = do_siga_sync(q->irq, q->mask, 0);
+		if (!(irq_ptr->is_qebsm))
+			cc = do_siga_sync(0x10000|q->irq, q->mask, 0);
 	} else 
 		return -EINVAL;
 
@@ -1945,12 +2224,49 @@ qdio_synchronize(struct ccw_device *cdev
 	return cc;
 }
 
-static unsigned char
-qdio_check_siga_needs(int sch)
+static inline void
+qdio_check_subchannel_qebsm(struct qdio_irq *irq_ptr, unsigned char qdioac,
+			    unsigned long token)
+{
+	struct qdio_q *q;
+	int i;
+	unsigned int count, start_buf;
+	char dbf_text[15];
+
+	/*check if QEBSM is disabled */
+	if (!(irq_ptr->is_qebsm) || !(qdioac & 0x01)) {
+		irq_ptr->is_qebsm  = 0;
+		irq_ptr->sch_token = 0;
+		irq_ptr->qib.rflags &= ~QIB_RFLAGS_ENABLE_QEBSM;
+		QDIO_DBF_TEXT0(0,setup,"noV=V");
+		return;
+	}
+	irq_ptr->sch_token = token;
+	/*input queue*/
+	for (i = 0; i < irq_ptr->no_input_qs;i++) {
+		q = irq_ptr->input_qs[i];
+		count = QDIO_MAX_BUFFERS_PER_Q;
+		start_buf = 0;
+		set_slsb(q, &start_buf, SLSB_P_INPUT_NOT_INIT, &count);
+	}
+	sprintf(dbf_text,"V=V:%2x",irq_ptr->is_qebsm);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	sprintf(dbf_text,"%8lx",irq_ptr->sch_token);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	/*output queue*/
+	for (i = 0; i < irq_ptr->no_output_qs; i++) {
+		q = irq_ptr->output_qs[i];
+		count = QDIO_MAX_BUFFERS_PER_Q;
+		start_buf = 0;
+		set_slsb(q, &start_buf, SLSB_P_OUTPUT_NOT_INIT, &count);
+	}
+}
+
+static void
+qdio_get_ssqd_information(struct qdio_irq *irq_ptr)
 {
 	int result;
 	unsigned char qdioac;
-
 	struct {
 		struct chsc_header request;
 		u16 reserved1;
@@ -1964,67 +2280,80 @@ qdio_check_siga_needs(int sch)
 		u8  reserved5;
 		u16 sch;
 		u8  qfmt;
-		u8  reserved6;
-		u8  qdioac;
+		u8  parm;
+		u8  qdioac1;
 		u8  sch_class;
 		u8  reserved7;
 		u8  icnt;
 		u8  reserved8;
 		u8  ocnt;
+		u8 reserved9;
+		u8 mbccnt;
+		u16 qdioac2;
+		u64 sch_token;
 	} *ssqd_area;
 
+	QDIO_DBF_TEXT0(0,setup,"getssqd");
+	qdioac = 0;
 	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!ssqd_area) {
 	        QDIO_PRINT_WARN("Could not get memory for chsc. Using all " \
-				"SIGAs for sch x%x.\n", sch);
-		return CHSC_FLAG_SIGA_INPUT_NECESSARY ||
-			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
-			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
+				"SIGAs for sch x%x.\n", irq_ptr->irq);
+		irq_ptr->qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
+				  CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
+				  CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
+		irq_ptr->is_qebsm = 0;
+		irq_ptr->sch_token = 0;
+		irq_ptr->qib.rflags &= ~QIB_RFLAGS_ENABLE_QEBSM;
+		return;
 	}
+
 	ssqd_area->request = (struct chsc_header) {
 		.length = 0x0010,
 		.code   = 0x0024,
 	};
-
-	ssqd_area->first_sch = sch;
-	ssqd_area->last_sch = sch;
-
-	result=chsc(ssqd_area);
+	ssqd_area->first_sch = irq_ptr->irq;
+	ssqd_area->last_sch = irq_ptr->irq;
+	result = chsc(ssqd_area);
 
 	if (result) {
 		QDIO_PRINT_WARN("CHSC returned cc %i. Using all " \
 				"SIGAs for sch x%x.\n",
-				result,sch);
+				result, irq_ptr->irq);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
+		irq_ptr->is_qebsm  = 0;
 		goto out;
 	}
 
 	if (ssqd_area->response.code != QDIO_CHSC_RESPONSE_CODE_OK) {
 		QDIO_PRINT_WARN("response upon checking SIGA needs " \
 				"is 0x%x. Using all SIGAs for sch x%x.\n",
-				ssqd_area->response.code, sch);
+				ssqd_area->response.code, irq_ptr->irq);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
+		irq_ptr->is_qebsm  = 0;
 		goto out;
 	}
 	if (!(ssqd_area->flags & CHSC_FLAG_QDIO_CAPABILITY) ||
 	    !(ssqd_area->flags & CHSC_FLAG_VALIDITY) ||
-	    (ssqd_area->sch != sch)) {
+	    (ssqd_area->sch != irq_ptr->irq)) {
 		QDIO_PRINT_WARN("huh? problems checking out sch x%x... " \
-				"using all SIGAs.\n",sch);
+				"using all SIGAs.\n",irq_ptr->irq);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY |
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY |
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* worst case */
+		irq_ptr->is_qebsm  = 0;
 		goto out;
 	}
-
-	qdioac = ssqd_area->qdioac;
+	qdioac = ssqd_area->qdioac1;
 out:
+	qdio_check_subchannel_qebsm(irq_ptr, qdioac,
+				    ssqd_area->sch_token);
 	free_page ((unsigned long) ssqd_area);
-	return qdioac;
+	irq_ptr->qdioac = qdioac;
 }
 
 static unsigned int
@@ -2055,6 +2384,13 @@ tiqdio_check_chsc_availability(void)
 	sprintf(dbf_text,"hydrati%1x", hydra_thinints);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
+#ifdef CONFIG_ARCH_S390X
+	/* Check for QEBSM support in general (bit 58). */
+	is_passthrough = css_general_characteristics.qebsm;
+#endif
+	sprintf(dbf_text,"cssQBS:%1x", is_passthrough);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+
 	/* Check for aif time delay disablement fac (bit 56). If installed,
 	 * omit svs even under lpar (good point by rick again) */
 	omit_svs = css_general_characteristics.aif_tdd;
@@ -2698,7 +3034,7 @@ int qdio_fill_irq(struct qdio_initialize
 	QDIO_DBF_TEXT2(0,setup,dbf_text);
 
 	if (irq_ptr->is_thinint_irq) {
-		irq_ptr->dev_st_chg_ind=qdio_get_indicator();
+		irq_ptr->dev_st_chg_ind = qdio_get_indicator();
 		QDIO_DBF_HEX1(0,setup,&irq_ptr->dev_st_chg_ind,sizeof(void*));
 		if (!irq_ptr->dev_st_chg_ind) {
 			QDIO_PRINT_WARN("no indicator location available " \
@@ -2747,6 +3083,10 @@ int qdio_fill_irq(struct qdio_initialize
 	irq_ptr->qdr->qkey=QDIO_STORAGE_KEY;
 
 	/* fill in qib */
+	irq_ptr->is_qebsm = is_passthrough;
+	if (irq_ptr->is_qebsm)
+		irq_ptr->qib.rflags |= QIB_RFLAGS_ENABLE_QEBSM;
+
 	irq_ptr->qib.qfmt=init_data->q_format;
 	if (init_data->no_input_qs)
 		irq_ptr->qib.isliba=(unsigned long)(irq_ptr->input_qs[0]->slib);
@@ -2884,7 +3224,7 @@ qdio_establish(struct qdio_initialize *i
 		return -EIO;
 	}
 
-	irq_ptr->qdioac=qdio_check_siga_needs(irq_ptr->irq);
+	qdio_get_ssqd_information(irq_ptr);
 	/* if this gets set once, we're running under VM and can omit SVSes */
 	if (irq_ptr->qdioac&CHSC_FLAG_SIGA_SYNC_NECESSARY)
 		omit_svs=1;
@@ -3015,30 +3355,40 @@ static inline void
 qdio_do_qdio_fill_input(struct qdio_q *q, unsigned int qidx,
 			unsigned int count, struct qdio_buffer *buffers)
 {
+	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+	qidx &= (QDIO_MAX_BUFFERS_PER_Q - 1);
+	if (irq->is_qebsm) {
+		while (count)
+			set_slsb(q, &qidx, SLSB_CU_INPUT_EMPTY, &count);
+		return;
+	}
 	for (;;) {
-		set_slsb(&q->slsb.acc.val[qidx],SLSB_CU_INPUT_EMPTY);
+		set_slsb(q, &qidx, SLSB_CU_INPUT_EMPTY, &count);
 		count--;
 		if (!count) break;
-		qidx=(qidx+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
+		qidx = (qidx + 1) & (QDIO_MAX_BUFFERS_PER_Q - 1);
 	}
-
-	/* not necessary, as the queues are synced during the SIGA read */
-	/*SYNC_MEMORY;*/
 }
 
 static inline void
 qdio_do_qdio_fill_output(struct qdio_q *q, unsigned int qidx,
 			 unsigned int count, struct qdio_buffer *buffers)
 {
+	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
+
+	qidx &= (QDIO_MAX_BUFFERS_PER_Q - 1);
+	if (irq->is_qebsm) {
+		while (count)
+			set_slsb(q, &qidx, SLSB_CU_OUTPUT_PRIMED, &count);
+		return;
+	}
+
 	for (;;) {
-		set_slsb(&q->slsb.acc.val[qidx],SLSB_CU_OUTPUT_PRIMED);
+		set_slsb(q, &qidx, SLSB_CU_OUTPUT_PRIMED, &count);
 		count--;
 		if (!count) break;
-		qidx=(qidx+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
+		qidx = (qidx + 1) & (QDIO_MAX_BUFFERS_PER_Q - 1);
 	}
-
-	/* SIGA write will sync the queues */
-	/*SYNC_MEMORY;*/
 }
 
 static inline void
@@ -3083,6 +3433,9 @@ do_qdio_handle_outbound(struct qdio_q *q
 			struct qdio_buffer *buffers)
 {
 	int used_elements;
+	unsigned int cnt, start_buf;
+	unsigned char state = 0;
+	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
 
 	/* This is the outbound handling of queues */
 #ifdef QDIO_PERFORMANCE_STATS
@@ -3115,9 +3468,15 @@ do_qdio_handle_outbound(struct qdio_q *q
 			 * SYNC_MEMORY :-/ ), we try to
 			 * fast-requeue buffers 
 			 */
-			if (q->slsb.acc.val[(qidx+QDIO_MAX_BUFFERS_PER_Q-1)
-					    &(QDIO_MAX_BUFFERS_PER_Q-1)]!=
-			    SLSB_CU_OUTPUT_PRIMED) {
+			if (irq->is_qebsm) {
+				cnt = 1;
+				start_buf = ((qidx+QDIO_MAX_BUFFERS_PER_Q-1) &
+					     (QDIO_MAX_BUFFERS_PER_Q-1));
+				qdio_do_eqbs(q, &state, &start_buf, &cnt);
+			} else
+				state = q->slsb.acc.val[(qidx+QDIO_MAX_BUFFERS_PER_Q-1)
+					&(QDIO_MAX_BUFFERS_PER_Q-1) ];
+			 if (state != SLSB_CU_OUTPUT_PRIMED) {
 				qdio_kick_outbound_q(q);
 			} else {
 				QDIO_DBF_TEXT3(0,trace, "fast-req");
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2005-12-09 14:21:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2005-12-09 14:25:51.000000000 +0100
@@ -3,14 +3,13 @@
 
 #include <asm/page.h>
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.33 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.37 $"
 
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
 #else /* CONFIG_QDIO_DEBUG */
 #define QDIO_VERBOSE_LEVEL 5
 #endif /* CONFIG_QDIO_DEBUG */
-
 #define QDIO_USE_PROCESSING_STATE
 
 #ifdef CONFIG_QDIO_PERF_STATS
@@ -265,6 +264,58 @@ QDIO_PRINT_##importance(header "%02x %02
 /*
  * Some instructions as assembly
  */
+
+static inline int
+do_sqbs(unsigned long sch, unsigned char state, int queue,
+       unsigned int *start, unsigned int *count)
+{
+#ifdef CONFIG_ARCH_S390X
+       register unsigned long _ccq asm ("0") = *count;
+       register unsigned long _sch asm ("1") = sch;
+       unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
+
+       asm volatile (
+              " .insn rsy,0xeb000000008A,%1,0,0(%2)\n\t"
+              : "+d" (_ccq), "+d" (_queuestart)
+              : "d" ((unsigned long)state), "d" (_sch)
+              : "memory", "cc"
+       );
+       *count = _ccq & 0xff;
+       *start = _queuestart & 0xff;
+
+       return (_ccq >> 32) & 0xff;
+#else
+       return 0;
+#endif
+}
+
+static inline int
+do_eqbs(unsigned long sch, unsigned char *state, int queue,
+	unsigned int *start, unsigned int *count)
+{
+#ifdef CONFIG_ARCH_S390X
+	register unsigned long _ccq asm ("0") = *count;
+	register unsigned long _sch asm ("1") = sch;
+	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
+	unsigned long _state = 0;
+
+	asm volatile (
+	      " .insn rrf,0xB99c0000,%1,%2,0,0  \n\t"
+	      : "+d" (_ccq), "+d" (_queuestart), "+d" (_state)
+	      : "d" (_sch)
+	      : "memory", "cc"
+	);
+	*count = _ccq & 0xff;
+	*start = _queuestart & 0xff;
+	*state = _state & 0xff;
+
+	return (_ccq >> 32) & 0xff;
+#else
+	return 0;
+#endif
+}
+
+
 static inline int
 do_siga_sync(unsigned int irq, unsigned int mask1, unsigned int mask2)
 {
@@ -280,7 +331,7 @@ do_siga_sync(unsigned int irq, unsigned 
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (0x10000|irq), "d" (mask1), "d" (mask2)
+		: "d" (irq), "d" (mask1), "d" (mask2)
 		: "cc", "0", "1", "2", "3"
 		);
 #else /* CONFIG_ARCH_S390X */
@@ -293,7 +344,7 @@ do_siga_sync(unsigned int irq, unsigned 
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (0x10000|irq), "d" (mask1), "d" (mask2)
+		: "d" (irq), "d" (mask1), "d" (mask2)
 		: "cc", "0", "1", "2", "3"
 		);
 #endif /* CONFIG_ARCH_S390X */
@@ -314,7 +365,7 @@ do_siga_input(unsigned int irq, unsigned
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (0x10000|irq), "d" (mask)
+		: "d" (irq), "d" (mask)
 		: "cc", "0", "1", "2", "memory"
 		);
 #else /* CONFIG_ARCH_S390X */
@@ -326,7 +377,7 @@ do_siga_input(unsigned int irq, unsigned
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (0x10000|irq), "d" (mask)
+		: "d" (irq), "d" (mask)
 		: "cc", "0", "1", "2", "memory"
 		);
 #endif /* CONFIG_ARCH_S390X */
@@ -335,7 +386,8 @@ do_siga_input(unsigned int irq, unsigned
 }
 
 static inline int
-do_siga_output(unsigned long irq, unsigned long mask, __u32 *bb)
+do_siga_output(unsigned long irq, unsigned long mask, __u32 *bb,
+	       unsigned int fc)
 {
 	int cc;
 	__u32 busy_bit;
@@ -366,14 +418,14 @@ do_siga_output(unsigned long irq, unsign
 		".long	0b,2b	\n\t"
 		".previous	\n\t"
 		: "=d" (cc), "=d" (busy_bit)
-		: "d" (0x10000|irq), "d" (mask),
+		: "d" (irq), "d" (mask),
 		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION)
 		: "cc", "0", "1", "2", "memory"
 		);
 #else /* CONFIG_ARCH_S390X */
 	asm volatile (
-		"lghi	0,0	\n\t"
-		"llgfr	1,%2	\n\t"
+        	"llgfr  0,%5    \n\t"
+                "lgr    1,%2    \n\t"
 		"llgfr	2,%3	\n\t"
 		"siga	0	\n\t"
 		"0:"
@@ -391,8 +443,8 @@ do_siga_output(unsigned long irq, unsign
 		".quad	0b,1b	\n\t"
 		".previous	\n\t"
 		: "=d" (cc), "=d" (busy_bit)
-		: "d" (0x10000|irq), "d" (mask),
-		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION)
+		: "d" (irq), "d" (mask),
+		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION), "d" (fc)
 		: "cc", "0", "1", "2", "memory"
 		);
 #endif /* CONFIG_ARCH_S390X */
@@ -494,33 +546,12 @@ struct qdio_perf_stats {
 #define QDIO_GET_ADDR(x) ((__u32)(long)x)
 #endif /* CONFIG_ARCH_S390X */
 
-#ifdef CONFIG_QDIO_DEBUG
-#define set_slsb(x,y) \
-  if(q->queue_type==QDIO_TRACE_QTYPE) { \
-        if(q->is_input_q) { \
-            QDIO_DBF_HEX2(0,slsb_in,&q->slsb,QDIO_MAX_BUFFERS_PER_Q); \
-        } else { \
-            QDIO_DBF_HEX2(0,slsb_out,&q->slsb,QDIO_MAX_BUFFERS_PER_Q); \
-        } \
-  } \
-  qdio_set_slsb(x,y); \
-  if(q->queue_type==QDIO_TRACE_QTYPE) { \
-        if(q->is_input_q) { \
-            QDIO_DBF_HEX2(0,slsb_in,&q->slsb,QDIO_MAX_BUFFERS_PER_Q); \
-        } else { \
-            QDIO_DBF_HEX2(0,slsb_out,&q->slsb,QDIO_MAX_BUFFERS_PER_Q); \
-        } \
-  }
-#else /* CONFIG_QDIO_DEBUG */
-#define set_slsb(x,y) qdio_set_slsb(x,y)
-#endif /* CONFIG_QDIO_DEBUG */
-
 struct qdio_q {
 	volatile struct slsb slsb;
 
 	char unused[QDIO_MAX_BUFFERS_PER_Q];
 
-	__u32 * volatile dev_st_chg_ind;
+	__u32 * dev_st_chg_ind;
 
 	int is_input_q;
 	int irq;
@@ -568,6 +599,7 @@ struct qdio_q {
 	struct tasklet_struct tasklet;
 #endif /* QDIO_USE_TIMERS_FOR_POLLING */
 
+
 	enum qdio_irq_states state;
 
 	/* used to store the error condition during a data transfer */
@@ -624,6 +656,10 @@ struct qdio_irq {
 	unsigned int hydra_gives_outbound_pcis;
 	unsigned int sync_done_on_outb_pcis;
 
+	/* QEBSM facility */
+	unsigned int is_qebsm;
+	unsigned long sch_token;
+
 	enum qdio_irq_states state;
 
 	unsigned int no_input_qs;
diff -urpN linux-2.6/include/asm-s390/qdio.h linux-2.6-patched/include/asm-s390/qdio.h
--- linux-2.6/include/asm-s390/qdio.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/qdio.h	2005-12-09 14:25:51.000000000 +0100
@@ -195,12 +195,14 @@ struct qdr {
 /*
  * queue information block (QIB)
  */
-#define QIB_AC_INBOUND_PCI_SUPPORTED 0x80
-#define QIB_AC_OUTBOUND_PCI_SUPPORTED 0x40
+#define QIB_AC_INBOUND_PCI_SUPPORTED 	0x80
+#define QIB_AC_OUTBOUND_PCI_SUPPORTED 	0x40
+#define QIB_RFLAGS_ENABLE_QEBSM		0x80
+
 struct qib {
 	unsigned int  qfmt    :  8;     /* queue format */
 	unsigned int  pfmt    :  8;     /* impl. dep. parameter format */
-	unsigned int  res1    :  8;     /* reserved */
+	unsigned int  rflags  :  8;	/* QEBSM */
 	unsigned int  ac      :  8;     /* adapter characteristics */
 	unsigned int  res2;             /* reserved */
 #ifdef QDIO_32_BIT
