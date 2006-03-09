Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWCIGz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWCIGz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWCIGxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:15 -0500
Received: from ns.suse.de ([195.135.220.2]:61360 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751693AbWCIGxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:12 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:08 +1100
Message-Id: <1060309065208.24617@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 14] knfsd: Use new cache code for rsc cache
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/auth_gss/svcauth_gss.c |   74 +++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 10 deletions(-)

diff ./net/sunrpc/auth_gss/svcauth_gss.c~current~ ./net/sunrpc/auth_gss/svcauth_gss.c
--- ./net/sunrpc/auth_gss/svcauth_gss.c~current~	2006-03-09 17:15:43.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-03-09 17:15:58.000000000 +1100
@@ -345,7 +345,8 @@ struct rsc {
 
 static struct cache_head *rsc_table[RSC_HASHMAX];
 static struct cache_detail rsc_cache;
-static struct rsc *rsc_lookup(struct rsc *item, int set);
+static struct rsc *rsc_update(struct rsc *new, struct rsc *old);
+static struct rsc *rsc_lookup(struct rsc *item);
 
 static void rsc_free(struct rsc *rsci)
 {
@@ -372,15 +373,21 @@ rsc_hash(struct rsc *rsci)
 	return hash_mem(rsci->handle.data, rsci->handle.len, RSC_HASHBITS);
 }
 
-static inline int
-rsc_match(struct rsc *new, struct rsc *tmp)
+static int
+rsc_match(struct cache_head *a, struct cache_head *b)
 {
+	struct rsc *new = container_of(a, struct rsc, h);
+	struct rsc *tmp = container_of(b, struct rsc, h);
+
 	return netobj_equal(&new->handle, &tmp->handle);
 }
 
-static inline void
-rsc_init(struct rsc *new, struct rsc *tmp)
+static void
+rsc_init(struct cache_head *cnew, struct cache_head *ctmp)
 {
+	struct rsc *new = container_of(cnew, struct rsc, h);
+	struct rsc *tmp = container_of(ctmp, struct rsc, h);
+
 	new->handle.len = tmp->handle.len;
 	tmp->handle.len = 0;
 	new->handle.data = tmp->handle.data;
@@ -389,9 +396,12 @@ rsc_init(struct rsc *new, struct rsc *tm
 	new->cred.cr_group_info = NULL;
 }
 
-static inline void
-rsc_update(struct rsc *new, struct rsc *tmp)
+static void
+update_rsc(struct cache_head *cnew, struct cache_head *ctmp)
 {
+	struct rsc *new = container_of(cnew, struct rsc, h);
+	struct rsc *tmp = container_of(ctmp, struct rsc, h);
+
 	new->mechctx = tmp->mechctx;
 	tmp->mechctx = NULL;
 	memset(&new->seqdata, 0, sizeof(new->seqdata));
@@ -400,6 +410,16 @@ rsc_update(struct rsc *new, struct rsc *
 	tmp->cred.cr_group_info = NULL;
 }
 
+static struct cache_head *
+rsc_alloc(void)
+{
+	struct rsc *rsci = kmalloc(sizeof(*rsci), GFP_KERNEL);
+	if (rsci)
+		return &rsci->h;
+	else
+		return NULL;
+}
+
 static int rsc_parse(struct cache_detail *cd,
 		     char *mesg, int mlen)
 {
@@ -425,6 +445,10 @@ static int rsc_parse(struct cache_detail
 	if (expiry == 0)
 		goto out;
 
+	rscp = rsc_lookup(&rsci);
+	if (!rscp)
+		goto out;
+
 	/* uid, or NEGATIVE */
 	rv = get_int(&mesg, &rsci.cred.cr_uid);
 	if (rv == -EINVAL)
@@ -480,12 +504,14 @@ static int rsc_parse(struct cache_detail
 		gss_mech_put(gm);
 	}
 	rsci.h.expiry_time = expiry;
-	rscp = rsc_lookup(&rsci, 1);
+	rscp = rsc_update(&rsci, rscp);
 	status = 0;
 out:
 	rsc_free(&rsci);
 	if (rscp)
 		rsc_put(&rscp->h, &rsc_cache);
+	else
+		status = -ENOMEM;
 	return status;
 }
 
@@ -496,9 +522,37 @@ static struct cache_detail rsc_cache = {
 	.name		= "auth.rpcsec.context",
 	.cache_put	= rsc_put,
 	.cache_parse	= rsc_parse,
+	.match		= rsc_match,
+	.init		= rsc_init,
+	.update		= update_rsc,
+	.alloc		= rsc_alloc,
 };
 
-static DefineSimpleCacheLookup(rsc, rsc);
+static struct rsc *rsc_lookup(struct rsc *item)
+{
+	struct cache_head *ch;
+	int hash = rsc_hash(item);
+
+	ch = sunrpc_cache_lookup(&rsc_cache, &item->h, hash);
+	if (ch)
+		return container_of(ch, struct rsc, h);
+	else
+		return NULL;
+}
+
+static struct rsc *rsc_update(struct rsc *new, struct rsc *old)
+{
+	struct cache_head *ch;
+	int hash = rsc_hash(new);
+
+	ch = sunrpc_cache_update(&rsc_cache, &new->h,
+				 &old->h, hash);
+	if (ch)
+		return container_of(ch, struct rsc, h);
+	else
+		return NULL;
+}
+
 
 static struct rsc *
 gss_svc_searchbyctx(struct xdr_netobj *handle)
@@ -509,7 +563,7 @@ gss_svc_searchbyctx(struct xdr_netobj *h
 	memset(&rsci, 0, sizeof(rsci));
 	if (dup_to_netobj(&rsci.handle, handle->data, handle->len))
 		return NULL;
-	found = rsc_lookup(&rsci, 0);
+	found = rsc_lookup(&rsci);
 	rsc_free(&rsci);
 	if (!found)
 		return NULL;
