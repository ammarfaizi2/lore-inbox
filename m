Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWA3BYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWA3BYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 20:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWA3BYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 20:24:21 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:38784 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751219AbWA3BYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 20:24:14 -0500
Date: Sun, 29 Jan 2006 23:21:44 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 2/4]  pktgen: Ports thread list to Kernel list
 implementation.
Message-ID: <20060129232144.0057964f@localhost>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Ports the thread list to use the Linux Kernel linked list implementation.
The final result is a simpler and smaller code.

 Note that I'm adding a new member in the struct pktgen_thread called
'removed'. The reason is that I didn't find a better wait condition to be
used in the place of the replaced one. Suggestions are very welcome.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>


---

 net/core/pktgen.c |   96 +++++++++++++++++++++++------------------------------
 1 files changed, 41 insertions(+), 55 deletions(-)

3679f7d860ed28c86f0c8e1d6c1b4d9ee1e716d7
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index a6a45b9..b9dea09 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -125,6 +125,7 @@
 #include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/list.h>
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
@@ -327,7 +328,8 @@ struct pktgen_hdr {
 struct pktgen_thread {
 	spinlock_t if_lock;
 	struct pktgen_dev *if_list;	/* All device here */
-	struct pktgen_thread *next;
+	struct list_head th_list;
+	int removed;
 	char name[32];
 	char result[512];
 	u32 max_before_softirq;	/* We'll call do_softirq to prevent starvation. */
@@ -489,7 +491,7 @@ static int pg_clone_skb_d;
 static int debug;
 
 static DECLARE_MUTEX(pktgen_sem);
-static struct pktgen_thread *pktgen_threads = NULL;
+static LIST_HEAD(pktgen_threads);
 
 static struct notifier_block pktgen_notifier_block = {
 	.notifier_call = pktgen_device_event,
@@ -1522,9 +1524,7 @@ static struct pktgen_dev *__pktgen_NN_th
 	struct pktgen_thread *t;
 	struct pktgen_dev *pkt_dev = NULL;
 
-	t = pktgen_threads;
-
-	while (t) {
+	list_for_each_entry(t, &pktgen_threads, th_list) {
 		pkt_dev = pktgen_find_dev(t, ifname);
 		if (pkt_dev) {
 			if (remove) {
@@ -1534,7 +1534,6 @@ static struct pktgen_dev *__pktgen_NN_th
 			}
 			break;
 		}
-		t = t->next;
 	}
 	return pkt_dev;
 }
@@ -2422,15 +2421,15 @@ static void pktgen_run(struct pktgen_thr
 
 static void pktgen_stop_all_threads_ifs(void)
 {
-	struct pktgen_thread *t = pktgen_threads;
+	struct pktgen_thread *t;
 
 	PG_DEBUG(printk("pktgen: entering pktgen_stop_all_threads.\n"));
 
 	thread_lock();
-	while (t) {
+
+	list_for_each_entry(t, &pktgen_threads, th_list)
 		pktgen_stop(t);
-		t = t->next;
-	}
+
 	thread_unlock();
 }
 
@@ -2472,40 +2471,36 @@ signal:
 
 static int pktgen_wait_all_threads_run(void)
 {
-	struct pktgen_thread *t = pktgen_threads;
+	struct pktgen_thread *t;
 	int sig = 1;
 
-	while (t) {
+	thread_lock();
+
+	list_for_each_entry(t, &pktgen_threads, th_list) {
 		sig = pktgen_wait_thread_run(t);
 		if (sig == 0)
 			break;
-		thread_lock();
-		t = t->next;
-		thread_unlock();
 	}
-	if (sig == 0) {
-		thread_lock();
-		while (t) {
+
+	if (sig == 0)
+		list_for_each_entry(t, &pktgen_threads, th_list)
 			t->control |= (T_STOP);
-			t = t->next;
-		}
-		thread_unlock();
-	}
+
+	thread_unlock();
 	return sig;
 }
 
 static void pktgen_run_all_threads(void)
 {
-	struct pktgen_thread *t = pktgen_threads;
+	struct pktgen_thread *t;
 
 	PG_DEBUG(printk("pktgen: entering pktgen_run_all_threads.\n"));
 
 	thread_lock();
 
-	while (t) {
+	list_for_each_entry(t, &pktgen_threads, th_list)
 		t->control |= (T_RUN);
-		t = t->next;
-	}
+
 	thread_unlock();
 
 	schedule_timeout_interruptible(msecs_to_jiffies(125));	/* Propagate thread->control  */
@@ -2625,24 +2620,12 @@ static void pktgen_rem_thread(struct pkt
 {
 	/* Remove from the thread list */
 
-	struct pktgen_thread *tmp = pktgen_threads;
-
 	remove_proc_entry(t->name, pg_proc_dir);
 
 	thread_lock();
 
-	if (tmp == t)
-		pktgen_threads = tmp->next;
-	else {
-		while (tmp) {
-			if (tmp->next == t) {
-				tmp->next = t->next;
-				t->next = NULL;
-				break;
-			}
-			tmp = tmp->next;
-		}
-	}
+	list_del(&t->th_list);
+
 	thread_unlock();
 }
 
@@ -2890,6 +2873,8 @@ static void pktgen_thread_worker(struct 
 
 	PG_DEBUG(printk("pktgen: %s removing thread.\n", t->name));
 	pktgen_rem_thread(t);
+
+	t->removed = 1;
 }
 
 static struct pktgen_dev *pktgen_find_dev(struct pktgen_thread *t,
@@ -3001,19 +2986,18 @@ static int pktgen_add_device(struct pktg
 
 static struct pktgen_thread *__init pktgen_find_thread(const char *name)
 {
-	struct pktgen_thread *t = NULL;
+	struct pktgen_thread *t;
 
 	thread_lock();
 
-	t = pktgen_threads;
-	while (t) {
-		if (strcmp(t->name, name) == 0)
-			break;
+	list_for_each_entry(t, &pktgen_threads, th_list)
+		if (strcmp(t->name, name) == 0) {
+			thread_unlock();
+			return t;
+		}
 
-		t = t->next;
-	}
 	thread_unlock();
-	return t;
+	return NULL;
 }
 
 static int __init pktgen_create_thread(const char *name, int cpu)
@@ -3052,8 +3036,9 @@ static int __init pktgen_create_thread(c
 	pe->proc_fops = &pktgen_thread_fops;
 	pe->data = t;
 
-	t->next = pktgen_threads;
-	pktgen_threads = t;
+	list_add_tail(&t->th_list, &pktgen_threads);
+
+	t->removed = 0;
 
 	if (kernel_thread((void *)pktgen_thread_worker, (void *)t,
 			  CLONE_FS | CLONE_FILES | CLONE_SIGHAND) < 0)
@@ -3154,17 +3139,18 @@ static int __init pg_init(void)
 
 static void __exit pg_cleanup(void)
 {
+	struct pktgen_thread *t;
+	struct list_head *q, *n;
 	wait_queue_head_t queue;
 	init_waitqueue_head(&queue);
 
 	/* Stop all interfaces & threads */
 
-	while (pktgen_threads) {
-		struct pktgen_thread *t = pktgen_threads;
-		pktgen_threads->control |= (T_TERMINATE);
+	list_for_each_safe(q, n, &pktgen_threads) {
+		t = list_entry(q, struct pktgen_thread, th_list);
+		t->control |= (T_TERMINATE);
 
-		wait_event_interruptible_timeout(queue, (t != pktgen_threads),
-						 HZ);
+		wait_event_interruptible_timeout(queue, (t->removed == 1), HZ);
 	}
 
 	/* Un-register us from receiving netdevice events */
-- 
1.1.5.g3480


-- 
Luiz Fernando N. Capitulino
