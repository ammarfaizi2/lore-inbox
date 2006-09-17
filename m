Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWIQRxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWIQRxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWIQRxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:53:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50567 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965039AbWIQRxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:53:42 -0400
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
Date: Sun, 17 Sep 2006 20:42:49 +0530
Message-Id: <20060917151249.11160.30762.sendpatchset@localhost.localdomain>
In-Reply-To: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
References: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH 4/4] Aggregated beancounters syscall support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add support for charging aggregated beancounters along with the beancounters
they contain. Limit checks are also done at the aggregated beancounter level.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/bc/beancounter.h |    4 +++
 kernel/bc/beancounter.c  |   51 +++++++++++++++++++++++++++++++++++++++++++----
 kernel/bc/vmpages.c      |   23 +++++++++++++++++++--
 kernel/bc/vmrss.c        |   13 +++++++++++
 4 files changed, 84 insertions(+), 7 deletions(-)

diff -puN kernel/bc/beancounter.c~aggr-bc-charging-support kernel/bc/beancounter.c
--- linux-2.6.18-rc5/kernel/bc/beancounter.c~aggr-bc-charging-support	2006-09-17 20:34:48.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/beancounter.c	2006-09-17 20:34:48.000000000 +0530
@@ -199,6 +199,7 @@ struct beancounter *beancounter_relocate
 	unsigned long flags;
 	struct beancounter *bc = NULL, *new_bc;
 	struct hlist_head *slot;
+	int i;
 
 	double_ab_lock(dst_ab, src_ab, &flags);
 	bc = beancounter_find_locked(src_ab, id);
@@ -217,10 +218,26 @@ struct beancounter *beancounter_relocate
 	}
 
 	spin_lock(&bc->bc_lock);
+
+	/*
+	 * TODO: Support limit checking before relocation
+	 */
+	for (i = 0; i < BC_RESOURCES; i++)
+		src_ab->ab_parms[i].held -= bc->bc_parms[i].held;
+	src_ab->unused_privvmpages -= bc->unused_privvmpages;
+	src_ab->rss_pages -= bc->rss_pages;
+
 	hlist_del(&bc->hash);
 	slot = &dst_ab->ab_bucket[bc_hash_fn(id)];
 	hlist_add_head(&bc->hash, slot);
 	bc->ab = dst_ab;
+
+	for (i = 0; i < BC_RESOURCES; i++)
+		dst_ab->ab_parms[i].held += bc->bc_parms[i].held;
+
+	dst_ab->unused_privvmpages += bc->unused_privvmpages;
+	dst_ab->rss_pages += bc->rss_pages;
+
 	spin_unlock(&bc->bc_lock);
 
 out:
@@ -243,6 +260,14 @@ void put_aggr_beancounter(struct aggr_be
 			printk("AB: %d has %lu of %s held on put", ab->ab_id,
 				ab->ab_parms[i].held, bc_rnames[i]);
 
+	if (ab->unused_privvmpages != 0)
+		printk("AB: %d has %lu of unused pages held on put", ab->ab_id,
+			ab->unused_privvmpages);
+#ifdef CONFIG_BEANCOUNTERS_RSS
+	if (ab->rss_pages != 0)
+		printk("AB: %d hash %llu of rss pages held on put", ab->ab_id,
+			ab->rss_pages);
+#endif
 	hlist_del(&ab->hash);
 	nr_beancounters--;
 	spin_unlock_irqrestore(&ab_hash_lock, flags);
@@ -294,6 +319,7 @@ int bc_charge_locked(struct beancounter 
 		enum bc_severity strict)
 {
 	unsigned long new_held;
+	struct aggr_beancounter *ab = bc->ab;
 
 	/*
 	 * bc_value <= BC_MAXVALUE, value <= BC_MAXVALUE, and only one addition
@@ -303,17 +329,18 @@ int bc_charge_locked(struct beancounter 
 
 	switch (strict) {
 	case BC_BARRIER:
-		if (bc->bc_parms[resource].held >
-				bc->bc_parms[resource].barrier)
+		if (ab->ab_parms[resource].held >
+				ab->ab_parms[resource].barrier)
 			break;
 		/* fallthrough */
 	case BC_LIMIT:
-		if (bc->bc_parms[resource].held >
-				bc->bc_parms[resource].limit)
+		if (ab->ab_parms[resource].held >
+				ab->ab_parms[resource].limit)
 			break;
 		/* fallthrough */
 	case BC_FORCE:
 		bc->bc_parms[resource].held = new_held;
+		ab->ab_parms[resource].held += val;
 		bc_adjust_maxheld(bc, resource);
 		return 0;
 
@@ -344,6 +371,19 @@ EXPORT_SYMBOL_GPL(bc_charge);
 /* called with bc->bc_lock held and interrupts disabled */
 void bc_uncharge_locked(struct beancounter *bc, int resource, unsigned long val)
 {
+	struct aggr_beancounter *ab = bc->ab;
+	unsigned long val2 = val;
+
+	if (unlikely(ab->ab_parms[resource].held < val)) {
+		if (printk_ratelimit()) {
+			printk("AB: overuncharging ab %d %s: val %lu, holds "
+				"%lu\n", ab->ab_id, bc_rnames[resource], val,
+				ab->ab_parms[resource].held);
+			dump_stack();
+		}
+		val2 = ab->ab_parms[resource].held;
+	}
+
 	if (unlikely(bc->bc_parms[resource].held < val)) {
 		if (printk_ratelimit()) {
 			printk("BC: overuncharging bc %d %s: val %lu, holds "
@@ -355,6 +395,7 @@ void bc_uncharge_locked(struct beancount
 	}
 
 	bc->bc_parms[resource].held -= val;
+	ab->ab_parms[resource].held -= val2;
 	bc_adjust_minheld(bc, resource);
 }
 EXPORT_SYMBOL_GPL(bc_uncharge_locked);
@@ -404,6 +445,8 @@ static void init_aggr_beancounter_struct
 	for (i = 0; i < AB_HASH_SIZE; i++)
 		INIT_HLIST_HEAD(&ab->ab_bucket[i]);
 	INIT_HLIST_NODE(&ab->hash);
+	ab->unused_privvmpages = 0;
+	ab->rss_pages = 0;
 }
 
 static void init_aggr_beancounter_parm_nolimits(struct aggr_beancounter *ab)
diff -puN kernel/bc/vmpages.c~aggr-bc-charging-support kernel/bc/vmpages.c
--- linux-2.6.18-rc5/kernel/bc/vmpages.c~aggr-bc-charging-support	2006-09-17 20:34:48.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/vmpages.c	2006-09-17 20:34:48.000000000 +0530
@@ -17,6 +17,13 @@
 
 void bc_update_privvmpages(struct beancounter *bc)
 {
+	struct aggr_beancounter *ab = bc->ab;
+
+	ab->ab_parms[BC_PRIVVMPAGES].held = ab->unused_privvmpages
+#ifdef CONFIG_BEANCOUNTERS_RSS
+		+ (ab->rss_pages >> PB_PAGE_WEIGHT_SHIFT)
+#endif
+		;
 	bc->bc_parms[BC_PRIVVMPAGES].held = bc->unused_privvmpages
 #ifdef CONFIG_BEANCOUNTERS_RSS
 		+ (bc->rss_pages >> PB_PAGE_WEIGHT_SHIFT)
@@ -33,17 +40,29 @@ static inline int privvm_charge(struct b
 		return -ENOMEM;
 
 	bc->unused_privvmpages += sz;
+	bc->ab->unused_privvmpages += sz;
 	return 0;
 }
 
 static inline void privvm_uncharge(struct beancounter *bc, unsigned long sz)
 {
+	unsigned long sz2 = sz;
+	struct aggr_beancounter *ab = bc->ab;
+
 	if (unlikely(bc->unused_privvmpages < sz)) {
-		printk("BC: overuncharging %d unused pages: val %lu held %lu\n",
-				bc->bc_id, sz, bc->unused_privvmpages);
+		printk("privvm_uncharge: BC: overuncharging %d unused pages: "
+			" val %lu held %lu\n", bc->bc_id, sz,
+			bc->unused_privvmpages);
 		sz = bc->unused_privvmpages;
 	}
+	if (unlikely(ab->unused_privvmpages < sz2)) {
+		printk("privvm_uncharge: AB: overuncharging %d unused pages: "
+			"val %lu held %lu\n", ab->ab_id, sz,
+			ab->unused_privvmpages);
+		sz2 = ab->unused_privvmpages;
+	}
 	bc->unused_privvmpages -= sz;
+	ab->unused_privvmpages -= sz;
 	bc_update_privvmpages(bc);
 }
 
diff -puN include/bc/beancounter.h~aggr-bc-charging-support include/bc/beancounter.h
--- linux-2.6.18-rc5/include/bc/beancounter.h~aggr-bc-charging-support	2006-09-17 20:34:48.000000000 +0530
+++ linux-2.6.18-rc5-balbir/include/bc/beancounter.h	2006-09-17 20:34:48.000000000 +0530
@@ -77,6 +77,10 @@ struct aggr_beancounter {
 	spinlock_t 		ab_lock;
 	struct hlist_node	hash;
 	bcid_t			ab_id;
+	unsigned long		unused_privvmpages;
+#ifdef CONFIG_BEANCOUNTERS_RSS
+	unsigned long long	rss_pages;
+#endif
 };
 
 /*
diff -puN kernel/bc/vmrss.c~aggr-bc-charging-support kernel/bc/vmrss.c
--- linux-2.6.18-rc5/kernel/bc/vmrss.c~aggr-bc-charging-support	2006-09-17 20:34:48.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/vmrss.c	2006-09-17 20:34:48.000000000 +0530
@@ -154,19 +154,30 @@ static void mod_rss_pages(struct beancou
 		struct vm_area_struct *vma, int unused)
 {
 	unsigned long flags;
+	int unused2 = unused;
 
 	spin_lock_irqsave(&bc->bc_lock, flags);
 	if (vma && BC_VM_PRIVATE(vma->vm_flags, vma->vm_file)) {
 		if (unused < 0 && unlikely(bc->unused_privvmpages < -unused)) {
-			printk("BC: overuncharging %d unused pages: "
+			printk("mod_rss: BC: overuncharging %d unused pages: "
 					"val %i, held %lu\n",
 					bc->bc_id, unused,
 					bc->unused_privvmpages);
 			unused = -bc->unused_privvmpages;
 		}
+		if (unused < 0 && unlikely(bc->ab->unused_privvmpages <
+						-unused)) {
+			printk("mod_rss: AB: overuncharging %d unused pages: "
+					"val %i, held %lu\n",
+					bc->ab->ab_id, unused,
+					bc->ab->unused_privvmpages);
+			unused2 = -bc->ab->unused_privvmpages;
+		}
 		bc->unused_privvmpages += unused;
+		bc->ab->unused_privvmpages += unused2;
 	}
 	bc->rss_pages += val;
+	bc->ab->rss_pages += val;
 	bc_update_privvmpages(bc);
 	spin_unlock_irqrestore(&bc->bc_lock, flags);
 }
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs

