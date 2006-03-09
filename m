Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWCIGwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWCIGwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWCIGwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:52:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:40163 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750948AbWCIGwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:31 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:27 +1100
Message-Id: <1060309065127.24521@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 14] knfsd: Change the store of auth_domains to not be a 'cache'.
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 'auth_domain's are simply handles on internal data structures.
They do not cache information from user-space, and forcing them
into the mold of a 'cache' misrepresents their true nature and causes confusion.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c                  |    5 +-
 ./include/linux/sunrpc/svcauth.h    |   10 +++--
 ./net/sunrpc/auth_gss/svcauth_gss.c |   14 +++----
 ./net/sunrpc/svcauth_unix.c         |   66 ++++++++++++++++--------------------
 4 files changed, 46 insertions(+), 49 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./fs/nfsd/export.c	2006-03-09 17:13:01.000000000 +1100
@@ -242,7 +242,7 @@ static inline int svc_expkey_match (stru
 
 static inline void svc_expkey_init(struct svc_expkey *new, struct svc_expkey *item)
 {
-	cache_get(&item->ek_client->h);
+	kref_get(&item->ek_client->ref);
 	new->ek_client = item->ek_client;
 	new->ek_fsidtype = item->ek_fsidtype;
 	new->ek_fsid[0] = item->ek_fsid[0];
@@ -474,7 +474,7 @@ static inline int svc_export_match(struc
 }
 static inline void svc_export_init(struct svc_export *new, struct svc_export *item)
 {
-	cache_get(&item->ex_client->h);
+	kref_get(&item->ex_client->ref);
 	new->ex_client = item->ex_client;
 	new->ex_dentry = dget(item->ex_dentry);
 	new->ex_mnt = mntget(item->ex_mnt);
@@ -1129,7 +1129,6 @@ exp_delclient(struct nfsctl_client *ncp)
 	 */
 	if (dom) {
 		err = auth_unix_forget_old(dom);
-		dom->h.expiry_time = get_seconds();
 		auth_domain_put(dom);
 	}
 

diff ./include/linux/sunrpc/svcauth.h~current~ ./include/linux/sunrpc/svcauth.h
--- ./include/linux/sunrpc/svcauth.h~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./include/linux/sunrpc/svcauth.h	2006-03-09 17:13:01.000000000 +1100
@@ -45,9 +45,10 @@ struct svc_rqst;		/* forward decl */
  * of ip addresses to the given client.
  */
 struct auth_domain {
-	struct	cache_head	h;
+	struct kref		ref;
+	struct hlist_node	hash;
 	char			*name;
-	int			flavour;
+	struct auth_ops		*flavour;
 };
 
 /*
@@ -86,6 +87,9 @@ struct auth_domain {
  *
  * domain_release()
  *   This call releases a domain.
+ * set_client()
+ *   Givens a pending request (struct svc_rqst), finds and assigns
+ *   an appropriate 'auth_domain' as the client.
  */
 struct auth_ops {
 	char *	name;
@@ -117,7 +121,7 @@ extern void	svc_auth_unregister(rpc_auth
 extern struct auth_domain *unix_domain_find(char *name);
 extern void auth_domain_put(struct auth_domain *item);
 extern int auth_unix_add_addr(struct in_addr addr, struct auth_domain *dom);
-extern struct auth_domain *auth_domain_lookup(struct auth_domain *item, int set);
+extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
 extern struct auth_domain *auth_domain_find(char *name);
 extern struct auth_domain *auth_unix_lookup(struct in_addr addr);
 extern int auth_unix_forget_old(struct auth_domain *dom);

diff ./net/sunrpc/auth_gss/svcauth_gss.c~current~ ./net/sunrpc/auth_gss/svcauth_gss.c
--- ./net/sunrpc/auth_gss/svcauth_gss.c~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-03-09 17:13:54.000000000 +1100
@@ -645,6 +645,8 @@ find_gss_auth_domain(struct gss_ctx *ctx
 	return auth_domain_find(name);
 }
 
+static struct auth_ops svcauthops_gss;
+
 int
 svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
 {
@@ -655,20 +657,18 @@ svcauth_gss_register_pseudoflavor(u32 ps
 	new = kmalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
 		goto out;
-	cache_init(&new->h.h);
+	kref_init(&new->h.ref);
 	new->h.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
 	if (!new->h.name)
 		goto out_free_dom;
 	strcpy(new->h.name, name);
-	new->h.flavour = RPC_AUTH_GSS;
+	new->h.flavour = &svcauthops_gss;
 	new->pseudoflavor = pseudoflavor;
-	new->h.h.expiry_time = NEVER;
 
-	test = auth_domain_lookup(&new->h, 1);
-	if (test == &new->h) {
-		BUG_ON(atomic_dec_and_test(&new->h.h.refcnt));
-	} else { /* XXX Duplicate registration? */
+	test = auth_domain_lookup(name, &new->h);
+	if (test != &new->h) { /* XXX Duplicate registration? */
 		auth_domain_put(&new->h);
+		/* dangling ref-count... */
 		goto out;
 	}
 	return 0;

diff ./net/sunrpc/svcauth_unix.c~current~ ./net/sunrpc/svcauth_unix.c
--- ./net/sunrpc/svcauth_unix.c~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-03-09 17:13:01.000000000 +1100
@@ -27,41 +27,35 @@ struct unix_domain {
 	/* other stuff later */
 };
 
+extern struct auth_ops svcauth_unix;
+
 struct auth_domain *unix_domain_find(char *name)
 {
-	struct auth_domain *rv, ud;
-	struct unix_domain *new;
-
-	ud.name = name;
-	
-	rv = auth_domain_lookup(&ud, 0);
-
- foundit:
-	if (rv && rv->flavour != RPC_AUTH_UNIX) {
-		auth_domain_put(rv);
-		return NULL;
-	}
-	if (rv)
-		return rv;
+	struct auth_domain *rv;
+	struct unix_domain *new = NULL;
 
-	new = kmalloc(sizeof(*new), GFP_KERNEL);
-	if (new == NULL)
-		return NULL;
-	cache_init(&new->h.h);
-	new->h.name = kstrdup(name, GFP_KERNEL);
-	new->h.flavour = RPC_AUTH_UNIX;
-	new->addr_changes = 0;
-	new->h.h.expiry_time = NEVER;
-
-	rv = auth_domain_lookup(&new->h, 2);
-	if (rv == &new->h) {
-		if (atomic_dec_and_test(&new->h.h.refcnt)) BUG();
-	} else {
-		auth_domain_put(&new->h);
-		goto foundit;
+	rv = auth_domain_lookup(name, NULL);
+	while(1) {
+		if (rv != &new->h) {
+			if (new) auth_domain_put(&new->h);
+			return rv;
+		}
+		if (rv && rv->flavour != &svcauth_unix) {
+			auth_domain_put(rv);
+			return NULL;
+		}
+		if (rv)
+			return rv;
+
+		new = kmalloc(sizeof(*new), GFP_KERNEL);
+		if (new == NULL)
+			return NULL;
+		kref_init(&new->h.ref);
+		new->h.name = kstrdup(name, GFP_KERNEL);
+		new->h.flavour = &svcauth_unix;
+		new->addr_changes = 0;
+		rv = auth_domain_lookup(name, &new->h);
 	}
-
-	return rv;
 }
 
 static void svcauth_unix_domain_release(struct auth_domain *dom)
@@ -130,7 +124,7 @@ static inline void ip_map_init(struct ip
 }
 static inline void ip_map_update(struct ip_map *new, struct ip_map *item)
 {
-	cache_get(&item->m_client->h.h);
+	kref_get(&item->m_client->h.ref);
 	new->m_client = item->m_client;
 	new->m_add_change = item->m_add_change;
 }
@@ -272,7 +266,7 @@ int auth_unix_add_addr(struct in_addr ad
 	struct unix_domain *udom;
 	struct ip_map ip, *ipmp;
 
-	if (dom->flavour != RPC_AUTH_UNIX)
+	if (dom->flavour != &svcauth_unix)
 		return -EINVAL;
 	udom = container_of(dom, struct unix_domain, h);
 	strcpy(ip.m_class, "nfsd");
@@ -295,7 +289,7 @@ int auth_unix_forget_old(struct auth_dom
 {
 	struct unix_domain *udom;
 	
-	if (dom->flavour != RPC_AUTH_UNIX)
+	if (dom->flavour != &svcauth_unix)
 		return -EINVAL;
 	udom = container_of(dom, struct unix_domain, h);
 	udom->addr_changes++;
@@ -323,7 +317,7 @@ struct auth_domain *auth_unix_lookup(str
 		rv = NULL;
 	} else {
 		rv = &ipm->m_client->h;
-		cache_get(&rv->h);
+		kref_get(&rv->ref);
 	}
 	ip_map_put(&ipm->h, &ip_map_cache);
 	return rv;
@@ -361,7 +355,7 @@ svcauth_unix_set_client(struct svc_rqst 
 			return SVC_DENIED;
 		case 0:
 			rqstp->rq_client = &ipm->m_client->h;
-			cache_get(&rqstp->rq_client->h);
+			kref_get(&rqstp->rq_client->ref);
 			ip_map_put(&ipm->h, &ip_map_cache);
 			break;
 	}
