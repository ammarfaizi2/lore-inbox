Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164343AbWLHBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164343AbWLHBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164242AbWLHBSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:18:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:47182 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164337AbWLHBNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:45 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:57 +1100
Message-Id: <1061208011357.30639@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 18] knfsd: nfsd: don't drop silently on upcall deferral
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

To avoid tying up server threads when nfsd makes an upcall (to mountd, to
get export options, to idmapd, for nfsv4 name<->id mapping, etc.), we
temporarily "drop" the request and save enough information so that we can
revisit it later.

Certain failures during the deferral process can cause us to really drop
the request and never revisit it.

This is often less than ideal, and is unacceptable in the NFSv4 case--rfc
3530 forbids the server from dropping a request without also closing the
connection.

As a first step, we modify the deferral code to return -ETIMEDOUT (which is
translated to nfserr_jukebox in the v3 and v4 cases, and remains a drop in
the v2 case).

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c                  |   11 ++++++++---
 ./fs/nfsd/nfsfh.c                   |    6 ++++--
 ./fs/nfsd/vfs.c                     |    2 +-
 ./net/sunrpc/auth_gss/svcauth_gss.c |    2 +-
 ./net/sunrpc/cache.c                |   11 +++++++----
 ./net/sunrpc/svcauth_unix.c         |    1 +
 6 files changed, 22 insertions(+), 11 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-12-08 12:08:25.000000000 +1100
+++ ./fs/nfsd/export.c	2006-12-08 12:08:37.000000000 +1100
@@ -787,15 +787,20 @@ exp_get_by_name(svc_client *clp, struct 
 	key.ex_dentry = dentry;
 
 	exp = svc_export_lookup(&key);
-	if (exp != NULL) 
-		switch (cache_check(&svc_export_cache, &exp->h, reqp)) {
+	if (exp != NULL)  {
+		int err;
+
+		err = cache_check(&svc_export_cache, &exp->h, reqp);
+		switch (err) {
 		case 0: break;
 		case -EAGAIN:
-			exp = ERR_PTR(-EAGAIN);
+		case -ETIMEDOUT:
+			exp = ERR_PTR(err);
 			break;
 		default:
 			exp = NULL;
 		}
+	}
 
 	return exp;
 }

diff .prev/fs/nfsd/nfsfh.c ./fs/nfsd/nfsfh.c
--- .prev/fs/nfsd/nfsfh.c	2006-12-08 12:07:23.000000000 +1100
+++ ./fs/nfsd/nfsfh.c	2006-12-08 12:08:37.000000000 +1100
@@ -169,9 +169,11 @@ fh_verify(struct svc_rqst *rqstp, struct
 			exp = exp_find(rqstp->rq_client, 0, tfh, &rqstp->rq_chandle);
 		}
 
-		error = nfserr_dropit;
-		if (IS_ERR(exp) && PTR_ERR(exp) == -EAGAIN)
+		if (IS_ERR(exp) && (PTR_ERR(exp) == -EAGAIN
+				|| PTR_ERR(exp) == -ETIMEDOUT)) {
+			error = nfserrno(PTR_ERR(exp));
 			goto out;
+		}
 
 		error = nfserr_stale; 
 		if (!exp || IS_ERR(exp))

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-12-08 12:07:23.000000000 +1100
+++ ./fs/nfsd/vfs.c	2006-12-08 12:08:37.000000000 +1100
@@ -99,7 +99,7 @@ static struct raparm_hbucket	raparm_hash
 /* 
  * Called from nfsd_lookup and encode_dirent. Check if we have crossed 
  * a mount point.
- * Returns -EAGAIN leaving *dpp and *expp unchanged, 
+ * Returns -EAGAIN or -ETIMEDOUT leaving *dpp and *expp unchanged,
  *  or nfs_ok having possibly changed *dpp and *expp
  */
 int

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-12-08 12:08:05.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-12-08 12:08:37.000000000 +1100
@@ -1080,7 +1080,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 		}
 		switch(cache_check(&rsi_cache, &rsip->h, &rqstp->rq_chandle)) {
 		case -EAGAIN:
-			goto drop;
+		case -ETIMEDOUT:
 		case -ENOENT:
 			goto drop;
 		case 0:

diff .prev/net/sunrpc/cache.c ./net/sunrpc/cache.c
--- .prev/net/sunrpc/cache.c	2006-12-08 12:07:23.000000000 +1100
+++ ./net/sunrpc/cache.c	2006-12-08 12:09:12.000000000 +1100
@@ -34,7 +34,7 @@
 
 #define	 RPCDBG_FACILITY RPCDBG_CACHE
 
-static void cache_defer_req(struct cache_req *req, struct cache_head *item);
+static int cache_defer_req(struct cache_req *req, struct cache_head *item);
 static void cache_revisit_request(struct cache_head *item);
 
 static void cache_init(struct cache_head *h)
@@ -185,6 +185,7 @@ static int cache_make_upcall(struct cach
  *
  * Returns 0 if the cache_head can be used, or cache_puts it and returns
  * -EAGAIN if upcall is pending,
+ * -ETIMEDOUT if upcall failed and should be retried,
  * -ENOENT if cache entry was negative
  */
 int cache_check(struct cache_detail *detail,
@@ -236,7 +237,8 @@ int cache_check(struct cache_detail *det
 	}
 
 	if (rv == -EAGAIN)
-		cache_defer_req(rqstp, h);
+		if (cache_defer_req(rqstp, h) != 0)
+			rv = -ETIMEDOUT;
 
 	if (rv)
 		cache_put(h, detail);
@@ -523,14 +525,14 @@ static LIST_HEAD(cache_defer_list);
 static struct list_head cache_defer_hash[DFR_HASHSIZE];
 static int cache_defer_cnt;
 
-static void cache_defer_req(struct cache_req *req, struct cache_head *item)
+static int cache_defer_req(struct cache_req *req, struct cache_head *item)
 {
 	struct cache_deferred_req *dreq;
 	int hash = DFR_HASH(item);
 
 	dreq = req->defer(req);
 	if (dreq == NULL)
-		return;
+		return -ETIMEDOUT;
 
 	dreq->item = item;
 	dreq->recv_time = get_seconds();
@@ -571,6 +573,7 @@ static void cache_defer_req(struct cache
 		/* must have just been validated... */
 		cache_revisit_request(item);
 	}
+	return 0;
 }
 
 static void cache_revisit_request(struct cache_head *item)

diff .prev/net/sunrpc/svcauth_unix.c ./net/sunrpc/svcauth_unix.c
--- .prev/net/sunrpc/svcauth_unix.c	2006-12-08 12:07:23.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-12-08 12:08:37.000000000 +1100
@@ -435,6 +435,7 @@ svcauth_unix_set_client(struct svc_rqst 
 		default:
 			BUG();
 		case -EAGAIN:
+		case -ETIMEDOUT:
 			return SVC_DROP;
 		case -ENOENT:
 			return SVC_DENIED;
