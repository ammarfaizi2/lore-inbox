Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWIAEjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWIAEjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWIAEi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:38:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:22955 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932108AbWIAEi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:57 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:49 +1000
Message-Id: <1060901043849.27512@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 008 of 19] knfsd: lockd: make the hash chains use a hlist_node
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  Get rid of the home-grown singly linked lists for the
  nlm_host hash table.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c             |   71 +++++++++++++++++++++++-------------------
 ./include/linux/lockd/lockd.h |    2 -
 2 files changed, 40 insertions(+), 33 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-09-01 10:42:33.000000000 +1000
+++ ./fs/lockd/host.c	2006-08-31 17:32:46.000000000 +1000
@@ -27,7 +27,7 @@
 #define NLM_HOST_EXPIRE		((nrhosts > NLM_HOST_MAX)? 300 * HZ : 120 * HZ)
 #define NLM_HOST_COLLECT	((nrhosts > NLM_HOST_MAX)? 120 * HZ :  60 * HZ)
 
-static struct nlm_host *	nlm_hosts[NLM_HOST_NRHASH];
+static struct hlist_head	nlm_hosts[NLM_HOST_NRHASH];
 static unsigned long		next_gc;
 static int			nrhosts;
 static DEFINE_MUTEX(nlm_host_mutex);
@@ -69,7 +69,9 @@ nlm_lookup_host(int server, const struct
 					const char *hostname,
 					int hostname_len)
 {
-	struct nlm_host	*host, **hp;
+	struct hlist_head *chain;
+	struct hlist_node *pos;
+	struct nlm_host	*host;
 	struct nsm_handle *nsm = NULL;
 	int		hash;
 
@@ -95,7 +97,8 @@ nlm_lookup_host(int server, const struct
 	 * different NLM rpc_clients into one single nlm_host object.
 	 * This would allow us to have one nlm_host per address.
 	 */
-	for (hp = &nlm_hosts[hash]; (host = *hp) != 0; hp = &host->h_next) {
+	chain = &nlm_hosts[hash];
+	hlist_for_each_entry(host, pos, chain, h_hash) {
 		if (!nlm_cmp_addr(&host->h_addr, sin))
 			continue;
 
@@ -110,15 +113,16 @@ nlm_lookup_host(int server, const struct
 		if (host->h_server != server)
 			continue;
 
-		if (hp != nlm_hosts + hash) {
-			*hp = host->h_next;
-			host->h_next = nlm_hosts[hash];
-			nlm_hosts[hash] = host;
-		}
+		/* Move to head of hash chain. */
+		hlist_del(&host->h_hash);
+		hlist_add_head(&host->h_hash, chain);
+
 		nlm_get_host(host);
 		goto out;
 	}
 
+	host = NULL;
+
 	/* Sadly, the host isn't in our hash table yet. See if
 	 * we have an NSM handle for it. If not, create one.
 	 */
@@ -146,8 +150,7 @@ nlm_lookup_host(int server, const struct
 	host->h_nsmstate   = 0;			/* real NSM state */
 	host->h_nsmhandle  = nsm;
 	host->h_server	   = server;
-	host->h_next       = nlm_hosts[hash];
-	nlm_hosts[hash]    = host;
+	hlist_add_head(&host->h_hash, chain);
 	INIT_LIST_HEAD(&host->h_lockowners);
 	spin_lock_init(&host->h_lock);
 	INIT_LIST_HEAD(&host->h_granted);
@@ -164,14 +167,17 @@ out:
 struct nlm_host *
 nlm_find_client(void)
 {
+	struct hlist_head *chain;
+	struct hlist_node *pos;
+
 	/* find a nlm_host for a client for which h_killed == 0.
 	 * and return it
 	 */
-	int hash;
 	mutex_lock(&nlm_host_mutex);
-	for (hash = 0 ; hash < NLM_HOST_NRHASH; hash++) {
-		struct nlm_host *host, **hp;
-		for (hp = &nlm_hosts[hash]; (host = *hp) != 0; hp = &host->h_next) {
+	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
+		struct nlm_host *host;
+
+		hlist_for_each_entry(host, pos, chain, h_hash) {
 			if (host->h_server &&
 			    host->h_killed == 0) {
 				nlm_get_host(host);
@@ -294,9 +300,10 @@ void nlm_host_rebooted(const struct sock
 				const char *hostname, int hostname_len,
 				u32 new_state)
 {
+	struct hlist_head *chain;
+	struct hlist_node *pos;
 	struct nsm_handle *nsm;
-	struct nlm_host	*host, **hp;
-	int		hash;
+	struct nlm_host	*host;
 
 	dprintk("lockd: nlm_host_rebooted(%s, %u.%u.%u.%u)\n",
 			hostname, NIPQUAD(sin->sin_addr));
@@ -315,8 +322,8 @@ void nlm_host_rebooted(const struct sock
 	 * To avoid processing a host several times, we match the nsmstate.
 	 */
 again:	mutex_lock(&nlm_host_mutex);
-	for (hash = 0; hash < NLM_HOST_NRHASH; hash++) {
-		for (hp = &nlm_hosts[hash]; (host = *hp); hp = &host->h_next) {
+	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
+		hlist_for_each_entry(host, pos, chain, h_hash) {
 			if (host->h_nsmhandle == nsm
 			 && host->h_nsmstate != new_state) {
 				host->h_nsmstate = new_state;
@@ -350,16 +357,17 @@ again:	mutex_lock(&nlm_host_mutex);
 void
 nlm_shutdown_hosts(void)
 {
+	struct hlist_head *chain;
+	struct hlist_node *pos;
 	struct nlm_host	*host;
-	int		i;
 
 	dprintk("lockd: shutting down host module\n");
 	mutex_lock(&nlm_host_mutex);
 
 	/* First, make all hosts eligible for gc */
 	dprintk("lockd: nuking all hosts...\n");
-	for (i = 0; i < NLM_HOST_NRHASH; i++) {
-		for (host = nlm_hosts[i]; host; host = host->h_next)
+	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
+		hlist_for_each_entry(host, pos, chain, h_hash)
 			host->h_expires = jiffies - 1;
 	}
 
@@ -371,8 +379,8 @@ nlm_shutdown_hosts(void)
 	if (nrhosts) {
 		printk(KERN_WARNING "lockd: couldn't shutdown host module!\n");
 		dprintk("lockd: %d hosts left:\n", nrhosts);
-		for (i = 0; i < NLM_HOST_NRHASH; i++) {
-			for (host = nlm_hosts[i]; host; host = host->h_next) {
+		for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
+			hlist_for_each_entry(host, pos, chain, h_hash) {
 				dprintk("       %s (cnt %d use %d exp %ld)\n",
 					host->h_name, atomic_read(&host->h_count),
 					host->h_inuse, host->h_expires);
@@ -389,32 +397,31 @@ nlm_shutdown_hosts(void)
 static void
 nlm_gc_hosts(void)
 {
-	struct nlm_host	**q, *host;
+	struct hlist_head *chain;
+	struct hlist_node *pos, *next;
+	struct nlm_host	*host;
 	struct rpc_clnt	*clnt;
-	int		i;
 
 	dprintk("lockd: host garbage collection\n");
-	for (i = 0; i < NLM_HOST_NRHASH; i++) {
-		for (host = nlm_hosts[i]; host; host = host->h_next)
+	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
+		hlist_for_each_entry(host, pos, chain, h_hash)
 			host->h_inuse = 0;
 	}
 
 	/* Mark all hosts that hold locks, blocks or shares */
 	nlmsvc_mark_resources();
 
-	for (i = 0; i < NLM_HOST_NRHASH; i++) {
-		q = &nlm_hosts[i];
-		while ((host = *q) != NULL) {
+	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
+		hlist_for_each_entry_safe(host, pos, next, chain, h_hash) {
 			if (atomic_read(&host->h_count) || host->h_inuse
 			 || time_before(jiffies, host->h_expires)) {
 				dprintk("nlm_gc_hosts skipping %s (cnt %d use %d exp %ld)\n",
 					host->h_name, atomic_read(&host->h_count),
 					host->h_inuse, host->h_expires);
-				q = &host->h_next;
 				continue;
 			}
 			dprintk("lockd: delete host %s\n", host->h_name);
-			*q = host->h_next;
+			hlist_del_init(&host->h_hash);
 
 			/*
 			 * Unmonitor unless host was invalidated (i.e. lockd restarted)

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 10:42:33.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 10:42:31.000000000 +1000
@@ -37,7 +37,7 @@
  * Lockd host handle (used both by the client and server personality).
  */
 struct nlm_host {
-	struct nlm_host *	h_next;		/* linked list (hash table) */
+	struct hlist_node	h_hash;		/* doubly linked list */
 	struct sockaddr_in	h_addr;		/* peer address */
 	struct rpc_clnt	*	h_rpcclnt;	/* RPC client to talk to peer */
 	char *			h_name;		/* remote hostname */
