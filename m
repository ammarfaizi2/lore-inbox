Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUI0K5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUI0K5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUI0K5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:57:38 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:20447 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266646AbUI0K4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:56:52 -0400
Date: Mon, 27 Sep 2004 19:57:38 +0900 (JST)
Message-Id: <200409271057.i8RAvcA1007873@mailsv.bs1.fc.nec.co.jp>
To: "akpm@osdl.org" <akpm@osdl.org>
Cc: kaigai@ak.jp.nec.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>,
       Linux Kernel ML (Eng) <linux-kernel@vger.kernel.org>
Subject: [PATCH] SELinux performance improvement with RCU
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

The attached patch for 2.6.9-rc2-mm2 improves scalability of SELinux.

The current implementation of SELinux must always hold a spinlock
when decision-making is done. It causes a catastrophic performance
degradation in Big-SMP environment especially.

The attached patch replaces the spinlock in security/selinux/avc.c
by the lock-less read access with RCU for scalability improvement.

The series of discussions are as follows:
- [PATCH]SELinux performance improvement by RCU (Re: RCU issue with SELinux)
  http://marc.theaimsgroup.com/?t=109386515000001&r=1&w=2
- RCU issue with SELinux (Re: SELINUX performance issues)
  http://marc.theaimsgroup.com/?t=109264930300002&r=1&w=2

This is a benchmark result of the patch by James Morris.
  http://marc.theaimsgroup.com/?l=linux-kernel&m=109396691524294&w=2

Because this patch depends on two external function: atomic_inc_return()
and list_replace_rcu(), I was waiting for those functions to be merged
into 2.6.9-rc2-mm2 tree.
Please apply this.

Thank you.

* selinux.rcu-2.6.9-rc2-mm2.patch
Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


diff -rNU4 linux-2.6.9-rc2-mm2/security/selinux/avc.c linux-2.6.9-rc2-mm2.rcu/security/selinux/avc.c
--- linux-2.6.9-rc2-mm2/security/selinux/avc.c	2004-09-13 14:33:11.000000000 +0900
+++ linux-2.6.9-rc2-mm2.rcu/security/selinux/avc.c	2004-09-24 14:39:28.000000000 +0900
@@ -3,8 +3,11 @@
  *
  * Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
  *           James Morris <jmorris@redhat.com>
  *
+ * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>
+ *     Replaced the avc_lock spinlock by RCU.
+ *
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
@@ -35,28 +38,32 @@
 #include "av_perm_to_string.h"
 #include "objsec.h"
 
 #define AVC_CACHE_SLOTS		512
-#define AVC_CACHE_MAXNODES	410
+#define AVC_CACHE_THRESHOLD	410
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
+	spinlock_t		slots_lock[AVC_CACHE_SLOTS];
+		/* lock for insert/update/delete and reset */
+	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
+	atomic_t		active_nodes;
+	u32			latest_notif;	/* latest revocation notification */
 };
 
 struct avc_callback_node {
 	int (*callback) (u32 event, u32 ssid, u32 tsid,
@@ -69,10 +76,8 @@
 	u32 perms;
 	struct avc_callback_node *next;
 };
 
-static spinlock_t avc_lock = SPIN_LOCK_UNLOCKED;
-static struct avc_node *avc_node_freelist;
 static struct avc_cache avc_cache;
 static unsigned avc_cache_stats[AVC_NSTATS];
 static struct avc_callback_node *avc_callbacks;
 
@@ -187,23 +192,17 @@
  * Initialize the access vector cache.
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
-	}
-
+	for (i =0; i < AVC_CACHE_SLOTS; i++) {
+		INIT_LIST_HEAD(&avc_cache.slots[i]);
+		avc_cache.slots_lock[i] = SPIN_LOCK_UNLOCKED;
+	}
+	atomic_set(&avc_cache.active_nodes, 0);
+	atomic_set(&avc_cache.lru_hint, 0);
+	
 	audit_log(current->audit_context, "AVC INITIALIZED\n");
 }
 
 #if 0
@@ -212,27 +211,24 @@
 	int i, chain_len, max_chain_len, slots_used;
 	struct avc_node *node;
 	unsigned long flags;
 
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
+			list_for_each_entry_rcu(node, &avc_cache.slots[i])
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
 	       "chain length %d\n", tag, avc_cache.active_nodes, slots_used,
@@ -242,188 +238,210 @@
 static inline void avc_hash_eval(char *tag)
 { }
 #endif
 
-static inline struct avc_node *avc_reclaim_node(void)
+static void avc_node_free(struct rcu_head *rhead) {
+	struct avc_node *node;
+	node = container_of(rhead, struct avc_node, rhead);
+	kfree(node);
+}
+
+static inline int avc_reclaim_node(void)
 {
-	struct avc_node *prev, *cur;
-	int hvalue, try;
+	struct avc_node *node;
+	int hvalue, try, ecx;
 
-	hvalue = avc_cache.lru_hint;
-	for (try = 0; try < 2; try++) {
-		do {
-			prev = NULL;
-			cur = avc_cache.slots[hvalue];
-			while (cur) {
-				if (!cur->ae.used)
-					goto found;
+	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++ ) {
+		hvalue = atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;
 
-				cur->ae.used = 0;
+		if (!spin_trylock(&avc_cache.slots_lock[hvalue]))
+			continue;
 
-				prev = cur;
-				cur = cur->next;
+		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
+			if (!atomic_dec_and_test(&node->ae.used)) {
+				/* Recently Unused */
+				list_del_rcu(&node->list);
+				call_rcu(&node->rhead, avc_node_free);
+				atomic_dec(&avc_cache.active_nodes);
+				ecx++;
+				if (ecx >= AVC_CACHE_RECLAIM) {
+					spin_unlock(&avc_cache.slots_lock[hvalue]);
+					goto out;
+				}
 			}
-			hvalue = (hvalue + 1) & (AVC_CACHE_SLOTS - 1);
-		} while (hvalue != avc_cache.lru_hint);
+		}
+		spin_unlock(&avc_cache.slots_lock[hvalue]);
 	}
-
-	panic("avc_reclaim_node");
-
-found:
-	avc_cache.lru_hint = hvalue;
-
-	if (prev == NULL)
-		avc_cache.slots[hvalue] = cur->next;
-	else
-		prev->next = cur->next;
-
-	return cur;
+out:
+	return ecx;
 }
 
-static inline struct avc_node *avc_claim_node(u32 ssid,
-                                              u32 tsid, u16 tclass)
+static inline struct avc_node *avc_get_node(void)
 {
 	struct avc_node *new;
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
+	int actives;
 
-	new->ae.used = 1;
-	new->ae.ssid = ssid;
-	new->ae.tsid = tsid;
-	new->ae.tclass = tclass;
-	new->next = avc_cache.slots[hvalue];
-	avc_cache.slots[hvalue] = new;
+	new = kmalloc(sizeof(struct avc_node), GFP_ATOMIC);
+	if (!new)
+		return NULL;
+
+	INIT_RCU_HEAD(&new->rhead);
+	INIT_LIST_HEAD(&new->list);
+
+	actives = atomic_inc_return(&avc_cache.active_nodes);
+	if (actives > AVC_CACHE_THRESHOLD)
+		avc_reclaim_node();
 
-out:
 	return new;
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
  * avc_lookup - Look up an AVC entry.
  * @ssid: source security identifier
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
+struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested)
 {
 	struct avc_node *node;
-	int probes, rc = 0;
+	int probes;
 
 	avc_cache_stats_incr(AVC_CAV_LOOKUPS);
 	node = avc_search_node(ssid, tsid, tclass,&probes);
 
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
  * avc_insert - Insert an AVC entry.
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
  * @ae: AVC entry
- * @aeref:  AVC entry reference
  *
  * Insert an AVC entry for the SID pair
  * (@ssid, @tsid) and class @tclass.
  * The access vectors and the sequence number are
  * normally provided by the security server in
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
+struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae)
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
-	}
+	node = avc_get_node();
+
+	if (node) {
+		hvalue = avc_hash(ssid, tsid, tclass);
 
-	node->ae.avd.allowed = ae->avd.allowed;
-	node->ae.avd.decided = ae->avd.decided;
-	node->ae.avd.auditallow = ae->avd.auditallow;
-	node->ae.avd.auditdeny = ae->avd.auditdeny;
-	node->ae.avd.seqno = ae->avd.seqno;
-	aeref->ae = &node->ae;
+		node->ae.ssid = ssid;
+		node->ae.tsid = tsid;
+		node->ae.tclass = tclass;
+		atomic_set(&node->ae.used, 1);
+
+		node->ae.avd.allowed = ae->avd.allowed;
+		node->ae.avd.decided = ae->avd.decided;
+		node->ae.avd.auditallow = ae->avd.auditallow;
+		node->ae.avd.auditdeny = ae->avd.auditdeny;
+		node->ae.avd.seqno = ae->avd.seqno;
+
+		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
+		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
+			if (pos->ae.ssid == ssid &&
+			    pos->ae.tsid == tsid &&
+			    pos->ae.tclass == tclass) {
+				list_replace_rcu(&pos->list, &node->list);
+				call_rcu(&pos->rhead, avc_node_free);
+				atomic_dec(&avc_cache.active_nodes);
+				goto found;
+			}
+		}
+		list_add_rcu(&node->list, &avc_cache.slots[hvalue]);
+found:
+		spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
+	}
 out:
-	return rc;
+	return node;
 }
 
 static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
 				       struct in6_addr *addr, u16 port,
@@ -685,10 +703,51 @@
 {
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
+	struct avc_node *pos, *node, *org = NULL;
+
+	/* Lock the target slot */
+	hvalue = avc_hash(ssid, tsid, tclass);
+	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
+
+	list_for_each_entry(pos, &avc_cache.slots[hvalue], list){
+		if ( ssid==pos->ae.ssid &&
+		     tsid==pos->ae.tsid &&
+		     tclass==pos->ae.tclass ){
+			org = pos;
+			break;
+		}
+	}
+
+	if (!org) {
+		rc = -ENOENT;
+		goto out;
+	}
+
+	node = kmalloc(sizeof(struct avc_node), GFP_ATOMIC);
+	if (!node) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Duplicate and Update */
+	memcpy(node, org, sizeof(struct avc_node));
 	switch (event) {
 	case AVC_CALLBACK_GRANT:
 		node->ae.avd.allowed |= perms;
 		break;
@@ -708,40 +767,41 @@
 	case AVC_CALLBACK_AUDITDENY_DISABLE:
 		node->ae.avd.auditdeny &= ~perms;
 		break;
 	}
+	list_replace_rcu(&org->list,&node->list);
+out:
+	spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
+
+	return rc;
 }
 
 static int avc_update_cache(u32 event, u32 ssid, u32 tsid,
                             u16 tclass, u32 perms)
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
+					avc_update_node(event, perms, node->ae.ssid
+					                ,node->ae.tsid, node->ae.tclass);
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
 
@@ -751,9 +811,8 @@
 {
 	struct avc_callback_node *c;
 	u32 tretained = 0, cretained = 0;
 	int rc = 0;
-	unsigned long flags;
 
 	/*
 	 * try_revoke only removes permissions from the cache
 	 * state if they are not retained by the object manager.
@@ -786,12 +845,9 @@
 		avc_update_cache(event,ssid,tsid,tclass,perms);
 		*out_retained = tretained;
 	}
 
-	spin_lock_irqsave(&avc_lock,flags);
-	if (seqno > avc_cache.latest_notif)
-		avc_cache.latest_notif = seqno;
-	spin_unlock_irqrestore(&avc_lock,flags);
+	avc_latest_notif_update(seqno, 0);
 
 out:
 	return rc;
 }
@@ -856,34 +912,21 @@
 int avc_ss_reset(u32 seqno)
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
+		spin_lock_irqsave(&avc_cache.slots_lock[i], flag);
+		list_for_each_entry(node, &avc_cache.slots[i], list){
+			list_del_rcu(&node->list);
+			call_rcu(&node->rhead, avc_node_free);
 		}
-		avc_cache.slots[i] = NULL;
+		spin_unlock_irqrestore(&avc_cache.slots_lock[i], flag);
 	}
-	avc_cache.lru_hint = 0;
-
-	spin_unlock_irqrestore(&avc_lock,flags);
 
 	for (i = 0; i < AVC_NSTATS; i++)
 		avc_cache_stats[i] = 0;
 
@@ -895,12 +938,9 @@
 				goto out;
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
 
@@ -949,9 +989,9 @@
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @aeref:  AVC entry reference
+ * @aeref:  AVC entry reference(not in use)
  * @avd: access vector decisions
  *
  * Check the AVC to determine whether the @requested permissions are granted
  * for the SID pair (@ssid, @tsid), interpreting the permissions
@@ -968,72 +1008,44 @@
 int avc_has_perm_noaudit(u32 ssid, u32 tsid,
                          u16 tclass, u32 requested,
                          struct avc_entry_ref *aeref, struct av_decision *avd)
 {
-	struct avc_entry *ae;
+	struct avc_node *node;
+	struct avc_entry entry, *p_ae;
 	int rc = 0;
-	unsigned long flags;
-	struct avc_entry entry;
 	u32 denied;
-	struct avc_entry_ref ref;
 
-	if (!aeref) {
-		avc_entry_ref_init(&ref);
-		aeref = &ref;
-	}
-
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
 		if (selinux_enforcing) {
-			spin_unlock_irqrestore(&avc_lock,flags);
 			rc = -EACCES;
-			goto out;
 		} else {
-			ae->avd.allowed |= requested;
-			spin_unlock_irqrestore(&avc_lock,flags);
-			goto out;
+			if (node)
+				avc_update_node(AVC_CALLBACK_GRANT,requested
+				                ,ssid,tsid,tclass);
 		}
 	}
 
-	spin_unlock_irqrestore(&avc_lock,flags);
+	rcu_read_unlock();
 out:
 	return rc;
 }
 
@@ -1042,9 +1054,9 @@
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @aeref:  AVC entry reference
+ * @aeref:  AVC entry reference(not in use)
  * @auditdata: auxiliary audit data
  *
  * Check the AVC to determine whether the @requested permissions are granted
  * for the SID pair (@ssid, @tsid), interpreting the permissions
@@ -1061,8 +1073,8 @@
 {
 	struct av_decision avd;
 	int rc;
 
-	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
+	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, NULL, &avd);
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
 	return rc;
 }
diff -rNU4 linux-2.6.9-rc2-mm2/security/selinux/include/avc.h linux-2.6.9-rc2-mm2.rcu/security/selinux/include/avc.h
--- linux-2.6.9-rc2-mm2/security/selinux/include/avc.h	2004-09-13 14:31:57.000000000 +0900
+++ linux-2.6.9-rc2-mm2.rcu/security/selinux/include/avc.h	2004-09-24 14:39:28.000000000 +0900
@@ -117,13 +117,11 @@
  */
 
 void __init avc_init(void);
 
-int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
-               u32 requested, struct avc_entry_ref *aeref);
+struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested);
 
-int avc_insert(u32 ssid, u32 tsid, u16 tclass,
-               struct avc_entry *ae, struct avc_entry_ref *out_aeref);
+struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae);
 
 void avc_audit(u32 ssid, u32 tsid,
                u16 tclass, u32 requested,
                struct av_decision *avd, int result, struct avc_audit_data *auditdata);
