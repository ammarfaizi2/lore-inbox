Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWCIGw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWCIGw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCIGwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:52:45 -0500
Received: from mail.suse.de ([195.135.220.2]:55984 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751666AbWCIGwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:41 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:37 +1100
Message-Id: <1060309065137.24545@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 14] knfsd: Get rid of 'inplace' sunrpc caches
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These were an unnecessary wart.
Also only have one 'DefineSimpleCache..' instead of two.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c                  |    4 ++--
 ./fs/nfsd/nfs4idmap.c               |   10 ++--------
 ./include/linux/sunrpc/cache.h      |   28 +++++++++++-----------------
 ./net/sunrpc/auth_gss/svcauth_gss.c |    4 ++--
 ./net/sunrpc/svcauth_unix.c         |    2 +-
 5 files changed, 18 insertions(+), 30 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-03-09 17:15:13.000000000 +1100
+++ ./fs/nfsd/export.c	2006-03-09 17:15:13.000000000 +1100
@@ -250,7 +250,7 @@ static inline void svc_expkey_update(str
 	new->ek_dentry = dget(item->ek_dentry);
 }
 
-static DefineSimpleCacheLookup(svc_expkey,0) /* no inplace updates */
+static DefineSimpleCacheLookup(svc_expkey, svc_expkey)
 
 #define	EXPORT_HASHBITS		8
 #define	EXPORT_HASHMAX		(1<< EXPORT_HASHBITS)
@@ -482,7 +482,7 @@ static inline void svc_export_update(str
 	new->ex_fsid = item->ex_fsid;
 }
 
-static DefineSimpleCacheLookup(svc_export,1) /* allow inplace updates */
+static DefineSimpleCacheLookup(svc_export, svc_export)
 
 
 struct svc_expkey *

diff ./fs/nfsd/nfs4idmap.c~current~ ./fs/nfsd/nfs4idmap.c
--- ./fs/nfsd/nfs4idmap.c~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./fs/nfsd/nfs4idmap.c	2006-03-09 17:15:13.000000000 +1100
@@ -76,12 +76,6 @@ struct ent {
 	char              authname[IDMAP_NAMESZ];
 };
 
-#define DefineSimpleCacheLookupMap(STRUCT, FUNC)			\
-        DefineCacheLookup(struct STRUCT, h, FUNC##_lookup,		\
-        (struct STRUCT *item, int set), /*no setup */,			\
-	& FUNC##_cache, FUNC##_hash(item), FUNC##_match(item, tmp),	\
-	STRUCT##_init(new, item), STRUCT##_update(tmp, item), 0)
-
 /* Common entry handling */
 
 #define ENT_HASHBITS          8
@@ -264,7 +258,7 @@ out:
 	return error;
 }
 
-static DefineSimpleCacheLookupMap(ent, idtoname);
+static DefineSimpleCacheLookup(ent, idtoname);
 
 /*
  * Name -> ID cache
@@ -390,7 +384,7 @@ out:
 	return (error);
 }
 
-static DefineSimpleCacheLookupMap(ent, nametoid);
+static DefineSimpleCacheLookup(ent, nametoid);
 
 /*
  * Exported API

diff ./include/linux/sunrpc/cache.h~current~ ./include/linux/sunrpc/cache.h
--- ./include/linux/sunrpc/cache.h~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./include/linux/sunrpc/cache.h	2006-03-09 17:15:13.000000000 +1100
@@ -133,14 +133,11 @@ struct cache_deferred_req {
  * If "set" == 0 :
  *    If an entry is found, it is returned
  *    If no entry is found, a new non-VALID entry is created.
- * If "set" == 1 and INPLACE == 0 :
+ * If "set" == 1 :
  *    If no entry is found a new one is inserted with data from "template"
  *    If a non-CACHE_VALID entry is found, it is updated from template using UPDATE
  *    If a CACHE_VALID entry is found, a new entry is swapped in with data
  *       from "template"
- * If set == 1, and INPLACE == 1 :
- *    As above, except that if a CACHE_VALID entry is found, we UPDATE in place
- *       instead of swapping in a new entry.
  *
  * If the passed handle has the CACHE_NEGATIVE flag set, then UPDATE is not
  * run but insteead CACHE_NEGATIVE is set in any new item.
@@ -159,13 +156,8 @@ struct cache_deferred_req {
  * TEST  tests if "tmp" matches "item"
  * INIT copies key information from "item" to "new"
  * UPDATE copies content information from "item" to "tmp"
- * INPLACE is true if updates can happen inplace rather than allocating a new structure
- *
- * WARNING: any substantial changes to this must be reflected in
- *   net/sunrpc/svcauth.c(auth_domain_lookup)
- *  which is a similar routine that is open-coded.
  */
-#define DefineCacheLookup(RTN,MEMBER,FNAME,ARGS,SETUP,DETAIL,HASHFN,TEST,INIT,UPDATE,INPLACE)	\
+#define DefineCacheLookup(RTN,MEMBER,FNAME,ARGS,SETUP,DETAIL,HASHFN,TEST,INIT,UPDATE)	\
 RTN *FNAME ARGS										\
 {											\
 	RTN *tmp, *new=NULL;								\
@@ -179,13 +171,13 @@ RTN *FNAME ARGS										\
 		tmp = container_of(*hp, RTN, MEMBER);					\
 		if (TEST) { /* found a match */						\
 											\
-			if (set && !INPLACE && test_bit(CACHE_VALID, &tmp->MEMBER.flags) && !new) \
+			if (set && test_bit(CACHE_VALID, &tmp->MEMBER.flags) && !new)	\
 				break;							\
 											\
 			if (new)							\
 				{INIT;}							\
 			if (set) {							\
-				if (!INPLACE && test_bit(CACHE_VALID, &tmp->MEMBER.flags))\
+				if (test_bit(CACHE_VALID, &tmp->MEMBER.flags))\
 				{ /* need to swap in new */				\
 					RTN *t2;					\
 											\
@@ -206,7 +198,7 @@ RTN *FNAME ARGS										\
 			else read_unlock(&(DETAIL)->hash_lock);				\
 			if (set)							\
 				cache_fresh(DETAIL, &tmp->MEMBER, item->MEMBER.expiry_time); \
-			if (set && !INPLACE && new) cache_fresh(DETAIL, &new->MEMBER, 0);	\
+			if (set && new) cache_fresh(DETAIL, &new->MEMBER, 0);	\
 			if (new) (DETAIL)->cache_put(&new->MEMBER, DETAIL);		\
 			return tmp;							\
 		}									\
@@ -239,10 +231,12 @@ RTN *FNAME ARGS										\
 	return NULL;									\
 }
 
-#define DefineSimpleCacheLookup(STRUCT,INPLACE)	\
-	DefineCacheLookup(struct STRUCT, h, STRUCT##_lookup, (struct STRUCT *item, int set), /*no setup */,	\
-			  & STRUCT##_cache, STRUCT##_hash(item), STRUCT##_match(item, tmp),\
-			  STRUCT##_init(new, item), STRUCT##_update(tmp, item),INPLACE)
+#define DefineSimpleCacheLookup(STRUCT, FUNC)				\
+        DefineCacheLookup(struct STRUCT, h, FUNC##_lookup,		\
+        (struct STRUCT *item, int set), /*no setup */,			\
+	& FUNC##_cache, FUNC##_hash(item), FUNC##_match(item, tmp),	\
+	STRUCT##_init(new, item), STRUCT##_update(tmp, item))
+
 
 #define cache_for_each(pos, detail, index, member) 						\
 	for (({read_lock(&(detail)->hash_lock); index = (detail)->hash_size;}) ;		\

diff ./net/sunrpc/auth_gss/svcauth_gss.c~current~ ./net/sunrpc/auth_gss/svcauth_gss.c
--- ./net/sunrpc/auth_gss/svcauth_gss.c~current~	2006-03-09 17:13:54.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-03-09 17:15:13.000000000 +1100
@@ -259,7 +259,7 @@ static struct cache_detail rsi_cache = {
 	.cache_parse    = rsi_parse,
 };
 
-static DefineSimpleCacheLookup(rsi, 0)
+static DefineSimpleCacheLookup(rsi, rsi)
 
 /*
  * The rpcsec_context cache is used to store a context that is
@@ -446,7 +446,7 @@ static struct cache_detail rsc_cache = {
 	.cache_parse	= rsc_parse,
 };
 
-static DefineSimpleCacheLookup(rsc, 0);
+static DefineSimpleCacheLookup(rsc, rsc);
 
 static struct rsc *
 gss_svc_searchbyctx(struct xdr_netobj *handle)

diff ./net/sunrpc/svcauth_unix.c~current~ ./net/sunrpc/svcauth_unix.c
--- ./net/sunrpc/svcauth_unix.c~current~	2006-03-09 17:13:01.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-03-09 17:15:13.000000000 +1100
@@ -258,7 +258,7 @@ struct cache_detail ip_map_cache = {
 	.cache_show	= ip_map_show,
 };
 
-static DefineSimpleCacheLookup(ip_map, 0)
+static DefineSimpleCacheLookup(ip_map, ip_map)
 
 
 int auth_unix_add_addr(struct in_addr addr, struct auth_domain *dom)
