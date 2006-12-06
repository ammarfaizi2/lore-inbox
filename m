Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935738AbWLFP0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935738AbWLFP0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935706AbWLFP0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:26:16 -0500
Received: from mout2.freenet.de ([194.97.50.155]:59935 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935644AbWLFP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:26:11 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -rt 3/3] Make trace_freerunning work; Take 2: change reset_trace_idx()
Date: Wed, 6 Dec 2006 16:26:38 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061205220257.1AECF3E2420@elvis.elte.hu> <200612061612.53254.fzu@wemgehoertderstaat.de> <200612061618.51150.fzu@wemgehoertderstaat.de>
In-Reply-To: <200612061618.51150.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061626.38945.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move atomic_set(&tr->underrun, 0) and atomic_set(&tr->overrun, 0)
occurrences into reset_trace_idx().
Note this leads to under/overrun being reset more often than before:
	- in the trace_all_cpus case.
	- from under check_critical_timing()

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- rt6-kw/kernel/latency_trace-tk2.2.c	2006-12-06 14:58:44.000000000 +0100
+++ rt6-kw/kernel/latency_trace.c	2006-12-06 15:37:08.000000000 +0100
@@ -1695,10 +1695,17 @@ __setup("preempt_thresh=", setup_preempt
 static inline void notrace reset_trace_idx(int cpu, struct cpu_trace *tr)
 {
 	if (trace_all_cpus)
-		for_each_online_cpu(cpu)
-			cpu_traces[cpu].trace_idx = 0;
-	else
+		for_each_online_cpu(cpu) {
+			tr = cpu_traces + cpu;
+			tr->trace_idx = 0;
+			atomic_set(&tr->underrun, 0);
+			atomic_set(&tr->overrun, 0);
+		}
+	else{
 		tr->trace_idx = 0;
+		atomic_set(&tr->underrun, 0);
+		atomic_set(&tr->overrun, 0);
+	}
 }
 
 #ifdef CONFIG_CRITICAL_TIMING
@@ -1842,8 +1849,6 @@ __start_critical_timing(unsigned long ei
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->critical_start = eip;
-	atomic_set(&tr->underrun, 0);
-	atomic_set(&tr->overrun, 0);
 	reset_trace_idx(cpu, tr);
 	tr->latency_type = latency_type;
 	_trace_cmdline(cpu, tr);
@@ -2221,8 +2226,6 @@ void __trace_start_sched_wakeup(struct t
 		tr->preempt_timestamp = get_monotonic_cycles();
 		tr->latency_type = WAKEUP_LATENCY;
 		tr->critical_start = CALLER_ADDR0;
-		atomic_set(&tr->underrun, 0);
-		atomic_set(&tr->overrun, 0);
 		_trace_cmdline(raw_smp_processor_id(), tr);
 		atomic_dec(&tr->disabled);
 //	}
@@ -2332,8 +2335,6 @@ long user_trace_start(void)
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->critical_start = CALLER_ADDR0;
-	atomic_set(&tr->underrun, 0);
-	atomic_set(&tr->overrun, 0);
 	_trace_cmdline(cpu, tr);
 	mcount();
 
