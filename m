Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWIQRxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWIQRxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWIQRxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:53:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:7312 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965037AbWIQRxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:53:34 -0400
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
X-Sieve: CMU Sieve 2.3
X-Spam-TestScore: none
X-Spam-TokenSummary: Bayes not run.
X-Spam-Relay-Country: US ** US US ** US US ** US
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>, Balbir Singh <balbir@in.ibm.com>
Date: Sun, 17 Sep 2006 20:42:30 +0530
Message-Id: <20060917151230.11160.20384.sendpatchset@localhost.localdomain>
In-Reply-To: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
References: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH 2/4] Aggregated beancounters infrastructure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add support for aggregated beancounters. An aggregated beancounter contains
several beancounters. The default aggregator is called init_ab (similar to
init_bc). Aggregated beancounters are created without any limits imposed
on them.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/bc/beancounter.h |   48 +++++++-
 kernel/bc/beancounter.c  |  272 ++++++++++++++++++++++++++++++++++++++++-------
 kernel/bc/misc.c         |    2 
 3 files changed, 280 insertions(+), 42 deletions(-)

diff -puN include/bc/beancounter.h~add-aggr-bc include/bc/beancounter.h
--- linux-2.6.18-rc5/include/bc/beancounter.h~add-aggr-bc	2006-09-17 20:33:15.000000000 +0530
+++ linux-2.6.18-rc5-balbir/include/bc/beancounter.h	2006-09-17 20:33:15.000000000 +0530
@@ -18,6 +18,13 @@
 
 #define BC_RESOURCES	3
 
+struct ab_resource_parm {
+	unsigned long barrier;
+	unsigned long held;
+	unsigned long limit;	/* hard resource limit */
+	unsigned long failcnt;	/* count of failed charges */
+};
+
 struct bc_resource_parm {
 	unsigned long barrier;	/* A barrier over which resource allocations
 				 * are failed gracefully. e.g. if the amount
@@ -51,6 +58,27 @@ struct bc_resource_parm {
  */
 #define BC_MAGIC                0x62756275UL
 
+#define AB_HASH_BITS		8
+#define AB_HASH_SIZE		(1 << AB_HASH_BITS)
+#define ab_hash_fn(bcid)	(hash_long(bcid, AB_HASH_BITS))
+
+#define BC_HASH_BITS		5
+#define BC_HASH_SIZE		(1 << BC_HASH_BITS)
+#define bc_hash_fn(bcid)	(hash_long(bcid, BC_HASH_BITS))
+
+
+/*
+ * Aggregate beancounters - group independent BC's together to form groups
+ */
+struct aggr_beancounter {
+	struct ab_resource_parm	ab_parms[BC_RESOURCES];
+	atomic_t		ab_refcount;
+	struct hlist_head 	ab_bucket[AB_HASH_SIZE];
+	spinlock_t 		ab_lock;
+	struct hlist_node	hash;
+	bcid_t			ab_id;
+};
+
 /*
  *	Resource management structures
  * Serialization issues:
@@ -73,6 +101,7 @@ struct beancounter {
 #endif
 	/* resources statistics and settings */
 	struct bc_resource_parm	bc_parms[BC_RESOURCES];
+	struct aggr_beancounter *ab;
 };
 
 enum bc_severity { BC_BARRIER, BC_LIMIT, BC_FORCE };
@@ -118,7 +147,20 @@ int __must_check bc_charge(struct beanco
 void bc_uncharge_locked(struct beancounter *bc, int res, unsigned long val);
 void bc_uncharge(struct beancounter *bc, int res, unsigned long val);
 
-struct beancounter *beancounter_findcreate(bcid_t id, int mask);
+struct beancounter *beancounter_create(struct aggr_beancounter *ab, bcid_t id);
+struct beancounter *beancounter_find_locked(struct aggr_beancounter *ab,
+						bcid_t id);
+struct aggr_beancounter *ab_findcreate(bcid_t id, int mask);
+struct beancounter *beancounter_relocate(struct aggr_beancounter *dst_ab,
+						struct aggr_beancounter *src_ab,
+						bcid_t id);
+
+static inline struct aggr_beancounter *
+get_aggr_beancounter(struct aggr_beancounter *ab)
+{
+	atomic_inc(&ab->ab_refcount);
+	return ab;
+}
 
 static inline struct beancounter *get_beancounter(struct beancounter *bc)
 {
@@ -127,6 +169,7 @@ static inline struct beancounter *get_be
 }
 
 void put_beancounter(struct beancounter *bc);
+void put_aggr_beancounter(struct aggr_beancounter *ab);
 
 void bc_init_early(void);
 void bc_init_late(void);
@@ -139,7 +182,8 @@ extern const char *bc_rnames[];
 
 #define nr_beancounters 0
 
-#define beancounter_findcreate(id, f)			(NULL)
+#define beancounter_create(ab, id)			(NULL)
+#define beancounter_find_locked(ab, id)			(NULL)
 #define get_beancounter(bc)				(NULL)
 #define put_beancounter(bc)				do { } while (0)
 
diff -puN kernel/bc/beancounter.c~add-aggr-bc kernel/bc/beancounter.c
--- linux-2.6.18-rc5/kernel/bc/beancounter.c~add-aggr-bc	2006-09-17 20:33:15.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/beancounter.c	2006-09-17 20:33:15.000000000 +0530
@@ -14,11 +14,17 @@
 #include <bc/vmrss.h>
 
 static kmem_cache_t *bc_cachep;
+static kmem_cache_t *ab_cachep;
 static struct beancounter default_beancounter;
 
-static void init_beancounter_struct(struct beancounter *bc, bcid_t id);
+static void init_beancounter_struct(struct aggr_beancounter *ab,
+					struct beancounter *bc, bcid_t id);
+static void init_aggr_beancounter_struct(struct aggr_beancounter *ab,
+						bcid_t id);
+static void init_aggr_beancounter_parm_nolimits(struct aggr_beancounter *ab);
 
-struct beancounter init_bc;
+struct beancounter 	init_bc;
+struct aggr_beancounter init_ab;
 
 unsigned int nr_beancounters = 1;
 
@@ -28,12 +34,64 @@ const char *bc_rnames[] = {
 	"privvmpages",
 };
 
-#define BC_HASH_BITS		8
-#define BC_HASH_SIZE		(1 << BC_HASH_BITS)
+/*
+ * Aggregated beancounters are stored in ab_hash bucket
+ */
+static struct hlist_head 	ab_hash[AB_HASH_SIZE];
+spinlock_t 			ab_hash_lock;
+
+struct aggr_beancounter *ab_findcreate(bcid_t id, int mask)
+{
+	struct aggr_beancounter *new_ab, *ab;
+	unsigned long flags;
+	struct hlist_head *slot;
+	struct hlist_node *pos;
+
+	/*
+	 * Assumption: This function is called with a reference to ab held
+	 */
+	slot = &ab_hash[ab_hash_fn(id)];
+	new_ab = NULL;
+
+retry:
+	spin_lock_irqsave(&ab_hash_lock, flags);
+	hlist_for_each_entry (ab, pos, slot, hash)
+		if (ab->ab_id == id)
+			break;
 
-static struct hlist_head bc_hash[BC_HASH_SIZE];
-static spinlock_t bc_hash_lock;
-#define bc_hash_fn(bcid)	(hash_long(bcid, BC_HASH_BITS))
+	if (pos != NULL) {
+		get_aggr_beancounter(ab);
+		spin_unlock_irqrestore(&ab_hash_lock, flags);
+
+		if (new_ab != NULL)
+			kmem_cache_free(ab_cachep, new_ab);
+		return ab;
+	}
+
+	if (new_ab != NULL)
+		goto out_install;
+
+	spin_unlock_irqrestore(&ab_hash_lock, flags);
+
+	if (!(mask & BC_ALLOC))
+		goto out;
+
+	new_ab = kmem_cache_alloc(ab_cachep,
+			mask & BC_ALLOC_ATOMIC ? GFP_ATOMIC : GFP_KERNEL);
+	if (new_ab == NULL)
+		goto out;
+
+	init_aggr_beancounter_struct(new_ab, id);
+	init_aggr_beancounter_parm_nolimits(new_ab);
+	goto retry;
+
+out_install:
+	hlist_add_head(&new_ab->hash, slot);
+	nr_beancounters++;
+	spin_unlock_irqrestore(&ab_hash_lock, flags);
+out:
+	return new_ab;
+}
 
 /*
  *	Per resource beancounting. Resources are tied to their bc id.
@@ -47,63 +105,159 @@ static spinlock_t bc_hash_lock;
  *	will mean the old entry is still around with resource tied to it.
  */
 
-struct beancounter *beancounter_findcreate(bcid_t id, int mask)
+struct beancounter *beancounter_find_locked(struct aggr_beancounter *ab,
+						bcid_t id)
 {
-	struct beancounter *new_bc, *bc;
-	unsigned long flags;
+	struct beancounter *bc;
 	struct hlist_head *slot;
 	struct hlist_node *pos;
 
-	slot = &bc_hash[bc_hash_fn(id)];
-	new_bc = NULL;
+	/*
+	 * Assumption: This function is called with a reference to ab held
+	 */
+	slot = &ab->ab_bucket[bc_hash_fn(id)];
 
-retry:
-	spin_lock_irqsave(&bc_hash_lock, flags);
 	hlist_for_each_entry (bc, pos, slot, hash)
 		if (bc->bc_id == id)
 			break;
 
 	if (pos != NULL) {
 		get_beancounter(bc);
-		spin_unlock_irqrestore(&bc_hash_lock, flags);
+		return bc;
+	}
+	else
+		return NULL;
+}
+
+struct beancounter *beancounter_create(struct aggr_beancounter *ab, bcid_t id)
+{
+	unsigned long flags;
+	struct beancounter *bc = NULL, *new_bc;
+	struct hlist_head *slot;
+
+	get_aggr_beancounter(ab);
+	spin_lock_irqsave(&ab->ab_lock, flags);
+	bc = beancounter_find_locked(ab, id);
+	spin_unlock_irqrestore(&ab->ab_lock, flags);
 
-		if (new_bc != NULL)
-			kmem_cache_free(bc_cachep, new_bc);
+	if (bc)
 		return bc;
+	else {
+		new_bc = kmem_cache_alloc(bc_cachep, GFP_KERNEL);
+		*new_bc = default_beancounter;
+		init_beancounter_struct(ab, new_bc, id);
 	}
 
-	if (new_bc != NULL)
-		goto out_install;
+	spin_lock_irqsave(&ab->ab_lock, flags);
+	bc = beancounter_find_locked(ab, id);
+	if (unlikely(bc)) {
+		spin_unlock_irqrestore(&ab->ab_lock, flags);
+		kmem_cache_free(bc_cachep, new_bc);
+		return bc;
+	}
+	slot = &ab->ab_bucket[bc_hash_fn(id)];
+	hlist_add_head(&new_bc->hash, slot);
+	spin_unlock_irqrestore(&ab->ab_lock, flags);
+	return new_bc;
+}
 
-	spin_unlock_irqrestore(&bc_hash_lock, flags);
+static void double_ab_lock(struct aggr_beancounter *ab1,
+				struct aggr_beancounter *ab2,
+				unsigned long *flags)
+{
+	if (ab1 > ab2) {
+		spin_lock_irqsave(&ab1->ab_lock, *flags);
+		spin_lock(&ab2->ab_lock);
+	} else if (ab2 > ab1) {
+		spin_lock_irqsave(&ab2->ab_lock, *flags);
+		spin_lock(&ab1->ab_lock);
+	} else
+		BUG();
+}
 
-	if (!(mask & BC_ALLOC))
+static void double_ab_unlock(struct aggr_beancounter *ab1,
+				struct aggr_beancounter *ab2,
+				unsigned long *flags)
+{
+	if (ab1 > ab2) {
+		spin_unlock(&ab2->ab_lock);
+		spin_unlock_irqrestore(&ab1->ab_lock, *flags);
+	} else if (ab2 > ab1) {
+		spin_unlock(&ab1->ab_lock);
+		spin_unlock_irqrestore(&ab2->ab_lock, *flags);
+	} else
+		BUG();
+}
+
+/*
+ * This function should be called with a reference to dst_ab held
+ */
+struct beancounter *beancounter_relocate(struct aggr_beancounter *dst_ab,
+						struct aggr_beancounter *src_ab,
+						bcid_t id)
+{
+	unsigned long flags;
+	struct beancounter *bc = NULL, *new_bc;
+	struct hlist_head *slot;
+
+	double_ab_lock(dst_ab, src_ab, &flags);
+	bc = beancounter_find_locked(src_ab, id);
+	if (!bc)
 		goto out;
 
-	new_bc = kmem_cache_alloc(bc_cachep,
-			mask & BC_ALLOC_ATOMIC ? GFP_ATOMIC : GFP_KERNEL);
-	if (new_bc == NULL)
+	/*
+	 * Ideally this should be a BUG if new_bc is found.
+	 * But we allow a small margin for several threads migrating
+	 * to a new aggregated beancounter. BUG() it later.
+	 */
+	new_bc = beancounter_find_locked(dst_ab, id);
+	if (new_bc) {
+		bc = new_bc;
 		goto out;
+	}
 
-	*new_bc = default_beancounter;
-	init_beancounter_struct(new_bc, id);
-	goto retry;
+	spin_lock(&bc->bc_lock);
+	hlist_del(&bc->hash);
+	slot = &dst_ab->ab_bucket[bc_hash_fn(id)];
+	hlist_add_head(&bc->hash, slot);
+	bc->ab = dst_ab;
+	spin_unlock(&bc->bc_lock);
 
-out_install:
-	hlist_add_head(&new_bc->hash, slot);
-	nr_beancounters++;
-	spin_unlock_irqrestore(&bc_hash_lock, flags);
 out:
-	return new_bc;
+	put_aggr_beancounter(src_ab);
+	double_ab_unlock(dst_ab, src_ab, &flags);
+	return bc;
+}
+
+void put_aggr_beancounter(struct aggr_beancounter *ab)
+{
+	int i;
+	unsigned long flags;
+
+	if (!atomic_dec_and_lock_irqsave(&ab->ab_refcount,
+				&ab_hash_lock, flags))
+		return;
+
+	for (i = 0; i < BC_RESOURCES; i++)
+		if (ab->ab_parms[i].held != 0)
+			printk("AB: %d has %lu of %s held on put", ab->ab_id,
+				ab->ab_parms[i].held, bc_rnames[i]);
+
+	hlist_del(&ab->hash);
+	nr_beancounters--;
+	spin_unlock_irqrestore(&ab_hash_lock, flags);
+
+	kmem_cache_free(ab_cachep, ab);
 }
 
 void put_beancounter(struct beancounter *bc)
 {
 	int i;
 	unsigned long flags;
+	struct aggr_beancounter *ab = bc->ab;
 
 	if (!atomic_dec_and_lock_irqsave(&bc->bc_refcount,
-				&bc_hash_lock, flags))
+				&ab->ab_lock, flags))
 		return;
 
 	BUG_ON(bc == &init_bc);
@@ -123,9 +277,10 @@ void put_beancounter(struct beancounter 
 #endif
 	hlist_del(&bc->hash);
 	nr_beancounters--;
-	spin_unlock_irqrestore(&bc_hash_lock, flags);
+	spin_unlock_irqrestore(&ab->ab_lock, flags);
 
 	kmem_cache_free(bc_cachep, bc);
+	put_aggr_beancounter(ab);
 }
 
 EXPORT_SYMBOL_GPL(put_beancounter);
@@ -228,12 +383,38 @@ EXPORT_SYMBOL_GPL(bc_uncharge);
  *	of fields not initialized explicitly.
  */
 
-static void init_beancounter_struct(struct beancounter *bc, bcid_t id)
+static void init_beancounter_struct(struct aggr_beancounter *ab,
+					struct beancounter *bc, bcid_t id)
 {
 	bc->bc_magic = BC_MAGIC;
 	atomic_set(&bc->bc_refcount, 1);
 	spin_lock_init(&bc->bc_lock);
 	bc->bc_id = id;
+	bc->ab = ab;
+}
+
+static void init_aggr_beancounter_struct(struct aggr_beancounter *ab,
+						bcid_t ab_id)
+{
+	int i;
+
+	spin_lock_init(&ab->ab_lock);
+	ab->ab_id = ab_id;
+	atomic_set(&ab->ab_refcount, 1);
+	for (i = 0; i < AB_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&ab->ab_bucket[i]);
+	INIT_HLIST_NODE(&ab->hash);
+}
+
+static void init_aggr_beancounter_parm_nolimits(struct aggr_beancounter *ab)
+{
+	int k;
+
+	for (k = 0; k < BC_RESOURCES; k++) {
+		ab->ab_parms[k].held = 0;
+		ab->ab_parms[k].limit = BC_MAXVALUE;
+		ab->ab_parms[k].barrier = BC_MAXVALUE;
+	}
 }
 
 static void init_beancounter_nolimits(struct beancounter *bc)
@@ -261,17 +442,24 @@ static void init_beancounter_syslimits(s
 void __init bc_init_early(void)
 {
 	struct beancounter *bc;
+	struct aggr_beancounter *ab;
 	struct hlist_head *slot;
 
 	bc = &init_bc;
+	ab = &init_ab;
 
 	init_beancounter_nolimits(bc);
-	init_beancounter_struct(bc, 0);
+	init_aggr_beancounter_struct(ab, 0);
+	init_aggr_beancounter_parm_nolimits(ab);
+	init_beancounter_struct(ab, bc, 0);
 
-	spin_lock_init(&bc_hash_lock);
-	slot = &bc_hash[bc_hash_fn(bc->bc_id)];
+	slot = &ab->ab_bucket[bc_hash_fn(bc->bc_id)];
 	hlist_add_head(&bc->hash, slot);
 
+	spin_lock_init(&ab_hash_lock);
+	slot = &ab_hash[ab_hash_fn(ab->ab_id)];
+	hlist_add_head(&ab->hash, slot);
+
 	current->task_bc.exec_bc = get_beancounter(bc);
 	current->task_bc.fork_bc = get_beancounter(bc);
 }
@@ -279,12 +467,18 @@ void __init bc_init_early(void)
 void __init bc_init_late(void)
 {
 	struct beancounter *bc;
+	struct aggr_beancounter *ab;
 
 	bc_cachep = kmem_cache_create("beancounters",
 			sizeof(struct beancounter), 0,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL, NULL);
 
+	ab_cachep = kmem_cache_create("aggr_beancounters",
+			sizeof(struct aggr_beancounter), 0,
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL, NULL);
+
+	ab = &init_ab;
 	bc = &default_beancounter;
 	init_beancounter_syslimits(bc);
-	init_beancounter_struct(bc, 0);
+	init_beancounter_struct(ab, bc, 0);
 }
diff -puN kernel/bc/misc.c~add-aggr-bc kernel/bc/misc.c
--- linux-2.6.18-rc5/kernel/bc/misc.c~add-aggr-bc	2006-09-17 20:33:15.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/misc.c	2006-09-17 20:33:15.000000000 +0530
@@ -16,7 +16,7 @@ void bc_task_charge(struct task_struct *
 	struct beancounter *bc;
 
 	new_bc = &new->task_bc;
-	bc = beancounter_findcreate(new->tgid, BC_ALLOC);
+	bc = beancounter_create(parent->task_bc.exec_bc->ab, new->tgid);
 	if (!bc) {
 		printk(KERN_WARNING "failed to create bc %d for tgid %d\n",
 			bc->bc_id, new->tgid);
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
