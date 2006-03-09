Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWCIG4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWCIG4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWCIG4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:56:03 -0500
Received: from cantor2.suse.de ([195.135.220.15]:46051 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751699AbWCIGxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:02 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:58 +1100
Message-Id: <1060309065158.24593@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 14] knfsd: Use new cache_lookup for svc_expkey cache.
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |  136 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 99 insertions(+), 37 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-03-09 17:15:14.000000000 +1100
+++ ./fs/nfsd/export.c	2006-03-09 17:15:15.000000000 +1100
@@ -57,17 +57,6 @@ static int		exp_verify_string(char *cp, 
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 static struct cache_head *expkey_table[EXPKEY_HASHMAX];
 
-static inline int svc_expkey_hash(struct svc_expkey *item)
-{
-	int hash = item->ek_fsidtype;
-	char * cp = (char*)item->ek_fsid;
-	int len = key_len(item->ek_fsidtype);
-
-	hash ^= hash_mem(cp, len, EXPKEY_HASHBITS);
-	hash ^= hash_ptr(item->ek_client, EXPKEY_HASHBITS);
-	return hash & EXPKEY_HASHMASK;
-}
-
 void expkey_put(struct cache_head *item, struct cache_detail *cd)
 {
 	if (cache_put(item, cd)) {
@@ -97,7 +86,8 @@ static void expkey_request(struct cache_
 	(*bpp)[-1] = '\n';
 }
 
-static struct svc_expkey *svc_expkey_lookup(struct svc_expkey *, int);
+static struct svc_expkey *svc_expkey_update(struct svc_expkey *new, struct svc_expkey *old);
+static struct svc_expkey *svc_expkey_lookup(struct svc_expkey *);
 static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
 	/* client fsidtype fsid [path] */
@@ -108,6 +98,7 @@ static int expkey_parse(struct cache_det
 	int fsidtype;
 	char *ep;
 	struct svc_expkey key;
+	struct svc_expkey *ek;
 
 	if (mesg[mlen-1] != '\n')
 		return -EINVAL;
@@ -152,20 +143,25 @@ static int expkey_parse(struct cache_det
 	key.ek_fsidtype = fsidtype;
 	memcpy(key.ek_fsid, buf, len);
 
+	ek = svc_expkey_lookup(&key);
+	err = -ENOMEM;
+	if (!ek)
+		goto out;
+
 	/* now we want a pathname, or empty meaning NEGATIVE  */
+	err = -EINVAL;
 	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) < 0)
 		goto out;
 	dprintk("Path seems to be <%s>\n", buf);
 	err = 0;
 	if (len == 0) {
-		struct svc_expkey *ek;
 		set_bit(CACHE_NEGATIVE, &key.h.flags);
-		ek = svc_expkey_lookup(&key, 1);
+		ek = svc_expkey_update(&key, ek);
 		if (ek)
 			expkey_put(&ek->h, &svc_expkey_cache);
+		else err = -ENOMEM;
 	} else {
 		struct nameidata nd;
-		struct svc_expkey *ek;
 		err = path_lookup(buf, 0, &nd);
 		if (err)
 			goto out;
@@ -174,10 +170,11 @@ static int expkey_parse(struct cache_det
 		key.ek_mnt = nd.mnt;
 		key.ek_dentry = nd.dentry;
 		
-		ek = svc_expkey_lookup(&key, 1);
+		ek = svc_expkey_update(&key, ek);
 		if (ek)
 			expkey_put(&ek->h, &svc_expkey_cache);
-		err = 0;
+		else
+			err = -ENOMEM;
 		path_release(&nd);
 	}
 	cache_flush();
@@ -213,29 +210,25 @@ static int expkey_show(struct seq_file *
 	seq_printf(m, "\n");
 	return 0;
 }
-	
-struct cache_detail svc_expkey_cache = {
-	.owner		= THIS_MODULE,
-	.hash_size	= EXPKEY_HASHMAX,
-	.hash_table	= expkey_table,
-	.name		= "nfsd.fh",
-	.cache_put	= expkey_put,
-	.cache_request	= expkey_request,
-	.cache_parse	= expkey_parse,
-	.cache_show	= expkey_show,
-};
 
-static inline int svc_expkey_match (struct svc_expkey *a, struct svc_expkey *b)
+static inline int expkey_match (struct cache_head *a, struct cache_head *b)
 {
-	if (a->ek_fsidtype != b->ek_fsidtype ||
-	    a->ek_client != b->ek_client ||
-	    memcmp(a->ek_fsid, b->ek_fsid, key_len(a->ek_fsidtype)) != 0)
+	struct svc_expkey *orig = container_of(a, struct svc_expkey, h);
+	struct svc_expkey *new = container_of(b, struct svc_expkey, h);
+
+	if (orig->ek_fsidtype != new->ek_fsidtype ||
+	    orig->ek_client != new->ek_client ||
+	    memcmp(orig->ek_fsid, new->ek_fsid, key_len(orig->ek_fsidtype)) != 0)
 		return 0;
 	return 1;
 }
 
-static inline void svc_expkey_init(struct svc_expkey *new, struct svc_expkey *item)
+static inline void expkey_init(struct cache_head *cnew,
+				   struct cache_head *citem)
 {
+	struct svc_expkey *new = container_of(cnew, struct svc_expkey, h);
+	struct svc_expkey *item = container_of(citem, struct svc_expkey, h);
+
 	kref_get(&item->ek_client->ref);
 	new->ek_client = item->ek_client;
 	new->ek_fsidtype = item->ek_fsidtype;
@@ -244,13 +237,80 @@ static inline void svc_expkey_init(struc
 	new->ek_fsid[2] = item->ek_fsid[2];
 }
 
-static inline void svc_expkey_update(struct svc_expkey *new, struct svc_expkey *item)
+static inline void expkey_update(struct cache_head *cnew,
+				   struct cache_head *citem)
 {
+	struct svc_expkey *new = container_of(cnew, struct svc_expkey, h);
+	struct svc_expkey *item = container_of(citem, struct svc_expkey, h);
+
 	new->ek_mnt = mntget(item->ek_mnt);
 	new->ek_dentry = dget(item->ek_dentry);
 }
 
-static DefineSimpleCacheLookup(svc_expkey, svc_expkey)
+static struct cache_head *expkey_alloc(void)
+{
+	struct svc_expkey *i = kmalloc(sizeof(*i), GFP_KERNEL);
+	if (i)
+		return &i->h;
+	else
+		return NULL;
+}
+
+struct cache_detail svc_expkey_cache = {
+	.owner		= THIS_MODULE,
+	.hash_size	= EXPKEY_HASHMAX,
+	.hash_table	= expkey_table,
+	.name		= "nfsd.fh",
+	.cache_put	= expkey_put,
+	.cache_request	= expkey_request,
+	.cache_parse	= expkey_parse,
+	.cache_show	= expkey_show,
+	.match		= expkey_match,
+	.init		= expkey_init,
+	.update       	= expkey_update,
+	.alloc		= expkey_alloc,
+};
+
+static struct svc_expkey *
+svc_expkey_lookup(struct svc_expkey *item)
+{
+	struct cache_head *ch;
+	int hash = item->ek_fsidtype;
+	char * cp = (char*)item->ek_fsid;
+	int len = key_len(item->ek_fsidtype);
+
+	hash ^= hash_mem(cp, len, EXPKEY_HASHBITS);
+	hash ^= hash_ptr(item->ek_client, EXPKEY_HASHBITS);
+	hash &= EXPKEY_HASHMASK;
+
+	ch = sunrpc_cache_lookup(&svc_expkey_cache, &item->h,
+				 hash);
+	if (ch)
+		return container_of(ch, struct svc_expkey, h);
+	else
+		return NULL;
+}
+
+static struct svc_expkey *
+svc_expkey_update(struct svc_expkey *new, struct svc_expkey *old)
+{
+	struct cache_head *ch;
+	int hash = new->ek_fsidtype;
+	char * cp = (char*)new->ek_fsid;
+	int len = key_len(new->ek_fsidtype);
+
+	hash ^= hash_mem(cp, len, EXPKEY_HASHBITS);
+	hash ^= hash_ptr(new->ek_client, EXPKEY_HASHBITS);
+	hash &= EXPKEY_HASHMASK;
+
+	ch = sunrpc_cache_update(&svc_expkey_cache, &new->h,
+				 &old->h, hash);
+	if (ch)
+		return container_of(ch, struct svc_expkey, h);
+	else
+		return NULL;
+}
+
 
 #define	EXPORT_HASHBITS		8
 #define	EXPORT_HASHMAX		(1<< EXPORT_HASHBITS)
@@ -549,7 +609,7 @@ exp_find_key(svc_client *clp, int fsid_t
 	key.ek_fsidtype = fsid_type;
 	memcpy(key.ek_fsid, fsidv, key_len(fsid_type));
 
-	ek = svc_expkey_lookup(&key, 0);
+	ek = svc_expkey_lookup(&key);
 	if (ek != NULL)
 		if ((err = cache_check(&svc_expkey_cache, &ek->h, reqp)))
 			ek = ERR_PTR(err);
@@ -569,7 +629,9 @@ static int exp_set_key(svc_client *clp, 
 	key.h.expiry_time = NEVER;
 	key.h.flags = 0;
 
-	ek = svc_expkey_lookup(&key, 1);
+	ek = svc_expkey_lookup(&key);
+	if (ek)
+		ek = svc_expkey_update(&key,ek);
 	if (ek) {
 		expkey_put(&ek->h, &svc_expkey_cache);
 		return 0;
