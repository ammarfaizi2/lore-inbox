Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWCMVT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWCMVT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWCMVT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:19:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1807 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932319AbWCMVT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:19:27 -0500
Date: Mon, 13 Mar 2006 22:19:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no
Subject: [RFC: -mm patch] fs/nfsd/export.c,net/sunrpc/cache.c: make needlessly global code static
Message-ID: <20060313211926.GJ13973@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
>...
> +knfsd-change-the-store-of-auth_domains-to-not-be-a-cache.patch
> +knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix.patch
> +knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-2.patch
> +knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3.patch
> +knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3-fix.patch
> +knfsd-break-the-hard-linkage-from-svc_expkey-to-svc_export.patch
> +knfsd-get-rid-of-inplace-sunrpc-caches.patch
> +knfsd-create-cache_lookup-function-instead-of-using-a-macro-to-declare-one.patch
> +knfsd-convert-ip_map-cache-to-use-the-new-lookup-routine.patch
> +knfsd-use-new-cache_lookup-for-svc_export.patch
> +knfsd-use-new-cache_lookup-for-svc_expkey-cache.patch
> +knfsd-use-new-sunrpc-cache-for-rsi-cache.patch
> +knfsd-use-new-cache-code-for-rsc-cache.patch
> +knfsd-use-new-cache-code-for-name-id-lookup-caches.patch
> +knfsd-an-assortment-of-little-fixes-to-the-sunrpc-cache-code.patch
> +knfsd-remove-definecachelookup.patch
> +knfsd-unexport-cache_fresh-and-fix-a-small-race.patch
> +knfsd-convert-sunrpc_cache-to-use-krefs.patch
> +knfsd-convert-sunrpc_cache-to-use-krefs-fix.patch
> 
>  knfsd update
>...


We can now make some code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfsd/export.c             |   13 ++++++++-----
 include/linux/nfsd/export.h  |    5 +----
 include/linux/sunrpc/cache.h |    1 -
 net/sunrpc/cache.c           |    2 +-
 net/sunrpc/sunrpc_syms.c     |    1 -
 5 files changed, 10 insertions(+), 12 deletions(-)

--- linux-2.6.16-rc6-mm1-full/include/linux/nfsd/export.h.old	2006-03-13 21:18:50.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/include/linux/nfsd/export.h	2006-03-13 21:20:05.000000000 +0100
@@ -86,9 +86,6 @@
 void			nfsd_export_flush(void);
 void			exp_readlock(void);
 void			exp_readunlock(void);
-struct svc_expkey *	exp_find_key(struct auth_domain *clp, 
-				     int fsid_type, u32 *fsidv,
-				     struct cache_req *reqp);
 struct svc_export *	exp_get_by_name(struct auth_domain *clp,
 					struct vfsmount *mnt,
 					struct dentry *dentry,
@@ -102,7 +99,7 @@
 int			exp_pseudoroot(struct auth_domain *, struct svc_fh *fhp, struct cache_req *creq);
 int			nfserrno(int errno);
 
-extern struct cache_detail svc_export_cache, svc_expkey_cache;
+extern struct cache_detail svc_export_cache;
 
 static inline void exp_put(struct svc_export *exp)
 {
--- linux-2.6.16-rc6-mm1-full/fs/nfsd/export.c.old	2006-03-13 21:19:13.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/fs/nfsd/export.c	2006-03-13 21:25:02.000000000 +0100
@@ -57,7 +57,7 @@
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 static struct cache_head *expkey_table[EXPKEY_HASHMAX];
 
-void expkey_put(struct kref *ref)
+static void expkey_put(struct kref *ref)
 {
 	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
@@ -87,6 +87,8 @@
 
 static struct svc_expkey *svc_expkey_update(struct svc_expkey *new, struct svc_expkey *old);
 static struct svc_expkey *svc_expkey_lookup(struct svc_expkey *);
+static struct cache_detail svc_expkey_cache;
+
 static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
 	/* client fsidtype fsid [path] */
@@ -255,7 +257,7 @@
 		return NULL;
 }
 
-struct cache_detail svc_expkey_cache = {
+static struct cache_detail svc_expkey_cache = {
 	.owner		= THIS_MODULE,
 	.hash_size	= EXPKEY_HASHMAX,
 	.hash_table	= expkey_table,
@@ -345,7 +347,8 @@
 	(*bpp)[-1] = '\n';
 }
 
-struct svc_export *svc_export_update(struct svc_export *new, struct svc_export *old);
+static struct svc_export *svc_export_update(struct svc_export *new,
+					    struct svc_export *old);
 static struct svc_export *svc_export_lookup(struct svc_export *);
 
 static int check_export(struct inode *inode, int flags)
@@ -574,7 +577,7 @@
 		return NULL;
 }
 
-struct svc_export *
+static struct svc_export *
 svc_export_update(struct svc_export *new, struct svc_export *old)
 {
 	struct cache_head *ch;
@@ -593,7 +596,7 @@
 }
 
 
-struct svc_expkey *
+static struct svc_expkey *
 exp_find_key(svc_client *clp, int fsid_type, u32 *fsidv, struct cache_req *reqp)
 {
 	struct svc_expkey key, *ek;
--- linux-2.6.16-rc6-mm1-full/include/linux/sunrpc/cache.h.old	2006-03-13 21:26:34.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/include/linux/sunrpc/cache.h	2006-03-13 21:26:40.000000000 +0100
@@ -163,7 +163,6 @@
 	kref_put(&h->ref, cd->cache_put);
 }
 
-extern void cache_init(struct cache_head *h);
 extern int cache_check(struct cache_detail *detail,
 		       struct cache_head *h, struct cache_req *rqstp);
 extern void cache_flush(void);
--- linux-2.6.16-rc6-mm1-full/net/sunrpc/cache.c.old	2006-03-13 21:26:55.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/net/sunrpc/cache.c	2006-03-13 21:27:01.000000000 +0100
@@ -37,7 +37,7 @@
 static void cache_defer_req(struct cache_req *req, struct cache_head *item);
 static void cache_revisit_request(struct cache_head *item);
 
-void cache_init(struct cache_head *h)
+static void cache_init(struct cache_head *h)
 {
 	time_t now = get_seconds();
 	h->next = NULL;
--- linux-2.6.16-rc6-mm1-full/net/sunrpc/sunrpc_syms.c.old	2006-03-13 21:27:10.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/net/sunrpc/sunrpc_syms.c	2006-03-13 21:27:13.000000000 +0100
@@ -105,7 +105,6 @@
 EXPORT_SYMBOL(cache_check);
 EXPORT_SYMBOL(cache_flush);
 EXPORT_SYMBOL(cache_purge);
-EXPORT_SYMBOL(cache_init);
 EXPORT_SYMBOL(cache_register);
 EXPORT_SYMBOL(cache_unregister);
 EXPORT_SYMBOL(qword_add);

