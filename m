Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUHDOev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUHDOev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUHDOeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:34:50 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:3049 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S266069AbUHDOcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:32:33 -0400
Date: Wed, 4 Aug 2004 07:28:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: dipankar@in.ibm.com, ak@suse.de, maneesh@in.ibm.com, shemminger@osdl.org
Subject: [RFC][PATCH] Improve readability by hiding read_barrier_depends() calls
Message-ID: <20040804142845.GB1865@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Updated based on feedback, and merged forward to 2.6.8-rc3.

This patch introduced an rcu_dereference() macro that replaces most
uses of smp_read_barrier_depends().  The new macro has the advantage
of explicitly documenting which pointers are protected by RCU -- in
contrast, it is sometimes difficult to figure out which pointer is
being protected by a given smp_read_barrier_depends() call.

Thoughts?

						Thanx, Paul


diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/include/linux/rcupdate.h linux-2.5-rcu_dereference/include/linux/rcupdate.h
--- linux-2.5-rcu_read_lock_comments/include/linux/rcupdate.h	Wed Aug  4 06:44:57 2004
+++ linux-2.5-rcu_dereference/include/linux/rcupdate.h	Wed Aug  4 07:04:22 2004
@@ -181,6 +181,22 @@ static inline int rcu_pending(int cpu) 
  * others' way, as long as they do so.
  */
 
+/**
+ * rcu_dereference - fetch an RCU-protected pointer in an
+ * RCU read-side critical section.  This pointer may later
+ * be safely dereferenced.
+ *
+ * Inserts memory barriers on architectures that require them
+ * (currently only the Alpha), and, more importantly, documents
+ * exactly which pointers are protected by RCU.
+ */
+
+#define rcu_dereference(p)	({ \
+				typeof(p) _________p1 = p; \
+				smp_read_barrier_depends(); \
+				(_________p1); \
+				})
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/arch/x86_64/kernel/mce.c linux-2.5-rcu_dereference/arch/x86_64/kernel/mce.c
--- linux-2.5-rcu_read_lock_comments/arch/x86_64/kernel/mce.c	Mon Aug  2 11:31:01 2004
+++ linux-2.5-rcu_dereference/arch/x86_64/kernel/mce.c	Wed Aug  4 06:46:43 2004
@@ -48,8 +48,7 @@ static void mce_log(struct mce *mce)
 	mce->finished = 0;
 	smp_wmb();
 	for (;;) {
-		entry = mcelog.next;
-		read_barrier_depends();
+		entry = rcu_dereference(mcelog.next);
 		/* When the buffer fills up discard new entries. Assume 
 		   that the earlier errors are the more interesting. */
 		if (entry >= MCE_LOG_LEN) {
@@ -333,9 +332,8 @@ static ssize_t mce_read(struct file *fil
 	int i, err;
 
 	down(&mce_read_sem); 
-	next = mcelog.next;
-	read_barrier_depends();
-		
+	next = rcu_dereference(mcelog.next);
+
 	/* Only supports full reads right now */
 	if (*off != 0 || usize < MCE_LOG_LEN*sizeof(struct mce)) { 
 		up(&mce_read_sem);
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/fs/dcache.c linux-2.5-rcu_dereference/fs/dcache.c
--- linux-2.5-rcu_read_lock_comments/fs/dcache.c	Mon Aug  2 11:31:45 2004
+++ linux-2.5-rcu_dereference/fs/dcache.c	Wed Aug  4 06:46:45 2004
@@ -613,7 +613,7 @@ void shrink_dcache_parent(struct dentry 
  *
  * Prune the dentries that are anonymous
  *
- * parsing d_hash list does not read_barrier_depends() as it
+ * parsing d_hash list does not hlist_for_each_rcu() as it
  * done under dcache_lock.
  *
  */
@@ -970,11 +970,10 @@ struct dentry * __d_lookup(struct dentry
 
 	rcu_read_lock();
 	
-	hlist_for_each (node, head) { 
+	hlist_for_each_rcu(node, head) { 
 		struct dentry *dentry; 
 		struct qstr *qstr;
 
-		smp_read_barrier_depends();
 		dentry = hlist_entry(node, struct dentry, d_hash);
 
 		smp_rmb();
@@ -1001,8 +1000,7 @@ struct dentry * __d_lookup(struct dentry
 		if (dentry->d_parent != parent)
 			goto next;
 
-		qstr = &dentry->d_name;
-		smp_read_barrier_depends();
+		qstr = rcu_dereference(&dentry->d_name);
 		if (parent->d_op && parent->d_op->d_compare) {
 			if (parent->d_op->d_compare(parent, qstr, name))
 				goto next;
@@ -1055,7 +1053,7 @@ int d_validate(struct dentry *dentry, st
 	spin_lock(&dcache_lock);
 	base = d_hash(dparent, dentry->d_name.hash);
 	hlist_for_each(lhp,base) { 
-		/* read_barrier_depends() not required for d_hash list
+		/* hlist_for_each_rcu() not required for d_hash list
 		 * as it is parsed under dcache_lock
 		 */
 		if (dentry == hlist_entry(lhp, struct dentry, d_hash)) {
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/include/linux/list.h linux-2.5-rcu_dereference/include/linux/list.h
--- linux-2.5-rcu_read_lock_comments/include/linux/list.h	Mon Aug  2 11:32:10 2004
+++ linux-2.5-rcu_dereference/include/linux/list.h	Wed Aug  4 06:54:12 2004
@@ -420,11 +420,11 @@ static inline void list_splice_init(stru
  */
 #define list_for_each_rcu(pos, head) \
 	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, ({ smp_read_barrier_depends(); 0;}), prefetch(pos->next))
+        	pos = rcu_dereference(pos->next), prefetch(pos->next))
 
 #define __list_for_each_rcu(pos, head) \
 	for (pos = (head)->next; pos != (head); \
-        	pos = pos->next, ({ smp_read_barrier_depends(); 0;}))
+        	pos = rcu_dereference(pos->next))
 
 /**
  * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
@@ -439,7 +439,7 @@ static inline void list_splice_init(stru
  */
 #define list_for_each_safe_rcu(pos, n, head) \
 	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = n, ({ smp_read_barrier_depends(); 0;}), n = pos->next)
+		pos = rcu_dereference(n), n = pos->next)
 
 /**
  * list_for_each_entry_rcu	-	iterate over rcu list of given type
@@ -455,8 +455,8 @@ static inline void list_splice_init(stru
 	for (pos = list_entry((head)->next, typeof(*pos), member),	\
 		     prefetch(pos->member.next);			\
 	     &pos->member != (head); 					\
-	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
-		     ({ smp_read_barrier_depends(); 0;}),		\
+	     pos = rcu_dereference(list_entry(pos->member.next,		\
+	     			   typeof(*pos), member)),		\
 		     prefetch(pos->member.next))
 
 
@@ -472,7 +472,7 @@ static inline void list_splice_init(stru
  */
 #define list_for_each_continue_rcu(pos, head) \
 	for ((pos) = (pos)->next, prefetch((pos)->next); (pos) != (head); \
-        	(pos) = (pos)->next, ({ smp_read_barrier_depends(); 0;}), prefetch((pos)->next))
+        	(pos) = rcu_dereference((pos)->next), prefetch((pos)->next))
 
 /*
  * Double linked lists with a single pointer list head.
@@ -578,12 +578,9 @@ static inline void hlist_add_head(struct
  * or hlist_del_rcu(), running on this same list.
  * However, it is perfectly legal to run concurrently with
  * the _rcu list-traversal primitives, such as
- * hlist_for_each_entry(), but only if smp_read_barrier_depends()
- * is used to prevent memory-consistency problems on Alpha CPUs.
- * Regardless of the type of CPU, the list-traversal primitive
- * must be guarded by rcu_read_lock().
- *
- * OK, so why don't we have an hlist_for_each_entry_rcu()???
+ * hlist_for_each_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.  Regardless of the type of CPU, the
+ * list-traversal primitive must be guarded by rcu_read_lock().
  */
 static inline void hlist_add_head_rcu(struct hlist_node *n,
 					struct hlist_head *h)
@@ -624,6 +621,10 @@ static inline void hlist_add_after(struc
 	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
 	     pos = pos->next)
 
+#define hlist_for_each_rcu(pos, head) \
+	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
+	     pos = rcu_dereference(pos->next))
+
 #define hlist_for_each_safe(pos, n, head) \
 	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
 	     pos = n)
@@ -693,7 +694,7 @@ static inline void hlist_add_after(struc
 	for (pos = (head)->first;					 \
 	     pos && ({ prefetch(pos->next); 1;}) &&			 \
 		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next, ({ smp_read_barrier_depends(); 0; }) )
+	     pos = rcu_dereference(pos->next))
 
 #else
 #warning "don't include kernel headers in userspace"
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/ipc/util.c linux-2.5-rcu_dereference/ipc/util.c
--- linux-2.5-rcu_read_lock_comments/ipc/util.c	Mon Aug  2 11:32:13 2004
+++ linux-2.5-rcu_dereference/ipc/util.c	Wed Aug  4 06:46:52 2004
@@ -100,7 +100,7 @@ int ipc_findkey(struct ipc_ids* ids, key
 	int max_id = ids->max_id;
 
 	/*
-	 * read_barrier_depends is not needed here
+	 * rcu_dereference() is not needed here
 	 * since ipc_ids.sem is held
 	 */
 	for (id = 0; id <= max_id; id++) {
@@ -172,7 +172,7 @@ int ipc_addid(struct ipc_ids* ids, struc
 	size = grow_ary(ids,size);
 
 	/*
-	 * read_barrier_depends() is not needed here since
+	 * rcu_dereference()() is not needed here since
 	 * ipc_ids.sem is held
 	 */
 	for (id = 0; id < size; id++) {
@@ -221,7 +221,7 @@ struct kern_ipc_perm* ipc_rmid(struct ip
 		BUG();
 
 	/* 
-	 * do not need a read_barrier_depends() here to force ordering
+	 * do not need a rcu_dereference()() here to force ordering
 	 * on Alpha, since the ipc_ids.sem is held.
 	 */	
 	p = ids->entries[lid].p;
@@ -481,13 +481,12 @@ struct kern_ipc_perm* ipc_lock(struct ip
 	 * Note: The following two read barriers are corresponding
 	 * to the two write barriers in grow_ary(). They guarantee 
 	 * the writes are seen in the same order on the read side. 
-	 * smp_rmb() has effect on all CPUs.  read_barrier_depends() 
+	 * smp_rmb() has effect on all CPUs.  rcu_dereference() 
 	 * is used if there are data dependency between two reads, and 
 	 * has effect only on Alpha.
 	 */
 	smp_rmb(); /* prevent indexing old array with new size */
-	entries = ids->entries;
-	read_barrier_depends(); /*prevent seeing new array unitialized */
+	entries = rcu_dereference(ids->entries);
 	out = entries[lid].p;
 	if(out == NULL) {
 		rcu_read_unlock();
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/bridge/br_input.c linux-2.5-rcu_dereference/net/bridge/br_input.c
--- linux-2.5-rcu_read_lock_comments/net/bridge/br_input.c	Mon Aug  2 11:32:14 2004
+++ linux-2.5-rcu_dereference/net/bridge/br_input.c	Wed Aug  4 06:46:54 2004
@@ -56,8 +56,7 @@ int br_handle_frame_finish(struct sk_buf
 	dest = skb->mac.ethernet->h_dest;
 
 	rcu_read_lock();
-	p = skb->dev->br_port;
-	smp_read_barrier_depends();
+	p = rcu_dereference(skb->dev->br_port);
 
 	if (p == NULL || p->state == BR_STATE_DISABLED) {
 		kfree_skb(skb);
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/core/dev.c linux-2.5-rcu_dereference/net/core/dev.c
--- linux-2.5-rcu_read_lock_comments/net/core/dev.c	Mon Aug  2 11:32:15 2004
+++ linux-2.5-rcu_dereference/net/core/dev.c	Wed Aug  4 06:58:22 2004
@@ -1332,8 +1332,7 @@ int dev_queue_xmit(struct sk_buff *skb)
 	 * also serializes access to the device queue.
 	 */
 
-	q = dev->qdisc;
-	smp_read_barrier_depends();
+	q = rcu_dereference(dev->qdisc);
 #ifdef CONFIG_NET_CLS_ACT
 	skb->tc_verd = SET_TC_AT(skb->tc_verd,AT_EGRESS);
 #endif
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/core/netfilter.c linux-2.5-rcu_dereference/net/core/netfilter.c
--- linux-2.5-rcu_read_lock_comments/net/core/netfilter.c	Mon Aug  2 11:32:18 2004
+++ linux-2.5-rcu_dereference/net/core/netfilter.c	Wed Aug  4 06:46:54 2004
@@ -783,13 +783,12 @@ void nf_log_packet(int pf,
 	nf_logfn *logfn;
 	
 	rcu_read_lock();
-	logfn = nf_logging[pf];
+	logfn = rcu_dereference(nf_logging[pf]);
 	if (logfn) {
 		va_start(args, fmt);
 		vsnprintf(prefix, sizeof(prefix), fmt, args);
 		va_end(args);
 		/* We must read logging before nf_logfn[pf] */
-		smp_read_barrier_depends();
 		logfn(hooknum, skb, in, out, prefix);
 	} else if (!reported) {
 		printk(KERN_WARNING "nf_log_packet: can\'t log yet, "
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/decnet/dn_route.c linux-2.5-rcu_dereference/net/decnet/dn_route.c
--- linux-2.5-rcu_read_lock_comments/net/decnet/dn_route.c	Mon Aug  2 11:32:18 2004
+++ linux-2.5-rcu_dereference/net/decnet/dn_route.c	Wed Aug  4 06:46:55 2004
@@ -1,4 +1,3 @@
-
 /*
  * DECnet       An implementation of the DECnet protocol suite for the LINUX
  *              operating system.  DECnet is implemented using the  BSD Socket
@@ -1175,8 +1174,8 @@ static int __dn_route_output_key(struct 
 
 	if (!(flags & MSG_TRYHARD)) {
 		rcu_read_lock();
-		for(rt = dn_rt_hash_table[hash].chain; rt; rt = rt->u.rt_next) {
-			read_barrier_depends();
+		for(rt = rcu_dereference(dn_rt_hash_table[hash].chain); rt;
+		    rt = rcu_dereference(rt->u.rt_next)) {
 			if ((flp->fld_dst == rt->fl.fld_dst) &&
 			    (flp->fld_src == rt->fl.fld_src) &&
 #ifdef CONFIG_DECNET_ROUTE_FWMARK
@@ -1454,8 +1453,8 @@ int dn_route_input(struct sk_buff *skb)
 		return 0;
 
 	rcu_read_lock();
-	for(rt = dn_rt_hash_table[hash].chain; rt != NULL; rt = rt->u.rt_next) {
-		read_barrier_depends();
+	for(rt = rcu_dereference(dn_rt_hash_table[hash].chain); rt != NULL;
+	    rt = rcu_dereference(rt->u.rt_next)) {
 		if ((rt->fl.fld_src == cb->src) &&
 	 	    (rt->fl.fld_dst == cb->dst) &&
 		    (rt->fl.oif == 0) &&
@@ -1648,8 +1647,8 @@ int dn_cache_dump(struct sk_buff *skb, s
 		if (h > s_h)
 			s_idx = 0;
 		rcu_read_lock();
-		for(rt = dn_rt_hash_table[h].chain, idx = 0; rt; rt = rt->u.rt_next, idx++) {
-			read_barrier_depends();
+		for(rt = rcu_dereference(dn_rt_hash_table[h].chain), idx = 0;
+		    rt; rt = rcu_dereference(rt->u.rt_next), idx++) {
 			if (idx < s_idx)
 				continue;
 			skb->dst = dst_clone(&rt->u.dst);
@@ -1692,9 +1691,8 @@ static struct dn_route *dn_rt_cache_get_
 
 static struct dn_route *dn_rt_cache_get_next(struct seq_file *seq, struct dn_route *rt)
 {
-	struct dn_rt_cache_iter_state *s = seq->private;
+	struct dn_rt_cache_iter_state *s = rcu_dereference(seq->private);
 
-	smp_read_barrier_depends();
 	rt = rt->u.rt_next;
 	while(!rt) {
 		rcu_read_unlock();
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/ipv4/icmp.c linux-2.5-rcu_dereference/net/ipv4/icmp.c
--- linux-2.5-rcu_read_lock_comments/net/ipv4/icmp.c	Mon Aug  2 11:32:18 2004
+++ linux-2.5-rcu_dereference/net/ipv4/icmp.c	Wed Aug  4 06:46:56 2004
@@ -705,8 +705,7 @@ static void icmp_unreach(struct sk_buff 
 	read_unlock(&raw_v4_lock);
 
 	rcu_read_lock();
-	ipprot = inet_protos[hash];
-	smp_read_barrier_depends();
+	ipprot = rcu_dereference(inet_protos[hash]);
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, info);
 	rcu_read_unlock();
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/ipv4/ip_input.c linux-2.5-rcu_dereference/net/ipv4/ip_input.c
--- linux-2.5-rcu_read_lock_comments/net/ipv4/ip_input.c	Mon Aug  2 11:32:18 2004
+++ linux-2.5-rcu_dereference/net/ipv4/ip_input.c	Wed Aug  4 06:46:57 2004
@@ -231,10 +231,9 @@ static inline int ip_local_deliver_finis
 		if (raw_sk)
 			raw_v4_input(skb, skb->nh.iph, hash);
 
-		if ((ipprot = inet_protos[hash]) != NULL) {
+		if ((ipprot = rcu_dereference(inet_protos[hash])) != NULL) {
 			int ret;
 
-			smp_read_barrier_depends();
 			if (!ipprot->no_policy &&
 			    !xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 				kfree_skb(skb);
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/ipv4/route.c linux-2.5-rcu_dereference/net/ipv4/route.c
--- linux-2.5-rcu_read_lock_comments/net/ipv4/route.c	Mon Aug  2 11:32:18 2004
+++ linux-2.5-rcu_dereference/net/ipv4/route.c	Wed Aug  4 06:46:59 2004
@@ -237,9 +237,8 @@ static struct rtable *rt_cache_get_first
 
 static struct rtable *rt_cache_get_next(struct seq_file *seq, struct rtable *r)
 {
-	struct rt_cache_iter_state *st = seq->private;
+	struct rt_cache_iter_state *st = rcu_dereference(seq->private);
 
-	smp_read_barrier_depends();
 	r = r->u.rt_next;
 	while (!r) {
 		rcu_read_unlock();
@@ -1004,10 +1003,9 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 			rthp=&rt_hash_table[hash].chain;
 
 			rcu_read_lock();
-			while ((rth = *rthp) != NULL) {
+			while ((rth = rcu_dereference(*rthp)) != NULL) {
 				struct rtable *rt;
 
-				smp_read_barrier_depends();
 				if (rth->fl.fl4_dst != daddr ||
 				    rth->fl.fl4_src != skeys[i] ||
 				    rth->fl.fl4_tos != tos ||
@@ -1259,9 +1257,8 @@ unsigned short ip_rt_frag_needed(struct 
 		unsigned hash = rt_hash_code(daddr, skeys[i], tos);
 
 		rcu_read_lock();
-		for (rth = rt_hash_table[hash].chain; rth;
-		     rth = rth->u.rt_next) {
-			smp_read_barrier_depends();
+		for (rth = rcu_dereference(rt_hash_table[hash].chain); rth;
+		     rth = rcu_dereference(rth->u.rt_next)) {
 			if (rth->fl.fl4_dst == daddr &&
 			    rth->fl.fl4_src == skeys[i] &&
 			    rth->rt_dst  == daddr &&
@@ -1864,8 +1861,8 @@ int ip_route_input(struct sk_buff *skb, 
 	hash = rt_hash_code(daddr, saddr ^ (iif << 5), tos);
 
 	rcu_read_lock();
-	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
-		smp_read_barrier_depends();
+	for (rth = rcu_dereference(rt_hash_table[hash].chain); rth;
+	     rth = rcu_dereference(rth->u.rt_next)) {
 		if (rth->fl.fl4_dst == daddr &&
 		    rth->fl.fl4_src == saddr &&
 		    rth->fl.iif == iif &&
@@ -2232,8 +2229,8 @@ int __ip_route_output_key(struct rtable 
 	hash = rt_hash_code(flp->fl4_dst, flp->fl4_src ^ (flp->oif << 5), flp->fl4_tos);
 
 	rcu_read_lock();
-	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
-		smp_read_barrier_depends();
+	for (rth = rcu_dereference(rt_hash_table[hash].chain); rth;
+	     rth = rcu_dereference(rth->u.rt_next)) {
 		if (rth->fl.fl4_dst == flp->fl4_dst &&
 		    rth->fl.fl4_src == flp->fl4_src &&
 		    rth->fl.iif == 0 &&
@@ -2464,9 +2461,8 @@ int ip_rt_dump(struct sk_buff *skb,  str
 		if (h > s_h)
 			s_idx = 0;
 		rcu_read_lock();
-		for (rt = rt_hash_table[h].chain, idx = 0; rt;
-		     rt = rt->u.rt_next, idx++) {
-			smp_read_barrier_depends();
+		for (rt = rcu_dereference(rt_hash_table[h].chain), idx = 0; rt;
+		     rt = rcu_dereference(rt->u.rt_next), idx++) {
 			if (idx < s_idx)
 				continue;
 			skb->dst = dst_clone(&rt->u.dst);
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/ipv6/icmp.c linux-2.5-rcu_dereference/net/ipv6/icmp.c
--- linux-2.5-rcu_read_lock_comments/net/ipv6/icmp.c	Mon Aug  2 11:32:19 2004
+++ linux-2.5-rcu_dereference/net/ipv6/icmp.c	Wed Aug  4 07:00:13 2004
@@ -530,8 +530,7 @@ static void icmpv6_notify(struct sk_buff
 	hash = nexthdr & (MAX_INET_PROTOS - 1);
 
 	rcu_read_lock();
-	ipprot = inet6_protos[hash];
-	smp_read_barrier_depends();
+	ipprot = rcu_dereference(inet6_protos[hash]);
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, NULL, type, code, inner_offset, info);
 	rcu_read_unlock();
diff -urpN -X ../dontdiff linux-2.5-rcu_read_lock_comments/net/ipv6/ip6_input.c linux-2.5-rcu_dereference/net/ipv6/ip6_input.c
--- linux-2.5-rcu_read_lock_comments/net/ipv6/ip6_input.c	Mon Aug  2 11:32:19 2004
+++ linux-2.5-rcu_dereference/net/ipv6/ip6_input.c	Wed Aug  4 06:47:00 2004
@@ -167,10 +167,9 @@ resubmit:
 		ipv6_raw_deliver(skb, nexthdr);
 
 	hash = nexthdr & (MAX_INET_PROTOS - 1);
-	if ((ipprot = inet6_protos[hash]) != NULL) {
+	if ((ipprot = rcu_dereference(inet6_protos[hash])) != NULL) {
 		int ret;
 		
-		smp_read_barrier_depends();
 		if (ipprot->flags & INET6_PROTO_FINAL) {
 			struct ipv6hdr *hdr;	
 
