Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWCIGxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWCIGxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWCIGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:47587 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751685AbWCIGxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:07 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:03 +1100
Message-Id: <1060309065203.24605@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 14] knfsd: Use new sunrpc cache for rsi cache
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |   66 ++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff ./net/sunrpc/auth_gss/svcauth_gss.c~current~ ./net/sunrpc/auth_gss/svcauth_gss.c
--- ./net/sunrpc/auth_gss/svcauth_gss.c~current~	2006-03-09 17:15:13.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-03-09 17:15:43.000000000 +1100
@@ -78,7 +78,8 @@ struct rsi {
 
 static struct cache_head *rsi_table[RSI_HASHMAX];
 static struct cache_detail rsi_cache;
-static struct rsi *rsi_lookup(struct rsi *item, int set);
+static struct rsi *rsi_update(struct rsi *new, struct rsi *old);
+static struct rsi *rsi_lookup(struct rsi *item);
 
 static void rsi_free(struct rsi *rsii)
 {
@@ -103,8 +104,10 @@ static inline int rsi_hash(struct rsi *i
 	     ^ hash_mem(item->in_token.data, item->in_token.len, RSI_HASHBITS);
 }
 
-static inline int rsi_match(struct rsi *item, struct rsi *tmp)
+static int rsi_match(struct cache_head *a, struct cache_head *b)
 {
+	struct rsi *item = container_of(a, struct rsi, h);
+	struct rsi *tmp = container_of(b, struct rsi, h);
 	return netobj_equal(&item->in_handle, &tmp->in_handle)
 		&& netobj_equal(&item->in_token, &tmp->in_token);
 }
@@ -125,8 +128,11 @@ static inline int dup_netobj(struct xdr_
 	return dup_to_netobj(dst, src->data, src->len);
 }
 
-static inline void rsi_init(struct rsi *new, struct rsi *item)
+static void rsi_init(struct cache_head *cnew, struct cache_head *citem)
 {
+	struct rsi *new = container_of(cnew, struct rsi, h);
+	struct rsi *item = container_of(citem, struct rsi, h);
+
 	new->out_handle.data = NULL;
 	new->out_handle.len = 0;
 	new->out_token.data = NULL;
@@ -141,8 +147,11 @@ static inline void rsi_init(struct rsi *
 	item->in_token.data = NULL;
 }
 
-static inline void rsi_update(struct rsi *new, struct rsi *item)
+static void update_rsi(struct cache_head *cnew, struct cache_head *citem)
 {
+	struct rsi *new = container_of(cnew, struct rsi, h);
+	struct rsi *item = container_of(citem, struct rsi, h);
+
 	BUG_ON(new->out_handle.data || new->out_token.data);
 	new->out_handle.len = item->out_handle.len;
 	item->out_handle.len = 0;
@@ -157,6 +166,15 @@ static inline void rsi_update(struct rsi
 	new->minor_status = item->minor_status;
 }
 
+static struct cache_head *rsi_alloc(void)
+{
+	struct rsi *rsii = kmalloc(sizeof(*rsii), GFP_KERNEL);
+	if (rsii)
+		return &rsii->h;
+	else
+		return NULL;
+}
+
 static void rsi_request(struct cache_detail *cd,
                        struct cache_head *h,
                        char **bpp, int *blen)
@@ -198,6 +216,10 @@ static int rsi_parse(struct cache_detail
 	if (dup_to_netobj(&rsii.in_token, buf, len))
 		goto out;
 
+	rsip = rsi_lookup(&rsii);
+	if (!rsip)
+		goto out;
+
 	rsii.h.flags = 0;
 	/* expiry */
 	expiry = get_expiry(&mesg);
@@ -240,12 +262,14 @@ static int rsi_parse(struct cache_detail
 			goto out;
 	}
 	rsii.h.expiry_time = expiry;
-	rsip = rsi_lookup(&rsii, 1);
+	rsip = rsi_update(&rsii, rsip);
 	status = 0;
 out:
 	rsi_free(&rsii);
 	if (rsip)
 		rsi_put(&rsip->h, &rsi_cache);
+	else
+		status = -ENOMEM;
 	return status;
 }
 
@@ -257,9 +281,37 @@ static struct cache_detail rsi_cache = {
 	.cache_put      = rsi_put,
 	.cache_request  = rsi_request,
 	.cache_parse    = rsi_parse,
+	.match		= rsi_match,
+	.init		= rsi_init,
+	.update		= update_rsi,
+	.alloc		= rsi_alloc,
 };
 
-static DefineSimpleCacheLookup(rsi, rsi)
+static struct rsi *rsi_lookup(struct rsi *item)
+{
+	struct cache_head *ch;
+	int hash = rsi_hash(item);
+
+	ch = sunrpc_cache_lookup(&rsi_cache, &item->h, hash);
+	if (ch)
+		return container_of(ch, struct rsi, h);
+	else
+		return NULL;
+}
+
+static struct rsi *rsi_update(struct rsi *new, struct rsi *old)
+{
+	struct cache_head *ch;
+	int hash = rsi_hash(new);
+
+	ch = sunrpc_cache_update(&rsi_cache, &new->h,
+				 &old->h, hash);
+	if (ch)
+		return container_of(ch, struct rsi, h);
+	else
+		return NULL;
+}
+
 
 /*
  * The rpcsec_context cache is used to store a context that is
@@ -895,7 +947,7 @@ svcauth_gss_accept(struct svc_rqst *rqst
 			goto drop;
 		}
 
-		rsip = rsi_lookup(&rsikey, 0);
+		rsip = rsi_lookup(&rsikey);
 		rsi_free(&rsikey);
 		if (!rsip) {
 			goto drop;
