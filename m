Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUD2I1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUD2I1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUD2I1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:27:34 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:19385 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S263696AbUD2IZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:25:10 -0400
Message-ID: <4090BBD9.7050807@watson.ibm.com>
Date: Thu, 29 Apr 2004 04:24:57 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [PATCH 6/6] CKRM socket accept queue resource controller
Content-Type: multipart/mixed;
 boundary="------------070600030403030605020809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600030403030605020809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070600030403030605020809
Content-Type: text/plain;
 name="05-socketaq.ckrm-E12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-socketaq.ckrm-E12.patch"

diff -Nru a/include/linux/tcp.h b/include/linux/tcp.h
--- a/include/linux/tcp.h	Wed Apr 28 22:41:05 2004
+++ b/include/linux/tcp.h	Wed Apr 28 22:41:05 2004
@@ -128,6 +128,10 @@
 #define TCP_INFO		11	/* Information about this connection. */
 #define TCP_QUICKACK		12	/* Block/reenable quick acks */
 
+#ifdef CONFIG_ACCEPT_QUEUES
+#define TCP_ACCEPTQ_SHARE	13	/* Set accept queue share */
+#endif
+
 #define TCPI_OPT_TIMESTAMPS	1
 #define TCPI_OPT_SACK		2
 #define TCPI_OPT_WSCALE		4
@@ -185,6 +189,18 @@
 	__u32	tcpi_reordering;
 };
 
+#ifdef CONFIG_ACCEPT_QUEUES
+
+#define NUM_ACCEPT_QUEUES	8 	/* Must be power of 2 */
+
+struct tcp_acceptq_info {
+	unsigned char acceptq_shares;
+	unsigned long acceptq_wait_time;
+	unsigned int acceptq_qcount;
+	unsigned int acceptq_count;
+};
+#endif
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>
@@ -362,8 +378,9 @@
 
 	/* FIFO of established children */
 	struct open_request	*accept_queue;
-	struct open_request	*accept_queue_tail;
-
+#ifndef CONFIG_ACCEPT_QUEUES
+	struct open_request     *accept_queue_tail;
+#endif
 	int			write_pending;	/* A write to socket waits to start. */
 
 	unsigned int		keepalive_time;	  /* time before keep alive takes place */
@@ -387,6 +404,22 @@
                 __u32    rtt;
                 __u32    rtt_min;          /* minimum observed RTT */
         } westwood;
+
+#ifdef CONFIG_ACCEPT_QUEUES
+	/* move to listen opt... */
+	char		class_index;
+	struct {
+		struct open_request     *aq_head;
+		struct open_request     *aq_tail;
+		unsigned int		 aq_cnt;
+		unsigned int		 aq_ratio;
+		unsigned int             aq_count;
+		unsigned int             aq_qcount;
+		unsigned int             aq_backlog;
+		unsigned int             aq_wait_time;
+		int			 aq_valid;
+	} acceptq[NUM_ACCEPT_QUEUES];
+#endif
 };
 
 /* WARNING: don't change the layout of the members in tcp_sock! */
diff -Nru a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h	Wed Apr 28 22:41:05 2004
+++ b/include/net/sock.h	Wed Apr 28 22:41:05 2004
@@ -245,6 +245,7 @@
 	struct timeval		sk_stamp;
 	struct socket		*sk_socket;
 	void			*sk_user_data;
+	void                    *sk_ns;        // For use by CKRM
 	struct module		*sk_owner;
 	void			*sk_security;
 	void			(*sk_state_change)(struct sock *sk);
diff -Nru a/include/net/tcp.h b/include/net/tcp.h
--- a/include/net/tcp.h	Wed Apr 28 22:41:05 2004
+++ b/include/net/tcp.h	Wed Apr 28 22:41:05 2004
@@ -642,6 +642,10 @@
 		struct tcp_v6_open_req v6_req;
 #endif
 	} af;
+#ifdef CONFIG_ACCEPT_QUEUES
+	unsigned long acceptq_time_stamp;
+	int	      acceptq_class;
+#endif
 };
 
 /* SLAB cache for open requests. */
@@ -1691,6 +1695,69 @@
 	return tcp_win_from_space(sk->sk_rcvbuf); 
 }
 
+#ifdef CONFIG_ACCEPT_QUEUES
+static inline void tcp_acceptq_removed(struct sock *sk, int class)
+{
+	tcp_sk(sk)->acceptq[class].aq_backlog--;
+}
+
+static inline void tcp_acceptq_added(struct sock *sk, int class)
+{
+	tcp_sk(sk)->acceptq[class].aq_backlog++;
+}
+
+static inline int tcp_acceptq_is_full(struct sock *sk, int class)
+{
+	return tcp_sk(sk)->acceptq[class].aq_backlog >
+		sk->sk_max_ack_backlog;
+}
+
+static inline void tcp_set_acceptq(struct tcp_opt *tp, struct open_request *req)
+{
+	int class = req->acceptq_class;
+	int prev_class;
+
+	if (!tp->acceptq[class].aq_ratio) {
+		req->acceptq_class = 0;
+		class = 0;
+	}
+
+	tp->acceptq[class].aq_qcount++;
+	req->acceptq_time_stamp = jiffies;
+
+	if (tp->acceptq[class].aq_tail) {
+		req->dl_next = tp->acceptq[class].aq_tail->dl_next;
+		tp->acceptq[class].aq_tail->dl_next = req;
+		tp->acceptq[class].aq_tail = req;
+	} else { /* if first request in the class */
+		tp->acceptq[class].aq_head = req;
+		tp->acceptq[class].aq_tail = req;
+
+		prev_class = class - 1;
+		while (prev_class >= 0) {
+			if (tp->acceptq[prev_class].aq_tail)
+				break;
+			prev_class--;
+		}
+		if (prev_class < 0) {
+			req->dl_next = tp->accept_queue;
+			tp->accept_queue = req;
+		}
+		else {
+			req->dl_next = tp->acceptq[prev_class].aq_tail->dl_next;
+			tp->acceptq[prev_class].aq_tail->dl_next = req;
+		}
+	}
+}
+static inline void tcp_acceptq_queue(struct sock *sk, struct open_request *req,
+					 struct sock *child)
+{
+	tcp_set_acceptq(tcp_sk(sk),req);
+	req->sk = child;
+	tcp_acceptq_added(sk,req->acceptq_class);
+}
+
+#else
 static inline void tcp_acceptq_removed(struct sock *sk)
 {
 	sk->sk_ack_backlog--;
@@ -1723,16 +1790,55 @@
 	req->dl_next = NULL;
 }
 
+#endif
+
 struct tcp_listen_opt
 {
 	u8			max_qlen_log;	/* log_2 of maximal queued SYNs */
 	int			qlen;
+#ifdef CONFIG_ACCEPT_QUEUES
+	int			qlen_young[NUM_ACCEPT_QUEUES];
+#else
 	int			qlen_young;
+#endif
 	int			clock_hand;
 	u32			hash_rnd;
 	struct open_request	*syn_table[TCP_SYNQ_HSIZE];
 };
 
+#ifdef CONFIG_ACCEPT_QUEUES
+static inline void
+tcp_synq_removed(struct sock *sk, struct open_request *req)
+{
+	struct tcp_listen_opt *lopt = tcp_sk(sk)->listen_opt;
+
+	if (--lopt->qlen == 0)
+		tcp_delete_keepalive_timer(sk);
+	if (req->retrans == 0)
+		lopt->qlen_young[req->acceptq_class]--;
+}
+
+static inline void tcp_synq_added(struct sock *sk, struct open_request *req)
+{
+	struct tcp_listen_opt *lopt = tcp_sk(sk)->listen_opt;
+
+	if (lopt->qlen++ == 0)
+		tcp_reset_keepalive_timer(sk, TCP_TIMEOUT_INIT);
+	lopt->qlen_young[req->acceptq_class]++;
+}
+
+static inline int tcp_synq_len(struct sock *sk)
+{
+	return tcp_sk(sk)->listen_opt->qlen;
+}
+
+static inline int tcp_synq_young(struct sock *sk, int class)
+{
+	return tcp_sk(sk)->listen_opt->qlen_young[class];
+}
+
+#else
+
 static inline void
 tcp_synq_removed(struct sock *sk, struct open_request *req)
 {
@@ -1762,6 +1868,7 @@
 {
 	return tcp_sk(sk)->listen_opt->qlen_young;
 }
+#endif
 
 static inline int tcp_synq_is_full(struct sock *sk)
 {
diff -Nru a/kernel/ckrm/ckrm_listenaq.c b/kernel/ckrm/ckrm_listenaq.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/ckrm/ckrm_listenaq.c	Wed Apr 28 22:41:05 2004
@@ -0,0 +1,503 @@
+/* ckrm_socketaq.c - accept queue resource controller
+ *
+ * Copyright (C) Vivek Kashyap,      IBM Corp. 2004
+ * 
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ * Initial version
+ */
+
+/* Code Description: TBD
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <asm/errno.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/ckrm.h>
+#include <linux/ckrm_rc.h>
+#include <net/tcp.h>
+
+#include <linux/ckrm_net.h>
+
+#define hnode_2_core(ptr) \
+                ((ptr) ? container_of(ptr, struct ckrm_core_class, hnode) : NULL)
+
+
+#define CKRM_SAQ_MAX_DEPTH	3 // 0 => /rcfs
+				  // 1 => socket_aq
+				  // 2 => socket_aq/listen_class
+				  // 3 => socket_aq/listen_class/accept_queues
+				  // 4 => Not allowed
+
+typedef struct ckrm_laq_res {
+	spinlock_t		reslock;
+	atomic_t		refcnt;
+	struct ckrm_shares 	shares;
+	struct ckrm_core_class *core;
+	struct ckrm_core_class *pcore;
+	int 			my_depth;
+	int 			my_id;
+} ckrm_laq_res_t;
+
+static int my_resid = -1;
+
+extern	struct ckrm_core_class *rcfs_create_under_netroot(char *, int, int);
+extern struct ckrm_core_class *rcfs_make_core(struct dentry *, 
+						struct ckrm_core_class * ) ;
+
+void
+laq_res_hold(struct ckrm_laq_res *res)
+{
+        atomic_inc(&res->refcnt);
+	return;
+}
+
+void
+laq_res_put(struct ckrm_laq_res *res)
+{
+	if (atomic_dec_and_test(&res->refcnt))
+		kfree(res);
+	return;
+}
+
+/* Initialize rescls values
+ */
+static void
+laq_res_initcls(void *my_res)
+{
+	ckrm_laq_res_t *res = my_res;
+
+	res->shares.my_guarantee     = CKRM_SHARE_DONTCARE;
+	res->shares.my_limit         = CKRM_SHARE_DONTCARE;
+	res->shares.total_guarantee  = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+	res->shares.max_limit        = CKRM_SHARE_DFLT_MAX_LIMIT;
+	res->shares.unused_guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+	res->shares.cur_max_limit    = 0;
+}
+
+static int 
+atoi(char *s)
+{
+	int k = 0;
+	while(*s) 
+		k = *s++ - '0' + (k * 10);
+	return k;
+}
+
+static char *
+laq_get_name(struct ckrm_core_class *c)
+{
+        char *p = (char *)c->name;
+
+        while(*p)
+                p++;
+        while( *p != '/' && p != c->name)
+                p--;
+
+        return ++p;
+}
+
+static void *
+laq_res_alloc(struct ckrm_core_class *core, struct ckrm_core_class *parent)
+{
+	ckrm_laq_res_t *res, *pres;
+	int pdepth;
+
+	if (parent)
+		pres = ckrm_get_res_class(parent, my_resid, ckrm_laq_res_t);
+	else
+		pres = NULL;
+
+	if (core == core->classtype->default_class)    
+		pdepth = 1;
+	else {
+		if (!parent)
+			return NULL;
+		pdepth = 1 + pres->my_depth;
+	}
+
+	res = kmalloc(sizeof(ckrm_laq_res_t), GFP_ATOMIC);
+	if (res) {
+		memset(res, 0, sizeof(res));
+		spin_lock_init(&res->reslock);
+		laq_res_hold(res);
+		res->my_depth  = pdepth;
+		if (pdepth == 2)	// listen class
+			res->my_id = 0;
+		else if (pdepth == 3)
+			res->my_id = atoi(laq_get_name(core));
+		res->core = core;
+		res->pcore = parent;
+
+		// rescls in place, now initialize contents other than 
+		// hierarchy pointers
+		laq_res_initcls(res); // acts as initialising value
+	}
+
+	return res;
+}
+
+static void
+laq_res_free(void *my_res)
+{
+	ckrm_laq_res_t *res = (ckrm_laq_res_t *)my_res;
+	ckrm_laq_res_t *parent;
+
+	if (!res) 
+		return;
+
+	if (res->my_depth != 3) {
+		kfree(res);
+		return;
+	}
+
+	parent = ckrm_get_res_class(res->pcore, my_resid, ckrm_laq_res_t);
+	if (!parent)	// Should never happen
+		return;
+
+	spin_lock(&parent->reslock);
+	spin_lock(&res->reslock);
+
+	// return child's guarantee to parent node
+	// Limits have no meaning for accept queue control
+	child_guarantee_changed(&parent->shares, res->shares.my_guarantee, 0);
+
+	spin_unlock(&res->reslock);
+	laq_res_put(res);	
+	spin_unlock(&parent->reslock);
+	return;
+}
+
+/**************************************************************************
+ * 			SHARES					        ***
+ **************************************************************************/
+
+void
+laq_set_aq_values(ckrm_laq_res_t *my_res, ckrm_laq_res_t *parent, int updatep)
+{
+
+	struct ckrm_net_struct *ns;
+	struct ckrm_core_class *core = parent->core;
+	struct tcp_opt *tp;
+	
+	if (my_res->my_depth < 2) 
+		return;
+	
+	// XXX Instead of holding a  class_lock introduce a rw
+	// lock to be write locked by listen callbacks and read locked here.
+	// - VK
+	class_lock(core);
+	list_for_each_entry(ns, &core->objlist,ckrm_link) { 
+		tp = tcp_sk(ns->ns_sk);
+		if (updatep)
+			tp->acceptq[0].aq_ratio =
+			       parent->shares.total_guarantee/
+				parent->shares.unused_guarantee;	       
+
+		tp->acceptq[my_res->my_id].aq_ratio =
+		       my_res->shares.total_guarantee/
+			parent->shares.my_guarantee;	       
+	}
+	class_unlock(core);
+	return;
+}
+
+static int
+laq_set_share_values(void *my_res, struct ckrm_shares *shares)
+{
+	ckrm_laq_res_t *res = my_res;
+	ckrm_laq_res_t *parent, *child;
+	struct ckrm_hnode *chnode; 
+	int rc = 0;
+
+	if (!res) 
+		return -EINVAL;
+
+	if (!res->pcore) { 
+		// something is badly wrong
+		printk(KERN_ERR "socketaq internal inconsistency\n");
+		return -EBADF;
+	}
+
+	parent = ckrm_get_res_class(res->pcore, my_resid, ckrm_laq_res_t);
+	if (!parent)	// socket_class does not have a share interface
+		return -EINVAL;
+
+	// Ensure that we ignore limit values
+	shares->my_limit = shares->max_limit = CKRM_SHARE_UNCHANGED;
+
+	switch (res->my_depth) {
+
+	case 0: printk(KERN_ERR "socketaq bad entry\n");
+		rc = -EBADF;
+		break;
+
+	case 1: // can't be written to. this is internal default.
+		// return -EINVAL
+		rc = -EINVAL;
+		break;
+
+	case 2: // nothing to inherit
+		if (!shares->total_guarantee) {
+			rc = -EINVAL;
+			break;
+		}
+
+		ckrm_lock_hier(res->pcore);
+		spin_lock(&res->reslock);
+		rc = set_shares(shares, &res->shares, NULL);
+		if (!rc) {
+			list_for_each_entry(chnode,
+					&res->core->hnode.children,siblings){
+				child=hnode_2_core(chnode)->res_class[my_resid];
+				laq_set_aq_values(child,res,(child->my_id==1));
+			}
+		}
+		spin_unlock(&res->reslock);
+		ckrm_unlock_hier(res->pcore);
+		break;
+
+	case 3: // accept queue itself. Check against parent.
+		ckrm_lock_hier(parent->pcore);
+		spin_lock(&parent->reslock);
+		rc = set_shares(shares, &res->shares, &parent->shares);
+		if (!rc) {
+			laq_set_aq_values(res,parent,1);
+		}
+		spin_unlock(&parent->reslock);
+		ckrm_unlock_hier(parent->pcore);
+		break;
+	}
+
+	return rc;
+}
+
+static int
+laq_get_share_values(void *my_res, struct ckrm_shares *shares)
+{
+	ckrm_laq_res_t *res = my_res;
+
+	if (!res) 
+		return -EINVAL;
+	*shares = res->shares;
+	return 0;
+}
+
+/**************************************************************************
+ * 			STATS						***
+ **************************************************************************/
+
+void
+laq_print_aq_stats(struct seq_file *sfile, struct tcp_acceptq_info *taq, int i)
+{
+	seq_printf(sfile, "Class %d connections:\n\taccepted: %u\n\t"
+			  "queued: %u\n\twait_time: %lu\n\t",
+			  i, taq->acceptq_count, taq->acceptq_qcount,
+			  taq->acceptq_wait_time);
+
+	if (i)
+		return;
+
+	for (i = 1; i < NUM_ACCEPT_QUEUES; i++) {
+		taq[0].acceptq_wait_time += taq[i].acceptq_wait_time;
+		taq[0].acceptq_qcount += taq[i].acceptq_qcount;
+		taq[0].acceptq_count += taq[i].acceptq_count;
+	}
+
+	seq_printf(sfile, "Totals :\n\taccepted: %u\n\t"
+			  "queued: %u\n\twait_time: %lu\n",
+			   taq->acceptq_count, taq->acceptq_qcount,
+			  taq->acceptq_wait_time);
+
+	return;
+}
+
+void
+laq_get_aq_stats(ckrm_laq_res_t *pres, ckrm_laq_res_t *mres, 
+					struct tcp_acceptq_info *taq)
+{
+	struct ckrm_net_struct *ns;
+	struct ckrm_core_class *core = pres->core;
+	struct tcp_opt *tp;
+	int a = mres->my_id;
+	int z;
+
+	if (a == 0)
+		z = NUM_ACCEPT_QUEUES;
+	else
+		z = a+1;
+
+	// XXX Instead of holding a  class_lock introduce a rw
+	// lock to be write locked by listen callbacks and read locked here.
+	// - VK
+	class_lock(pres->core);
+	list_for_each_entry(ns, &core->objlist,ckrm_link) { 
+		tp = tcp_sk(ns->ns_sk);
+		for (; a< z; a++) {
+			taq->acceptq_wait_time += tp->acceptq[a].aq_wait_time;
+			taq->acceptq_qcount += tp->acceptq[a].aq_qcount;
+			taq->acceptq_count += tp->acceptq[a].aq_count;
+			taq++;
+		}
+	}
+	class_unlock(pres->core);
+}
+
+
+static int  
+laq_get_stats(void *my_res, struct seq_file *sfile)
+{
+	ckrm_laq_res_t *res = my_res;
+	ckrm_laq_res_t *parent;
+	struct tcp_acceptq_info taq[NUM_ACCEPT_QUEUES];
+	int rc = 0;
+
+	if (!res) 
+		return -EINVAL;
+	
+	if (!res->pcore) { 
+		// something is badly wrong
+		printk(KERN_ERR "socketaq internal inconsistency\n");
+		return -EBADF;
+	}
+
+	parent = ckrm_get_res_class(res->pcore, my_resid, ckrm_laq_res_t);
+	if (!parent) {	// socket_class does not have a stat interface
+		printk(KERN_ERR "socketaq internal fs inconsistency\n");
+		return -EINVAL;
+	}
+
+	memset(taq, 0, sizeof(struct tcp_acceptq_info) * NUM_ACCEPT_QUEUES);
+
+	switch (res->my_depth) {
+
+	default:
+	case 0: printk(KERN_ERR "socket class bad entry\n");
+		rc = -EBADF;
+		break;
+
+	case 1: // can't be read from. this is internal default.
+		// return -EINVAL
+		rc = -EINVAL;
+		break;
+
+	case 2: // return the default and total
+		ckrm_lock_hier(res->core);	// block any deletes
+		laq_get_aq_stats(res, res, &taq[0]);
+		laq_print_aq_stats(sfile, &taq[0], 0);
+		ckrm_unlock_hier(res->core);	// block any deletes
+		break;
+
+	case 3: 
+		ckrm_lock_hier(parent->core);	// block any deletes
+		laq_get_aq_stats(parent, res, &taq[res->my_id]);
+		laq_print_aq_stats(sfile, &taq[res->my_id], res->my_id);
+		ckrm_unlock_hier(parent->core);	// block any deletes
+		break;
+	}
+
+	return rc;
+}
+
+/*
+ * The network connection is reclassified to this class. Update its shares.
+ * The socket lock is held. 
+ */
+static void
+laq_change_resclass(void *n, void *old, void *r)
+{
+	struct ckrm_net_struct *ns = (struct ckrm_net_struct *)n;
+	struct ckrm_laq_res *res = (struct ckrm_laq_res *)r;
+	struct ckrm_hnode  *chnode = NULL;
+
+
+	if (res->my_depth != 2) 
+		return;	
+
+	// a change to my_depth == 3 ie. the accept classes cannot happen.
+	// there is no target file
+	if (res->my_depth == 2) { // it is one of the socket classes
+		struct ckrm_laq_res *reschild;
+		struct sock *sk = ns->ns_sk; 
+		struct tcp_opt *tp = tcp_sk(sk);
+
+		// share rule: hold parent resource lock. then self.
+		// However, since my_depth == 1 is a generic class it is not
+		// needed here. Self lock is enough.
+		spin_lock(&res->reslock);
+		tp->acceptq[0].aq_ratio = res->shares.total_guarantee/
+				res->shares.unused_guarantee;
+		list_for_each_entry(chnode,&res->core->hnode.children,siblings){
+			reschild = hnode_2_core(chnode)->res_class[my_resid];
+
+			spin_lock(&reschild->reslock);
+			tp->acceptq[reschild->my_id].aq_ratio=
+				reschild->shares.total_guarantee/
+					res->shares.my_guarantee;
+			spin_unlock(&reschild->reslock);
+		}
+		spin_unlock(&res->reslock);
+	}
+	
+	return;
+}
+
+struct ckrm_res_ctlr laq_rcbs = {
+	.res_name          = "laq",
+	.resid		   = -1 , // dynamically assigned
+	.res_alloc         = laq_res_alloc,
+	.res_free          = laq_res_free,
+	.set_share_values  = laq_set_share_values,
+	.get_share_values  = laq_get_share_values,
+	.get_stats         = laq_get_stats,
+	.change_resclass   = laq_change_resclass,
+	//	.res_initcls       = laq_res_initcls,         // LAQ_HUBERTUS: no need for this !!
+};
+
+int __init
+init_ckrm_laq_res(void)
+{
+	struct ckrm_classtype *clstype;
+	int resid;
+
+	clstype = ckrm_find_classtype_by_name("socket_class");
+	if (clstype == NULL) {
+		printk(KERN_INFO " Unknown ckrm classtype<socket_class>");
+		return -ENOENT;
+	}
+
+	if (my_resid == -1) {
+		resid = ckrm_register_res_ctlr(clstype,&laq_rcbs);
+		if (resid >= 0)
+			my_resid = resid;
+		printk("........init_ckrm_listen_aq_res -> %d\n",my_resid);
+	}
+	return 0;
+
+}	
+
+void __exit
+exit_ckrm_laq_res(void)
+{
+	ckrm_unregister_res_ctlr(&laq_rcbs);
+	my_resid = -1;
+}
+
+
+module_init(init_ckrm_laq_res)
+module_exit(exit_ckrm_laq_res)
+
+MODULE_LICENSE("GPL");
+
diff -Nru a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	Wed Apr 28 22:41:05 2004
+++ b/net/ipv4/Kconfig	Wed Apr 28 22:41:05 2004
@@ -360,5 +360,28 @@
 	  
 	  If unsure, say Y.
 
+config ACCEPT_QUEUES 
+	bool "IP: TCP Multiple accept queues support"
+	depends on INET && NETFILTER
+	---help---
+	  Support multiple accept queues per listening socket. If you say Y
+	  here, multiple accept queues will be configured per listening
+	  socket.
+	  
+	  Each queue is mapped to a priority class. Incoming connection 
+	  requests can be classified (see iptables(8), MARK target), depending
+	  on the packet's src/dest address or other parameters, into one of 
+	  the priority classes. The requests are then queued to the relevant
+	  accept queue. 
+
+	  Each of the queues can be assigned a weight. The accept()ance 
+	  of packets is then scheduled in accordance with the weight 
+	  assigned to the priority class. 
+	  
+	  Be sure to enable "Network packet filtering" if you wish
+	  to use this feature.
+
+	  If unsure, say N.
+
 source "net/ipv4/ipvs/Kconfig"
 
diff -Nru a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	Wed Apr 28 22:41:05 2004
+++ b/net/ipv4/tcp.c	Wed Apr 28 22:41:05 2004
@@ -256,6 +256,7 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/random.h>
+#include <linux/ckrm.h>
 
 #include <net/icmp.h>
 #include <net/tcp.h>
@@ -534,13 +535,34 @@
 
 int tcp_listen_start(struct sock *sk)
 {
+#ifdef CONFIG_ACCEPT_QUEUES
+	int i = 0;
+#endif
 	struct inet_opt *inet = inet_sk(sk);
 	struct tcp_opt *tp = tcp_sk(sk);
 	struct tcp_listen_opt *lopt;
 
 	sk->sk_max_ack_backlog = 0;
 	sk->sk_ack_backlog = 0;
-	tp->accept_queue = tp->accept_queue_tail = NULL;
+	tp->accept_queue = NULL;
+#ifdef CONFIG_ACCEPT_QUEUES
+	tp->class_index = 0;
+	for (i=0; i < NUM_ACCEPT_QUEUES; i++) {
+		tp->acceptq[i].aq_tail = NULL;
+		tp->acceptq[i].aq_head = NULL;
+		tp->acceptq[i].aq_wait_time = 0; 
+		tp->acceptq[i].aq_qcount = 0; 
+		tp->acceptq[i].aq_count = 0; 
+		if (i == 0) {
+			tp->acceptq[i].aq_valid = 1; 
+			tp->acceptq[i].aq_ratio = 1; 
+		}
+		else {
+			tp->acceptq[i].aq_valid = 0; 
+			tp->acceptq[i].aq_ratio = 0; 
+		}
+	}
+#endif
 	tp->syn_wait_lock = RW_LOCK_UNLOCKED;
 	tcp_delack_init(tp);
 
@@ -570,6 +592,10 @@
 		sk_dst_reset(sk);
 		sk->sk_prot->hash(sk);
 
+#ifdef CONFIG_CKRM
+		ckrm_cb_listen_start(sk);
+#endif
+
 		return 0;
 	}
 
@@ -600,7 +626,18 @@
 	write_lock_bh(&tp->syn_wait_lock);
 	tp->listen_opt = NULL;
 	write_unlock_bh(&tp->syn_wait_lock);
-	tp->accept_queue = tp->accept_queue_tail = NULL;
+
+#ifdef CONFIG_CKRM
+		ckrm_cb_listen_stop(sk);
+#endif
+
+#ifdef CONFIG_ACCEPT_QUEUES
+	for (i = 0; i < NUM_ACCEPT_QUEUES; i++)
+		tp->acceptq[i].aq_head = tp->acceptq[i].aq_tail = NULL;
+#else
+	tp->accept_queue_tail = NULL;
+#endif
+	tp->accept_queue = NULL;
 
 	if (lopt->qlen) {
 		for (i = 0; i < TCP_SYNQ_HSIZE; i++) {
@@ -646,7 +683,11 @@
 		local_bh_enable();
 		sock_put(child);
 
+#ifdef CONFIG_ACCEPT_QUEUES
+		tcp_acceptq_removed(sk, req->acceptq_class);
+#else
 		tcp_acceptq_removed(sk);
+#endif
 		tcp_openreq_fastfree(req);
 	}
 	BUG_TRAP(!sk->sk_ack_backlog);
@@ -2230,6 +2271,10 @@
 	struct open_request *req;
 	struct sock *newsk;
 	int error;
+#ifdef CONFIG_ACCEPT_QUEUES	
+	int prev_class = 0;
+	int first;
+#endif
 
 	lock_sock(sk);
 
@@ -2243,7 +2288,6 @@
 	/* Find already established connection */
 	if (!tp->accept_queue) {
 		long timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
-
 		/* If this is a non blocking socket don't sleep */
 		error = -EAGAIN;
 		if (!timeo)
@@ -2254,12 +2298,46 @@
 			goto out;
 	}
 
+#ifndef CONFIG_ACCEPT_QUEUES
 	req = tp->accept_queue;
 	if ((tp->accept_queue = req->dl_next) == NULL)
 		tp->accept_queue_tail = NULL;
 
- 	newsk = req->sk;
 	tcp_acceptq_removed(sk);
+#else
+	first = tp->class_index;
+	/* We should always have  request queued here. The accept_queue
+	 * is already checked for NULL above.
+	 */
+	while(!tp->acceptq[first].aq_head) {
+		tp->acceptq[first].aq_cnt = 0;
+		first = (first+1) & ~NUM_ACCEPT_QUEUES; 
+	}
+        req = tp->acceptq[first].aq_head;
+	tp->acceptq[first].aq_qcount--;
+	tp->acceptq[first].aq_count++;
+	tp->acceptq[first].aq_wait_time+=(jiffies - req->acceptq_time_stamp);
+
+	for (prev_class= first-1 ; prev_class >=0; prev_class--)
+		if (tp->acceptq[prev_class].aq_tail)
+			break;
+	if (prev_class>=0)
+		tp->acceptq[prev_class].aq_tail->dl_next = req->dl_next; 
+	else 
+		tp->accept_queue = req->dl_next;
+
+	if (req == tp->acceptq[first].aq_tail) 
+		tp->acceptq[first].aq_head = tp->acceptq[first].aq_tail = NULL;
+	else
+		tp->acceptq[first].aq_head = req->dl_next;
+
+	if((++(tp->acceptq[first].aq_cnt)) >= tp->acceptq[first].aq_ratio){
+		tp->acceptq[first].aq_cnt = 0;
+		tp->class_index = ++first & ~NUM_ACCEPT_QUEUES;
+	}	
+	tcp_acceptq_removed(sk, req->acceptq_class);
+#endif
+ 	newsk = req->sk;
 	tcp_openreq_fastfree(req);
 	BUG_TRAP(newsk->sk_state != TCP_SYN_RECV);
 	release_sock(sk);
@@ -2429,6 +2507,49 @@
 			}
 		}
 		break;
+		
+#ifdef CONFIG_ACCEPT_QUEUES
+	case TCP_ACCEPTQ_SHARE:
+		{
+			char share_wt[NUM_ACCEPT_QUEUES];
+			int i,j;
+
+			if (sk->sk_state != TCP_LISTEN)
+				return -EOPNOTSUPP;
+
+			if (copy_from_user(share_wt,optval, optlen)) {
+				err = -EFAULT;
+				break;
+			}
+			j = 0;
+			for (i = 0; i < NUM_ACCEPT_QUEUES; i++) {
+				if (share_wt[i]) {
+					if (!j)
+						j = share_wt[i];
+					else if (share_wt[i] < j) {
+						j = share_wt[i];
+					}
+					tp->acceptq[i].aq_valid = 1;
+				}
+				else
+					tp->acceptq[i].aq_valid = 0;
+					
+			}
+			if (j == 0) {
+				/* Class 0 is always valid. If nothing is 
+				 * specified set class 0 as 1.
+				 */
+				share_wt[0] = 1;
+				tp->acceptq[0].aq_valid = 1;
+				j = 1;
+			}
+			for (i=0; i < NUM_ACCEPT_QUEUES; i++)  {
+				tp->acceptq[i].aq_ratio = share_wt[i]/j;
+				tp->acceptq[i].aq_cnt = 0;
+			}
+		}
+		break;
+#endif
 
 	default:
 		err = -ENOPROTOOPT;
@@ -2555,6 +2676,41 @@
 	case TCP_QUICKACK:
 		val = !tp->ack.pingpong;
 		break;
+
+#ifdef CONFIG_ACCEPT_QUEUES
+	case TCP_ACCEPTQ_SHARE: {
+		struct tcp_acceptq_info tinfo[NUM_ACCEPT_QUEUES];
+		int i;
+
+		if (sk->sk_state != TCP_LISTEN)
+			return -EOPNOTSUPP;
+
+		if (get_user(len, optlen))
+			return -EFAULT;
+
+		memset(tinfo, 0, sizeof(tinfo));
+
+		for(i=0; i < NUM_ACCEPT_QUEUES; i++) {
+			tinfo[i].acceptq_wait_time = 
+				tp->acceptq[i].aq_wait_time/(HZ/USER_HZ);
+			tinfo[i].acceptq_qcount = tp->acceptq[i].aq_qcount;
+			tinfo[i].acceptq_count = tp->acceptq[i].aq_count;
+			if (tp->acceptq[i].aq_valid) 
+				tinfo[i].acceptq_shares=tp->acceptq[i].aq_ratio;
+			else
+				tinfo[i].acceptq_shares = 0;
+		}
+
+		len = min_t(unsigned int, len, sizeof(tinfo));
+		if (put_user(len, optlen)) 
+			return -EFAULT;
+			
+		if (copy_to_user(optval, (char *)tinfo, len))
+			return -EFAULT;
+		
+		return 0;
+	}
+#endif
 	default:
 		return -ENOPROTOOPT;
 	};
diff -Nru a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	Wed Apr 28 22:41:05 2004
+++ b/net/ipv4/tcp_ipv4.c	Wed Apr 28 22:41:05 2004
@@ -458,7 +458,6 @@
 	head = &tcp_listening_hash[tcp_lhashfn(hnum)];
 	if (!hlist_empty(head)) {
 		struct inet_opt *inet = inet_sk((sk = __sk_head(head)));
-
 		if (inet->num == hnum && !sk->sk_node.next &&
 		    (!inet->rcv_saddr || inet->rcv_saddr == daddr) &&
 		    (sk->sk_family == PF_INET || !ipv6_only_sock(sk)) &&
@@ -916,7 +915,11 @@
 	lopt->syn_table[h] = req;
 	write_unlock(&tp->syn_wait_lock);
 
+#ifdef CONFIG_ACCEPT_QUEUES
+	tcp_synq_added(sk, req);
+#else
 	tcp_synq_added(sk);
+#endif
 }
 
 
@@ -1413,6 +1416,9 @@
 	__u32 daddr = skb->nh.iph->daddr;
 	__u32 isn = TCP_SKB_CB(skb)->when;
 	struct dst_entry *dst = NULL;
+#ifdef CONFIG_ACCEPT_QUEUES
+	int class = 0;
+#endif
 #ifdef CONFIG_SYN_COOKIES
 	int want_cookie = 0;
 #else
@@ -1437,12 +1443,32 @@
 		goto drop;
 	}
 
+#ifdef CONFIG_ACCEPT_QUEUES
+	class = (skb->nfmark <= 0) ? 0 :
+		((skb->nfmark > NUM_ACCEPT_QUEUES) ? NUM_ACCEPT_QUEUES:
+		 skb->nfmark);
+	/*
+	 * Accept only if the class has shares set or if the default class
+	 * i.e. class 0 has shares
+	 */
+	if (!(tcp_sk(sk)->acceptq[class].aq_valid)) {
+		if (tcp_sk(sk)->acceptq[0].aq_valid) 
+			class = 0;
+		else
+			goto drop;
+	}
+#endif
+
 	/* Accept backlog is full. If we have already queued enough
 	 * of warm entries in syn queue, drop request. It is better than
 	 * clogging syn queue with openreqs with exponentially increasing
 	 * timeout.
 	 */
+#ifdef CONFIG_ACCEPT_QUEUES
+	if (tcp_acceptq_is_full(sk, class) && tcp_synq_young(sk, class) > 1)
+#else
 	if (tcp_acceptq_is_full(sk) && tcp_synq_young(sk) > 1)
+#endif
 		goto drop;
 
 	req = tcp_openreq_alloc();
@@ -1472,7 +1498,10 @@
 	tp.tstamp_ok = tp.saw_tstamp;
 
 	tcp_openreq_init(req, &tp, skb);
-
+#ifdef CONFIG_ACCEPT_QUEUES
+	req->acceptq_class = class;
+	req->acceptq_time_stamp = jiffies;
+#endif
 	req->af.v4_req.loc_addr = daddr;
 	req->af.v4_req.rmt_addr = saddr;
 	req->af.v4_req.opt = tcp_v4_save_options(sk, skb);
@@ -1567,7 +1596,11 @@
 	struct tcp_opt *newtp;
 	struct sock *newsk;
 
+#ifdef CONFIG_ACCEPT_QUEUES
+	if (tcp_acceptq_is_full(sk, req->acceptq_class))
+#else
 	if (tcp_acceptq_is_full(sk))
+#endif
 		goto exit_overflow;
 
 	if (!dst && (dst = tcp_v4_route_req(sk, req)) == NULL)
diff -Nru a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
--- a/net/ipv4/tcp_minisocks.c	Wed Apr 28 22:41:05 2004
+++ b/net/ipv4/tcp_minisocks.c	Wed Apr 28 22:41:05 2004
@@ -787,7 +787,14 @@
 		newtp->num_sacks = 0;
 		newtp->urg_data = 0;
 		newtp->listen_opt = NULL;
+#ifdef CONFIG_ACCEPT_QUEUES
+		newtp->accept_queue = NULL;
+		memset(newtp->acceptq, 0,sizeof(newtp->acceptq));
+		newtp->class_index = 0;
+
+#else
 		newtp->accept_queue = newtp->accept_queue_tail = NULL;
+#endif
 		/* Deinitialize syn_wait_lock to trap illegal accesses. */
 		memset(&newtp->syn_wait_lock, 0, sizeof(newtp->syn_wait_lock));
 
diff -Nru a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
--- a/net/ipv4/tcp_timer.c	Wed Apr 28 22:41:05 2004
+++ b/net/ipv4/tcp_timer.c	Wed Apr 28 22:41:05 2004
@@ -498,7 +498,16 @@
 	 * ones are about to clog our table.
 	 */
 	if (lopt->qlen>>(lopt->max_qlen_log-1)) {
+#ifdef CONFIG_ACCEPT_QUEUES
+		int young = 0;
+	       
+		for(i=0; i < NUM_ACCEPT_QUEUES; i++) 
+			young += lopt->qlen_young[i];
+		
+		young <<= 1;
+#else
 		int young = (lopt->qlen_young<<1);
+#endif
 
 		while (thresh > 2) {
 			if (lopt->qlen < young)
@@ -524,9 +533,12 @@
 					unsigned long timeo;
 
 					if (req->retrans++ == 0)
-						lopt->qlen_young--;
-					timeo = min((TCP_TIMEOUT_INIT << req->retrans),
-						    TCP_RTO_MAX);
+#ifdef CONFIG_ACCEPT_QUEUES
+			         		lopt->qlen_young[req->acceptq_class]--;
+#else
+			         		lopt->qlen_young--;
+#endif
+					timeo = min((TCP_TIMEOUT_INIT << req->retrans), TCP_RTO_MAX);
 					req->expires = now + timeo;
 					reqp = &req->dl_next;
 					continue;
@@ -538,7 +550,11 @@
 				write_unlock(&tp->syn_wait_lock);
 				lopt->qlen--;
 				if (req->retrans == 0)
-					lopt->qlen_young--;
+#ifdef CONFIG_ACCEPT_QUEUES
+			         		lopt->qlen_young[req->acceptq_class]--;
+#else
+			         		lopt->qlen_young--;
+#endif
 				tcp_openreq_free(req);
 				continue;
 			}

--------------070600030403030605020809--
