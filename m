Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWBYTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWBYTIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWBYTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:08:06 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:7567 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161070AbWBYTHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:07:47 -0500
Date: Sat, 25 Feb 2006 16:08:18 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 5/6] pktgen: Ports if_list to the in-kernel implementation.
Message-ID: <20060225160818.276d244e@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 This patch ports the per-thread interface list list to the in-kernel linked
list implementation. In the general, the resulting code is a bit simpler.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

---

 net/core/pktgen.c |   92 +++++++++++++++++++++++++----------------------------
 1 files changed, 44 insertions(+), 48 deletions(-)

31bc49027940cd679fff67215c72c82fe958ad20
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 89480e3..5d13626 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -210,7 +210,7 @@ struct pktgen_dev {
 	char result[512];
 
 	struct pktgen_thread *pg_thread;	/* the owner */
-	struct pktgen_dev *next;	/* Used for chaining in the thread's run-queue */
+	struct list_head list;		/* Used for chaining in the thread's run-queue */
 
 	int running;		/* if this changes to false, the test will stop */
 
@@ -330,7 +330,7 @@ struct pktgen_hdr {
 
 struct pktgen_thread {
 	spinlock_t if_lock;
-	struct pktgen_dev *if_list;	/* All device here */
+	struct list_head if_list;	/* All device here */
 	struct list_head th_list;
 	int removed;
 	char name[32];
@@ -1378,7 +1378,7 @@ static struct file_operations pktgen_if_
 static int pktgen_thread_show(struct seq_file *seq, void *v)
 {
 	struct pktgen_thread *t = seq->private;
-	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_dev *pkt_dev;
 
 	BUG_ON(!t);
 
@@ -1388,13 +1388,13 @@ static int pktgen_thread_show(struct seq
 	seq_printf(seq, "Running: ");
 
 	if_lock(t);
-	for (pkt_dev = t->if_list; pkt_dev; pkt_dev = pkt_dev->next)
+	list_for_each_entry(pkt_dev, &t->if_list, list)
 		if (pkt_dev->running)
 			seq_printf(seq, "%s ", pkt_dev->ifname);
 
 	seq_printf(seq, "\nStopped: ");
 
-	for (pkt_dev = t->if_list; pkt_dev; pkt_dev = pkt_dev->next)
+	list_for_each_entry(pkt_dev, &t->if_list, list)
 		if (!pkt_dev->running)
 			seq_printf(seq, "%s ", pkt_dev->ifname);
 
@@ -2421,13 +2421,13 @@ static void pktgen_clear_counters(struct
 
 static void pktgen_run(struct pktgen_thread *t)
 {
-	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_dev *pkt_dev;
 	int started = 0;
 
 	PG_DEBUG(printk("pktgen: entering pktgen_run. %p\n", t));
 
 	if_lock(t);
-	for (pkt_dev = t->if_list; pkt_dev; pkt_dev = pkt_dev->next) {
+	list_for_each_entry(pkt_dev, &t->if_list, list) {
 
 		/*
 		 * setup odev and create initial packet.
@@ -2468,15 +2468,14 @@ static void pktgen_stop_all_threads_ifs(
 
 static int thread_is_running(struct pktgen_thread *t)
 {
-	struct pktgen_dev *next;
+	struct pktgen_dev *pkt_dev;
 	int res = 0;
 
-	for (next = t->if_list; next; next = next->next) {
-		if (next->running) {
+	list_for_each_entry(pkt_dev, &t->if_list, list)
+		if (pkt_dev->running) {
 			res = 1;
 			break;
 		}
-	}
 	return res;
 }
 
@@ -2597,17 +2596,17 @@ static int pktgen_stop_device(struct pkt
 
 static struct pktgen_dev *next_to_run(struct pktgen_thread *t)
 {
-	struct pktgen_dev *next, *best = NULL;
+	struct pktgen_dev *pkt_dev, *best = NULL;
 
 	if_lock(t);
 
-	for (next = t->if_list; next; next = next->next) {
-		if (!next->running)
+	list_for_each_entry(pkt_dev, &t->if_list, list) {
+		if (!pkt_dev->running)
 			continue;
 		if (best == NULL)
-			best = next;
-		else if (next->next_tx_us < best->next_tx_us)
-			best = next;
+			best = pkt_dev;
+		else if (pkt_dev->next_tx_us < best->next_tx_us)
+			best = pkt_dev;
 	}
 	if_unlock(t);
 	return best;
@@ -2615,18 +2614,18 @@ static struct pktgen_dev *next_to_run(st
 
 static void pktgen_stop(struct pktgen_thread *t)
 {
-	struct pktgen_dev *next = NULL;
+	struct pktgen_dev *pkt_dev;
 
 	PG_DEBUG(printk("pktgen: entering pktgen_stop\n"));
 
 	if_lock(t);
 
-	for (next = t->if_list; next; next = next->next) {
-		pktgen_stop_device(next);
-		if (next->skb)
-			kfree_skb(next->skb);
+	list_for_each_entry(pkt_dev, &t->if_list, list) {
+		pktgen_stop_device(pkt_dev);
+		if (pkt_dev->skb)
+			kfree_skb(pkt_dev->skb);
 
-		next->skb = NULL;
+		pkt_dev->skb = NULL;
 	}
 
 	if_unlock(t);
@@ -2638,14 +2637,15 @@ static void pktgen_stop(struct pktgen_th
  */
 static void pktgen_rem_one_if(struct pktgen_thread *t)
 {
-	struct pktgen_dev *cur, *next = NULL;
+	struct list_head *q, *n;
+	struct pktgen_dev *cur;
 
 	PG_DEBUG(printk("pktgen: entering pktgen_rem_one_if\n"));
 
 	if_lock(t);
 
-	for (cur = t->if_list; cur; cur = next) {
-		next = cur->next;
+	list_for_each_safe(q, n, &t->if_list) {
+		cur = list_entry(q, struct pktgen_dev, list);
 
 		if (!cur->removal_mark)
 			continue;
@@ -2664,15 +2664,16 @@ static void pktgen_rem_one_if(struct pkt
 
 static void pktgen_rem_all_ifs(struct pktgen_thread *t)
 {
-	struct pktgen_dev *cur, *next = NULL;
+	struct list_head *q, *n;
+	struct pktgen_dev *cur;
 
 	/* Remove all devices, free mem */
 
 	PG_DEBUG(printk("pktgen: entering pktgen_rem_all_ifs\n"));
 	if_lock(t);
 
-	for (cur = t->if_list; cur; cur = next) {
-		next = cur->next;
+	list_for_each_safe(q, n, &t->if_list) {
+		cur = list_entry(q, struct pktgen_dev, list);
 
 		if (cur->skb)
 			kfree_skb(cur->skb);
@@ -2959,14 +2960,14 @@ static void pktgen_thread_worker(struct 
 static struct pktgen_dev *pktgen_find_dev(struct pktgen_thread *t,
 					  const char *ifname)
 {
-	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_dev *p, *pkt_dev = NULL;
 	if_lock(t);
 
-	for (pkt_dev = t->if_list; pkt_dev; pkt_dev = pkt_dev->next) {
-		if (strncmp(pkt_dev->ifname, ifname, IFNAMSIZ) == 0) {
+	list_for_each_entry(p, &t->if_list, list)
+		if (strncmp(p->ifname, ifname, IFNAMSIZ) == 0) {
+			pkt_dev = p;
 			break;
 		}
-	}
 
 	if_unlock(t);
 	PG_DEBUG(printk("pktgen: find_dev(%s) returning %p\n", ifname, pkt_dev));
@@ -2989,8 +2990,8 @@ static int add_dev_to_thread(struct pktg
 		rv = -EBUSY;
 		goto out;
 	}
-	pkt_dev->next = t->if_list;
-	t->if_list = pkt_dev;
+
+	list_add(&pkt_dev->list, &t->if_list);
 	pkt_dev->pg_thread = t;
 	pkt_dev->running = 0;
 
@@ -3117,6 +3118,8 @@ static int __init pktgen_create_thread(c
 	pe->proc_fops = &pktgen_thread_fops;
 	pe->data = t;
 
+	INIT_LIST_HEAD(&t->if_list);
+
 	list_add_tail(&t->th_list, &pktgen_threads);
 
 	t->removed = 0;
@@ -3140,20 +3143,13 @@ static int __init pktgen_create_thread(c
 static void _rem_dev_from_if_list(struct pktgen_thread *t,
 				  struct pktgen_dev *pkt_dev)
 {
-	struct pktgen_dev *i, *prev = NULL;
-
-	i = t->if_list;
+	struct list_head *q, *n;
+	struct pktgen_dev *p;
 
-	while (i) {
-		if (i == pkt_dev) {
-			if (prev)
-				prev->next = i->next;
-			else
-				t->if_list = NULL;
-			break;
-		}
-		prev = i;
-		i = i->next;
+	list_for_each_safe(q, n, &t->if_list) {
+		p = list_entry(q, struct pktgen_dev, list);
+		if (p == pkt_dev)
+			list_del(&p->list);
 	}
 }
 
-- 
1.2.1.g3397f9


-- 
Luiz Fernando N. Capitulino
