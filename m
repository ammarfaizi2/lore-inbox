Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266645AbUF3MWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266645AbUF3MWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUF3MV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:21:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:37024 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266648AbUF3MVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:21:18 -0400
Date: Wed, 30 Jun 2004 14:21:11 +0200 (MEST)
Message-Id: <200406301221.i5UCLBLD014208@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update 4/6: PPC32 cleanups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- PPC32 cleanups: change get_cpu_cache() to return a pointer instead
  of an lvalue; eliminate duplicated initialisation and cleanup code;
  reduce size of non-preemptible code regions

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm4/drivers/perfctr/ppc.c.~1~	2004-06-29 18:05:23.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/ppc.c	2004-06-29 21:29:23.221577000 +0200
@@ -22,7 +22,7 @@
 	unsigned int ppc_mmcr[3];
 } ____cacheline_aligned;
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
-#define get_cpu_cache()	__get_cpu_var(per_cpu_cache)
+#define get_cpu_cache()	(&__get_cpu_var(per_cpu_cache))
 
 /* Structure for counter snapshots, as 32-bit values. */
 struct perfctr_low_ctrs {
@@ -245,7 +245,7 @@
 	if (state->cstatus & (1<<30)) {
 		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
 		state->ppc_mmcr[0] = mmcr0;
-		get_cpu_cache().ppc_mmcr[0] = mmcr0;
+		get_cpu_cache()->ppc_mmcr[0] = mmcr0;
 	}
 }
 
@@ -367,7 +367,7 @@
 	struct per_cpu_cache *cache;
 	unsigned int value;
 
-	cache = &get_cpu_cache();
+	cache = get_cpu_cache();
 	if (cache->k1.id == state->k1.id)
 		return;
 	/*
@@ -466,7 +466,7 @@
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
-	get_cpu_cache().k1.id = 0;
+	get_cpu_cache()->k1.id = 0;
 #endif
 }
 
@@ -609,7 +609,7 @@
 {
 	struct per_cpu_cache *cache;
 
-	cache = &get_cpu_cache();
+	cache = get_cpu_cache();
 	memset(cache, 0, sizeof *cache);
 	cache->k1.id = -1;
 
@@ -848,18 +848,17 @@
 	return 0;
 }
 
-static void __init perfctr_cpu_init_one(void *ignore)
+static void perfctr_cpu_clear_one(void *ignore)
 {
-	/* PREEMPT note: when called via smp_call_function(),
+	/* PREEMPT note: when called via on_each_cpu(),
 	   this is in IRQ context with preemption disabled. */
 	perfctr_cpu_clear_counters();
 }
 
-static void __exit perfctr_cpu_exit_one(void *ignore)
+static void perfctr_cpu_reset(void)
 {
-	/* PREEMPT note: when called via smp_call_function(),
-	   this is in IRQ context with preemption disabled. */
-	perfctr_cpu_clear_counters();
+	on_each_cpu(perfctr_cpu_clear_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
 }
 
 static int init_done;
@@ -868,8 +867,6 @@
 {
 	int err;
 
-	preempt_disable();
-
 	perfctr_info.cpu_features = 0;
 
 	err = known_init();
@@ -879,22 +876,15 @@
 			goto out;
 	}
 
-	perfctr_cpu_init_one(NULL);
-	smp_call_function(perfctr_cpu_init_one, NULL, 1, 1);
-	perfctr_cpu_set_ihandler(NULL);
+	perfctr_cpu_reset();
 	init_done = 1;
  out:
-	preempt_enable();
 	return err;
 }
 
 void __exit perfctr_cpu_exit(void)
 {
-	preempt_disable();
-	perfctr_cpu_exit_one(NULL);
-	smp_call_function(perfctr_cpu_exit_one, NULL, 1, 1);
-	perfctr_cpu_set_ihandler(NULL);
-	preempt_enable();
+	perfctr_cpu_reset();
 }
 
 /****************************************************************
@@ -920,13 +910,6 @@
 	return ret;
 }
 
-static void perfctr_cpu_clear_one(void *ignore)
-{
-	/* PREEMPT note: when called via smp_call_function(),
-	   this is in IRQ context with preemption disabled. */
-	perfctr_cpu_clear_counters();
-}
-
 void perfctr_cpu_release(const char *service)
 {
 	down(&mutex);
@@ -935,8 +918,7 @@
 		       __FUNCTION__, service, current_service);
 	} else {
 		/* power down the counters */
-		on_each_cpu(perfctr_cpu_clear_one, NULL, 1, 1);
-		perfctr_cpu_set_ihandler(NULL);
+		perfctr_cpu_reset();
 		current_service = 0;
 	}
 	up(&mutex);
--- linux-2.6.7-mm4/drivers/perfctr/ppc_tests.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/ppc_tests.c	2004-06-29 21:20:28.591577000 +0200
@@ -282,5 +282,7 @@
 
 void __init perfctr_ppc_init_tests(int have_mmcr1)
 {
+	preempt_disable();
 	measure_overheads(have_mmcr1);
+	preempt_enable();
 }
