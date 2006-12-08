Return-Path: <linux-kernel-owner+w=401wt.eu-S936710AbWLHPVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936710AbWLHPVc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938063AbWLHPVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:21:31 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61573 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936710AbWLHPV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:21:29 -0500
Date: Fri, 8 Dec 2006 16:21:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, braunu@de.ibm.com
Subject: [S390] runtime switch for qdio performance statistics
Message-ID: <20061208152123.GB15860@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <braunu@de.ibm.com>

[S390] runtime switch for qdio performance statistics

Remove CONFIG_QETH_PERF_STATS and use a sysfs attribute instead.
We want to have the ability to turn the statistics on/off at runtime.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/Kconfig       |    8 -
 arch/s390/defconfig     |    1 
 drivers/s390/cio/qdio.c |  226 ++++++++++++++++++++++++++----------------------
 drivers/s390/cio/qdio.h |   28 ++---
 4 files changed, 135 insertions(+), 128 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-12-08 15:52:40.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2006-12-08 15:52:53.000000000 +0100
@@ -136,7 +136,6 @@ CONFIG_HOLES_IN_ZONE=y
 #
 CONFIG_MACHCHK_WARNING=y
 CONFIG_QDIO=y
-# CONFIG_QDIO_PERF_STATS is not set
 # CONFIG_QDIO_DEBUG is not set
 
 #
diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-12-08 15:52:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2006-12-08 15:52:53.000000000 +0100
@@ -258,14 +258,6 @@ config QDIO
 
 	  If unsure, say Y.
 
-config QDIO_PERF_STATS
-	bool "Performance statistics in /proc"
-	depends on QDIO
-	help
-	  Say Y here to get performance statistics in /proc/qdio_perf
-
-	  If unsure, say N.
-
 config QDIO_DEBUG
 	bool "Extended debugging information"
 	depends on QDIO
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-12-08 15:52:47.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-12-08 15:52:53.000000000 +0100
@@ -46,6 +46,7 @@
 #include <asm/timex.h>
 
 #include <asm/debug.h>
+#include <asm/s390_rdev.h>
 #include <asm/qdio.h>
 
 #include "cio.h"
@@ -65,12 +66,12 @@ MODULE_LICENSE("GPL");
 /******************** HERE WE GO ***********************************/
 
 static const char version[] = "QDIO base support version 2";
+extern struct bus_type ccw_bus_type;
 
-#ifdef QDIO_PERFORMANCE_STATS
+static int qdio_performance_stats = 0;
 static int proc_perf_file_registration;
 static unsigned long i_p_c, i_p_nc, o_p_c, o_p_nc, ii_p_c, ii_p_nc;
 static struct qdio_perf_stats perf_stats;
-#endif /* QDIO_PERFORMANCE_STATS */
 
 static int hydra_thinints;
 static int is_passthrough = 0;
@@ -275,9 +276,8 @@ qdio_siga_sync(struct qdio_q *q, unsigne
 	QDIO_DBF_TEXT4(0,trace,"sigasync");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.siga_syncs++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats)
+		perf_stats.siga_syncs++;
 
 	cc = do_siga_sync(q->schid, gpr2, gpr3);
 	if (cc)
@@ -322,9 +322,8 @@ qdio_siga_output(struct qdio_q *q)
 	__u32 busy_bit;
 	__u64 start_time=0;
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.siga_outs++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats)
+		perf_stats.siga_outs++;
 
 	QDIO_DBF_TEXT4(0,trace,"sigaout");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
@@ -358,9 +357,8 @@ qdio_siga_input(struct qdio_q *q)
 	QDIO_DBF_TEXT4(0,trace,"sigain");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.siga_ins++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats)
+		perf_stats.siga_ins++;
 
 	cc = do_siga_input(q->schid, q->mask);
 	
@@ -954,9 +952,8 @@ __qdio_outbound_processing(struct qdio_q
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-#ifdef QDIO_PERFORMANCE_STATS
-		o_p_c++;
-#endif /* QDIO_PERFORMANCE_STATS */
+		if (qdio_performance_stats)
+			o_p_c++;
 		/* as we're sissies, we'll check next time */
 		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
@@ -964,10 +961,10 @@ __qdio_outbound_processing(struct qdio_q
 		}
 		return;
 	}
-#ifdef QDIO_PERFORMANCE_STATS
-	o_p_nc++;
-	perf_stats.tl_runs++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		o_p_nc++;
+		perf_stats.tl_runs++;
+	}
 
 	/* see comment in qdio_kick_outbound_q */
 	siga_attempts=atomic_read(&q->busy_siga_counter);
@@ -1142,15 +1139,16 @@ qdio_has_inbound_q_moved(struct qdio_q *
 {
 	int i;
 
-#ifdef QDIO_PERFORMANCE_STATS
 	static int old_pcis=0;
 	static int old_thinints=0;
 
-	if ((old_pcis==perf_stats.pcis)&&(old_thinints==perf_stats.thinints))
-		perf_stats.start_time_inbound=NOW;
-	else
-		old_pcis=perf_stats.pcis;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		if ((old_pcis==perf_stats.pcis)&&
+		    (old_thinints==perf_stats.thinints))
+			perf_stats.start_time_inbound=NOW;
+		else
+			old_pcis=perf_stats.pcis;
+	}
 
 	i=qdio_get_inbound_buffer_frontier(q);
 	if ( (i!=GET_SAVED_FRONTIER(q)) ||
@@ -1340,10 +1338,10 @@ qdio_kick_inbound_handler(struct qdio_q 
 	q->siga_error=0;
 	q->error_status_flags=0;
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.inbound_time+=NOW-perf_stats.start_time_inbound;
-	perf_stats.inbound_cnt++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		perf_stats.inbound_time+=NOW-perf_stats.start_time_inbound;
+		perf_stats.inbound_cnt++;
+	}
 }
 
 static inline void
@@ -1363,9 +1361,8 @@ __tiqdio_inbound_processing(struct qdio_
 	 */
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-#ifdef QDIO_PERFORMANCE_STATS
-		ii_p_c++;
-#endif /* QDIO_PERFORMANCE_STATS */
+		if (qdio_performance_stats)
+			ii_p_c++;
 		/* 
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
@@ -1373,9 +1370,8 @@ __tiqdio_inbound_processing(struct qdio_
 		tiqdio_sched_tl();
 		return;
 	}
-#ifdef QDIO_PERFORMANCE_STATS
-	ii_p_nc++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats)
+		ii_p_nc++;
 	if (unlikely(atomic_read(&q->is_in_shutdown))) {
 		qdio_unmark_q(q);
 		goto out;
@@ -1416,11 +1412,11 @@ __tiqdio_inbound_processing(struct qdio_
 		irq_ptr = (struct qdio_irq*)q->irq_ptr;
 		for (i=0;i<irq_ptr->no_output_qs;i++) {
 			oq = irq_ptr->output_qs[i];
-#ifdef QDIO_PERFORMANCE_STATS
-			perf_stats.tl_runs--;
-#endif /* QDIO_PERFORMANCE_STATS */
-			if (!qdio_is_outbound_q_done(oq))
+			if (!qdio_is_outbound_q_done(oq)) {
+				if (qdio_performance_stats)
+					perf_stats.tl_runs--;
 				__qdio_outbound_processing(oq);
+			}
 		}
 	}
 
@@ -1457,9 +1453,8 @@ __qdio_inbound_processing(struct qdio_q 
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-#ifdef QDIO_PERFORMANCE_STATS
-		i_p_c++;
-#endif /* QDIO_PERFORMANCE_STATS */
+		if (qdio_performance_stats)
+			i_p_c++;
 		/* as we're sissies, we'll check next time */
 		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
@@ -1467,10 +1462,10 @@ __qdio_inbound_processing(struct qdio_q 
 		}
 		return;
 	}
-#ifdef QDIO_PERFORMANCE_STATS
-	i_p_nc++;
-	perf_stats.tl_runs++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		i_p_nc++;
+		perf_stats.tl_runs++;
+	}
 
 again:
 	if (qdio_has_inbound_q_moved(q)) {
@@ -1516,9 +1511,8 @@ tiqdio_reset_processing_state(struct qdi
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-#ifdef QDIO_PERFORMANCE_STATS
-		ii_p_c++;
-#endif /* QDIO_PERFORMANCE_STATS */
+		if (qdio_performance_stats)
+			ii_p_c++;
 		/* 
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
@@ -1609,9 +1603,8 @@ tiqdio_tl(unsigned long data)
 {
 	QDIO_DBF_TEXT4(0,trace,"iqdio_tl");
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.tl_runs++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats)
+		perf_stats.tl_runs++;
 
 	tiqdio_inbound_checks();
 }
@@ -1918,10 +1911,10 @@ tiqdio_thinint_handler(void)
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.thinints++;
-	perf_stats.start_time_inbound=NOW;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		perf_stats.thinints++;
+		perf_stats.start_time_inbound=NOW;
+	}
 
 	/* SVS only when needed:
 	 * issue SVS to benefit from iqdio interrupt avoidance
@@ -1976,18 +1969,17 @@ qdio_handle_pci(struct qdio_irq *irq_ptr
 	int i;
 	struct qdio_q *q;
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.pcis++;
-	perf_stats.start_time_inbound=NOW;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		perf_stats.pcis++;
+		perf_stats.start_time_inbound=NOW;
+	}
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		q=irq_ptr->input_qs[i];
 		if (q->is_input_q&QDIO_FLAG_NO_INPUT_INTERRUPT_CONTEXT)
 			qdio_mark_q(q);
 		else {
-#ifdef QDIO_PERFORMANCE_STATS
-			perf_stats.tl_runs--;
-#endif /* QDIO_PERFORMANCE_STATS */
+			if (qdio_performance_stats)
+				perf_stats.tl_runs--;
 			__qdio_inbound_processing(q);
 		}
 	}
@@ -1995,11 +1987,10 @@ qdio_handle_pci(struct qdio_irq *irq_ptr
 		return;
 	for (i=0;i<irq_ptr->no_output_qs;i++) {
 		q=irq_ptr->output_qs[i];
-#ifdef QDIO_PERFORMANCE_STATS
-		perf_stats.tl_runs--;
-#endif /* QDIO_PERFORMANCE_STATS */
 		if (qdio_is_outbound_q_done(q))
 			continue;
+		if (qdio_performance_stats)
+			perf_stats.tl_runs--;
 		if (!irq_ptr->sync_done_on_outb_pcis)
 			SYNC_MEMORY;
 		__qdio_outbound_processing(q);
@@ -3460,19 +3451,18 @@ do_qdio_handle_outbound(struct qdio_q *q
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
 
 	/* This is the outbound handling of queues */
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.start_time_outbound=NOW;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats)
+		perf_stats.start_time_outbound=NOW;
 
 	qdio_do_qdio_fill_output(q,qidx,count,buffers);
 
 	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 
 	if (callflags&QDIO_FLAG_DONT_SIGA) {
-#ifdef QDIO_PERFORMANCE_STATS
-		perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
-		perf_stats.outbound_cnt++;
-#endif /* QDIO_PERFORMANCE_STATS */
+		if (qdio_performance_stats) {
+			perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
+			perf_stats.outbound_cnt++;
+		}
 		return;
 	}
 	if (q->is_iqdio_q) {
@@ -3502,9 +3492,8 @@ do_qdio_handle_outbound(struct qdio_q *q
 				qdio_kick_outbound_q(q);
 			} else {
 				QDIO_DBF_TEXT3(0,trace, "fast-req");
-#ifdef QDIO_PERFORMANCE_STATS
-				perf_stats.fast_reqs++;
-#endif /* QDIO_PERFORMANCE_STATS */
+				if (qdio_performance_stats)
+					perf_stats.fast_reqs++;
 			}
 		}
 		/* 
@@ -3515,10 +3504,10 @@ do_qdio_handle_outbound(struct qdio_q *q
 		__qdio_outbound_processing(q);
 	}
 
-#ifdef QDIO_PERFORMANCE_STATS
-	perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
-	perf_stats.outbound_cnt++;
-#endif /* QDIO_PERFORMANCE_STATS */
+	if (qdio_performance_stats) {
+		perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
+		perf_stats.outbound_cnt++;
+	}
 }
 
 /* count must be 1 in iqdio */
@@ -3576,7 +3565,6 @@ do_QDIO(struct ccw_device *cdev,unsigned
 	return 0;
 }
 
-#ifdef QDIO_PERFORMANCE_STATS
 static int
 qdio_perf_procfile_read(char *buffer, char **buffer_location, off_t offset,
 			int buffer_length, int *eof, void *data)
@@ -3592,29 +3580,29 @@ qdio_perf_procfile_read(char *buffer, ch
 	_OUTP_IT("i_p_nc/c=%lu/%lu\n",i_p_nc,i_p_c);
 	_OUTP_IT("ii_p_nc/c=%lu/%lu\n",ii_p_nc,ii_p_c);
 	_OUTP_IT("o_p_nc/c=%lu/%lu\n",o_p_nc,o_p_c);
-	_OUTP_IT("Number of tasklet runs (total)                  : %u\n",
+	_OUTP_IT("Number of tasklet runs (total)                  : %lu\n",
 		 perf_stats.tl_runs);
 	_OUTP_IT("\n");
-	_OUTP_IT("Number of SIGA sync's issued                    : %u\n",
+	_OUTP_IT("Number of SIGA sync's issued                    : %lu\n",
 		 perf_stats.siga_syncs);
-	_OUTP_IT("Number of SIGA in's issued                      : %u\n",
+	_OUTP_IT("Number of SIGA in's issued                      : %lu\n",
 		 perf_stats.siga_ins);
-	_OUTP_IT("Number of SIGA out's issued                     : %u\n",
+	_OUTP_IT("Number of SIGA out's issued                     : %lu\n",
 		 perf_stats.siga_outs);
-	_OUTP_IT("Number of PCIs caught                           : %u\n",
+	_OUTP_IT("Number of PCIs caught                           : %lu\n",
 		 perf_stats.pcis);
-	_OUTP_IT("Number of adapter interrupts caught             : %u\n",
+	_OUTP_IT("Number of adapter interrupts caught             : %lu\n",
 		 perf_stats.thinints);
-	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %u\n",
+	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %lu\n",
 		 perf_stats.fast_reqs);
 	_OUTP_IT("\n");
-	_OUTP_IT("Total time of all inbound actions (us) incl. UL : %u\n",
+	_OUTP_IT("Total time of all inbound actions (us) incl. UL : %lu\n",
 		 perf_stats.inbound_time);
-	_OUTP_IT("Number of inbound transfers                     : %u\n",
+	_OUTP_IT("Number of inbound transfers                     : %lu\n",
 		 perf_stats.inbound_cnt);
-	_OUTP_IT("Total time of all outbound do_QDIOs (us)        : %u\n",
+	_OUTP_IT("Total time of all outbound do_QDIOs (us)        : %lu\n",
 		 perf_stats.outbound_time);
-	_OUTP_IT("Number of do_QDIOs outbound                     : %u\n",
+	_OUTP_IT("Number of do_QDIOs outbound                     : %lu\n",
 		 perf_stats.outbound_cnt);
 	_OUTP_IT("\n");
 
@@ -3622,12 +3610,10 @@ qdio_perf_procfile_read(char *buffer, ch
 }
 
 static struct proc_dir_entry *qdio_perf_proc_file;
-#endif /* QDIO_PERFORMANCE_STATS */
 
 static void
 qdio_add_procfs_entry(void)
 {
-#ifdef QDIO_PERFORMANCE_STATS
         proc_perf_file_registration=0;
 	qdio_perf_proc_file=create_proc_entry(QDIO_PERF,
 					      S_IFREG|0444,&proc_root);
@@ -3639,20 +3625,58 @@ qdio_add_procfs_entry(void)
                 QDIO_PRINT_WARN("was not able to register perf. " \
 				"proc-file (%i).\n",
 				proc_perf_file_registration);
-#endif /* QDIO_PERFORMANCE_STATS */
 }
 
 static void
 qdio_remove_procfs_entry(void)
 {
-#ifdef QDIO_PERFORMANCE_STATS
 	perf_stats.tl_runs=0;
 
         if (!proc_perf_file_registration) /* means if it went ok earlier */
 		remove_proc_entry(QDIO_PERF,&proc_root);
-#endif /* QDIO_PERFORMANCE_STATS */
 }
 
+/**
+ * attributes in sysfs
+ *****************************************************************************/
+
+static ssize_t
+qdio_performance_stats_show(struct bus_type *bus, char *buf)
+{
+	return sprintf(buf, "%i\n", qdio_performance_stats ? 1 : 0);
+}
+
+static ssize_t
+qdio_performance_stats_store(struct bus_type *bus, const char *buf, size_t count)
+{
+	char *tmp;
+	int i;
+
+	i = simple_strtoul(buf, &tmp, 16);
+	if ((i == 0) || (i == 1)) {
+		if (i == qdio_performance_stats)
+			return count;
+		qdio_performance_stats = i;
+		if (i==0) {
+			/* reset perf. stat. info */
+			i_p_nc = 0;
+			i_p_c = 0;
+			ii_p_nc = 0;
+			ii_p_c = 0;
+			o_p_nc = 0;
+			o_p_c = 0;
+			memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
+		}
+	} else {
+		QDIO_PRINT_WARN("QDIO performance_stats: write 0 or 1 to this file!\n");
+		return -EINVAL;
+	}
+	return count;
+}
+
+static BUS_ATTR(qdio_performance_stats, 0644, qdio_performance_stats_show,
+			qdio_performance_stats_store);
+
 static void
 tiqdio_register_thinints(void)
 {
@@ -3697,6 +3721,7 @@ qdio_release_qdio_memory(void)
 	kfree(indicators);
 }
 
+
 static void
 qdio_unregister_dbf_views(void)
 {
@@ -3798,9 +3823,7 @@ static int __init
 init_QDIO(void)
 {
 	int res;
-#ifdef QDIO_PERFORMANCE_STATS
 	void *ptr;
-#endif /* QDIO_PERFORMANCE_STATS */
 
 	printk("qdio: loading %s\n",version);
 
@@ -3813,13 +3836,12 @@ init_QDIO(void)
 		return res;
 
 	QDIO_DBF_TEXT0(0,setup,"initQDIO");
+	res = bus_create_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
 
-#ifdef QDIO_PERFORMANCE_STATS
-       	memset((void*)&perf_stats,0,sizeof(perf_stats));
+	memset((void*)&perf_stats,0,sizeof(perf_stats));
 	QDIO_DBF_TEXT0(0,setup,"perfstat");
 	ptr=&perf_stats;
 	QDIO_DBF_HEX0(0,setup,&ptr,sizeof(void*));
-#endif /* QDIO_PERFORMANCE_STATS */
 
 	qdio_add_procfs_entry();
 
@@ -3843,7 +3865,7 @@ cleanup_QDIO(void)
 	qdio_release_qdio_memory();
 	qdio_unregister_dbf_views();
 	mempool_destroy(qdio_mempool_scssc);
-
+	bus_remove_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
   	printk("qdio: %s: module removed\n",version);
 }
 
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2006-12-08 15:52:53.000000000 +0100
@@ -12,10 +12,6 @@
 #endif /* CONFIG_QDIO_DEBUG */
 #define QDIO_USE_PROCESSING_STATE
 
-#ifdef CONFIG_QDIO_PERF_STATS
-#define QDIO_PERFORMANCE_STATS
-#endif /* CONFIG_QDIO_PERF_STATS */
-
 #define QDIO_MINIMAL_BH_RELIEF_TIME 16
 #define QDIO_TIMER_POLL_VALUE 1
 #define IQDIO_TIMER_POLL_VALUE 1
@@ -409,25 +405,23 @@ do_clear_global_summary(void)
 #define CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS 0x08
 #define CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS 0x04
 
-#ifdef QDIO_PERFORMANCE_STATS
 struct qdio_perf_stats {
-	unsigned int tl_runs;
+	unsigned long tl_runs;
 
-	unsigned int siga_outs;
-	unsigned int siga_ins;
-	unsigned int siga_syncs;
-	unsigned int pcis;
-	unsigned int thinints;
-	unsigned int fast_reqs;
+	unsigned long siga_outs;
+	unsigned long siga_ins;
+	unsigned long siga_syncs;
+	unsigned long pcis;
+	unsigned long thinints;
+	unsigned long fast_reqs;
 
 	__u64 start_time_outbound;
-	unsigned int outbound_cnt;
-	unsigned int outbound_time;
+	unsigned long outbound_cnt;
+	unsigned long outbound_time;
 	__u64 start_time_inbound;
-	unsigned int inbound_cnt;
-	unsigned int inbound_time;
+	unsigned long inbound_cnt;
+	unsigned long inbound_time;
 };
-#endif /* QDIO_PERFORMANCE_STATS */
 
 /* unlikely as the later the better */
 #define SYNC_MEMORY if (unlikely(q->siga_sync)) qdio_siga_sync_q(q)
