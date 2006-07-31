Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWGaAnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWGaAnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWGaAm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45197 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964805AbWGaAmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:42:40 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:42:34 +1000
Message-Id: <1060731004234.29291@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 11] knfsd: make rpc threads pools numa aware
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: Actually implement multiple pools.  On NUMA machines, allocate
a svc_pool per NUMA node; on SMP a svc_pool per CPU; otherwise a single
global pool.  Enqueue sockets on the svc_pool corresponding to the CPU
on which the socket bh is run (i.e. the NIC interrupt CPU).  Threads
have their cpu mask set to limit them to the CPUs in the svc_pool that
owns them.

This is the patch that allows an Altix to scale NFS traffic linearly
beyond 4 CPUs and 4 NICs.

Incorporates changes and feedback from Neil Brown, Trond Myklebust,
and Christoph Hellwig.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svc.h |    1 
 ./net/sunrpc/svc.c           |  246 ++++++++++++++++++++++++++++++++++++++++++-
 ./net/sunrpc/svcsock.c       |    7 +
 3 files changed, 252 insertions(+), 2 deletions(-)

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-07-31 10:30:30.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-07-31 10:31:12.000000000 +1000
@@ -369,5 +369,6 @@ int		   svc_process(struct svc_rqst *);
 int		   svc_register(struct svc_serv *, int, unsigned short);
 void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
+struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
 
 #endif /* SUNRPC_SVC_H */

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-07-31 10:30:30.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-07-31 10:31:30.000000000 +1000
@@ -4,6 +4,10 @@
  * High-level RPC service routines
  *
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
+ *
+ * Multiple threads pools and NUMAisation
+ * Copyright (c) 2006 Silicon Graphics, Inc.
+ * by Greg Banks <gnb@melbourne.sgi.com>
  */
 
 #include <linux/linkage.h>
@@ -25,6 +29,233 @@
 #define RPC_PARANOIA 1
 
 /*
+ * Mode for mapping cpus to pools.
+ */
+enum {
+	SVC_POOL_NONE = -1,	/* uninitialised, choose one of the others */
+	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
+				 * (legacy & UP mode) */
+	SVC_POOL_PERCPU,	/* one pool per cpu */
+	SVC_POOL_PERNODE	/* one pool per numa node */
+};
+
+/*
+ * Structure for mapping cpus to pools and vice versa.
+ * Setup once during sunrpc initialisation.
+ */
+static struct svc_pool_map {
+	int mode;			/* Note: int not enum to avoid
+					 * warnings about "enumeration value
+					 * not handled in switch" */
+	unsigned int npools;
+	unsigned int *pool_to;		/* maps pool id to cpu or node */
+	unsigned int *to_pool;		/* maps cpu or node to pool id */
+} svc_pool_map = {
+	.mode = SVC_POOL_NONE
+};
+
+
+/*
+ * Detect best pool mapping mode heuristically,
+ * according to the machine's topology.
+ */
+static int
+svc_pool_map_choose_mode(void)
+{
+	unsigned int node;
+
+	if (num_online_nodes() > 1) {
+		/*
+		 * Actually have multiple NUMA nodes,
+		 * so split pools on NUMA node boundaries
+		 */
+		return SVC_POOL_PERNODE;
+	}
+
+	node = any_online_node(node_online_map);
+	if (nr_cpus_node(node) > 2) {
+		/*
+		 * Non-trivial SMP, or CONFIG_NUMA on
+		 * non-NUMA hardware, e.g. with a generic
+		 * x86_64 kernel on Xeons.  In this case we
+		 * want to divide the pools on cpu boundaries.
+		 */
+		return SVC_POOL_PERCPU;
+	}
+
+	/* default: one global pool */
+	return SVC_POOL_GLOBAL;
+}
+
+/*
+ * Allocate the to_pool[] and pool_to[] arrays.
+ * Returns 0 on success or an errno.
+ */
+static int
+svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsigned int maxpools)
+{
+	m->to_pool = kcalloc(maxpools, sizeof(unsigned int), GFP_KERNEL);
+	if (!m->to_pool)
+		goto fail;
+	m->pool_to = kcalloc(maxpools, sizeof(unsigned int), GFP_KERNEL);
+	if (!m->pool_to)
+		goto fail_free;
+
+	return 0;
+
+fail_free:
+	kfree(m->to_pool);
+fail:
+	return -ENOMEM;
+}
+
+/*
+ * Initialise the pool map for SVC_POOL_PERCPU mode.
+ * Returns number of pools or <0 on error.
+ */
+static int
+svc_pool_map_init_percpu(struct svc_pool_map *m)
+{
+	unsigned int maxpools = num_possible_cpus();
+	unsigned int pidx = 0;
+	unsigned int cpu;
+	int err;
+
+	err = svc_pool_map_alloc_arrays(m, maxpools);
+	if (err)
+		return err;
+
+	for_each_online_cpu(cpu) {
+		BUG_ON(pidx > maxpools);
+		m->to_pool[cpu] = pidx;
+		m->pool_to[pidx] = cpu;
+		pidx++;
+	}
+	/* cpus brought online later all get mapped to pool0, sorry */
+
+	return pidx;
+};
+
+
+/*
+ * Initialise the pool map for SVC_POOL_PERNODE mode.
+ * Returns number of pools or <0 on error.
+ */
+static int
+svc_pool_map_init_pernode(struct svc_pool_map *m)
+{
+	unsigned int maxpools = num_possible_nodes();
+	unsigned int pidx = 0;
+	unsigned int node;
+	int err;
+
+	err = svc_pool_map_alloc_arrays(m, maxpools);
+	if (err)
+		return err;
+
+	for_each_node_with_cpus(node) {
+		/* some architectures (e.g. SN2) have cpuless nodes */
+		BUG_ON(pidx > maxpools);
+		m->to_pool[node] = pidx;
+		m->pool_to[pidx] = node;
+		pidx++;
+	}
+	/* nodes brought online later all get mapped to pool0, sorry */
+
+	return pidx;
+}
+
+
+/*
+ * Build the global map of cpus to pools and vice versa.
+ */
+static unsigned int
+svc_pool_map_init(void)
+{
+	struct svc_pool_map *m = &svc_pool_map;
+	int npools = -1;
+
+	if (m->mode != SVC_POOL_NONE)
+		return m->npools;
+
+	m->mode = svc_pool_map_choose_mode();
+
+	switch (m->mode) {
+	case SVC_POOL_PERCPU:
+		npools = svc_pool_map_init_percpu(m);
+		break;
+	case SVC_POOL_PERNODE:
+		npools = svc_pool_map_init_pernode(m);
+		break;
+	}
+
+	if (npools < 0) {
+		/* default, or memory allocation failure */
+		npools = 1;
+		m->mode = SVC_POOL_GLOBAL;
+	}
+	m->npools = npools;
+
+	return m->npools;
+}
+
+/*
+ * Set the current thread's cpus_allowed mask so that it
+ * will only run on cpus in the given pool.
+ *
+ * Returns 1 and fills in oldmask iff a cpumask was applied.
+ */
+static inline int
+svc_pool_map_set_cpumask(unsigned int pidx, cpumask_t *oldmask)
+{
+	struct svc_pool_map *m = &svc_pool_map;
+	unsigned int node; /* or cpu */
+
+	BUG_ON(m->mode == SVC_POOL_NONE);
+
+	switch (m->mode)
+	{
+	default:
+		return 0;
+	case SVC_POOL_PERCPU:
+		node = m->pool_to[pidx];
+		*oldmask = current->cpus_allowed;
+		set_cpus_allowed(current, cpumask_of_cpu(node));
+		return 1;
+	case SVC_POOL_PERNODE:
+		node = m->pool_to[pidx];
+		*oldmask = current->cpus_allowed;
+		set_cpus_allowed(current, node_to_cpumask(node));
+		return 1;
+	}
+}
+
+/*
+ * Use the mapping mode to choose a pool for a given CPU.
+ * Used when enqueueing an incoming RPC.  Always returns
+ * a non-NULL pool pointer.
+ */
+struct svc_pool *
+svc_pool_for_cpu(struct svc_serv *serv, int cpu)
+{
+	struct svc_pool_map *m = &svc_pool_map;
+	unsigned int pidx = 0;
+
+	BUG_ON(m->mode == SVC_POOL_NONE);
+
+	switch (m->mode) {
+	case SVC_POOL_PERCPU:
+		pidx = m->to_pool[cpu];
+		break;
+	case SVC_POOL_PERNODE:
+		pidx = m->to_pool[cpu_to_node(cpu)];
+		break;
+	}
+	return &serv->sv_pools[pidx % serv->sv_nrpools];
+}
+
+
+/*
  * Create an RPC service
  */
 static struct svc_serv *
@@ -105,8 +336,9 @@ svc_create_pooled(struct svc_program *pr
 		  svc_thread_fn func, int sig, struct module *mod)
 {
 	struct svc_serv *serv;
+	unsigned int npools = svc_pool_map_init();
 
-	serv = __svc_create(prog, bufsize, /*npools*/1, shutdown);
+	serv = __svc_create(prog, bufsize, npools, shutdown);
 
 	if (serv != NULL) {
 		serv->sv_function = func;
@@ -209,6 +441,8 @@ svc_release_buffer(struct svc_rqst *rqst
 
 /*
  * Create a thread in the given pool.  Caller must hold BKL.
+ * On a NUMA or SMP machine, with a multi-pool serv, the thread
+ * will be restricted to run on the cpus belonging to the pool.
  */
 static int
 __svc_create_thread(svc_thread_fn func, struct svc_serv *serv,
@@ -216,6 +450,8 @@ __svc_create_thread(svc_thread_fn func, 
 {
 	struct svc_rqst	*rqstp;
 	int		error = -ENOMEM;
+	int		have_oldmask = 0;
+	cpumask_t	oldmask;
 
 	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
 	if (!rqstp)
@@ -235,7 +471,15 @@ __svc_create_thread(svc_thread_fn func, 
 	spin_unlock_bh(&pool->sp_lock);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
+
+	if (serv->sv_nrpools > 1)
+		have_oldmask = svc_pool_map_set_cpumask(pool->sp_id, &oldmask);
+
 	error = kernel_thread((int (*)(void *)) func, rqstp, 0);
+
+	if (have_oldmask)
+		set_cpus_allowed(current, oldmask);
+
 	if (error < 0)
 		goto out_thread;
 	svc_sock_update_bufs(serv);

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-31 10:29:38.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-31 10:31:12.000000000 +1000
@@ -151,8 +151,9 @@ static void
 svc_sock_enqueue(struct svc_sock *svsk)
 {
 	struct svc_serv	*serv = svsk->sk_server;
-	struct svc_pool *pool = &serv->sv_pools[0];
+	struct svc_pool *pool;
 	struct svc_rqst	*rqstp;
+	int cpu;
 
 	if (!(svsk->sk_flags &
 	      ( (1<<SK_CONN)|(1<<SK_DATA)|(1<<SK_CLOSE)|(1<<SK_DEFERRED)) ))
@@ -160,6 +161,10 @@ svc_sock_enqueue(struct svc_sock *svsk)
 	if (test_bit(SK_DEAD, &svsk->sk_flags))
 		return;
 
+	cpu = get_cpu();
+	pool = svc_pool_for_cpu(svsk->sk_server, cpu);
+	put_cpu();
+
 	spin_lock_bh(&pool->sp_lock);
 
 	if (!list_empty(&pool->sp_threads) &&
