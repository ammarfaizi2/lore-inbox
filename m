Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWC3IT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWC3IT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWC3IRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:44 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:23635 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932100AbWC3IRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:41 -0500
Message-Id: <20060330081729.880726000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:07 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 2/8] use hlist_move_head()
Content-Disposition: inline; filename=use-hlist-move-head.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of hlist_del(A) and hlist_add_head(A, B)
to hlist_move_head(A, B).

CC: Neil Brown <neilb@cse.unsw.edu.au>
CC: Prasanna S Panchamukhi <prasanna@in.ibm.com>
CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 fs/nfsd/nfscache.c                      |    3 +--
 kernel/kprobes.c                        |   10 +++++-----
 net/core/dev.c                          |    3 +--
 net/ipv4/fib_hash.c                     |    4 +---
 net/ipv4/fib_semantics.c                |    8 ++------
 net/ipv4/ip_fragment.c                  |    4 +---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    3 +--
 net/ipv6/reassembly.c                   |    4 +---
 net/sunrpc/auth.c                       |    9 +++------
 9 files changed, 16 insertions(+), 32 deletions(-)

Index: 2.6-git/fs/nfsd/nfscache.c
===================================================================
--- 2.6-git.orig/fs/nfsd/nfscache.c
+++ 2.6-git/fs/nfsd/nfscache.c
@@ -113,8 +113,7 @@ lru_put_end(struct svc_cacherep *rp)
 static void
 hash_refile(struct svc_cacherep *rp)
 {
-	hlist_del_init(&rp->c_hash);
-	hlist_add_head(&rp->c_hash, hash_list + REQHASH(rp->c_xid));
+	hlist_move_head(&rp->c_hash, hash_list + REQHASH(rp->c_xid));
 }
 
 /*
Index: 2.6-git/kernel/kprobes.c
===================================================================
--- 2.6-git.orig/kernel/kprobes.c
+++ 2.6-git/kernel/kprobes.c
@@ -307,11 +307,11 @@ void __kprobes recycle_rp_inst(struct kr
 	/* remove rp inst off the rprobe_inst_table */
 	hlist_del(&ri->hlist);
 	if (ri->rp) {
-		/* remove rp inst off the used list */
-		hlist_del(&ri->uflist);
-		/* put rp inst back onto the free list */
-		INIT_HLIST_NODE(&ri->uflist);
-		hlist_add_head(&ri->uflist, &ri->rp->free_instances);
+		/*
+		 * remove rp inst off the used list
+		 * and put rp inst back onto the free list
+		 */ 
+		hlist_move_head(&ri->uflist, &ri->rp->free_instances);
 	} else
 		/* Unregistering */
 		kfree(ri);
Index: 2.6-git/net/core/dev.c
===================================================================
--- 2.6-git.orig/net/core/dev.c
+++ 2.6-git/net/core/dev.c
@@ -734,8 +734,7 @@ int dev_change_name(struct net_device *d
 
 	err = class_device_rename(&dev->class_dev, dev->name);
 	if (!err) {
-		hlist_del(&dev->name_hlist);
-		hlist_add_head(&dev->name_hlist, dev_name_hash(dev->name));
+		hlist_move_head(&dev->name_hlist, dev_name_hash(dev->name));
 		blocking_notifier_call_chain(&netdev_chain,
 				NETDEV_CHANGENAME, dev);
 	}
Index: 2.6-git/net/ipv4/fib_hash.c
===================================================================
--- 2.6-git.orig/net/ipv4/fib_hash.c
+++ 2.6-git/net/ipv4/fib_hash.c
@@ -124,10 +124,8 @@ static inline void fn_rebuild_zone(struc
 		hlist_for_each_entry_safe(f, node, n, &old_ht[i], fn_hash) {
 			struct hlist_head *new_head;
 
-			hlist_del(&f->fn_hash);
-
 			new_head = &fz->fz_hash[fn_hash(f->fn_key, fz)];
-			hlist_add_head(&f->fn_hash, new_head);
+			hlist_move_head(&f->fn_hash, new_head);
 		}
 	}
 }
Index: 2.6-git/net/ipv4/fib_semantics.c
===================================================================
--- 2.6-git.orig/net/ipv4/fib_semantics.c
+++ 2.6-git/net/ipv4/fib_semantics.c
@@ -613,11 +613,9 @@ static void fib_hash_move(struct hlist_h
 			struct hlist_head *dest;
 			unsigned int new_hash;
 
-			hlist_del(&fi->fib_hash);
-
 			new_hash = fib_info_hashfn(fi);
 			dest = &new_info_hash[new_hash];
-			hlist_add_head(&fi->fib_hash, dest);
+			hlist_move_head(&fi->fib_hash, dest);
 		}
 	}
 	fib_info_hash = new_info_hash;
@@ -631,11 +629,9 @@ static void fib_hash_move(struct hlist_h
 			struct hlist_head *ldest;
 			unsigned int new_hash;
 
-			hlist_del(&fi->fib_lhash);
-
 			new_hash = fib_laddr_hashfn(fi->fib_prefsrc);
 			ldest = &new_laddrhash[new_hash];
-			hlist_add_head(&fi->fib_lhash, ldest);
+			hlist_move_head(&fi->fib_lhash, ldest);
 		}
 	}
 	fib_info_laddrhash = new_laddrhash;
Index: 2.6-git/net/ipv4/ip_fragment.c
===================================================================
--- 2.6-git.orig/net/ipv4/ip_fragment.c
+++ 2.6-git/net/ipv4/ip_fragment.c
@@ -149,10 +149,8 @@ static void ipfrag_secret_rebuild(unsign
 						      q->daddr, q->protocol);
 
 			if (hval != i) {
-				hlist_del(&q->list);
-
 				/* Relink to new hash chain. */
-				hlist_add_head(&q->list, &ipq_hash[hval]);
+				hlist_move_head(&q->list, &ipq_hash[hval]);
 			}
 		}
 	}
Index: 2.6-git/net/ipv6/netfilter/nf_conntrack_reasm.c
===================================================================
--- 2.6-git.orig/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ 2.6-git/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -162,9 +162,8 @@ static void nf_ct_frag6_secret_rebuild(u
 						       &q->saddr,
 						       &q->daddr);
 			if (hval != i) {
-				hlist_del(&q->list);
 				/* Relink to new hash chain. */
-				hlist_add_head(&q->list,
+				hlist_move_head(&q->list,
 					       &nf_ct_frag6_hash[hval]);
 			}
 		}
Index: 2.6-git/net/ipv6/reassembly.c
===================================================================
--- 2.6-git.orig/net/ipv6/reassembly.c
+++ 2.6-git/net/ipv6/reassembly.c
@@ -168,10 +168,8 @@ static void ip6_frag_secret_rebuild(unsi
 						       &q->daddr);
 
 			if (hval != i) {
-				hlist_del(&q->list);
-
 				/* Relink to new hash chain. */
-				hlist_add_head(&q->list,
+				hlist_move_head(&q->list,
 					       &ip6_frag_hash[hval]);
 
 			}
Index: 2.6-git/net/sunrpc/auth.c
===================================================================
--- 2.6-git.orig/net/sunrpc/auth.c
+++ 2.6-git/net/sunrpc/auth.c
@@ -149,8 +149,7 @@ rpcauth_free_credcache(struct rpc_auth *
 	for (i = 0; i < RPC_CREDCACHE_NR; i++) {
 		hlist_for_each_safe(pos, next, &cache->hashtable[i]) {
 			cred = hlist_entry(pos, struct rpc_cred, cr_hash);
-			__hlist_del(&cred->cr_hash);
-			hlist_add_head(&cred->cr_hash, &free);
+			hlist_move_head(&cred->cr_hash, &free);
 		}
 	}
 	spin_unlock(&rpc_credcache_lock);
@@ -164,10 +163,8 @@ rpcauth_prune_expired(struct rpc_auth *a
 	       return;
 	if (time_after(jiffies, cred->cr_expire + auth->au_credcache->expire))
 		cred->cr_flags &= ~RPCAUTH_CRED_UPTODATE;
-	if (!(cred->cr_flags & RPCAUTH_CRED_UPTODATE)) {
-		__hlist_del(&cred->cr_hash);
-		hlist_add_head(&cred->cr_hash, free);
-	}
+	if (!(cred->cr_flags & RPCAUTH_CRED_UPTODATE))
+		hlist_move_head(&cred->cr_hash, free);
 }
 
 /*

--
