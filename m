Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWIAEmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWIAEmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIAEje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:34 -0400
Received: from mail.suse.de ([195.135.220.2]:5338 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932130AbWIAEjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:24 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:16 +1000
Message-Id: <1060901043916.27594@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 013 of 19] knfsd: Simplify nlmsvc_invalidate_all
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  As a result of previous patches, the loop in nlmsvc_invalidate_all
  just sets h_expires for all client/hosts to 0 (though does it in a
  very complicated way).

  This was possibly meant to trigger early garbage collection but
  half the time '0' is in the future and so it infact delays garbage
  collection.

  Pre-aging the 'hosts' is not really needed at this point anyway
  so we throw out the loop and nlm_find_client which is no longer
  needed.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c             |   27 ---------------------------
 ./fs/lockd/svcsubs.c          |   10 +---------
 ./include/linux/lockd/lockd.h |    4 +---
 3 files changed, 2 insertions(+), 39 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-09-01 11:07:19.000000000 +1000
+++ ./fs/lockd/host.c	2006-09-01 11:37:34.000000000 +1000
@@ -192,33 +192,6 @@ nlm_destroy_host(struct nlm_host *host)
 	kfree(host);
 }
 
-struct nlm_host *
-nlm_find_client(void)
-{
-	struct hlist_head *chain;
-	struct hlist_node *pos;
-
-	/* find a nlm_host for a client for which h_killed == 0.
-	 * and return it
-	 */
-	mutex_lock(&nlm_host_mutex);
-	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
-		struct nlm_host *host;
-
-		hlist_for_each_entry(host, pos, chain, h_hash) {
-			if (host->h_server &&
-			    host->h_killed == 0) {
-				nlm_get_host(host);
-				mutex_unlock(&nlm_host_mutex);
-				return host;
-			}
-		}
-	}
-	mutex_unlock(&nlm_host_mutex);
-	return NULL;
-}
-
-				
 /*
  * Create the NLM RPC client for an NLM peer
  */

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-09-01 11:06:21.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-09-01 11:38:14.000000000 +1000
@@ -354,13 +354,11 @@ nlmsvc_free_host_resources(struct nlm_ho
 }
 
 /*
- * delete all hosts structs for clients
+ * Remove all locks held for clients
  */
 void
 nlmsvc_invalidate_all(void)
 {
-	struct nlm_host *host;
-
 	/* Release all locks held by NFS clients.
 	 * Previously, the code would call
 	 * nlmsvc_free_host_resources for each client in
@@ -368,10 +366,4 @@ nlmsvc_invalidate_all(void)
 	 * Now we just do it once in nlm_traverse_files.
 	 */
 	nlm_traverse_files(NULL, nlmsvc_is_client);
-
-	while ((host = nlm_find_client()) != NULL) {
-		host->h_expires = 0;
-		host->h_killed = 1;
-		nlm_release_host(host);
-	}
 }

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 10:58:38.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 11:38:57.000000000 +1000
@@ -45,8 +45,7 @@ struct nlm_host {
 	unsigned short		h_proto;	/* transport proto */
 	unsigned short		h_reclaiming : 1,
 				h_server     : 1, /* server side, not client side */
-				h_inuse      : 1,
-				h_killed     : 1;
+				h_inuse      : 1;
 	wait_queue_head_t	h_gracewait;	/* wait while reclaiming */
 	struct rw_semaphore	h_rwsem;	/* Reboot recovery lock */
 	u32			h_state;	/* pseudo-state counter */
@@ -169,7 +168,6 @@ void		  nlm_rebind_host(struct nlm_host 
 struct nlm_host * nlm_get_host(struct nlm_host *);
 void		  nlm_release_host(struct nlm_host *);
 void		  nlm_shutdown_hosts(void);
-extern struct nlm_host *nlm_find_client(void);
 extern void	  nlm_host_rebooted(const struct sockaddr_in *, const char *, int, u32);
 struct nsm_handle *nsm_find(const struct sockaddr_in *, const char *, int);
 void		  nsm_release(struct nsm_handle *);
