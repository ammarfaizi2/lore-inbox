Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWCIG5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWCIG5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWCIGz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:55:59 -0500
Received: from mail.suse.de ([195.135.220.2]:62640 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751668AbWCIGxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:17 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:14 +1100
Message-Id: <1060309065214.24629@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 14] knfsd: Use new cache code for name/id lookup caches
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4idmap.c |  126 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 103 insertions(+), 23 deletions(-)

diff ./fs/nfsd/nfs4idmap.c~current~ ./fs/nfsd/nfs4idmap.c
--- ./fs/nfsd/nfs4idmap.c~current~	2006-03-09 17:15:13.000000000 +1100
+++ ./fs/nfsd/nfs4idmap.c	2006-03-09 17:16:07.000000000 +1100
@@ -82,9 +82,12 @@ struct ent {
 #define ENT_HASHMAX           (1 << ENT_HASHBITS)
 #define ENT_HASHMASK          (ENT_HASHMAX - 1)
 
-static inline void
-ent_init(struct ent *new, struct ent *itm)
+static void
+ent_init(struct cache_head *cnew, struct cache_head *citm)
 {
+	struct ent *new = container_of(cnew, struct ent, h);
+	struct ent *itm = container_of(citm, struct ent, h);
+
 	new->id = itm->id;
 	new->type = itm->type;
 
@@ -92,12 +95,6 @@ ent_init(struct ent *new, struct ent *it
 	strlcpy(new->authname, itm->authname, sizeof(new->name));
 }
 
-static inline void
-ent_update(struct ent *new, struct ent *itm)
-{
-	ent_init(new, itm);
-}
-
 static void
 ent_put(struct cache_head *ch, struct cache_detail *cd)
 {
@@ -107,6 +104,16 @@ ent_put(struct cache_head *ch, struct ca
 	}
 }
 
+static struct cache_head *
+ent_alloc(void)
+{
+	struct ent *e = kmalloc(sizeof(*e), GFP_KERNEL);
+	if (e)
+		return &e->h;
+	else
+		return NULL;
+}
+
 /*
  * ID -> Name cache
  */
@@ -143,9 +150,12 @@ idtoname_request(struct cache_detail *cd
 	(*bpp)[-1] = '\n';
 }
 
-static inline int
-idtoname_match(struct ent *a, struct ent *b)
+static int
+idtoname_match(struct cache_head *ca, struct cache_head *cb)
 {
+	struct ent *a = container_of(ca, struct ent, h);
+	struct ent *b = container_of(cb, struct ent, h);
+
 	return (a->id == b->id && a->type == b->type &&
 	    strcmp(a->authname, b->authname) == 0);
 }
@@ -178,7 +188,8 @@ warn_no_idmapd(struct cache_detail *deta
 
 
 static int         idtoname_parse(struct cache_detail *, char *, int);
-static struct ent *idtoname_lookup(struct ent *, int);
+static struct ent *idtoname_lookup(struct ent *);
+static struct ent *idtoname_update(struct ent *, struct ent *);
 
 static struct cache_detail idtoname_cache = {
 	.owner		= THIS_MODULE,
@@ -190,6 +201,10 @@ static struct cache_detail idtoname_cach
 	.cache_parse	= idtoname_parse,
 	.cache_show	= idtoname_show,
 	.warn_no_listener = warn_no_idmapd,
+	.match		= idtoname_match,
+	.init		= ent_init,
+	.update		= ent_init,
+	.alloc		= ent_alloc,
 };
 
 int
@@ -232,6 +247,11 @@ idtoname_parse(struct cache_detail *cd, 
 	if (ent.h.expiry_time == 0)
 		goto out;
 
+	error = -ENOMEM;
+	res = idtoname_lookup(&ent);
+	if (!res)
+		goto out;
+
 	/* Name */
 	error = qword_get(&buf, buf1, PAGE_SIZE);
 	if (error == -EINVAL)
@@ -246,7 +266,8 @@ idtoname_parse(struct cache_detail *cd, 
 		memcpy(ent.name, buf1, sizeof(ent.name));
 	}
 	error = -ENOMEM;
-	if ((res = idtoname_lookup(&ent, 1)) == NULL)
+	res = idtoname_update(&ent, res);
+	if (res == NULL)
 		goto out;
 
 	ent_put(&res->h, &idtoname_cache);
@@ -258,7 +279,31 @@ out:
 	return error;
 }
 
-static DefineSimpleCacheLookup(ent, idtoname);
+
+static struct ent *
+idtoname_lookup(struct ent *item)
+{
+	struct cache_head *ch = sunrpc_cache_lookup(&idtoname_cache,
+						    &item->h,
+						    idtoname_hash(item));
+	if (ch)
+		return container_of(ch, struct ent, h);
+	else
+		return NULL;
+}
+
+static struct ent *
+idtoname_update(struct ent *new, struct ent *old)
+{
+	struct cache_head *ch = sunrpc_cache_update(&idtoname_cache,
+						    &new->h, &old->h,
+						    idtoname_hash(new));
+	if (ch)
+		return container_of(ch, struct ent, h);
+	else
+		return NULL;
+}
+
 
 /*
  * Name -> ID cache
@@ -285,9 +330,12 @@ nametoid_request(struct cache_detail *cd
 	(*bpp)[-1] = '\n';
 }
 
-static inline int
-nametoid_match(struct ent *a, struct ent *b)
+static int
+nametoid_match(struct cache_head *ca, struct cache_head *cb)
 {
+	struct ent *a = container_of(ca, struct ent, h);
+	struct ent *b = container_of(cb, struct ent, h);
+
 	return (a->type == b->type && strcmp(a->name, b->name) == 0 &&
 	    strcmp(a->authname, b->authname) == 0);
 }
@@ -311,7 +359,8 @@ nametoid_show(struct seq_file *m, struct
 	return 0;
 }
 
-static struct ent *nametoid_lookup(struct ent *, int);
+static struct ent *nametoid_lookup(struct ent *);
+static struct ent *nametoid_update(struct ent *, struct ent *);
 static int         nametoid_parse(struct cache_detail *, char *, int);
 
 static struct cache_detail nametoid_cache = {
@@ -324,6 +373,10 @@ static struct cache_detail nametoid_cach
 	.cache_parse	= nametoid_parse,
 	.cache_show	= nametoid_show,
 	.warn_no_listener = warn_no_idmapd,
+	.match		= nametoid_match,
+	.init		= ent_init,
+	.update		= ent_init,
+	.alloc		= ent_alloc,
 };
 
 static int
@@ -373,7 +426,11 @@ nametoid_parse(struct cache_detail *cd, 
 		set_bit(CACHE_NEGATIVE, &ent.h.flags);
 
 	error = -ENOMEM;
-	if ((res = nametoid_lookup(&ent, 1)) == NULL)
+	res = nametoid_lookup(&ent);
+	if (res == NULL)
+		goto out;
+	res = nametoid_update(&ent, res);
+	if (res == NULL)
 		goto out;
 
 	ent_put(&res->h, &nametoid_cache);
@@ -384,7 +441,30 @@ out:
 	return (error);
 }
 
-static DefineSimpleCacheLookup(ent, nametoid);
+
+static struct ent *
+nametoid_lookup(struct ent *item)
+{
+	struct cache_head *ch = sunrpc_cache_lookup(&nametoid_cache,
+						    &item->h,
+						    nametoid_hash(item));
+	if (ch)
+		return container_of(ch, struct ent, h);
+	else
+		return NULL;
+}
+
+static struct ent *
+nametoid_update(struct ent *new, struct ent *old)
+{
+	struct cache_head *ch = sunrpc_cache_update(&nametoid_cache,
+						    &new->h, &old->h,
+						    nametoid_hash(new));
+	if (ch)
+		return container_of(ch, struct ent, h);
+	else
+		return NULL;
+}
 
 /*
  * Exported API
@@ -452,24 +532,24 @@ idmap_defer(struct cache_req *req)
 }
 
 static inline int
-do_idmap_lookup(struct ent *(*lookup_fn)(struct ent *, int), struct ent *key,
+do_idmap_lookup(struct ent *(*lookup_fn)(struct ent *), struct ent *key,
 		struct cache_detail *detail, struct ent **item,
 		struct idmap_defer_req *mdr)
 {
-	*item = lookup_fn(key, 0);
+	*item = lookup_fn(key);
 	if (!*item)
 		return -ENOMEM;
 	return cache_check(detail, &(*item)->h, &mdr->req);
 }
 
 static inline int
-do_idmap_lookup_nowait(struct ent *(*lookup_fn)(struct ent *, int),
+do_idmap_lookup_nowait(struct ent *(*lookup_fn)(struct ent *),
 			struct ent *key, struct cache_detail *detail,
 			struct ent **item)
 {
 	int ret = -ENOMEM;
 
-	*item = lookup_fn(key, 0);
+	*item = lookup_fn(key);
 	if (!*item)
 		goto out_err;
 	ret = -ETIMEDOUT;
@@ -490,7 +570,7 @@ out_err:
 
 static int
 idmap_lookup(struct svc_rqst *rqstp,
-		struct ent *(*lookup_fn)(struct ent *, int), struct ent *key,
+		struct ent *(*lookup_fn)(struct ent *), struct ent *key,
 		struct cache_detail *detail, struct ent **item)
 {
 	struct idmap_defer_req *mdr;
