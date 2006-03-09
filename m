Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWCIGxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWCIGxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWCIGxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:06 -0500
Received: from ns2.suse.de ([195.135.220.15]:45283 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751685AbWCIGw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:56 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:53 +1100
Message-Id: <1060309065153.24581@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 14] knfsd: Use new cache_lookup for svc_export
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |  125 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 37 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-03-09 17:15:13.000000000 +1100
+++ ./fs/nfsd/export.c	2006-03-09 17:15:14.000000000 +1100
@@ -258,16 +258,6 @@ static DefineSimpleCacheLookup(svc_expke
 
 static struct cache_head *export_table[EXPORT_HASHMAX];
 
-static inline int svc_export_hash(struct svc_export *item)
-{
-	int rv;
-
-	rv = hash_ptr(item->ex_client, EXPORT_HASHBITS);
-	rv ^= hash_ptr(item->ex_dentry, EXPORT_HASHBITS);
-	rv ^= hash_ptr(item->ex_mnt, EXPORT_HASHBITS);
-	return rv;
-}
-
 void svc_export_put(struct cache_head *item, struct cache_detail *cd)
 {
 	if (cache_put(item, cd)) {
@@ -298,7 +288,8 @@ static void svc_export_request(struct ca
 	(*bpp)[-1] = '\n';
 }
 
-static struct svc_export *svc_export_lookup(struct svc_export *, int);
+struct svc_export *svc_export_update(struct svc_export *new, struct svc_export *old);
+static struct svc_export *svc_export_lookup(struct svc_export *);
 
 static int check_export(struct inode *inode, int flags)
 {
@@ -411,11 +402,16 @@ static int svc_export_parse(struct cache
 		if (err) goto out;
 	}
 
-	expp = svc_export_lookup(&exp, 1);
+	expp = svc_export_lookup(&exp);
 	if (expp)
-		exp_put(expp);
-	err = 0;
+		expp = svc_export_update(&exp, expp);
+	else
+		err = -ENOMEM;
 	cache_flush();
+	if (expp == NULL)
+		err = -ENOMEM;
+	else
+		exp_put(expp);
  out:
 	if (nd.dentry)
 		path_release(&nd);
@@ -449,40 +445,95 @@ static int svc_export_show(struct seq_fi
 	seq_puts(m, ")\n");
 	return 0;
 }
-struct cache_detail svc_export_cache = {
-	.owner		= THIS_MODULE,
-	.hash_size	= EXPORT_HASHMAX,
-	.hash_table	= export_table,
-	.name		= "nfsd.export",
-	.cache_put	= svc_export_put,
-	.cache_request	= svc_export_request,
-	.cache_parse	= svc_export_parse,
-	.cache_show	= svc_export_show,
-};
-
-static inline int svc_export_match(struct svc_export *a, struct svc_export *b)
+static int svc_export_match(struct cache_head *a, struct cache_head *b)
 {
-	return a->ex_client == b->ex_client &&
-		a->ex_dentry == b->ex_dentry &&
-		a->ex_mnt == b->ex_mnt;
+	struct svc_export *orig = container_of(a, struct svc_export, h);
+	struct svc_export *new = container_of(b, struct svc_export, h);
+	return orig->ex_client == new->ex_client &&
+		orig->ex_dentry == new->ex_dentry &&
+		orig->ex_mnt == new->ex_mnt;
 }
-static inline void svc_export_init(struct svc_export *new, struct svc_export *item)
+
+static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
 {
+	struct svc_export *new = container_of(cnew, struct svc_export, h);
+	struct svc_export *item = container_of(citem, struct svc_export, h);
+
 	kref_get(&item->ex_client->ref);
 	new->ex_client = item->ex_client;
 	new->ex_dentry = dget(item->ex_dentry);
 	new->ex_mnt = mntget(item->ex_mnt);
 }
 
-static inline void svc_export_update(struct svc_export *new, struct svc_export *item)
+static void export_update(struct cache_head *cnew, struct cache_head *citem)
 {
+	struct svc_export *new = container_of(cnew, struct svc_export, h);
+	struct svc_export *item = container_of(citem, struct svc_export, h);
+
 	new->ex_flags = item->ex_flags;
 	new->ex_anon_uid = item->ex_anon_uid;
 	new->ex_anon_gid = item->ex_anon_gid;
 	new->ex_fsid = item->ex_fsid;
 }
 
-static DefineSimpleCacheLookup(svc_export, svc_export)
+static struct cache_head *svc_export_alloc(void)
+{
+	struct svc_export *i = kmalloc(sizeof(*i), GFP_KERNEL);
+	if (i)
+		return &i->h;
+	else
+		return NULL;
+}
+
+struct cache_detail svc_export_cache = {
+	.owner		= THIS_MODULE,
+	.hash_size	= EXPORT_HASHMAX,
+	.hash_table	= export_table,
+	.name		= "nfsd.export",
+	.cache_put	= svc_export_put,
+	.cache_request	= svc_export_request,
+	.cache_parse	= svc_export_parse,
+	.cache_show	= svc_export_show,
+	.match		= svc_export_match,
+	.init		= svc_export_init,
+	.update		= export_update,
+	.alloc		= svc_export_alloc,
+};
+
+static struct svc_export *
+svc_export_lookup(struct svc_export *exp)
+{
+	struct cache_head *ch;
+	int hash;
+	hash = hash_ptr(exp->ex_client, EXPORT_HASHBITS);
+	hash ^= hash_ptr(exp->ex_dentry, EXPORT_HASHBITS);
+	hash ^= hash_ptr(exp->ex_mnt, EXPORT_HASHBITS);
+
+	ch = sunrpc_cache_lookup(&svc_export_cache, &exp->h,
+				 hash);
+	if (ch)
+		return container_of(ch, struct svc_export, h);
+	else
+		return NULL;
+}
+
+struct svc_export *
+svc_export_update(struct svc_export *new, struct svc_export *old)
+{
+	struct cache_head *ch;
+	int hash;
+	hash = hash_ptr(old->ex_client, EXPORT_HASHBITS);
+	hash ^= hash_ptr(old->ex_dentry, EXPORT_HASHBITS);
+	hash ^= hash_ptr(old->ex_mnt, EXPORT_HASHBITS);
+
+	ch = sunrpc_cache_update(&svc_export_cache, &new->h,
+				 &old->h,
+				 hash);
+	if (ch)
+		return container_of(ch, struct svc_export, h);
+	else
+		return NULL;
+}
 
 
 struct svc_expkey *
@@ -568,7 +619,7 @@ exp_get_by_name(svc_client *clp, struct 
 	key.ex_mnt = mnt;
 	key.ex_dentry = dentry;
 
-	exp = svc_export_lookup(&key, 0);
+	exp = svc_export_lookup(&key);
 	if (exp != NULL) 
 		switch (cache_check(&svc_export_cache, &exp->h, reqp)) {
 		case 0: break;
@@ -770,13 +821,13 @@ exp_export(struct nfsctl_export *nxp)
 	new.ex_anon_gid = nxp->ex_anon_gid;
 	new.ex_fsid = nxp->ex_dev;
 
-	exp = svc_export_lookup(&new, 1);
+	exp = svc_export_lookup(&new);
+	if (exp)
+		exp = svc_export_update(&new, exp);
 
-	if (exp == NULL)
+	if (!exp)
 		goto finish;
 
-	err = 0;
-
 	if (exp_hash(clp, exp) ||
 	    exp_fsid_hash(clp, exp)) {
 		/* failed to create at least one index */
