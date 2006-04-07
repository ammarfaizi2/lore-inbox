Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWDGFxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWDGFxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDGFxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:53:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbWDGFxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:53:42 -0400
Date: Thu, 6 Apr 2006 22:52:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kzalloc: use in alloc_netdev
Message-Id: <20060406225232.660e8251.akpm@osdl.org>
In-Reply-To: <20060407053204.11316.44763.stgit@zion.home.lan>
References: <20060407053204.11316.44763.stgit@zion.home.lan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> Noticed this use, fixed it.

OK, but I think that if we're going to make conversions like this it's best
to do it in decent-sized chunks, just to keep the patch volume down.

umm,

 net/core/dev.c           |    3 +--
 net/core/dv.c            |    5 +----
 net/core/flow.c          |    4 +---
 net/core/gen_estimator.c |    3 +--
 net/core/neighbour.c     |   14 ++++----------
 net/core/request_sock.c  |    4 +---
 6 files changed, 9 insertions(+), 24 deletions(-)

diff -puN net/core/dev.c~net-kzalloc-conversion net/core/dev.c
--- devel/net/core/dev.c~net-kzalloc-conversion	2006-04-06 22:50:24.000000000 -0700
+++ devel-akpm/net/core/dev.c	2006-04-06 22:50:24.000000000 -0700
@@ -3100,12 +3100,11 @@ struct net_device *alloc_netdev(int size
 	alloc_size = (sizeof(*dev) + NETDEV_ALIGN_CONST) & ~NETDEV_ALIGN_CONST;
 	alloc_size += sizeof_priv + NETDEV_ALIGN_CONST;
 
-	p = kmalloc(alloc_size, GFP_KERNEL);
+	p = kzalloc(alloc_size, GFP_KERNEL);
 	if (!p) {
 		printk(KERN_ERR "alloc_dev: Unable to allocate device.\n");
 		return NULL;
 	}
-	memset(p, 0, alloc_size);
 
 	dev = (struct net_device *)
 		(((long)p + NETDEV_ALIGN_CONST) & ~NETDEV_ALIGN_CONST);
diff -puN net/core/dv.c~net-kzalloc-conversion net/core/dv.c
--- devel/net/core/dv.c~net-kzalloc-conversion	2006-04-06 22:50:24.000000000 -0700
+++ devel-akpm/net/core/dv.c	2006-04-06 22:50:24.000000000 -0700
@@ -55,15 +55,12 @@ int alloc_divert_blk(struct net_device *
 
 	dev->divert = NULL;
 	if (dev->type == ARPHRD_ETHER) {
-		dev->divert = (struct divert_blk *)
-			kmalloc(alloc_size, GFP_KERNEL);
+		dev->divert = kzalloc(alloc_size, GFP_KERNEL);
 		if (dev->divert == NULL) {
 			printk(KERN_INFO "divert: unable to allocate divert_blk for %s\n",
 			       dev->name);
 			return -ENOMEM;
 		}
-
-		memset(dev->divert, 0, sizeof(struct divert_blk));
 		dev_hold(dev);
 	}
 
diff -puN net/core/flow.c~net-kzalloc-conversion net/core/flow.c
--- devel/net/core/flow.c~net-kzalloc-conversion	2006-04-06 22:50:24.000000000 -0700
+++ devel-akpm/net/core/flow.c	2006-04-06 22:50:24.000000000 -0700
@@ -318,12 +318,10 @@ static void __devinit flow_cache_cpu_pre
 		/* NOTHING */;
 
 	flow_table(cpu) = (struct flow_cache_entry **)
-		__get_free_pages(GFP_KERNEL, order);
+		__get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
 	if (!flow_table(cpu))
 		panic("NET: failed to allocate flow cache order %lu\n", order);
 
-	memset(flow_table(cpu), 0, PAGE_SIZE << order);
-
 	flow_hash_rnd_recalc(cpu) = 1;
 	flow_count(cpu) = 0;
 
diff -puN net/core/gen_estimator.c~net-kzalloc-conversion net/core/gen_estimator.c
--- devel/net/core/gen_estimator.c~net-kzalloc-conversion	2006-04-06 22:50:24.000000000 -0700
+++ devel-akpm/net/core/gen_estimator.c	2006-04-06 22:50:24.000000000 -0700
@@ -159,11 +159,10 @@ int gen_new_estimator(struct gnet_stats_
 	if (parm->interval < -2 || parm->interval > 3)
 		return -EINVAL;
 
-	est = kmalloc(sizeof(*est), GFP_KERNEL);
+	est = kzalloc(sizeof(*est), GFP_KERNEL);
 	if (est == NULL)
 		return -ENOBUFS;
 
-	memset(est, 0, sizeof(*est));
 	est->interval = parm->interval + 2;
 	est->bstats = bstats;
 	est->rate_est = rate_est;
diff -puN net/core/neighbour.c~net-kzalloc-conversion net/core/neighbour.c
--- devel/net/core/neighbour.c~net-kzalloc-conversion	2006-04-06 22:50:24.000000000 -0700
+++ devel-akpm/net/core/neighbour.c	2006-04-06 22:50:24.000000000 -0700
@@ -284,14 +284,11 @@ static struct neighbour **neigh_hash_all
 	struct neighbour **ret;
 
 	if (size <= PAGE_SIZE) {
-		ret = kmalloc(size, GFP_ATOMIC);
+		ret = kzalloc(size, GFP_ATOMIC);
 	} else {
 		ret = (struct neighbour **)
-			__get_free_pages(GFP_ATOMIC, get_order(size));
+		      __get_free_pages(GFP_ATOMIC|__GFP_ZERO, get_order(size));
 	}
-	if (ret)
-		memset(ret, 0, size);
-
 	return ret;
 }
 
@@ -1089,8 +1086,7 @@ static void neigh_hh_init(struct neighbo
 		if (hh->hh_type == protocol)
 			break;
 
-	if (!hh && (hh = kmalloc(sizeof(*hh), GFP_ATOMIC)) != NULL) {
-		memset(hh, 0, sizeof(struct hh_cache));
+	if (!hh && (hh = kzalloc(sizeof(*hh), GFP_ATOMIC)) != NULL) {
 		rwlock_init(&hh->hh_lock);
 		hh->hh_type = protocol;
 		atomic_set(&hh->hh_refcnt, 0);
@@ -1366,13 +1362,11 @@ void neigh_table_init(struct neigh_table
 	tbl->hash_buckets = neigh_hash_alloc(tbl->hash_mask + 1);
 
 	phsize = (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry *);
-	tbl->phash_buckets = kmalloc(phsize, GFP_KERNEL);
+	tbl->phash_buckets = kzalloc(phsize, GFP_KERNEL);
 
 	if (!tbl->hash_buckets || !tbl->phash_buckets)
 		panic("cannot allocate neighbour cache hashes");
 
-	memset(tbl->phash_buckets, 0, phsize);
-
 	get_random_bytes(&tbl->hash_rnd, sizeof(tbl->hash_rnd));
 
 	rwlock_init(&tbl->lock);
diff -puN net/core/request_sock.c~net-kzalloc-conversion net/core/request_sock.c
--- devel/net/core/request_sock.c~net-kzalloc-conversion	2006-04-06 22:50:24.000000000 -0700
+++ devel-akpm/net/core/request_sock.c	2006-04-06 22:50:24.000000000 -0700
@@ -38,13 +38,11 @@ int reqsk_queue_alloc(struct request_soc
 {
 	const int lopt_size = sizeof(struct listen_sock) +
 			      nr_table_entries * sizeof(struct request_sock *);
-	struct listen_sock *lopt = kmalloc(lopt_size, GFP_KERNEL);
+	struct listen_sock *lopt = kzalloc(lopt_size, GFP_KERNEL);
 
 	if (lopt == NULL)
 		return -ENOMEM;
 
-	memset(lopt, 0, lopt_size);
-
 	for (lopt->max_qlen_log = 6;
 	     (1 << lopt->max_qlen_log) < sysctl_max_syn_backlog;
 	     lopt->max_qlen_log++);
_

