Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbUKOUKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUKOUKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUKOUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:02:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261679AbUKOTzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:55:04 -0500
Date: Mon, 15 Nov 2004 14:51:16 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] SELinux scalability - convert AVC to RCU
In-Reply-To: <Xine.LNX.4.44.0411151447570.21180@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0411151448580.21180-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements an RCU scheme by Kaigai Kohei for the SELinux Access
Vector Cache (AVC), improving the scalability of SELinux.

AVC nodes are also allocated now via a slab cache, and AVC references have
been removed from the code.

Please apply.

Signed-off-by: Kaigai Kohei <kaigai@ak.jp.nec.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@redhat.com>

---

 security/selinux/avc.c            |  476 +++++++++++++++++++-------------------
 security/selinux/hooks.c          |  162 +++++-------
 security/selinux/include/avc.h    |   23 -
 security/selinux/include/objsec.h |    6 
 security/selinux/selinuxfs.c      |    2 
 5 files changed, 314 insertions(+), 355 deletions(-)

diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/avc.c linux-2.6.10-rc1-mm1.w/security/selinux/avc.c
--- linux-2.6.10-rc1-mm1.p/security/selinux/avc.c	2004-10-28 11:57:13.438497896 -0400
+++ linux-2.6.10-rc1-mm1.w/security/selinux/avc.c	2004-10-28 11:56:39.048725936 -0400
@@ -4,6 +4,9 @@
  * Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
  *           James Morris <jmorris@redhat.com>
  *
+ * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>
+ *     Replaced the avc_lock spinlock by RCU.
+ *
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
  *	This program is free software; you can redistribute it and/or modify
@@ -36,26 +39,29 @@
 #include "objsec.h"
 
 #define AVC_CACHE_SLOTS		512
-#define AVC_CACHE_MAXNODES	410
+#define AVC_CACHE_THRESHOLD	512
+#define AVC_CACHE_RECLAIM	16
 
 struct avc_entry {
 	u32			ssid;
 	u32			tsid;
 	u16			tclass;
 	struct av_decision	avd;
-	int			used;	/* used recently */
+	atomic_t		used;	/* used recently */
 };
 
 struct avc_node {
 	struct avc_entry	ae;
-	struct avc_node		*next;
+	struct list_head	list;
+	struct rcu_head         rhead;
 };
 
 struct avc_cache {
-	struct avc_node	*slots[AVC_CACHE_SLOTS];
-	u32		lru_hint;	/* LRU hint for reclaim scan */
-	u32		active_nodes;
-	u32		latest_notif;	/* latest revocation notification */
+	struct list_head	slots[AVC_CACHE_SLOTS];
+	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
+	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
+	atomic_t		active_nodes;
+	u32			latest_notif;	/* latest revocation notification */
 };
 
 struct avc_callback_node {
@@ -70,11 +76,10 @@ struct avc_callback_node {
 	struct avc_callback_node *next;
 };
 
-static spinlock_t avc_lock = SPIN_LOCK_UNLOCKED;
-static struct avc_node *avc_node_freelist;
 static struct avc_cache avc_cache;
 static unsigned avc_cache_stats[AVC_NSTATS];
 static struct avc_callback_node *avc_callbacks;
+static kmem_cache_t *avc_node_cachep;
 
 static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
@@ -188,20 +193,17 @@ void avc_dump_query(struct audit_buffer 
  */
 void __init avc_init(void)
 {
-	struct avc_node	*new;
 	int i;
 
-	for (i = 0; i < AVC_CACHE_MAXNODES; i++) {
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
-		if (!new) {
-			printk(KERN_WARNING "avc:  only able to allocate "
-			       "%d entries\n", i);
-			break;
-		}
-		memset(new, 0, sizeof(*new));
-		new->next = avc_node_freelist;
-		avc_node_freelist = new;
+	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
+		INIT_LIST_HEAD(&avc_cache.slots[i]);
+		avc_cache.slots_lock[i] = SPIN_LOCK_UNLOCKED;
 	}
+	atomic_set(&avc_cache.active_nodes, 0);
+	atomic_set(&avc_cache.lru_hint, 0);
+	
+	avc_node_cachep = kmem_cache_create("avc_node", sizeof(struct avc_node),
+					     0, SLAB_PANIC, NULL, NULL);
 
 	audit_log(current->audit_context, "AVC INITIALIZED\n");
 }
@@ -211,120 +213,130 @@ static void avc_hash_eval(char *tag)
 {
 	int i, chain_len, max_chain_len, slots_used;
 	struct avc_node *node;
-	unsigned long flags;
 
-	spin_lock_irqsave(&avc_lock,flags);
+	rcu_read_lock();
 
 	slots_used = 0;
 	max_chain_len = 0;
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		node = avc_cache.slots[i];
-		if (node) {
+		if (!list_empty(&avc_cache.slots[i])) {
 			slots_used++;
 			chain_len = 0;
-			while (node) {
+			list_for_each_entry_rcu(node, &avc_cache.slots[i], list)
 				chain_len++;
-				node = node->next;
-			}
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
 		}
 	}
 
-	spin_unlock_irqrestore(&avc_lock,flags);
+	rcu_read_unlock();
 
 	printk(KERN_INFO "\n");
 	printk(KERN_INFO "%s avc:  %d entries and %d/%d buckets used, longest "
-	       "chain length %d\n", tag, avc_cache.active_nodes, slots_used,
-	       AVC_CACHE_SLOTS, max_chain_len);
+	       "chain length %d\n", tag, atomic_read(&avc_cache.active_nodes),
+		slots_used, AVC_CACHE_SLOTS, max_chain_len);
 }
 #else
 static inline void avc_hash_eval(char *tag)
 { }
 #endif
 
-static inline struct avc_node *avc_reclaim_node(void)
+static void avc_node_free(struct rcu_head *rhead)
 {
-	struct avc_node *prev, *cur;
-	int hvalue, try;
-
-	hvalue = avc_cache.lru_hint;
-	for (try = 0; try < 2; try++) {
-		do {
-			prev = NULL;
-			cur = avc_cache.slots[hvalue];
-			while (cur) {
-				if (!cur->ae.used)
-					goto found;
+	struct avc_node *node = container_of(rhead, struct avc_node, rhead);
+	kmem_cache_free(avc_node_cachep, node);
+}
 
-				cur->ae.used = 0;
+static void avc_node_delete(struct avc_node *node)
+{
+	list_del_rcu(&node->list);
+	call_rcu(&node->rhead, avc_node_free);
+	atomic_dec(&avc_cache.active_nodes);
+}
 
-				prev = cur;
-				cur = cur->next;
-			}
-			hvalue = (hvalue + 1) & (AVC_CACHE_SLOTS - 1);
-		} while (hvalue != avc_cache.lru_hint);
-	}
+static void avc_node_replace(struct avc_node *new, struct avc_node *old)
+{
+	list_replace_rcu(&old->list, &new->list);
+	call_rcu(&old->rhead, avc_node_free);
+	atomic_dec(&avc_cache.active_nodes);
+}
 
-	panic("avc_reclaim_node");
+static inline int avc_reclaim_node(void)
+{
+	struct avc_node *node;
+	int hvalue, try, ecx;
+	unsigned long flags;
 
-found:
-	avc_cache.lru_hint = hvalue;
+	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++ ) {
+		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
 
-	if (prev == NULL)
-		avc_cache.slots[hvalue] = cur->next;
-	else
-		prev->next = cur->next;
+		if (!spin_trylock_irqsave(&avc_cache.slots_lock[hvalue], flags))
+			continue;
 
-	return cur;
+		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
+			if (!atomic_dec_and_test(&node->ae.used)) {
+				/* Recently Unused */
+				avc_node_delete(node);
+				ecx++;
+				if (ecx >= AVC_CACHE_RECLAIM) {
+					spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
+					goto out;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
+	}
+out:
+	return ecx;
 }
 
-static inline struct avc_node *avc_claim_node(u32 ssid,
-                                              u32 tsid, u16 tclass)
+static struct avc_node *avc_alloc_node(void)
 {
-	struct avc_node *new;
-	int hvalue;
-
-	hvalue = avc_hash(ssid, tsid, tclass);
-	if (avc_node_freelist) {
-		new = avc_node_freelist;
-		avc_node_freelist = avc_node_freelist->next;
-		avc_cache.active_nodes++;
-	} else {
-		new = avc_reclaim_node();
-		if (!new)
-			goto out;
-	}
+	struct avc_node *node;
+	
+	node = kmem_cache_alloc(avc_node_cachep, SLAB_ATOMIC);
+	if (!node)
+		goto out;
+		
+	memset(node, 0, sizeof(*node));
+	INIT_RCU_HEAD(&node->rhead);
+	INIT_LIST_HEAD(&node->list);
+	atomic_set(&node->ae.used, 1);	
 
-	new->ae.used = 1;
-	new->ae.ssid = ssid;
-	new->ae.tsid = tsid;
-	new->ae.tclass = tclass;
-	new->next = avc_cache.slots[hvalue];
-	avc_cache.slots[hvalue] = new;
+	if (atomic_inc_return(&avc_cache.active_nodes) > AVC_CACHE_THRESHOLD)
+		avc_reclaim_node();
 
 out:
-	return new;
+	return node;
+}
+
+static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae)
+{
+	node->ae.ssid = ssid;
+	node->ae.tsid = tsid;
+	node->ae.tclass = tclass;
+	memcpy(&node->ae.avd, &ae->avd, sizeof(node->ae.avd));
 }
 
 static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid,
                                                u16 tclass, int *probes)
 {
-	struct avc_node *cur;
+	struct avc_node *node, *ret = NULL;
 	int hvalue;
 	int tprobes = 1;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	cur = avc_cache.slots[hvalue];
-	while (cur != NULL &&
-	       (ssid != cur->ae.ssid ||
-		tclass != cur->ae.tclass ||
-		tsid != cur->ae.tsid)) {
+	list_for_each_entry_rcu(node, &avc_cache.slots[hvalue], list) {
+		if (ssid == node->ae.ssid &&
+		    tclass == node->ae.tclass &&
+		    tsid == node->ae.tsid) {
+			ret = node;
+			break;
+		}
 		tprobes++;
-		cur = cur->next;
 	}
 
-	if (cur == NULL) {
+	if (ret == NULL) {
 		/* cache miss */
 		goto out;
 	}
@@ -332,11 +344,10 @@ static inline struct avc_node *avc_searc
 	/* cache hit */
 	if (probes)
 		*probes = tprobes;
-
-	cur->ae.used = 1;
-
+	if (atomic_read(&ret->ae.used) != 1)
+		atomic_set(&ret->ae.used, 1);
 out:
-	return cur;
+	return ret;
 }
 
 /**
@@ -345,21 +356,18 @@ out:
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @aeref:  AVC entry reference
  *
  * Look up an AVC entry that is valid for the
  * @requested permissions between the SID pair
  * (@ssid, @tsid), interpreting the permissions
  * based on @tclass.  If a valid AVC entry exists,
- * then this function updates @aeref to refer to the
- * entry and returns %0. Otherwise, this function
- * returns -%ENOENT.
+ * then this function return the avc_node.
+ * Otherwise, this function returns NULL.
  */
-int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
-               u32 requested, struct avc_entry_ref *aeref)
+static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested)
 {
 	struct avc_node *node;
-	int probes, rc = 0;
+	int probes;
 
 	avc_cache_stats_incr(AVC_CAV_LOOKUPS);
 	node = avc_search_node(ssid, tsid, tclass,&probes);
@@ -367,14 +375,35 @@ int avc_lookup(u32 ssid, u32 tsid, u16 t
 	if (node && ((node->ae.avd.decided & requested) == requested)) {
 		avc_cache_stats_incr(AVC_CAV_HITS);
 		avc_cache_stats_add(AVC_CAV_PROBES,probes);
-		aeref->ae = &node->ae;
 		goto out;
 	}
 
+	node = NULL;
 	avc_cache_stats_incr(AVC_CAV_MISSES);
-	rc = -ENOENT;
 out:
-	return rc;
+	return node;
+}
+
+static int avc_latest_notif_update(int seqno, int is_insert)
+{
+	int ret = 0;
+	static spinlock_t notif_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long flag;
+
+	spin_lock_irqsave(&notif_lock, flag);
+	if (is_insert) {
+		if (seqno < avc_cache.latest_notif) {
+			printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",
+			       seqno, avc_cache.latest_notif);
+			ret = -EAGAIN;
+		}
+	} else {
+		if (seqno > avc_cache.latest_notif)
+			avc_cache.latest_notif = seqno;
+	}
+	spin_unlock_irqrestore(&notif_lock, flag);
+
+	return ret;
 }
 
 /**
@@ -383,7 +412,6 @@ out:
  * @tsid: target security identifier
  * @tclass: target security class
  * @ae: AVC entry
- * @aeref:  AVC entry reference
  *
  * Insert an AVC entry for the SID pair
  * (@ssid, @tsid) and class @tclass.
@@ -392,37 +420,38 @@ out:
  * response to a security_compute_av() call.  If the
  * sequence number @ae->avd.seqno is not less than the latest
  * revocation notification, then the function copies
- * the access vectors into a cache entry, updates
- * @aeref to refer to the entry, and returns %0.
- * Otherwise, this function returns -%EAGAIN.
+ * the access vectors into a cache entry, returns
+ * avc_node inserted. Otherwise, this function returns NULL.
  */
-int avc_insert(u32 ssid, u32 tsid, u16 tclass,
-               struct avc_entry *ae, struct avc_entry_ref *aeref)
+static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae)
 {
-	struct avc_node *node;
-	int rc = 0;
+	struct avc_node *pos, *node = NULL;
+	int hvalue;
+	unsigned long flag;
 
-	if (ae->avd.seqno < avc_cache.latest_notif) {
-		printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",
-		       ae->avd.seqno, avc_cache.latest_notif);
-		rc = -EAGAIN;
+	if (avc_latest_notif_update(ae->avd.seqno, 1))
 		goto out;
-	}
 
-	node = avc_claim_node(ssid, tsid, tclass);
-	if (!node) {
-		rc = -ENOMEM;
-		goto out;
+	node = avc_alloc_node();
+	if (node) {
+		hvalue = avc_hash(ssid, tsid, tclass);
+		avc_node_populate(node, ssid, tsid, tclass, ae);
+
+		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
+		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
+			if (pos->ae.ssid == ssid &&
+			    pos->ae.tsid == tsid &&
+			    pos->ae.tclass == tclass) {
+			    	avc_node_replace(node, pos);
+				goto found;
+			}
+		}
+		list_add_rcu(&node->list, &avc_cache.slots[hvalue]);
+found:
+		spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
 	}
-
-	node->ae.avd.allowed = ae->avd.allowed;
-	node->ae.avd.decided = ae->avd.decided;
-	node->ae.avd.auditallow = ae->avd.auditallow;
-	node->ae.avd.auditdeny = ae->avd.auditdeny;
-	node->ae.avd.seqno = ae->avd.seqno;
-	aeref->ae = &node->ae;
 out:
-	return rc;
+	return node;
 }
 
 static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
@@ -686,8 +715,52 @@ static inline int avc_sidcmp(u32 x, u32 
 	return (x == y || x == SECSID_WILD || y == SECSID_WILD);
 }
 
-static inline void avc_update_node(u32 event, struct avc_node *node, u32 perms)
+/**
+ * avc_update_node Update an AVC entry
+ * @event : Updating event
+ * @perms : Permission mask bits
+ * @ssid,@tsid,@tclass : identifier of an AVC entry
+ * 
+ * if a valid AVC entry doesn't exist,this function returns -ENOENT.
+ * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
+ * otherwise, this function update the AVC entry. The original AVC-entry object
+ * will release later by RCU.
+ */
+static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
 {
+	int hvalue, rc = 0;
+	unsigned long flag;
+	struct avc_node *pos, *node, *orig = NULL;
+
+	/* Lock the target slot */
+	hvalue = avc_hash(ssid, tsid, tclass);
+	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
+
+	list_for_each_entry(pos, &avc_cache.slots[hvalue], list){
+		if ( ssid==pos->ae.ssid &&
+		     tsid==pos->ae.tsid &&
+		     tclass==pos->ae.tclass ){
+			orig = pos;
+			break;
+		}
+	}
+
+	if (!orig) {
+		rc = -ENOENT;
+		goto out;
+	}
+
+	/*
+	 * Copy and replace original node.
+	 */
+	node = avc_alloc_node();
+	if (!node) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	avc_node_populate(node, ssid, tsid, tclass, &orig->ae);
+	
 	switch (event) {
 	case AVC_CALLBACK_GRANT:
 		node->ae.avd.allowed |= perms;
@@ -709,6 +782,11 @@ static inline void avc_update_node(u32 e
 		node->ae.avd.auditdeny &= ~perms;
 		break;
 	}
+	avc_node_replace(node, orig);
+out:
+	spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
+
+	return rc;
 }
 
 static int avc_update_cache(u32 event, u32 ssid, u32 tsid,
@@ -716,31 +794,27 @@ static int avc_update_cache(u32 event, u
 {
 	struct avc_node *node;
 	int i;
-	unsigned long flags;
 
-	spin_lock_irqsave(&avc_lock,flags);
+	rcu_read_lock();
 
 	if (ssid == SECSID_WILD || tsid == SECSID_WILD) {
 		/* apply to all matching nodes */
 		for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-			for (node = avc_cache.slots[i]; node;
-			     node = node->next) {
+			list_for_each_entry_rcu(node, &avc_cache.slots[i], list) {
 				if (avc_sidcmp(ssid, node->ae.ssid) &&
 				    avc_sidcmp(tsid, node->ae.tsid) &&
-				    tclass == node->ae.tclass) {
-					avc_update_node(event,node,perms);
+				    tclass == node->ae.tclass ) {
+					avc_update_node(event, perms, node->ae.ssid,
+							node->ae.tsid, node->ae.tclass);
 				}
 			}
 		}
 	} else {
 		/* apply to one node */
-		node = avc_search_node(ssid, tsid, tclass, NULL);
-		if (node) {
-			avc_update_node(event,node,perms);
-		}
+		avc_update_node(event, perms, ssid, tsid, tclass);
 	}
 
-	spin_unlock_irqrestore(&avc_lock,flags);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -752,7 +826,6 @@ static int avc_control(u32 event, u32 ss
 	struct avc_callback_node *c;
 	u32 tretained = 0, cretained = 0;
 	int rc = 0;
-	unsigned long flags;
 
 	/*
 	 * try_revoke only removes permissions from the cache
@@ -787,10 +860,7 @@ static int avc_control(u32 event, u32 ss
 		*out_retained = tretained;
 	}
 
-	spin_lock_irqsave(&avc_lock,flags);
-	if (seqno > avc_cache.latest_notif)
-		avc_cache.latest_notif = seqno;
-	spin_unlock_irqrestore(&avc_lock,flags);
+	avc_latest_notif_update(seqno, 0);
 
 out:
 	return rc;
@@ -857,32 +927,17 @@ int avc_ss_reset(u32 seqno)
 {
 	struct avc_callback_node *c;
 	int i, rc = 0;
-	struct avc_node *node, *tmp;
-	unsigned long flags;
+	unsigned long flag;
+	struct avc_node *node;
 
 	avc_hash_eval("reset");
 
-	spin_lock_irqsave(&avc_lock,flags);
-
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		node = avc_cache.slots[i];
-		while (node) {
-			tmp = node;
-			node = node->next;
-			tmp->ae.ssid = tmp->ae.tsid = SECSID_NULL;
-			tmp->ae.tclass = SECCLASS_NULL;
-			tmp->ae.avd.allowed = tmp->ae.avd.decided = 0;
-			tmp->ae.avd.auditallow = tmp->ae.avd.auditdeny = 0;
-			tmp->ae.used = 0;
-			tmp->next = avc_node_freelist;
-			avc_node_freelist = tmp;
-			avc_cache.active_nodes--;
-		}
-		avc_cache.slots[i] = NULL;
+		spin_lock_irqsave(&avc_cache.slots_lock[i], flag);
+		list_for_each_entry(node, &avc_cache.slots[i], list)
+			avc_node_delete(node);
+		spin_unlock_irqrestore(&avc_cache.slots_lock[i], flag);
 	}
-	avc_cache.lru_hint = 0;
-
-	spin_unlock_irqrestore(&avc_lock,flags);
 
 	for (i = 0; i < AVC_NSTATS; i++)
 		avc_cache_stats[i] = 0;
@@ -896,10 +951,7 @@ int avc_ss_reset(u32 seqno)
 		}
 	}
 
-	spin_lock_irqsave(&avc_lock,flags);
-	if (seqno > avc_cache.latest_notif)
-		avc_cache.latest_notif = seqno;
-	spin_unlock_irqrestore(&avc_lock,flags);
+	avc_latest_notif_update(seqno, 0);
 out:
 	return rc;
 }
@@ -950,14 +1002,12 @@ int avc_ss_set_auditdeny(u32 ssid, u32 t
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @aeref:  AVC entry reference
  * @avd: access vector decisions
  *
  * Check the AVC to determine whether the @requested permissions are granted
  * for the SID pair (@ssid, @tsid), interpreting the permissions
  * based on @tclass, and call the security server on a cache miss to obtain
- * a new decision and add it to the cache.  Update @aeref to refer to an AVC
- * entry with the resulting decisions, and return a copy of the decisions
+ * a new decision and add it to the cache.  Return a copy of the decisions
  * in @avd.  Return %0 if all @requested permissions are granted,
  * -%EACCES if any permissions are denied, or another -errno upon
  * other errors.  This function is typically called by avc_has_perm(),
@@ -967,72 +1017,43 @@ int avc_ss_set_auditdeny(u32 ssid, u32 t
  */
 int avc_has_perm_noaudit(u32 ssid, u32 tsid,
                          u16 tclass, u32 requested,
-                         struct avc_entry_ref *aeref, struct av_decision *avd)
+                         struct av_decision *avd)
 {
-	struct avc_entry *ae;
+	struct avc_node *node;
+	struct avc_entry entry, *p_ae;
 	int rc = 0;
-	unsigned long flags;
-	struct avc_entry entry;
 	u32 denied;
-	struct avc_entry_ref ref;
-
-	if (!aeref) {
-		avc_entry_ref_init(&ref);
-		aeref = &ref;
-	}
 
-	spin_lock_irqsave(&avc_lock, flags);
+	rcu_read_lock();
 	avc_cache_stats_incr(AVC_ENTRY_LOOKUPS);
-	ae = aeref->ae;
-	if (ae) {
-		if (ae->ssid == ssid &&
-		    ae->tsid == tsid &&
-		    ae->tclass == tclass &&
-		    ((ae->avd.decided & requested) == requested)) {
-			avc_cache_stats_incr(AVC_ENTRY_HITS);
-			ae->used = 1;
-		} else {
-			avc_cache_stats_incr(AVC_ENTRY_DISCARDS);
-			ae = NULL;
-		}
-	}
 
-	if (!ae) {
-		avc_cache_stats_incr(AVC_ENTRY_MISSES);
-		rc = avc_lookup(ssid, tsid, tclass, requested, aeref);
-		if (rc) {
-			spin_unlock_irqrestore(&avc_lock,flags);
-			rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
-			if (rc)
-				goto out;
-			spin_lock_irqsave(&avc_lock, flags);
-			rc = avc_insert(ssid,tsid,tclass,&entry,aeref);
-			if (rc) {
-				spin_unlock_irqrestore(&avc_lock,flags);
-				goto out;
-			}
-		}
-		ae = aeref->ae;
+	node = avc_lookup(ssid, tsid, tclass, requested);
+	if (!node) {
+		rcu_read_unlock();
+		rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
+		if (rc)
+			goto out;
+		rcu_read_lock();
+		node = avc_insert(ssid,tsid,tclass,&entry);
 	}
 
+	p_ae = node ? &node->ae : &entry;
+
 	if (avd)
-		memcpy(avd, &ae->avd, sizeof(*avd));
+		memcpy(avd, &p_ae->avd, sizeof(*avd));
 
-	denied = requested & ~(ae->avd.allowed);
+	denied = requested & ~(p_ae->avd.allowed);
 
 	if (!requested || denied) {
-		if (selinux_enforcing) {
-			spin_unlock_irqrestore(&avc_lock,flags);
+		if (selinux_enforcing)
 			rc = -EACCES;
-			goto out;
-		} else {
-			ae->avd.allowed |= requested;
-			spin_unlock_irqrestore(&avc_lock,flags);
-			goto out;
-		}
+		else
+			if (node)
+				avc_update_node(AVC_CALLBACK_GRANT,requested,
+						ssid,tsid,tclass);
 	}
-
-	spin_unlock_irqrestore(&avc_lock,flags);
+	
+	rcu_read_unlock();
 out:
 	return rc;
 }
@@ -1043,26 +1064,23 @@ out:
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @aeref:  AVC entry reference
  * @auditdata: auxiliary audit data
  *
  * Check the AVC to determine whether the @requested permissions are granted
  * for the SID pair (@ssid, @tsid), interpreting the permissions
  * based on @tclass, and call the security server on a cache miss to obtain
- * a new decision and add it to the cache.  Update @aeref to refer to an AVC
- * entry with the resulting decisions.  Audit the granting or denial of
+ * a new decision and add it to the cache.  Audit the granting or denial of
  * permissions in accordance with the policy.  Return %0 if all @requested
  * permissions are granted, -%EACCES if any permissions are denied, or
  * another -errno upon other errors.
  */
 int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
-                 u32 requested, struct avc_entry_ref *aeref,
-                 struct avc_audit_data *auditdata)
+                 u32 requested, struct avc_audit_data *auditdata)
 {
 	struct av_decision avd;
 	int rc;
 
-	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
+	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, &avd);
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
 	return rc;
 }
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/hooks.c linux-2.6.10-rc1-mm1.w/security/selinux/hooks.c
--- linux-2.6.10-rc1-mm1.p/security/selinux/hooks.c	2004-10-28 11:57:13.444496984 -0400
+++ linux-2.6.10-rc1-mm1.w/security/selinux/hooks.c	2004-10-28 11:56:54.946309136 -0400
@@ -448,12 +448,12 @@ static int try_context_mount(struct supe
 		}
 
 		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
-		                  FILESYSTEM__RELABELFROM, NULL, NULL);
+		                  FILESYSTEM__RELABELFROM, NULL);
 		if (rc)
 			goto out_free;
 
 		rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
-		                  FILESYSTEM__RELABELTO, NULL, NULL);
+		                  FILESYSTEM__RELABELTO, NULL);
 		if (rc)
 			goto out_free;
 
@@ -476,12 +476,12 @@ static int try_context_mount(struct supe
 			goto out_free;
 
 		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__RELABELFROM, NULL, NULL);
+				  FILESYSTEM__RELABELFROM, NULL);
 		if (rc)
 			goto out_free;
 
 		rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__ASSOCIATE, NULL, NULL);
+				  FILESYSTEM__ASSOCIATE, NULL);
 		if (rc)
 			goto out_free;
 
@@ -924,7 +924,7 @@ int task_has_perm(struct task_struct *ts
 	tsec1 = tsk1->security;
 	tsec2 = tsk2->security;
 	return avc_has_perm(tsec1->sid, tsec2->sid,
-			    SECCLASS_PROCESS, perms, &tsec2->avcr, NULL);
+			    SECCLASS_PROCESS, perms, NULL);
 }
 
 /* Check whether a task is allowed to use a capability. */
@@ -941,7 +941,7 @@ int task_has_capability(struct task_stru
 	ad.u.cap = cap;
 
 	return avc_has_perm(tsec->sid, tsec->sid,
-			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), NULL, &ad);
+			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
 }
 
 /* Check whether a task is allowed to use a system operation. */
@@ -953,18 +953,15 @@ int task_has_system(struct task_struct *
 	tsec = tsk->security;
 
 	return avc_has_perm(tsec->sid, SECINITSID_KERNEL,
-			    SECCLASS_SYSTEM, perms, NULL, NULL);
+			    SECCLASS_SYSTEM, perms, NULL);
 }
 
 /* Check whether a task has a particular permission to an inode.
-   The 'aeref' parameter is optional and allows other AVC
-   entry references to be passed (e.g. the one in the struct file).
    The 'adp' parameter is optional and allows other audit
    data to be passed (e.g. the dentry). */
 int inode_has_perm(struct task_struct *tsk,
 		   struct inode *inode,
 		   u32 perms,
-		   struct avc_entry_ref *aeref,
 		   struct avc_audit_data *adp)
 {
 	struct task_security_struct *tsec;
@@ -980,8 +977,7 @@ int inode_has_perm(struct task_struct *t
 		ad.u.fs.inode = inode;
 	}
 
-	return avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			    perms, aeref ? aeref : &isec->avcr, adp);
+	return avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -997,7 +993,7 @@ static inline int dentry_has_perm(struct
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.mnt = mnt;
 	ad.u.fs.dentry = dentry;
-	return inode_has_perm(tsk, inode, av, NULL, &ad);
+	return inode_has_perm(tsk, inode, av, &ad);
 }
 
 /* Check whether a task can use an open file descriptor to
@@ -1028,14 +1024,14 @@ static inline int file_has_perm(struct t
 		rc = avc_has_perm(tsec->sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
-				  &fsec->avcr, &ad);
+				  &ad);
 		if (rc)
 			return rc;
 	}
 
 	/* av is zero if only checking access to the descriptor. */
 	if (av)
-		return inode_has_perm(tsk, inode, av, &fsec->inode_avcr, &ad);
+		return inode_has_perm(tsk, inode, av, &ad);
 
 	return 0;
 }
@@ -1061,7 +1057,7 @@ static int may_create(struct inode *dir,
 
 	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
-			  &dsec->avcr, &ad);
+			  &ad);
 	if (rc)
 		return rc;
 
@@ -1074,13 +1070,13 @@ static int may_create(struct inode *dir,
 			return rc;
 	}
 
-	rc = avc_has_perm(tsec->sid, newsid, tclass, FILE__CREATE, NULL, &ad);
+	rc = avc_has_perm(tsec->sid, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
 	return avc_has_perm(newsid, sbsec->sid,
 			    SECCLASS_FILESYSTEM,
-			    FILESYSTEM__ASSOCIATE, NULL, &ad);
+			    FILESYSTEM__ASSOCIATE, &ad);
 }
 
 #define MAY_LINK   0
@@ -1108,8 +1104,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR,
-			  av, &dsec->avcr, &ad);
+	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1128,8 +1123,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			  av, &isec->avcr, &ad);
+	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass, av, &ad);
 	return rc;
 }
 
@@ -1155,21 +1149,16 @@ static inline int may_rename(struct inod
 
 	ad.u.fs.dentry = old_dentry;
 	rc = avc_has_perm(tsec->sid, old_dsec->sid, SECCLASS_DIR,
-			  DIR__REMOVE_NAME | DIR__SEARCH,
-			  &old_dsec->avcr, &ad);
+			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
 	rc = avc_has_perm(tsec->sid, old_isec->sid,
-			  old_isec->sclass,
-			  FILE__RENAME,
-			  &old_isec->avcr, &ad);
+			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
 		rc = avc_has_perm(tsec->sid, old_isec->sid,
-				  old_isec->sclass,
-				  DIR__REPARENT,
-				  &old_isec->avcr, &ad);
+				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
 	}
@@ -1178,8 +1167,7 @@ static inline int may_rename(struct inod
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (new_dentry->d_inode)
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(tsec->sid, new_dsec->sid, SECCLASS_DIR,
-			  av,&new_dsec->avcr, &ad);
+	rc = avc_has_perm(tsec->sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
@@ -1187,8 +1175,7 @@ static inline int may_rename(struct inod
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
 		rc = avc_has_perm(tsec->sid, new_isec->sid,
 				  new_isec->sclass,
-				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK),
-				  &new_isec->avcr, &ad);
+				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
 		if (rc)
 			return rc;
 	}
@@ -1208,7 +1195,7 @@ int superblock_has_perm(struct task_stru
 	tsec = tsk->security;
 	sbsec = sb->s_security;
 	return avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
-			    perms, NULL, ad);
+			    perms, ad);
 }
 
 /* Convert a Linux mode and permission mask to an access vector. */
@@ -1445,7 +1432,7 @@ static int selinux_sysctl(ctl_table *tab
 	 * a bad coupling between this module and sysctl.c */
 	if(op == 001) {
 		error = avc_has_perm(tsec->sid, tsid,
-				     SECCLASS_DIR, DIR__SEARCH, NULL, NULL);
+				     SECCLASS_DIR, DIR__SEARCH, NULL);
 	} else {
 		av = 0;
 		if (op & 004)
@@ -1454,7 +1441,7 @@ static int selinux_sysctl(ctl_table *tab
 			av |= FILE__WRITE;
 		if (av)
 			error = avc_has_perm(tsec->sid, tsid,
-					     SECCLASS_FILE, av, NULL, NULL);
+					     SECCLASS_FILE, av, NULL);
         }
 
 	return error;
@@ -1573,8 +1560,7 @@ static int selinux_vm_enough_memory(long
 		if (!rc) {
 			rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
 						  SECCLASS_CAPABILITY,
-						  CAP_TO_MASK(CAP_SYS_ADMIN),
-						  NULL, NULL);
+						  CAP_TO_MASK(CAP_SYS_ADMIN), NULL);
 		}
 		if (rc)
 			free -= free / 32;
@@ -1666,22 +1652,18 @@ static int selinux_bprm_set_security(str
 
         if (tsec->sid == newsid) {
 		rc = avc_has_perm(tsec->sid, isec->sid,
-				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS,
-				  &isec->avcr, &ad);
+				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
 		rc = avc_has_perm(tsec->sid, newsid,
-				  SECCLASS_PROCESS, PROCESS__TRANSITION,
-				  NULL,
-				  &ad);
+				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
 
 		rc = avc_has_perm(newsid, isec->sid,
-				  SECCLASS_FILE, FILE__ENTRYPOINT,
-				  &isec->avcr, &ad);
+				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
 		if (rc)
 			return rc;
 
@@ -1713,7 +1695,7 @@ static int selinux_bprm_secureexec (stru
 		   the two SIDs, i.e. ahp returns 0. */
 		atsecure = avc_has_perm(tsec->osid, tsec->sid,
 					 SECCLASS_PROCESS,
-					 PROCESS__NOATSECURE, NULL, NULL);
+					 PROCESS__NOATSECURE, NULL);
 	}
 
 	return (atsecure || secondary_ops->bprm_secureexec(bprm));
@@ -1748,8 +1730,7 @@ static inline void flush_unauthorized_fi
 			   interested in the inode-based check here. */
 			struct inode *inode = file->f_dentry->d_inode;
 			if (inode_has_perm(current, inode,
-					   FILE__READ | FILE__WRITE,
-					   NULL, NULL)) {
+					   FILE__READ | FILE__WRITE, NULL)) {
 				/* Reset controlling tty. */
 				current->signal->tty = NULL;
 				current->signal->tty_old_pgrp = 0;
@@ -1835,8 +1816,7 @@ static void selinux_bprm_apply_creds(str
 		   unchanged and kill. */
 		if (unsafe & LSM_UNSAFE_SHARE) {
 			rc = avc_has_perm_noaudit(tsec->sid, sid,
-					  SECCLASS_PROCESS, PROCESS__SHARE,
-					  NULL, &avd);
+					  SECCLASS_PROCESS, PROCESS__SHARE, &avd);
 			if (rc) {
 				task_unlock(current);
 				avc_audit(tsec->sid, sid, SECCLASS_PROCESS,
@@ -1850,8 +1830,7 @@ static void selinux_bprm_apply_creds(str
 		   Otherwise, leave SID unchanged and kill. */
 		if (unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
 			rc = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
-					  SECCLASS_PROCESS, PROCESS__PTRACE,
-					  NULL, &avd);
+					  SECCLASS_PROCESS, PROCESS__PTRACE, &avd);
 			if (!rc)
 				tsec->sid = sid;
 			task_unlock(current);
@@ -1876,7 +1855,7 @@ static void selinux_bprm_apply_creds(str
                   been updated so that any kill done after the flush
                   will be checked against the new SID. */
 		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
-				  PROCESS__SIGINH, NULL, NULL);
+				  PROCESS__SIGINH, NULL);
 		if (rc) {
 			memset(&itimer, 0, sizeof itimer);
 			for (i = 0; i < 3; i++)
@@ -1900,7 +1879,7 @@ static void selinux_bprm_apply_creds(str
 		   is lower than the hard limit, e.g. RLIMIT_CORE or 
 		   RLIMIT_STACK.*/
 		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
-				  PROCESS__RLIMITINH, NULL, NULL);
+				  PROCESS__RLIMITINH, NULL);
 		if (rc) {
 			for (i = 0; i < RLIM_NLIMITS; i++) {
 				rlim = current->signal->rlim + i;
@@ -2186,7 +2165,7 @@ static int selinux_inode_permission(stru
 	}
 
 	return inode_has_perm(current, inode,
-			       file_mask_to_av(inode->i_mode, mask), NULL, NULL);
+			       file_mask_to_av(inode->i_mode, mask), NULL);
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
@@ -2244,8 +2223,7 @@ static int selinux_inode_setxattr(struct
 	ad.u.fs.dentry = dentry;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			  FILE__RELABELFROM,
-			  &isec->avcr, &ad);
+			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
 
@@ -2254,7 +2232,7 @@ static int selinux_inode_setxattr(struct
 		return rc;
 
 	rc = avc_has_perm(tsec->sid, newsid, isec->sclass,
-			  FILE__RELABELTO, NULL, &ad);
+			  FILE__RELABELTO, &ad);
 	if (rc)
 		return rc;
 
@@ -2262,7 +2240,6 @@ static int selinux_inode_setxattr(struct
 			    sbsec->sid,
 			    SECCLASS_FILESYSTEM,
 			    FILESYSTEM__ASSOCIATE,
-			    NULL,
 			    &ad);
 }
 
@@ -2584,7 +2561,7 @@ static int selinux_file_send_sigiotask(s
 		perm = signal_to_av(signum);
 
 	return avc_has_perm(fsec->fown_sid, tsec->sid,
-			    SECCLASS_PROCESS, perm, NULL, NULL);
+			    SECCLASS_PROCESS, perm, NULL);
 }
 
 static int selinux_file_receive(struct file *file)
@@ -2721,8 +2698,7 @@ static int selinux_task_setscheduler(str
 	   is held and the system will deadlock if we try to log an audit
 	   message. */
 	return avc_has_perm_noaudit(tsec1->sid, tsec2->sid,
-				    SECCLASS_PROCESS, PROCESS__SETSCHED,
-				    &tsec2->avcr, NULL);
+				    SECCLASS_PROCESS, PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
@@ -2965,8 +2941,7 @@ static int socket_has_perm(struct task_s
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   perms, &isec->avcr, &ad);
+	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
 
 out:
 	return err;
@@ -2984,7 +2959,7 @@ static int selinux_socket_create(int fam
 	tsec = current->security;
 	err = avc_has_perm(tsec->sid, tsec->sid,
 			   socket_type_to_security_class(family, type,
-			   protocol), SOCKET__CREATE, NULL, NULL);
+			   protocol), SOCKET__CREATE, NULL);
 
 out:
 	return err;
@@ -3065,7 +3040,7 @@ static int selinux_socket_bind(struct so
 			ad.u.net.family = family;
 			err = avc_has_perm(isec->sid, sid,
 					   isec->sclass,
-					   SOCKET__NAME_BIND, NULL, &ad);
+					   SOCKET__NAME_BIND, &ad);
 			if (err)
 				goto out;
 		}
@@ -3098,7 +3073,7 @@ static int selinux_socket_bind(struct so
 			ipv6_addr_copy(&ad.u.net.v6info.saddr, &addr6->sin6_addr);
 
 		err = avc_has_perm(isec->sid, sid,
-		                   isec->sclass, node_perm, NULL, &ad);
+		                   isec->sclass, node_perm, &ad);
 		if (err)
 			goto out;
 	}
@@ -3198,8 +3173,7 @@ static int selinux_socket_unix_stream_co
 
 	err = avc_has_perm(isec->sid, other_isec->sid,
 			   isec->sclass,
-			   UNIX_STREAM_SOCKET__CONNECTTO,
-			   &other_isec->avcr, &ad);
+			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
 	if (err)
 		return err;
 
@@ -3229,9 +3203,7 @@ static int selinux_socket_unix_may_send(
 	ad.u.net.sk = other->sk;
 
 	err = avc_has_perm(isec->sid, other_isec->sid,
-			   isec->sclass,
-			   SOCKET__SENDTO,
-			   &other_isec->avcr, &ad);
+			   isec->sclass, SOCKET__SENDTO, &ad);
 	if (err)
 		return err;
 
@@ -3309,8 +3281,7 @@ static int selinux_socket_sock_rcv_skb(s
 	if (err)
 		goto out;
 
-	err = avc_has_perm(sock_sid, if_sid, SECCLASS_NETIF,
-	                   netif_perm, NULL, &ad);
+	err = avc_has_perm(sock_sid, if_sid, SECCLASS_NETIF, netif_perm, &ad);
 	if (err)
 		goto out;
 	
@@ -3319,7 +3290,7 @@ static int selinux_socket_sock_rcv_skb(s
 	if (err)
 		goto out;
 	
-	err = avc_has_perm(sock_sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
+	err = avc_has_perm(sock_sid, node_sid, SECCLASS_NODE, node_perm, &ad);
 	if (err)
 		goto out;
 
@@ -3333,8 +3304,8 @@ static int selinux_socket_sock_rcv_skb(s
 		if (err)
 			goto out;
 
-		err = avc_has_perm(sock_sid, port_sid, sock_class,
-		                   recv_perm, NULL, &ad);
+		err = avc_has_perm(sock_sid, port_sid,
+				   sock_class, recv_perm, &ad);
 	}
 out:	
 	return err;
@@ -3483,7 +3454,7 @@ static unsigned int selinux_ip_postroute
 		goto out;
 
 	err = avc_has_perm(isec->sid, if_sid, SECCLASS_NETIF,
-	                   netif_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+	                   netif_perm, &ad) ? NF_DROP : NF_ACCEPT;
 	if (err != NF_ACCEPT)
 		goto out;
 		
@@ -3494,7 +3465,7 @@ static unsigned int selinux_ip_postroute
 		goto out;
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE,
-	                   node_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+	                   node_perm, &ad) ? NF_DROP : NF_ACCEPT;
 	if (err != NF_ACCEPT)
 		goto out;
 
@@ -3511,7 +3482,7 @@ static unsigned int selinux_ip_postroute
 			goto out;
 
 		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
-		                   send_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+		                   send_perm, &ad) ? NF_DROP : NF_ACCEPT;
 	}
 
 out:
@@ -3648,8 +3619,7 @@ static int ipc_has_perm(struct kern_ipc_
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(tsec->sid, isec->sid, sclass,
-			    perms, &isec->avcr, &ad);
+	return avc_has_perm(tsec->sid, isec->sid, sclass, perms, &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -3681,7 +3651,7 @@ static int selinux_msg_queue_alloc_secur
  	ad.u.ipc_id = msq->q_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
-			  MSGQ__CREATE, &isec->avcr, &ad);
+			  MSGQ__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&msq->q_perm);
 		return rc;
@@ -3707,7 +3677,7 @@ static int selinux_msg_queue_associate(s
 	ad.u.ipc_id = msq->q_perm.key;
 
 	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
-			    MSGQ__ASSOCIATE, &isec->avcr, &ad);
+			    MSGQ__ASSOCIATE, &ad);
 }
 
 static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
@@ -3771,17 +3741,15 @@ static int selinux_msg_queue_msgsnd(stru
 
 	/* Can this process write to the queue? */
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
-			  MSGQ__WRITE, &isec->avcr, &ad);
+			  MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
 		rc = avc_has_perm(tsec->sid, msec->sid,
-				  SECCLASS_MSG, MSG__SEND,
-				  &msec->avcr, &ad);
+				  SECCLASS_MSG, MSG__SEND, &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
 		rc = avc_has_perm(msec->sid, isec->sid,
-				  SECCLASS_MSGQ, MSGQ__ENQUEUE,
-				  &isec->avcr, &ad);
+				  SECCLASS_MSGQ, MSGQ__ENQUEUE, &ad);
 
 	return rc;
 }
@@ -3804,12 +3772,10 @@ static int selinux_msg_queue_msgrcv(stru
  	ad.u.ipc_id = msq->q_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid,
-			  SECCLASS_MSGQ, MSGQ__READ,
-			  &isec->avcr, &ad);
+			  SECCLASS_MSGQ, MSGQ__READ, &ad);
 	if (!rc)
 		rc = avc_has_perm(tsec->sid, msec->sid,
-				  SECCLASS_MSG, MSG__RECEIVE,
-				  &msec->avcr, &ad);
+				  SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
 }
 
@@ -3832,7 +3798,7 @@ static int selinux_shm_alloc_security(st
  	ad.u.ipc_id = shp->shm_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
-			  SHM__CREATE, &isec->avcr, &ad);
+			  SHM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&shp->shm_perm);
 		return rc;
@@ -3858,7 +3824,7 @@ static int selinux_shm_associate(struct 
 	ad.u.ipc_id = shp->shm_perm.key;
 
 	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
-			    SHM__ASSOCIATE, &isec->avcr, &ad);
+			    SHM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, shp is locked down */
@@ -3931,7 +3897,7 @@ static int selinux_sem_alloc_security(st
  	ad.u.ipc_id = sma->sem_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
-			  SEM__CREATE, &isec->avcr, &ad);
+			  SEM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&sma->sem_perm);
 		return rc;
@@ -3957,7 +3923,7 @@ static int selinux_sem_associate(struct 
 	ad.u.ipc_id = sma->sem_perm.key;
 
 	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
-			    SEM__ASSOCIATE, &isec->avcr, &ad);
+			    SEM__ASSOCIATE, &ad);
 }
 
 /* Note, at this point, sma is locked down */
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/include/avc.h linux-2.6.10-rc1-mm1.w/security/selinux/include/avc.h
--- linux-2.6.10-rc1-mm1.p/security/selinux/include/avc.h	2004-10-28 11:57:13.445496832 -0400
+++ linux-2.6.10-rc1-mm1.w/security/selinux/include/avc.h	2004-10-28 11:56:39.065723352 -0400
@@ -29,19 +29,6 @@ extern int selinux_enforcing;
  */
 struct avc_entry;
 
-/*
- * A reference to an AVC entry.
- */
-struct avc_entry_ref {
-	struct avc_entry *ae;
-};
-
-/* Initialize an AVC entry reference before first use. */
-static inline void avc_entry_ref_init(struct avc_entry_ref *h)
-{
-	h->ae = NULL;
-}
-
 struct task_struct;
 struct vfsmount;
 struct dentry;
@@ -118,23 +105,17 @@ void avc_dump_query(struct audit_buffer 
 
 void __init avc_init(void);
 
-int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
-               u32 requested, struct avc_entry_ref *aeref);
-
-int avc_insert(u32 ssid, u32 tsid, u16 tclass,
-               struct avc_entry *ae, struct avc_entry_ref *out_aeref);
-
 void avc_audit(u32 ssid, u32 tsid,
                u16 tclass, u32 requested,
                struct av_decision *avd, int result, struct avc_audit_data *auditdata);
 
 int avc_has_perm_noaudit(u32 ssid, u32 tsid,
                          u16 tclass, u32 requested,
-                         struct avc_entry_ref *aeref, struct av_decision *avd);
+                         struct av_decision *avd);
 
 int avc_has_perm(u32 ssid, u32 tsid,
                  u16 tclass, u32 requested,
-                 struct avc_entry_ref *aeref, struct avc_audit_data *auditdata);
+                 struct avc_audit_data *auditdata);
 
 #define AVC_CALLBACK_GRANT		1
 #define AVC_CALLBACK_TRY_REVOKE		2
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/include/objsec.h linux-2.6.10-rc1-mm1.w/security/selinux/include/objsec.h
--- linux-2.6.10-rc1-mm1.p/security/selinux/include/objsec.h	2004-10-28 11:57:13.446496680 -0400
+++ linux-2.6.10-rc1-mm1.w/security/selinux/include/objsec.h	2004-10-28 02:30:30.000000000 -0400
@@ -33,7 +33,6 @@ struct task_security_struct {
 	u32 sid;             /* current SID */
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
-        struct avc_entry_ref avcr;     /* reference to process permissions */
 	u32 ptrace_sid;      /* SID of ptrace parent */
 };
 
@@ -44,7 +43,6 @@ struct inode_security_struct {
 	u32 task_sid;        /* SID of creating task */
 	u32 sid;             /* SID of this object */
 	u16 sclass;       /* security class of this object */
-	struct avc_entry_ref avcr;     /* reference to object permissions */
 	unsigned char initialized;     /* initialization flag */
 	struct semaphore sem;
 	unsigned char inherit;         /* inherit SID from parent entry */
@@ -55,8 +53,6 @@ struct file_security_struct {
 	struct file *file;              /* back pointer to file object */
 	u32 sid;              /* SID of open file description */
 	u32 fown_sid;         /* SID of file owner (for SIGIO) */
-	struct avc_entry_ref avcr;	/* reference to fd permissions */
-	struct avc_entry_ref inode_avcr;     /* reference to object permissions */
 };
 
 struct superblock_security_struct {
@@ -77,7 +73,6 @@ struct msg_security_struct {
         unsigned long magic;		/* magic number for this module */
 	struct msg_msg *msg;		/* back pointer */
 	u32 sid;              /* SID of message */
-        struct avc_entry_ref avcr;	/* reference to permissions */
 };
 
 struct ipc_security_struct {
@@ -85,7 +80,6 @@ struct ipc_security_struct {
 	struct kern_ipc_perm *ipc_perm; /* back pointer */
 	u16 sclass;	/* security class of this object */
 	u32 sid;              /* SID of IPC resource */
-        struct avc_entry_ref avcr;	/* reference to permissions */
 };
 
 struct bprm_security_struct {
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/security/selinux/selinuxfs.c linux-2.6.10-rc1-mm1.w/security/selinux/selinuxfs.c
--- linux-2.6.10-rc1-mm1.p/security/selinux/selinuxfs.c	2004-10-28 11:57:13.447496528 -0400
+++ linux-2.6.10-rc1-mm1.w/security/selinux/selinuxfs.c	2004-10-28 11:56:39.067723048 -0400
@@ -51,7 +51,7 @@ int task_has_security(struct task_struct
 		return -EACCES;
 
 	return avc_has_perm(tsec->sid, SECINITSID_SECURITY,
-			    SECCLASS_SECURITY, perms, NULL, NULL);
+			    SECCLASS_SECURITY, perms, NULL);
 }
 
 enum sel_inos {


