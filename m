Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVI0ScP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVI0ScP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVI0ScO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:32:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55804 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750927AbVI0ScN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:32:13 -0400
Subject: [PATCH] RT: update rcurefs for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 27 Sep 2005 11:32:06 -0700
Message-Id: <1127845926.4004.22.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make rcurefs compatible with RT w/o cmpxchg() .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/kernel/rcupdate.c
===================================================================
--- linux-2.6.13.orig/kernel/rcupdate.c
+++ linux-2.6.13/kernel/rcupdate.c
@@ -96,6 +96,25 @@ static void rcu_torture_init(void);
 static inline void rcu_torture_init(void) { }
 #endif
 
+#ifndef __HAVE_ARCH_CMPXCHG
+/*
+ * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
+ * 32 bit atomic_t implementations, and a hash function similar to that
+ * for our refcounting needs.
+ * Can't help multiprocessors which donot have cmpxchg :(
+ */
+spinlock_t __rcuref_hash[RCUREF_HASH_SIZE];
+
+static inline void init_rcurefs(void)
+{
+	int i;
+	for (i=0; i < RCUREF_HASH_SIZE; i++) 
+		SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);
+}
+#else
+#define init_rcurefs()	do { } while (0)
+#endif
+
 #ifndef CONFIG_PREEMPT_RCU
 
 /* Definition for rcupdate control block. */
@@ -123,18 +142,6 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int maxbatch = 10;
 
-#ifndef __HAVE_ARCH_CMPXCHG
-/*
- * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
- * 32 bit atomic_t implementations, and a hash function similar to that
- * for our refcounting needs.
- * Can't help multiprocessors which donot have cmpxchg :(
- */
-
-spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
-	[0 ... (RCUREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
-};
-#endif
 
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
@@ -487,6 +494,7 @@ static struct notifier_block __devinitda
  */
 void __init rcu_init(void)
 {
+	init_rcurefs();
 	rcu_torture_init();
 	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
 			(void *)(long)smp_processor_id());
@@ -824,6 +832,7 @@ rcu_pending(int cpu)
 
 void __init rcu_init(void)
 {
+	init_rcurefs();
 	rcu_torture_init();
 /*&&&&*/printk("WARNING: experimental RCU implementation.\n");
 	spin_lock_init(&rcu_data.lock);


