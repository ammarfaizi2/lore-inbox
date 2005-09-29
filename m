Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVI2PVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVI2PVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVI2PVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:21:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23548 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932196AbVI2PVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:21:06 -0400
Subject: Re: [PATCH] RT: update rcurefs for RT
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050929114235.GA638@elte.hu>
References: <1127845926.4004.22.camel@dhcp153.mvista.com>
	 <20050929114235.GA638@elte.hu>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 08:20:58 -0700
Message-Id: <1128007259.11511.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 13:42 +0200, Ingo Molnar wrote:

> > +		SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);
> 
> what the heck is this doing??? Patch reverted.

How is this ?

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
+		__rcuref_hash[i] = SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);
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


