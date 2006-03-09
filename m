Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWCIGz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWCIGz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWCIGxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:44259 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751668AbWCIGwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:51 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:48 +1100
Message-Id: <1060309065148.24569@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 14] knfsd: Convert ip_map cache to use the new lookup routine.
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcauth_unix.c |  143 +++++++++++++++++++++++++++++---------------
 1 file changed, 95 insertions(+), 48 deletions(-)

diff ./net/sunrpc/svcauth_unix.c~current~ ./net/sunrpc/svcauth_unix.c
--- ./net/sunrpc/svcauth_unix.c~current~	2006-03-09 17:15:13.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-03-09 17:15:14.000000000 +1100
@@ -106,28 +106,38 @@ static inline int hash_ip(unsigned long 
 	return (hash ^ (hash>>8)) & 0xff;
 }
 #endif
-
-static inline int ip_map_hash(struct ip_map *item)
-{
-	return hash_str(item->m_class, IP_HASHBITS) ^ 
-		hash_ip((unsigned long)item->m_addr.s_addr);
-}
-static inline int ip_map_match(struct ip_map *item, struct ip_map *tmp)
+static int ip_map_match(struct cache_head *corig, struct cache_head *cnew)
 {
-	return strcmp(tmp->m_class, item->m_class) == 0
-		&& tmp->m_addr.s_addr == item->m_addr.s_addr;
+	struct ip_map *orig = container_of(corig, struct ip_map, h);
+	struct ip_map *new = container_of(cnew, struct ip_map, h);
+	return strcmp(orig->m_class, new->m_class) == 0
+		&& orig->m_addr.s_addr == new->m_addr.s_addr;
 }
-static inline void ip_map_init(struct ip_map *new, struct ip_map *item)
+static void ip_map_init(struct cache_head *cnew, struct cache_head *citem)
 {
+	struct ip_map *new = container_of(cnew, struct ip_map, h);
+	struct ip_map *item = container_of(citem, struct ip_map, h);
+
 	strcpy(new->m_class, item->m_class);
 	new->m_addr.s_addr = item->m_addr.s_addr;
 }
-static inline void ip_map_update(struct ip_map *new, struct ip_map *item)
+static void update(struct cache_head *cnew, struct cache_head *citem)
 {
+	struct ip_map *new = container_of(cnew, struct ip_map, h);
+	struct ip_map *item = container_of(citem, struct ip_map, h);
+
 	kref_get(&item->m_client->h.ref);
 	new->m_client = item->m_client;
 	new->m_add_change = item->m_add_change;
 }
+static struct cache_head *ip_map_alloc(void)
+{
+	struct ip_map *i = kmalloc(sizeof(*i), GFP_KERNEL);
+	if (i)
+		return &i->h;
+	else
+		return NULL;
+}
 
 static void ip_map_request(struct cache_detail *cd,
 				  struct cache_head *h,
@@ -148,7 +158,8 @@ static void ip_map_request(struct cache_
 	(*bpp)[-1] = '\n';
 }
 
-static struct ip_map *ip_map_lookup(struct ip_map *, int);
+static struct ip_map *ip_map_lookup(char *class, struct in_addr addr);
+static int ip_map_update(struct ip_map *ipm, struct unix_domain *udom, time_t expiry);
 
 static int ip_map_parse(struct cache_detail *cd,
 			  char *mesg, int mlen)
@@ -160,7 +171,11 @@ static int ip_map_parse(struct cache_det
 	int len;
 	int b1,b2,b3,b4;
 	char c;
-	struct ip_map ipm, *ipmp;
+	char class[8];
+	struct in_addr addr;
+	int err;
+
+	struct ip_map *ipmp;
 	struct auth_domain *dom;
 	time_t expiry;
 
@@ -169,7 +184,7 @@ static int ip_map_parse(struct cache_det
 	mesg[mlen-1] = 0;
 
 	/* class */
-	len = qword_get(&mesg, ipm.m_class, sizeof(ipm.m_class));
+	len = qword_get(&mesg, class, sizeof(class));
 	if (len <= 0) return -EINVAL;
 
 	/* ip address */
@@ -194,25 +209,22 @@ static int ip_map_parse(struct cache_det
 	} else
 		dom = NULL;
 
-	ipm.m_addr.s_addr =
+	addr.s_addr =
 		htonl((((((b1<<8)|b2)<<8)|b3)<<8)|b4);
-	ipm.h.flags = 0;
-	if (dom) {
-		ipm.m_client = container_of(dom, struct unix_domain, h);
-		ipm.m_add_change = ipm.m_client->addr_changes;
+
+	ipmp = ip_map_lookup(class,addr);
+	if (ipmp) {
+		err = ip_map_update(ipmp,
+			     container_of(dom, struct unix_domain, h),
+			     expiry);
 	} else
-		set_bit(CACHE_NEGATIVE, &ipm.h.flags);
-	ipm.h.expiry_time = expiry;
+		err = -ENOMEM;
 
-	ipmp = ip_map_lookup(&ipm, 1);
-	if (ipmp)
-		ip_map_put(&ipmp->h, &ip_map_cache);
 	if (dom)
 		auth_domain_put(dom);
-	if (!ipmp)
-		return -ENOMEM;
+
 	cache_flush();
-	return 0;
+	return err;
 }
 
 static int ip_map_show(struct seq_file *m,
@@ -256,32 +268,70 @@ struct cache_detail ip_map_cache = {
 	.cache_request	= ip_map_request,
 	.cache_parse	= ip_map_parse,
 	.cache_show	= ip_map_show,
+	.match		= ip_map_match,
+	.init		= ip_map_init,
+	.update		= update,
+	.alloc		= ip_map_alloc,
 };
 
-static DefineSimpleCacheLookup(ip_map, ip_map)
+static struct ip_map *ip_map_lookup(char *class, struct in_addr addr)
+{
+	struct ip_map ip;
+	struct cache_head *ch;
 
+	strcpy(ip.m_class, class);
+	ip.m_addr = addr;
+	ch = sunrpc_cache_lookup(&ip_map_cache, &ip.h,
+				 hash_str(class, IP_HASHBITS) ^
+				 hash_ip((unsigned long)addr.s_addr));
+
+	if (ch)
+		return container_of(ch, struct ip_map, h);
+	else
+		return NULL;
+}
+
+static int ip_map_update(struct ip_map *ipm, struct unix_domain *udom, time_t expiry)
+{
+	struct ip_map ip;
+	struct cache_head *ch;
+
+	ip.m_client = udom;
+	ip.h.flags = 0;
+	if (!udom)
+		set_bit(CACHE_NEGATIVE, &ip.h.flags);
+	else {
+		ip.m_add_change = udom->addr_changes;
+		/* if this is from the legacy set_client system call,
+		 * we need m_add_change to be one higher
+		 */
+		if (expiry == NEVER)
+			ip.m_add_change++;
+	}
+	ip.h.expiry_time = expiry;
+	ch = sunrpc_cache_update(&ip_map_cache,
+				 &ip.h, &ipm->h,
+				 hash_str(ipm->m_class, IP_HASHBITS) ^
+				 hash_ip((unsigned long)ipm->m_addr.s_addr));
+	if (!ch)
+		return -ENOMEM;
+	ip_map_put(ch, &ip_map_cache);
+	return 0;
+}
 
 int auth_unix_add_addr(struct in_addr addr, struct auth_domain *dom)
 {
 	struct unix_domain *udom;
-	struct ip_map ip, *ipmp;
+	struct ip_map *ipmp;
 
 	if (dom->flavour != &svcauth_unix)
 		return -EINVAL;
 	udom = container_of(dom, struct unix_domain, h);
-	strcpy(ip.m_class, "nfsd");
-	ip.m_addr = addr;
-	ip.m_client = udom;
-	ip.m_add_change = udom->addr_changes+1;
-	ip.h.flags = 0;
-	ip.h.expiry_time = NEVER;
-	
-	ipmp = ip_map_lookup(&ip, 1);
+	ipmp = ip_map_lookup("nfsd", addr);
 
-	if (ipmp) {
-		ip_map_put(&ipmp->h, &ip_map_cache);
-		return 0;
-	} else
+	if (ipmp)
+		return ip_map_update(ipmp, udom, NEVER);
+	else
 		return -ENOMEM;
 }
 
@@ -304,7 +354,7 @@ struct auth_domain *auth_unix_lookup(str
 	strcpy(key.m_class, "nfsd");
 	key.m_addr = addr;
 
-	ipm = ip_map_lookup(&key, 0);
+	ipm = ip_map_lookup("nfsd", addr);
 
 	if (!ipm)
 		return NULL;
@@ -326,22 +376,19 @@ struct auth_domain *auth_unix_lookup(str
 void svcauth_unix_purge(void)
 {
 	cache_purge(&ip_map_cache);
-	cache_purge(&auth_domain_cache);
 }
 
 static int
 svcauth_unix_set_client(struct svc_rqst *rqstp)
 {
-	struct ip_map key, *ipm;
+	struct ip_map *ipm;
 
 	rqstp->rq_client = NULL;
 	if (rqstp->rq_proc == 0)
 		return SVC_OK;
 
-	strcpy(key.m_class, rqstp->rq_server->sv_program->pg_class);
-	key.m_addr = rqstp->rq_addr.sin_addr;
-
-	ipm = ip_map_lookup(&key, 0);
+	ipm = ip_map_lookup(rqstp->rq_server->sv_program->pg_class,
+			    rqstp->rq_addr.sin_addr);
 
 	if (ipm == NULL)
 		return SVC_DENIED;
