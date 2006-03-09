Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWCIGzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWCIGzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWCIGxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:47 -0500
Received: from ns.suse.de ([195.135.220.2]:64432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751716AbWCIGxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:39 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:34 +1100
Message-Id: <1060309065234.24691@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 014 of 14] knfsd: Convert sunrpc_cache to use krefs
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


.. it makes some of the code nicer.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c                  |   51 ++++++++++++++++--------------------
 ./fs/nfsd/nfs4idmap.c               |   18 +++++-------
 ./include/linux/nfsd/export.h       |    4 --
 ./include/linux/sunrpc/cache.h      |   13 ++++-----
 ./net/sunrpc/auth_gss/svcauth_gss.c |   28 ++++++++-----------
 ./net/sunrpc/cache.c                |   20 +++++++-------
 ./net/sunrpc/svcauth_unix.c         |   20 +++++++-------
 7 files changed, 71 insertions(+), 83 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./fs/nfsd/export.c	2006-03-09 17:46:00.000000000 +1100
@@ -57,18 +57,17 @@ static int		exp_verify_string(char *cp, 
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 static struct cache_head *expkey_table[EXPKEY_HASHMAX];
 
-void expkey_put(struct cache_head *item, struct cache_detail *cd)
+void expkey_put(struct kref *ref)
 {
-	if (cache_put(item, cd)) {
-		struct svc_expkey *key = container_of(item, struct svc_expkey, h);
-		if (test_bit(CACHE_VALID, &item->flags) &&
-		    !test_bit(CACHE_NEGATIVE, &item->flags)) {
-			dput(key->ek_dentry);
-			mntput(key->ek_mnt);
-		}
-		auth_domain_put(key->ek_client);
-		kfree(key);
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+
+	if (test_bit(CACHE_VALID, &key->h.flags) &&
+	    !test_bit(CACHE_NEGATIVE, &key->h.flags)) {
+		dput(key->ek_dentry);
+		mntput(key->ek_mnt);
 	}
+	auth_domain_put(key->ek_client);
+	kfree(key);
 }
 
 static void expkey_request(struct cache_detail *cd,
@@ -158,7 +157,7 @@ static int expkey_parse(struct cache_det
 		set_bit(CACHE_NEGATIVE, &key.h.flags);
 		ek = svc_expkey_update(&key, ek);
 		if (ek)
-			expkey_put(&ek->h, &svc_expkey_cache);
+			cache_put(&ek->h, &svc_expkey_cache);
 		else err = -ENOMEM;
 	} else {
 		struct nameidata nd;
@@ -172,7 +171,7 @@ static int expkey_parse(struct cache_det
 		
 		ek = svc_expkey_update(&key, ek);
 		if (ek)
-			expkey_put(&ek->h, &svc_expkey_cache);
+			cache_put(&ek->h, &svc_expkey_cache);
 		else
 			err = -ENOMEM;
 		path_release(&nd);
@@ -318,15 +317,13 @@ svc_expkey_update(struct svc_expkey *new
 
 static struct cache_head *export_table[EXPORT_HASHMAX];
 
-void svc_export_put(struct cache_head *item, struct cache_detail *cd)
+void svc_export_put(struct kref *ref)
 {
-	if (cache_put(item, cd)) {
-		struct svc_export *exp = container_of(item, struct svc_export, h);
-		dput(exp->ex_dentry);
-		mntput(exp->ex_mnt);
-		auth_domain_put(exp->ex_client);
-		kfree(exp);
-	}
+	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
+	dput(exp->ex_dentry);
+	mntput(exp->ex_mnt);
+	auth_domain_put(exp->ex_client);
+	kfree(exp);
 }
 
 static void svc_export_request(struct cache_detail *cd,
@@ -633,7 +630,7 @@ static int exp_set_key(svc_client *clp, 
 	if (ek)
 		ek = svc_expkey_update(&key,ek);
 	if (ek) {
-		expkey_put(&ek->h, &svc_expkey_cache);
+		cache_put(&ek->h, &svc_expkey_cache);
 		return 0;
 	}
 	return -ENOMEM;
@@ -762,7 +759,7 @@ static void exp_fsid_unhash(struct svc_e
 	ek = exp_get_fsid_key(exp->ex_client, exp->ex_fsid);
 	if (ek && !IS_ERR(ek)) {
 		ek->h.expiry_time = get_seconds()-1;
-		expkey_put(&ek->h, &svc_expkey_cache);
+		cache_put(&ek->h, &svc_expkey_cache);
 	}
 	svc_expkey_cache.nextcheck = get_seconds();
 }
@@ -800,7 +797,7 @@ static void exp_unhash(struct svc_export
 	ek = exp_get_key(exp->ex_client, inode->i_sb->s_dev, inode->i_ino);
 	if (ek && !IS_ERR(ek)) {
 		ek->h.expiry_time = get_seconds()-1;
-		expkey_put(&ek->h, &svc_expkey_cache);
+		cache_put(&ek->h, &svc_expkey_cache);
 	}
 	svc_expkey_cache.nextcheck = get_seconds();
 }
@@ -902,7 +899,7 @@ finish:
 	if (exp)
 		exp_put(exp);
 	if (fsid_key && !IS_ERR(fsid_key))
-		expkey_put(&fsid_key->h, &svc_expkey_cache);
+		cache_put(&fsid_key->h, &svc_expkey_cache);
 	if (clp)
 		auth_domain_put(clp);
 	path_release(&nd);
@@ -1030,7 +1027,7 @@ exp_find(struct auth_domain *clp, int fs
 		return ERR_PTR(PTR_ERR(ek));
 
 	exp = exp_get_by_name(clp, ek->ek_mnt, ek->ek_dentry, reqp);
-	expkey_put(&ek->h, &svc_expkey_cache);
+	cache_put(&ek->h, &svc_expkey_cache);
 
 	if (!exp || IS_ERR(exp))
 		return ERR_PTR(PTR_ERR(exp));
@@ -1068,7 +1065,7 @@ exp_pseudoroot(struct auth_domain *clp, 
 	else
 		rv = fh_compose(fhp, exp,
 				fsid_key->ek_dentry, NULL);
-	expkey_put(&fsid_key->h, &svc_expkey_cache);
+	cache_put(&fsid_key->h, &svc_expkey_cache);
 	return rv;
 }
 
@@ -1187,7 +1184,7 @@ static int e_show(struct seq_file *m, vo
 	cache_get(&exp->h);
 	if (cache_check(&svc_export_cache, &exp->h, NULL))
 		return 0;
-	if (cache_put(&exp->h, &svc_export_cache)) BUG();
+	cache_put(&exp->h, &svc_export_cache);
 	return svc_export_show(m, &svc_export_cache, cp);
 }
 

diff ./fs/nfsd/nfs4idmap.c~current~ ./fs/nfsd/nfs4idmap.c
--- ./fs/nfsd/nfs4idmap.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./fs/nfsd/nfs4idmap.c	2006-03-09 17:46:00.000000000 +1100
@@ -96,12 +96,10 @@ ent_init(struct cache_head *cnew, struct
 }
 
 static void
-ent_put(struct cache_head *ch, struct cache_detail *cd)
+ent_put(struct kref *ref)
 {
-	if (cache_put(ch, cd)) {
-		struct ent *map = container_of(ch, struct ent, h);
-		kfree(map);
-	}
+	struct ent *map = container_of(ref, struct ent, h.ref);
+	kfree(map);
 }
 
 static struct cache_head *
@@ -270,7 +268,7 @@ idtoname_parse(struct cache_detail *cd, 
 	if (res == NULL)
 		goto out;
 
-	ent_put(&res->h, &idtoname_cache);
+	cache_put(&res->h, &idtoname_cache);
 
 	error = 0;
 out:
@@ -433,7 +431,7 @@ nametoid_parse(struct cache_detail *cd, 
 	if (res == NULL)
 		goto out;
 
-	ent_put(&res->h, &nametoid_cache);
+	cache_put(&res->h, &nametoid_cache);
 	error = 0;
 out:
 	kfree(buf1);
@@ -562,7 +560,7 @@ do_idmap_lookup_nowait(struct ent *(*loo
 		goto out_put;
 	return 0;
 out_put:
-	ent_put(&(*item)->h, detail);
+	cache_put(&(*item)->h, detail);
 out_err:
 	*item = NULL;
 	return ret;
@@ -613,7 +611,7 @@ idmap_name_to_id(struct svc_rqst *rqstp,
 	if (ret)
 		return ret;
 	*id = item->id;
-	ent_put(&item->h, &nametoid_cache);
+	cache_put(&item->h, &nametoid_cache);
 	return 0;
 }
 
@@ -635,7 +633,7 @@ idmap_id_to_name(struct svc_rqst *rqstp,
 	ret = strlen(item->name);
 	BUG_ON(ret > IDMAP_NAMESZ);
 	memcpy(name, item->name, ret);
-	ent_put(&item->h, &idtoname_cache);
+	cache_put(&item->h, &idtoname_cache);
 	return ret;
 }
 

diff ./include/linux/nfsd/export.h~current~ ./include/linux/nfsd/export.h
--- ./include/linux/nfsd/export.h~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./include/linux/nfsd/export.h	2006-03-09 17:46:00.000000000 +1100
@@ -102,13 +102,11 @@ int			exp_rootfh(struct auth_domain *, 
 int			exp_pseudoroot(struct auth_domain *, struct svc_fh *fhp, struct cache_req *creq);
 int			nfserrno(int errno);
 
-extern void expkey_put(struct cache_head *item, struct cache_detail *cd);
-extern void svc_export_put(struct cache_head *item, struct cache_detail *cd);
 extern struct cache_detail svc_export_cache, svc_expkey_cache;
 
 static inline void exp_put(struct svc_export *exp)
 {
-	svc_export_put(&exp->h, &svc_export_cache);
+	cache_put(&exp->h, &svc_export_cache);
 }
 
 static inline void exp_get(struct svc_export *exp)

diff ./include/linux/sunrpc/cache.h~current~ ./include/linux/sunrpc/cache.h
--- ./include/linux/sunrpc/cache.h~current~	2006-03-09 17:33:29.000000000 +1100
+++ ./include/linux/sunrpc/cache.h	2006-03-09 17:46:00.000000000 +1100
@@ -50,7 +50,7 @@ struct cache_head {
 	time_t		last_refresh;   /* If CACHE_PENDING, this is when upcall 
 					 * was sent, else this is when update was received
 					 */
-	atomic_t 	refcnt;
+	struct kref	ref;
 	unsigned long	flags;
 };
 #define	CACHE_VALID	0	/* Entry contains valid data */
@@ -68,8 +68,7 @@ struct cache_detail {
 	atomic_t		inuse; /* active user-space update or lookup */
 
 	char			*name;
-	void			(*cache_put)(struct cache_head *,
-					     struct cache_detail*);
+	void			(*cache_put)(struct kref *);
 
 	void			(*cache_request)(struct cache_detail *cd,
 						 struct cache_head *h,
@@ -151,17 +150,17 @@ extern void cache_clean_deferred(void *o
 
 static inline struct cache_head  *cache_get(struct cache_head *h)
 {
-	atomic_inc(&h->refcnt);
+	kref_get(&h->ref);
 	return h;
 }
 
 
-static inline int cache_put(struct cache_head *h, struct cache_detail *cd)
+static inline void cache_put(struct cache_head *h, struct cache_detail *cd)
 {
-	if (atomic_read(&h->refcnt) <= 2 &&
+	if (atomic_read(&h->ref.refcount) <= 2 &&
 	    h->expiry_time < cd->nextcheck)
 		cd->nextcheck = h->expiry_time;
-	return atomic_dec_and_test(&h->refcnt);
+	kref_put(&h->ref, cd->cache_put);
 }
 
 extern void cache_init(struct cache_head *h);

diff ./net/sunrpc/auth_gss/svcauth_gss.c~current~ ./net/sunrpc/auth_gss/svcauth_gss.c
--- ./net/sunrpc/auth_gss/svcauth_gss.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-03-09 17:46:00.000000000 +1100
@@ -89,13 +89,11 @@ static void rsi_free(struct rsi *rsii)
 	kfree(rsii->out_token.data);
 }
 
-static void rsi_put(struct cache_head *item, struct cache_detail *cd)
+static void rsi_put(struct kref *ref)
 {
-	struct rsi *rsii = container_of(item, struct rsi, h);
-	if (cache_put(item, cd)) {
-		rsi_free(rsii);
-		kfree(rsii);
-	}
+	struct rsi *rsii = container_of(ref, struct rsi, h.ref);
+	rsi_free(rsii);
+	kfree(rsii);
 }
 
 static inline int rsi_hash(struct rsi *item)
@@ -267,7 +265,7 @@ static int rsi_parse(struct cache_detail
 out:
 	rsi_free(&rsii);
 	if (rsip)
-		rsi_put(&rsip->h, &rsi_cache);
+		cache_put(&rsip->h, &rsi_cache);
 	else
 		status = -ENOMEM;
 	return status;
@@ -357,14 +355,12 @@ static void rsc_free(struct rsc *rsci)
 		put_group_info(rsci->cred.cr_group_info);
 }
 
-static void rsc_put(struct cache_head *item, struct cache_detail *cd)
+static void rsc_put(struct kref *ref)
 {
-	struct rsc *rsci = container_of(item, struct rsc, h);
+	struct rsc *rsci = container_of(ref, struct rsc, h.ref);
 
-	if (cache_put(item, cd)) {
-		rsc_free(rsci);
-		kfree(rsci);
-	}
+	rsc_free(rsci);
+	kfree(rsci);
 }
 
 static inline int
@@ -509,7 +505,7 @@ static int rsc_parse(struct cache_detail
 out:
 	rsc_free(&rsci);
 	if (rscp)
-		rsc_put(&rscp->h, &rsc_cache);
+		cache_put(&rscp->h, &rsc_cache);
 	else
 		status = -ENOMEM;
 	return status;
@@ -1076,7 +1072,7 @@ drop:
 	ret = SVC_DROP;
 out:
 	if (rsci)
-		rsc_put(&rsci->h, &rsc_cache);
+		cache_put(&rsci->h, &rsc_cache);
 	return ret;
 }
 
@@ -1168,7 +1164,7 @@ out_err:
 		put_group_info(rqstp->rq_cred.cr_group_info);
 	rqstp->rq_cred.cr_group_info = NULL;
 	if (gsd->rsci)
-		rsc_put(&gsd->rsci->h, &rsc_cache);
+		cache_put(&gsd->rsci->h, &rsc_cache);
 	gsd->rsci = NULL;
 
 	return stat;

diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2006-03-09 17:45:46.000000000 +1100
+++ ./net/sunrpc/cache.c	2006-03-09 17:46:00.000000000 +1100
@@ -42,7 +42,7 @@ void cache_init(struct cache_head *h)
 	time_t now = get_seconds();
 	h->next = NULL;
 	h->flags = 0;
-	atomic_set(&h->refcnt, 1);
+	kref_init(&h->ref);
 	h->expiry_time = now + CACHE_NEW_EXPIRY;
 	h->last_refresh = now;
 }
@@ -81,7 +81,7 @@ struct cache_head *sunrpc_cache_lookup(s
 		if (detail->match(tmp, key)) {
 			cache_get(tmp);
 			write_unlock(&detail->hash_lock);
-			detail->cache_put(new, detail);
+			cache_put(new, detail);
 			return tmp;
 		}
 	}
@@ -145,7 +145,7 @@ struct cache_head *sunrpc_cache_update(s
 	/* We need to insert a new entry */
 	tmp = detail->alloc();
 	if (!tmp) {
-		detail->cache_put(old, detail);
+		cache_put(old, detail);
 		return NULL;
 	}
 	cache_init(tmp);
@@ -165,7 +165,7 @@ struct cache_head *sunrpc_cache_update(s
 	write_unlock(&detail->hash_lock);
 	cache_fresh_unlocked(tmp, detail, is_new);
 	cache_fresh_unlocked(old, detail, 0);
-	detail->cache_put(old, detail);
+	cache_put(old, detail);
 	return tmp;
 }
 EXPORT_SYMBOL(sunrpc_cache_update);
@@ -234,7 +234,7 @@ int cache_check(struct cache_detail *det
 		cache_defer_req(rqstp, h);
 
 	if (rv)
-		detail->cache_put(h, detail);
+		cache_put(h, detail);
 	return rv;
 }
 
@@ -431,7 +431,7 @@ static int cache_clean(void)
 			if (test_and_clear_bit(CACHE_PENDING, &ch->flags))
 				queue_loose(current_detail, ch);
 
-			if (atomic_read(&ch->refcnt) == 1)
+			if (atomic_read(&ch->ref.refcount) == 1)
 				break;
 		}
 		if (ch) {
@@ -446,7 +446,7 @@ static int cache_clean(void)
 			current_index ++;
 		spin_unlock(&cache_list_lock);
 		if (ch)
-			d->cache_put(ch, d);
+			cache_put(ch, d);
 	} else
 		spin_unlock(&cache_list_lock);
 
@@ -723,7 +723,7 @@ cache_read(struct file *filp, char __use
 		    !test_bit(CACHE_PENDING, &rq->item->flags)) {
 			list_del(&rq->q.list);
 			spin_unlock(&queue_lock);
-			cd->cache_put(rq->item, cd);
+			cache_put(rq->item, cd);
 			kfree(rq->buf);
 			kfree(rq);
 		} else
@@ -906,7 +906,7 @@ static void queue_loose(struct cache_det
 				continue;
 			list_del(&cr->q.list);
 			spin_unlock(&queue_lock);
-			detail->cache_put(cr->item, detail);
+			cache_put(cr->item, detail);
 			kfree(cr->buf);
 			kfree(cr);
 			return;
@@ -1192,7 +1192,7 @@ static int c_show(struct seq_file *m, vo
 
 	ifdebug(CACHE)
 		seq_printf(m, "# expiry=%ld refcnt=%d flags=%lx\n",
-			   cp->expiry_time, atomic_read(&cp->refcnt), cp->flags);
+			   cp->expiry_time, atomic_read(&cp->ref.refcount), cp->flags);
 	cache_get(cp);
 	if (cache_check(cd, cp, NULL))
 		/* cache_check does a cache_put on failure */

diff ./net/sunrpc/svcauth_unix.c~current~ ./net/sunrpc/svcauth_unix.c
--- ./net/sunrpc/svcauth_unix.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-03-09 17:46:00.000000000 +1100
@@ -84,15 +84,15 @@ struct ip_map {
 };
 static struct cache_head	*ip_table[IP_HASHMAX];
 
-static void ip_map_put(struct cache_head *item, struct cache_detail *cd)
+static void ip_map_put(struct kref *kref)
 {
+	struct cache_head *item = container_of(kref, struct cache_head, ref);
 	struct ip_map *im = container_of(item, struct ip_map,h);
-	if (cache_put(item, cd)) {
-		if (test_bit(CACHE_VALID, &item->flags) &&
-		    !test_bit(CACHE_NEGATIVE, &item->flags))
-			auth_domain_put(&im->m_client->h);
-		kfree(im);
-	}
+
+	if (test_bit(CACHE_VALID, &item->flags) &&
+	    !test_bit(CACHE_NEGATIVE, &item->flags))
+		auth_domain_put(&im->m_client->h);
+	kfree(im);
 }
 
 #if IP_HASHBITS == 8
@@ -315,7 +315,7 @@ static int ip_map_update(struct ip_map *
 				 hash_ip((unsigned long)ipm->m_addr.s_addr));
 	if (!ch)
 		return -ENOMEM;
-	ip_map_put(ch, &ip_map_cache);
+	cache_put(ch, &ip_map_cache);
 	return 0;
 }
 
@@ -369,7 +369,7 @@ struct auth_domain *auth_unix_lookup(str
 		rv = &ipm->m_client->h;
 		kref_get(&rv->ref);
 	}
-	ip_map_put(&ipm->h, &ip_map_cache);
+	cache_put(&ipm->h, &ip_map_cache);
 	return rv;
 }
 
@@ -403,7 +403,7 @@ svcauth_unix_set_client(struct svc_rqst 
 		case 0:
 			rqstp->rq_client = &ipm->m_client->h;
 			kref_get(&rqstp->rq_client->ref);
-			ip_map_put(&ipm->h, &ip_map_cache);
+			cache_put(&ipm->h, &ip_map_cache);
 			break;
 	}
 	return SVC_OK;
