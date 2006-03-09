Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWCIGwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWCIGwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWCIGwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:52:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:41699 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751600AbWCIGwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:36 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:32 +1100
Message-Id: <1060309065132.24533@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 14] knfsd: Break the hard linkage from svc_expkey to svc_export
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current svc_expkey holds a pointer to the svc_export
structure, so updates to that structure have to be in-place,
which is a wart on the whole cache infrastruct.
So we break that linkage and just do a second lookup.

If this became a performance issue, it would be possible to put a
direct link back in which was only used conditionally.
i.e. when an object is replaced in the cache, we set a flag in the old 
object.  When dereferencing the link from svc_expkey, if the flag is set,
we drop the reference and do a fresh lookup.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c            |   60 ++++++++++++++++++++++++++++--------------
 ./include/linux/nfsd/export.h |   20 ++------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-03-09 17:13:01.000000000 +1100
+++ ./fs/nfsd/export.c	2006-03-09 17:15:13.000000000 +1100
@@ -73,8 +73,10 @@ void expkey_put(struct cache_head *item,
 	if (cache_put(item, cd)) {
 		struct svc_expkey *key = container_of(item, struct svc_expkey, h);
 		if (test_bit(CACHE_VALID, &item->flags) &&
-		    !test_bit(CACHE_NEGATIVE, &item->flags))
-			exp_put(key->ek_export);
+		    !test_bit(CACHE_NEGATIVE, &item->flags)) {
+			dput(key->ek_dentry);
+			mntput(key->ek_mnt);
+		}
 		auth_domain_put(key->ek_client);
 		kfree(key);
 	}
@@ -164,26 +166,18 @@ static int expkey_parse(struct cache_det
 	} else {
 		struct nameidata nd;
 		struct svc_expkey *ek;
-		struct svc_export *exp;
 		err = path_lookup(buf, 0, &nd);
 		if (err)
 			goto out;
 
 		dprintk("Found the path %s\n", buf);
-		exp = exp_get_by_name(dom, nd.mnt, nd.dentry, NULL);
-
-		err = -ENOENT;
-		if (!exp)
-			goto out_nd;
-		key.ek_export = exp;
-		dprintk("And found export\n");
+		key.ek_mnt = nd.mnt;
+		key.ek_dentry = nd.dentry;
 		
 		ek = svc_expkey_lookup(&key, 1);
 		if (ek)
 			expkey_put(&ek->h, &svc_expkey_cache);
-		exp_put(exp);
 		err = 0;
-	out_nd:
 		path_release(&nd);
 	}
 	cache_flush();
@@ -214,7 +208,7 @@ static int expkey_show(struct seq_file *
 	if (test_bit(CACHE_VALID, &h->flags) && 
 	    !test_bit(CACHE_NEGATIVE, &h->flags)) {
 		seq_printf(m, " ");
-		seq_path(m, ek->ek_export->ex_mnt, ek->ek_export->ex_dentry, "\\ \t\n");
+		seq_path(m, ek->ek_mnt, ek->ek_dentry, "\\ \t\n");
 	}
 	seq_printf(m, "\n");
 	return 0;
@@ -252,8 +246,8 @@ static inline void svc_expkey_init(struc
 
 static inline void svc_expkey_update(struct svc_expkey *new, struct svc_expkey *item)
 {
-	cache_get(&item->ek_export->h);
-	new->ek_export = item->ek_export;
+	new->ek_mnt = mntget(item->ek_mnt);
+	new->ek_dentry = dget(item->ek_dentry);
 }
 
 static DefineSimpleCacheLookup(svc_expkey,0) /* no inplace updates */
@@ -519,7 +513,8 @@ static int exp_set_key(svc_client *clp, 
 	key.ek_client = clp;
 	key.ek_fsidtype = fsid_type;
 	memcpy(key.ek_fsid, fsidv, key_len(fsid_type));
-	key.ek_export = exp;
+	key.ek_mnt = exp->ex_mnt;
+	key.ek_dentry = exp->ex_dentry;
 	key.h.expiry_time = NEVER;
 	key.h.flags = 0;
 
@@ -741,8 +736,8 @@ exp_export(struct nfsctl_export *nxp)
 	if ((nxp->ex_flags & NFSEXP_FSID) &&
 	    (fsid_key = exp_get_fsid_key(clp, nxp->ex_dev)) &&
 	    !IS_ERR(fsid_key) &&
-	    fsid_key->ek_export &&
-	    fsid_key->ek_export != exp)
+	    fsid_key->ek_mnt &&
+	    (fsid_key->ek_mnt != nd.mnt || fsid_key->ek_dentry != nd.dentry) )
 		goto finish;
 
 	if (exp) {
@@ -912,6 +907,24 @@ out:
 	return err;
 }
 
+struct svc_export *
+exp_find(struct auth_domain *clp, int fsid_type, u32 *fsidv,
+	 struct cache_req *reqp)
+{
+	struct svc_export *exp;
+	struct svc_expkey *ek = exp_find_key(clp, fsid_type, fsidv, reqp);
+	if (!ek || IS_ERR(ek))
+		return ERR_PTR(PTR_ERR(ek));
+
+	exp = exp_get_by_name(clp, ek->ek_mnt, ek->ek_dentry, reqp);
+	expkey_put(&ek->h, &svc_expkey_cache);
+
+	if (!exp || IS_ERR(exp))
+		return ERR_PTR(PTR_ERR(exp));
+	return exp;
+}
+
+
 /*
  * Called when we need the filehandle for the root of the pseudofs,
  * for a given NFSv4 client.   The root is defined to be the
@@ -922,6 +935,7 @@ exp_pseudoroot(struct auth_domain *clp, 
 	       struct cache_req *creq)
 {
 	struct svc_expkey *fsid_key;
+	struct svc_export *exp;
 	int rv;
 	u32 fsidv[2];
 
@@ -933,8 +947,14 @@ exp_pseudoroot(struct auth_domain *clp, 
 	if (!fsid_key || IS_ERR(fsid_key))
 		return nfserr_perm;
 
-	rv = fh_compose(fhp, fsid_key->ek_export, 
-			  fsid_key->ek_export->ex_dentry, NULL);
+	exp = exp_get_by_name(clp, fsid_key->ek_mnt, fsid_key->ek_dentry, creq);
+	if (exp == NULL)
+		rv = nfserr_perm;
+	else if (IS_ERR(exp))
+		rv = nfserrno(PTR_ERR(exp));
+	else
+		rv = fh_compose(fhp, exp,
+				fsid_key->ek_dentry, NULL);
 	expkey_put(&fsid_key->h, &svc_expkey_cache);
 	return rv;
 }

diff ./include/linux/nfsd/export.h~current~ ./include/linux/nfsd/export.h
--- ./include/linux/nfsd/export.h~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./include/linux/nfsd/export.h	2006-03-09 17:15:13.000000000 +1100
@@ -67,7 +67,8 @@ struct svc_expkey {
 	int			ek_fsidtype;
 	u32			ek_fsid[3];
 
-	struct svc_export *	ek_export;
+	struct vfsmount *	ek_mnt;
+	struct dentry *		ek_dentry;
 };
 
 #define EX_SECURE(exp)		(!((exp)->ex_flags & NFSEXP_INSECURE_PORT))
@@ -114,22 +115,9 @@ static inline void exp_get(struct svc_ex
 {
 	cache_get(&exp->h);
 }
-static inline struct svc_export *
+extern struct svc_export *
 exp_find(struct auth_domain *clp, int fsid_type, u32 *fsidv,
-	 struct cache_req *reqp)
-{
-	struct svc_expkey *ek = exp_find_key(clp, fsid_type, fsidv, reqp);
-	if (ek && !IS_ERR(ek)) {
-		struct svc_export *exp = ek->ek_export;
-		int err;
-		exp_get(exp);
-		expkey_put(&ek->h, &svc_expkey_cache);
-		if ((err = cache_check(&svc_export_cache, &exp->h, reqp)))
-			exp = ERR_PTR(err);
-		return exp;
-	} else
-		return ERR_PTR(PTR_ERR(ek));
-}
+	 struct cache_req *reqp);
 
 #endif /* __KERNEL__ */
 
