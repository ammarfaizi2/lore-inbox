Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267676AbUHENVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267676AbUHENVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267675AbUHENVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:21:09 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12964 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267670AbUHENO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:14:28 -0400
Date: Thu, 5 Aug 2004 15:14:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: qeth performance.
Message-ID: <20040805131440.GF8251@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: qeth performance.

From: Thomas Spatzier <tspat@de.ibm.com>

qeth network driver performance improvements. The ping time on the
HiperSockets interface drops from 250 usecs to 50 usecs and the 1 bytes
request/response test improves from 70000 to 110000 transactions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
 
diffstat:
 arch/s390/Kconfig            |    9 ++
 arch/s390/defconfig          |    1 
 drivers/s390/cio/qdio.c      |   69 +++++++++++++---
 drivers/s390/cio/qdio.h      |   56 ++++++-------
 drivers/s390/net/qeth.h      |   12 ++
 drivers/s390/net/qeth_main.c |  183 +++++++++++++++++++++++++++++--------------
 6 files changed, 230 insertions(+), 100 deletions(-)

diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-s390/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	Thu Aug  5 14:20:32 2004
+++ linux-2.6-s390/arch/s390/Kconfig	Thu Aug  5 14:21:02 2004
@@ -181,6 +181,15 @@
 
 	  If unsure, say N.
 
+config QDIO_DEBUG
+	bool "Extended debugging information"
+	depends on QDIO
+	help
+	  Say Y here to get extended debugging output in /proc/s390dbf/qdio...
+	  Warning: this option reduces the performance of the QDIO module.
+
+	  If unsure, say N.
+
 comment "Misc"
 
 config PREEMPT
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Thu Aug  5 14:20:59 2004
+++ linux-2.6-s390/arch/s390/defconfig	Thu Aug  5 14:21:02 2004
@@ -70,6 +70,7 @@
 CONFIG_MACHCHK_WARNING=y
 CONFIG_QDIO=y
 # CONFIG_QDIO_PERF_STATS is not set
+# CONFIG_QDIO_DEBUG is not set
 
 #
 # Misc
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Thu Aug  5 14:21:02 2004
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.83 $"
+#define VERSION_QDIO_C "$Revision: 1.84 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -87,10 +87,10 @@
 static debug_info_t *qdio_dbf_sbal;
 static debug_info_t *qdio_dbf_trace;
 static debug_info_t *qdio_dbf_sense;
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 static debug_info_t *qdio_dbf_slsb_out;
 static debug_info_t *qdio_dbf_slsb_in;
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 /* iQDIO stuff: */
 static volatile struct qdio_q *tiq_list=NULL; /* volatile as it could change
@@ -514,10 +514,13 @@
 qdio_is_outbound_q_done(struct qdio_q *q)
 {
 	int no_used;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
+#endif
 
 	no_used=atomic_read(&q->number_of_buffers_used);
 
+#ifdef CONFIG_QDIO_DEBUG
 	if (no_used) {
 		sprintf(dbf_text,"oqisnt%02x",no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
@@ -525,6 +528,7 @@
 		QDIO_DBF_TEXT4(0,trace,"oqisdone");
 	}
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+#endif /* CONFIG_QDIO_DEBUG */
 	return (no_used==0);
 }
 
@@ -552,10 +556,12 @@
 qdio_kick_outbound_q(struct qdio_q *q)
 {
 	int result;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
 
 	QDIO_DBF_TEXT4(0,trace,"kickoutq");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if (!q->siga_out)
 		return;
@@ -593,16 +599,18 @@
 
 		switch (result) {
 		case 0:
-		/* went smooth this time, reset timestamp */
+			/* went smooth this time, reset timestamp */
+#ifdef CONFIG_QDIO_DEBUG
 			QDIO_DBF_TEXT3(0,trace,"cc2reslv");
 			sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
 				atomic_read(&q->busy_siga_counter));
 			QDIO_DBF_TEXT3(0,trace,dbf_text);
 			q->timing.busy_start=0;
+#endif /* CONFIG_QDIO_DEBUG */
 			break;
 		case (2|QDIO_SIGA_ERROR_B_BIT_SET):
 			/* cc=2 and busy bit: */
-		atomic_inc(&q->busy_siga_counter);
+			atomic_inc(&q->busy_siga_counter);
 
 			/* if the last siga was successful, save
 			 * timestamp here */
@@ -616,9 +624,11 @@
 				break;
 			}
 			QDIO_DBF_TEXT2(0,trace,"cc2REPRT");
+#ifdef CONFIG_QDIO_DEBUG
 			sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
 				atomic_read(&q->busy_siga_counter));
 			QDIO_DBF_TEXT3(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 			/* else fallthrough and report error */
 		default:
 			/* for plain cc=1, 2 or 3: */
@@ -635,7 +645,9 @@
 qdio_kick_outbound_handler(struct qdio_q *q)
 {
 	int start, end, real_end, count;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
+#endif
 
 	start = q->first_element_to_kick;
 	/* last_move_ftc was just updated */
@@ -645,11 +657,13 @@
 	count = (end+QDIO_MAX_BUFFERS_PER_Q+1-start)&
 		(QDIO_MAX_BUFFERS_PER_Q-1);
 
+#ifdef CONFIG_QDIO_DEBUG
 	QDIO_DBF_TEXT4(0,trace,"kickouth");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
 	sprintf(dbf_text,"s=%2xc=%2x",start,count);
 	QDIO_DBF_TEXT4(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
 		q->handler(q->cdev,QDIO_STATUS_OUTBOUND_INT|
@@ -732,7 +746,9 @@
 	int f,f_mod_no;
 	volatile char *slsb;
 	int first_not_to_check;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
+#endif /* CONFIG_QDIO_DEBUG */
 #ifdef QDIO_USE_PROCESSING_STATE
 	int last_position=-1;
 #endif /* QDIO_USE_PROCESSING_STATE */
@@ -806,8 +822,10 @@
 
 	/* P_ERROR means frontier is reached, break and report error */
 	case SLSB_P_INPUT_ERROR:
+#ifdef CONFIG_QDIO_DEBUG
 		sprintf(dbf_text,"inperr%2x",f_mod_no);
 		QDIO_DBF_TEXT3(1,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 		QDIO_DBF_HEX2(1,sbal,q->sbal[f_mod_no],256);
 
 		/* kind of process the buffer */
@@ -884,13 +902,16 @@
 iqdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
+#endif
 
 	no_used=atomic_read(&q->number_of_buffers_used);
 
 	/* propagate the change from 82 to 80 through VM */
 	SYNC_MEMORY;
 
+#ifdef CONFIG_QDIO_DEBUG
 	if (no_used) {
 		sprintf(dbf_text,"iqisnt%02x",no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
@@ -898,6 +919,7 @@
 		QDIO_DBF_TEXT4(0,trace,"iniqisdo");
 	}
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if (!no_used)
 		return 1;
@@ -933,7 +955,9 @@
 qdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
+#endif
 
 	no_used=atomic_read(&q->number_of_buffers_used);
 
@@ -968,16 +992,20 @@
 	 * has (probably) not moved (see qdio_inbound_processing) 
 	 */
 	if (NOW>GET_SAVED_TIMESTAMP(q)+q->timing.threshold) {
+#ifdef CONFIG_QDIO_DEBUG
 		QDIO_DBF_TEXT4(0,trace,"inqisdon");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 		sprintf(dbf_text,"pf%02xcn%02x",q->first_to_check,no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 		return 1;
 	} else {
+#ifdef CONFIG_QDIO_DEBUG
 		QDIO_DBF_TEXT4(0,trace,"inqisntd");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 		sprintf(dbf_text,"pf%02xcn%02x",q->first_to_check,no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 		return 0;
 	}
 }
@@ -986,7 +1014,9 @@
 qdio_kick_inbound_handler(struct qdio_q *q)
 {
 	int count, start, end, real_end, i;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
+#endif
 
 	QDIO_DBF_TEXT4(0,trace,"kickinh");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
@@ -1004,8 +1034,10 @@
  		i=(i+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
  	}
 
+#ifdef CONFIG_QDIO_DEBUG
 	sprintf(dbf_text,"s=%2xc=%2x",start,count);
 	QDIO_DBF_TEXT4(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if (likely(q->state==QDIO_IRQ_STATE_ACTIVE))
 		q->handler(q->cdev,
@@ -1622,11 +1654,13 @@
 qdio_set_state(struct qdio_irq *irq_ptr, enum qdio_irq_states state)
 {
 	int i;
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[15];
 
 	QDIO_DBF_TEXT5(0,trace,"newstate");
 	sprintf(dbf_text,"%4x%4x",irq_ptr->irq,state);
 	QDIO_DBF_TEXT5(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 
 	irq_ptr->state=state;
 	for (i=0;i<irq_ptr->no_input_qs;i++)
@@ -1791,9 +1825,11 @@
 	int cstat,dstat;
 	char dbf_text[15];
 
+#ifdef CONFIG_QDIO_DEBUG
 	QDIO_DBF_TEXT4(0, trace, "qint");
 	sprintf(dbf_text, "%s", cdev->dev.bus_id);
 	QDIO_DBF_TEXT4(0, trace, dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 	
 	if (!intparm) {
 		QDIO_PRINT_ERR("got unsolicited interrupt in qdio " \
@@ -1830,8 +1866,10 @@
 
 	qdio_irq_check_sense(irq_ptr->irq, irb);
 
+#ifdef CONFIG_QDIO_DEBUG
 	sprintf(dbf_text, "state:%d", irq_ptr->state);
 	QDIO_DBF_TEXT4(0, trace, dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 
         cstat = irb->scsw.cstat;
         dstat = irb->scsw.dstat;
@@ -1872,18 +1910,22 @@
 	int cc;
 	struct qdio_q *q;
 	struct qdio_irq *irq_ptr;
-	char dbf_text[15]="SyncXXXX";
 	void *ptr;
+#ifdef CONFIG_QDIO_DEBUG
+	char dbf_text[15]="SyncXXXX";
+#endif
 
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
 
+#ifdef CONFIG_QDIO_DEBUG
 	*((int*)(&dbf_text[4])) = irq_ptr->irq;
 	QDIO_DBF_HEX4(0,trace,dbf_text,QDIO_DBF_TRACE_LEN);
 	*((int*)(&dbf_text[0]))=flags;
 	*((int*)(&dbf_text[4]))=queue_number;
 	QDIO_DBF_HEX4(0,trace,dbf_text,QDIO_DBF_TRACE_LEN);
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if (flags&QDIO_FLAG_SYNC_INPUT) {
 		q=irq_ptr->input_qs[queue_number];
@@ -3083,11 +3125,12 @@
 	unsigned int count,struct qdio_buffer *buffers)
 {
 	struct qdio_irq *irq_ptr;
-
+#ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[20];
 
 	sprintf(dbf_text,"doQD%04x",cdev->private->irq);
-	QDIO_DBF_TEXT3(0,trace,dbf_text);
+ 	QDIO_DBF_TEXT3(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if ( (qidx>QDIO_MAX_BUFFERS_PER_Q) ||
 	     (count>QDIO_MAX_BUFFERS_PER_Q) ||
@@ -3101,6 +3144,7 @@
 	if (!irq_ptr)
 		return -ENODEV;
 
+#ifdef CONFIG_QDIO_DEBUG
 	if (callflags&QDIO_FLAG_SYNC_INPUT)
 		QDIO_DBF_HEX3(0,trace,&irq_ptr->input_qs[queue_number],
 			      sizeof(void*));
@@ -3111,6 +3155,7 @@
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
 	sprintf(dbf_text,"qi%02xct%02x",qidx,count);
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
+#endif /* CONFIG_QDIO_DEBUG */
 
 	if (irq_ptr->state!=QDIO_IRQ_STATE_ACTIVE)
 		return -EBUSY;
@@ -3261,12 +3306,12 @@
 		debug_unregister(qdio_dbf_sense);
 	if (qdio_dbf_trace)
 		debug_unregister(qdio_dbf_trace);
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
         if (qdio_dbf_slsb_out)
                 debug_unregister(qdio_dbf_slsb_out);
         if (qdio_dbf_slsb_in)
                 debug_unregister(qdio_dbf_slsb_in);
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 }
 
 static int
@@ -3311,7 +3356,7 @@
 	debug_register_view(qdio_dbf_trace,&debug_hex_ascii_view);
 	debug_set_level(qdio_dbf_trace,QDIO_DBF_TRACE_LEVEL);
 
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
         qdio_dbf_slsb_out=debug_register(QDIO_DBF_SLSB_OUT_NAME,
                                          QDIO_DBF_SLSB_OUT_INDEX,
                                          QDIO_DBF_SLSB_OUT_NR_AREAS,
@@ -3329,7 +3374,7 @@
 		goto oom;
         debug_register_view(qdio_dbf_slsb_in,&debug_hex_ascii_view);
         debug_set_level(qdio_dbf_slsb_in,QDIO_DBF_SLSB_IN_LEVEL);
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 	return 0;
 oom:
 	QDIO_PRINT_ERR("not enough memory for dbf.\n");
diff -urN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-s390/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.h	Thu Aug  5 14:21:02 2004
@@ -1,15 +1,13 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.24 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.26 $"
 
-//#define QDIO_DBF_LIKE_HELL
-
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_VERBOSE_LEVEL 5
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_USE_PROCESSING_STATE
 
@@ -103,75 +101,75 @@
 #define QDIO_DBF_HEX0(ex,name,addr,len) QDIO_DBF_HEX(ex,name,0,addr,len)
 #define QDIO_DBF_HEX1(ex,name,addr,len) QDIO_DBF_HEX(ex,name,1,addr,len)
 #define QDIO_DBF_HEX2(ex,name,addr,len) QDIO_DBF_HEX(ex,name,2,addr,len)
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_HEX3(ex,name,addr,len) QDIO_DBF_HEX(ex,name,3,addr,len)
 #define QDIO_DBF_HEX4(ex,name,addr,len) QDIO_DBF_HEX(ex,name,4,addr,len)
 #define QDIO_DBF_HEX5(ex,name,addr,len) QDIO_DBF_HEX(ex,name,5,addr,len)
 #define QDIO_DBF_HEX6(ex,name,addr,len) QDIO_DBF_HEX(ex,name,6,addr,len)
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_DBF_HEX3(ex,name,addr,len) do {} while (0)
 #define QDIO_DBF_HEX4(ex,name,addr,len) do {} while (0)
 #define QDIO_DBF_HEX5(ex,name,addr,len) do {} while (0)
 #define QDIO_DBF_HEX6(ex,name,addr,len) do {} while (0)
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_DBF_TEXT0(ex,name,text) QDIO_DBF_TEXT(ex,name,0,text)
 #define QDIO_DBF_TEXT1(ex,name,text) QDIO_DBF_TEXT(ex,name,1,text)
 #define QDIO_DBF_TEXT2(ex,name,text) QDIO_DBF_TEXT(ex,name,2,text)
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_TEXT3(ex,name,text) QDIO_DBF_TEXT(ex,name,3,text)
 #define QDIO_DBF_TEXT4(ex,name,text) QDIO_DBF_TEXT(ex,name,4,text)
 #define QDIO_DBF_TEXT5(ex,name,text) QDIO_DBF_TEXT(ex,name,5,text)
 #define QDIO_DBF_TEXT6(ex,name,text) QDIO_DBF_TEXT(ex,name,6,text)
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_DBF_TEXT3(ex,name,text) do {} while (0)
 #define QDIO_DBF_TEXT4(ex,name,text) do {} while (0)
 #define QDIO_DBF_TEXT5(ex,name,text) do {} while (0)
 #define QDIO_DBF_TEXT6(ex,name,text) do {} while (0)
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_DBF_SETUP_NAME "qdio_setup"
 #define QDIO_DBF_SETUP_LEN 8
 #define QDIO_DBF_SETUP_INDEX 2
 #define QDIO_DBF_SETUP_NR_AREAS 1
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_SETUP_LEVEL 6
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_DBF_SETUP_LEVEL 2
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_DBF_SBAL_NAME "qdio_labs" /* sbal */
 #define QDIO_DBF_SBAL_LEN 256
 #define QDIO_DBF_SBAL_INDEX 2
 #define QDIO_DBF_SBAL_NR_AREAS 2
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_SBAL_LEVEL 6
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_DBF_SBAL_LEVEL 2
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_DBF_TRACE_NAME "qdio_trace"
 #define QDIO_DBF_TRACE_LEN 8
 #define QDIO_DBF_TRACE_NR_AREAS 2
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_TRACE_INDEX 4
 #define QDIO_DBF_TRACE_LEVEL 4 /* -------- could be even more verbose here */
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_DBF_TRACE_INDEX 2
 #define QDIO_DBF_TRACE_LEVEL 2
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_DBF_SENSE_NAME "qdio_sense"
 #define QDIO_DBF_SENSE_LEN 64
 #define QDIO_DBF_SENSE_INDEX 1
 #define QDIO_DBF_SENSE_NR_AREAS 1
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_SENSE_LEVEL 6
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define QDIO_DBF_SENSE_LEVEL 2
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
-#ifdef QDIO_DBF_LIKE_HELL
+#ifdef CONFIG_QDIO_DEBUG
 #define QDIO_TRACE_QTYPE QDIO_ZFCP_QFMT
 
 #define QDIO_DBF_SLSB_OUT_NAME "qdio_slsb_out"
@@ -185,7 +183,7 @@
 #define QDIO_DBF_SLSB_IN_INDEX 8
 #define QDIO_DBF_SLSB_IN_NR_AREAS 1
 #define QDIO_DBF_SLSB_IN_LEVEL 6
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_PRINTK_HEADER QDIO_NAME ": "
 
@@ -494,7 +492,7 @@
 #define QDIO_GET_ADDR(x) ((__u32)(long)x)
 #endif /* CONFIG_ARCH_S390X */
 
-#ifdef QDIO_DBF_LIKE_HELL 
+#ifdef CONFIG_QDIO_DEBUG
 #define set_slsb(x,y) \
   if(q->queue_type==QDIO_TRACE_QTYPE) { \
         if(q->is_input_q) { \
@@ -511,9 +509,9 @@
             QDIO_DBF_HEX2(0,slsb_out,&q->slsb,QDIO_MAX_BUFFERS_PER_Q); \
         } \
   }
-#else /* QDIO_DBF_LIKE_HELL */
+#else /* CONFIG_QDIO_DEBUG */
 #define set_slsb(x,y) qdio_set_slsb(x,y)
-#endif /* QDIO_DBF_LIKE_HELL */
+#endif /* CONFIG_QDIO_DEBUG */
 
 struct qdio_q {
 	volatile struct slsb slsb;
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Thu Aug  5 14:21:02 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.111 $"
+#define VERSION_QETH_H 		"$Revision: 1.113 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -150,6 +150,8 @@
 #define SENSE_RESETTING_EVENT_BYTE 1
 #define SENSE_RESETTING_EVENT_FLAG 0x80
 
+#define atomic_swap(a,b) xchg((int *)a.counter, b)
+
 /*
  * Common IO related definitions
  */
@@ -425,12 +427,18 @@
 
 struct qeth_card;
 
+enum qeth_out_q_states {
+       QETH_OUT_Q_UNLOCKED,
+       QETH_OUT_Q_LOCKED,
+       QETH_OUT_Q_LOCKED_FLUSH,
+};
+
 struct qeth_qdio_out_q {
 	struct qdio_buffer qdio_bufs[QDIO_MAX_BUFFERS_PER_Q];
 	struct qeth_qdio_out_buffer bufs[QDIO_MAX_BUFFERS_PER_Q];
 	int queue_no;
 	struct qeth_card *card;
-	spinlock_t lock;
+	atomic_t state;
 	volatile int do_pack;
 	/*
 	 * index of buffer to be filled by driver; state EMPTY or PACKING
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Thu Aug  5 14:21:02 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.127 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.130 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.127 $	 $Date: 2004/07/14 21:46:40 $
+ *    $Revision: 1.130 $	 $Date: 2004/08/05 11:21:50 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.127 $"
+#define VERSION_QETH_C "$Revision: 1.130 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -1801,7 +1801,7 @@
 	}
 	add_timer(&timer);
 	wait_event(reply->wait_q, reply->received);
-	del_timer(&timer);
+	del_timer_sync(&timer);
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
@@ -2105,7 +2105,7 @@
 				QETH_DBF_TEXT(qerr,2,"unexeob");
 				QETH_DBF_TEXT_(qerr,2,"%s",CARD_BUS_ID(card));
 				QETH_DBF_HEX(misc,4,buffer,sizeof(*buffer));
-				dev_kfree_skb_irq(skb);
+				dev_kfree_skb_any(skb);
 				card->stats.rx_errors++;
 				return NULL;
 			}
@@ -2297,7 +2297,7 @@
 		qeth_rebuild_skb(card, skb, hdr);
 		/* is device UP ? */
 		if (!(card->dev->flags & IFF_UP)){
-			dev_kfree_skb_irq(skb);
+			dev_kfree_skb_any(skb);
 			continue;
 		}
 		skb->dev = card->dev;
@@ -2311,16 +2311,16 @@
 static inline struct qeth_buffer_pool_entry *
 qeth_get_buffer_pool_entry(struct qeth_card *card)
 {
-	struct qeth_buffer_pool_entry *entry, *tmp;
+	struct qeth_buffer_pool_entry *entry;
 
 	QETH_DBF_TEXT(trace, 6, "gtbfplen");
-	entry = NULL;
-	list_for_each_entry_safe(entry, tmp,
-				 &card->qdio.in_buf_pool.entry_list, list){
+	if (!list_empty(&card->qdio.in_buf_pool.entry_list)) {
+		entry = list_entry(card->qdio.in_buf_pool.entry_list.next,
+				struct qeth_buffer_pool_entry, list);
 		list_del_init(&entry->list);
-		break;
+		return entry;
 	}
-	return entry;
+	return NULL;
 }
 
 static inline void
@@ -2367,7 +2367,7 @@
 		buf->buffer->element[i].flags = 0;
 		while ((skb = skb_dequeue(&buf->skb_list))){
 			atomic_dec(&skb->users);
-			dev_kfree_skb_irq(skb);
+			dev_kfree_skb_any(skb);
 		}
 	}
 	buf->next_element_to_fill = 0;
@@ -2588,14 +2588,9 @@
 		QETH_DBF_TEXT(trace, 2, "flushbuf");
 		QETH_DBF_TEXT_(trace, 2, " err%d", rc);
 		queue->card->stats.tx_errors += count;
-		/* ok, since do_QDIO went wrong the buffers have not been given
-		 * to the hardware. they still belong to us, so we can clear
-		 * them and reuse then, i.e. set back next_buf_to_fill*/
-		for (i = index; i < index + count; ++i) {
-			buf = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
-			qeth_clear_output_buffer(queue, buf);
-		}
-		queue->next_buf_to_fill = index;
+		/* this must not happen under normal circumstances. if it
+		 * happens something is really wrong -> recover */
+		qeth_schedule_recovery(queue->card);
 		return;
 	}
 	atomic_add(count, &queue->used_buffers);
@@ -2605,16 +2600,12 @@
 }
 
 /*
- * switches between PACKING and non-PACKING state if needed.
- * has to be called holding queue->lock
+ * Switched to packing state if the number of used buffers on a queue
+ * reaches a certain limit.
  */
-static inline int
-qeth_switch_packing_state(struct qeth_qdio_out_q *queue)
+static inline void
+qeth_switch_to_packing_if_needed(struct qeth_qdio_out_q *queue)
 {
-	struct qeth_qdio_out_buffer *buffer;
-	int flush_count = 0;
-
-	QETH_DBF_TEXT(trace, 6, "swipack");
 	if (!queue->do_pack) {
 		if (atomic_read(&queue->used_buffers)
 		    >= QETH_HIGH_WATERMARK_PACK){
@@ -2625,7 +2616,22 @@
 #endif
 			queue->do_pack = 1;
 		}
-	} else {
+	}
+}
+
+/*
+ * Switches from packing to non-packing mode. If there is a packing
+ * buffer on the queue this buffer will be prepared to be flushed.
+ * In that case 1 is returned to inform the caller. If no buffer
+ * has to be flushed, zero is returned.
+ */
+static inline int
+qeth_switch_to_nonpacking_if_needed(struct qeth_qdio_out_q *queue)
+{
+	struct qeth_qdio_out_buffer *buffer;
+	int flush_count = 0;
+
+	if (queue->do_pack) {
 		if (atomic_read(&queue->used_buffers)
 		    <= QETH_LOW_WATERMARK_PACK) {
 			/* switch PACKING -> non-PACKING */
@@ -2650,21 +2656,62 @@
 	return flush_count;
 }
 
-static inline void
-qeth_flush_buffers_on_no_pci(struct qeth_qdio_out_q *queue, int under_int)
+/*
+ * Called to flush a packing buffer if no more pci flags are on the queue.
+ * Checks if there is a packing buffer and prepares it to be flushed.
+ * In that case returns 1, otherwise zero.
+ */
+static inline int
+qeth_flush_buffers_on_no_pci(struct qeth_qdio_out_q *queue)
 {
 	struct qeth_qdio_out_buffer *buffer;
-	int index;
 
-	index = queue->next_buf_to_fill;
-	buffer = &queue->bufs[index];
+	buffer = &queue->bufs[queue->next_buf_to_fill];
 	if((atomic_read(&buffer->state) == QETH_QDIO_BUF_EMPTY) &&
 	   (buffer->next_element_to_fill > 0)){
 		/* it's a packing buffer */
 		atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
 		queue->next_buf_to_fill =
 			(queue->next_buf_to_fill + 1) % QDIO_MAX_BUFFERS_PER_Q;
-		qeth_flush_buffers(queue, under_int, index, 1);
+		return 1;
+	}
+	return 0;
+}
+
+static inline void
+qeth_check_outbound_queue(struct qeth_qdio_out_q *queue)
+{
+	int index;
+	int flush_cnt = 0;
+
+	/*
+	 * check if weed have to switch to non-packing mode or if
+	 * we have to get a pci flag out on the queue
+	 */
+	if ((atomic_read(&queue->used_buffers) <= QETH_LOW_WATERMARK_PACK) ||
+	    !atomic_read(&queue->set_pci_flags_count)){
+		if (atomic_swap(&queue->state, QETH_OUT_Q_LOCKED_FLUSH) ==
+				QETH_OUT_Q_UNLOCKED) {
+			/*
+			 * If we get in here, there was no action in
+			 * do_send_packet. So, we check if there is a
+			 * packing buffer to be flushed here.
+			 */
+			/* TODO: try if we get a performance improvement
+			 * by calling netif_stop_queue here */
+			/* save start index for flushing */
+			index = queue->next_buf_to_fill;
+			flush_cnt += qeth_switch_to_nonpacking_if_needed(queue);
+			if (!flush_cnt &&
+			    !atomic_read(&queue->set_pci_flags_count))
+				flush_cnt +=
+					qeth_flush_buffers_on_no_pci(queue);
+			/* were done with updating critical queue members */
+			atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
+			/* flushing can be done outside the lock */
+			if (flush_cnt)
+				qeth_flush_buffers(queue, 1, index, flush_cnt);
+		}
 	}
 }
 
@@ -2710,6 +2757,8 @@
 		qeth_clear_output_buffer(queue, buffer);
 	}
 	atomic_sub(count, &queue->used_buffers);
+	/* check if we need to do something on this outbound queue */
+	qeth_check_outbound_queue(queue);
 
 	netif_wake_queue(card->dev);
 #ifdef CONFIG_QETH_PERF_STATS
@@ -2981,7 +3030,8 @@
 		card->qdio.out_qs[i]->do_pack = 0;
 		atomic_set(&card->qdio.out_qs[i]->used_buffers,0);
 		atomic_set(&card->qdio.out_qs[i]->set_pci_flags_count, 0);
-		spin_lock_init(&card->qdio.out_qs[i]->lock);
+		atomic_set(&card->qdio.out_qs[i]->state,
+			   QETH_OUT_Q_UNLOCKED);
 	}
 	return 0;
 }
@@ -3295,12 +3345,12 @@
 	card->perf_stats.outbound_start_time = qeth_get_micros();
 #endif
 	/*
-	 * dev_queue_xmit should ensure that we are called packet
-	 * after packet
+	 * We only call netif_stop_queue in case of errors. Since we've
+	 * got our own synchronization on queues we can keep the stack's
+	 * queue running.
 	 */
-	netif_stop_queue(dev);
-	if (!(rc = qeth_send_packet(card, skb)))
-		netif_wake_queue(dev);
+	if ((rc = qeth_send_packet(card, skb)))
+		netif_stop_queue(dev);
 
 #ifdef CONFIG_QETH_PERF_STATS
 	card->perf_stats.outbound_time += qeth_get_micros() -
@@ -3714,7 +3764,11 @@
 
 	QETH_DBF_TEXT(trace, 6, "dosndpfa");
 
-	spin_lock(&queue->lock);
+	/* spin until we get the queue ... */
+	while (atomic_compare_and_swap(QETH_OUT_Q_UNLOCKED,
+				       QETH_OUT_Q_LOCKED,
+				       &queue->state));
+	/* ... now we've got the queue */
 	index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
 	/*
@@ -3723,14 +3777,14 @@
 	 */
 	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) {
 		card->stats.tx_dropped++;
-		spin_unlock(&queue->lock);
+		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 		return -EBUSY;
 	}
 	queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
 				  QDIO_MAX_BUFFERS_PER_Q;
+	atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 	qeth_fill_buffer(queue, buffer, (char *)hdr, skb);
 	qeth_flush_buffers(queue, 0, index, 1);
-	spin_unlock(&queue->lock);
 	return 0;
 }
 
@@ -3746,7 +3800,10 @@
 
 	QETH_DBF_TEXT(trace, 6, "dosndpkt");
 
-	spin_lock(&queue->lock);
+	/* spin until we get the queue ... */
+	while (atomic_compare_and_swap(QETH_OUT_Q_UNLOCKED,
+				       QETH_OUT_Q_LOCKED,
+				       &queue->state));
 	start_index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
 	/*
@@ -3755,9 +3812,11 @@
 	 */
 	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY){
 		card->stats.tx_dropped++;
-		spin_unlock(&queue->lock);
+		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 		return -EBUSY;
 	}
+	/* check if we need to switch packing state of this queue */
+	qeth_switch_to_packing_if_needed(queue);
 	if (queue->do_pack){
 		/* does packet fit in current buffer? */
 		if((QETH_MAX_BUFFER_ELEMENTS(card) -
@@ -3772,11 +3831,10 @@
 			/* we did a step forward, so check buffer state again */
 			if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY){
 				card->stats.tx_dropped++;
-				qeth_flush_buffers(queue, 0, start_index, 1);
-				spin_unlock(&queue->lock);
 				/* return EBUSY because we sent old packet, not
 				 * the current one */
-				return -EBUSY;
+				rc = -EBUSY;
+				goto out;
 			}
 		}
 	}
@@ -3787,16 +3845,27 @@
 		queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
 			QDIO_MAX_BUFFERS_PER_Q;
 	}
-	/* check if we need to switch packing state of this queue */
-	flush_count += qeth_switch_packing_state(queue);
-
+	/*
+	 * queue->state will go from LOCKED -> UNLOCKED or from
+	 * LOCKED_FLUSH -> LOCKED if output_handler wanted to 'notify' us
+	 * (switch packing state or flush buffer to get another pci flag out).
+	 * In that case we will enter this loop
+	 */
+	while (atomic_dec_return(&queue->state)){
+		/* check if we can go back to non-packing state */
+		flush_count += qeth_switch_to_nonpacking_if_needed(queue);
+		/*
+		 * check if we need to flush a packing buffer to get a pci
+		 * flag out on the queue
+		 */
+		if (!flush_count && !atomic_read(&queue->set_pci_flags_count))
+			flush_count += qeth_flush_buffers_on_no_pci(queue);
+	}
+	/* at this point the queue is UNLOCKED again */
+out:
 	if (flush_count)
 		qeth_flush_buffers(queue, 0, start_index, flush_count);
 
-	if (!atomic_read(&queue->set_pci_flags_count))
-		qeth_flush_buffers_on_no_pci(queue, 0);
-
-	spin_unlock(&queue->lock);
 	return rc;
 }
 
