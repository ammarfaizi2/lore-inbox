Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUHaTEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUHaTEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUHaTEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:04:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:61582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268812AbUHaTEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:04:25 -0400
Date: Tue, 31 Aug 2004 12:02:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: PROBLEM: page allocation or what in 2.6.8.1
Message-Id: <20040831120232.18dfa3c0.akpm@osdl.org>
In-Reply-To: <200408311636.i7VGaBWT004636@moist.atmos.washington.edu>
References: <20040826033131.2cc153a9.akpm@osdl.org>
	<200408311636.i7VGaBWT004636@moist.atmos.washington.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harry Edmon <harry@atmos.washington.edu> wrote:
>
> We believe the hardware is okay.  We have run numerous memtests, all okay.  This
>  is a Tyan S2721-533 with dual 3.06 Xeons.
> 
>  We tried taking out CONFIG_DEBUG_PAGEALLOC and still we get crashes, especially
>  in nfsd.  We have now gone to the 2.6.8.1-mm4 kernel and got the following
>  crash:
> 
>  kfree_debugcheck: bad ptr f8c189fch.

ip_map_put() is doing kfree(garbage).  That should be fixed by the below,
which was merged subsequent to 2.6.8.1.


diff -puN net/sunrpc/svcauth_unix.c~use-fixed-size-buffer-instead-of-kmalloc-for-m_class-in-ip_map net/sunrpc/svcauth_unix.c
--- 25/net/sunrpc/svcauth_unix.c~use-fixed-size-buffer-instead-of-kmalloc-for-m_class-in-ip_map	2004-08-26 23:30:29.000000000 -0700
+++ 25-akpm/net/sunrpc/svcauth_unix.c	2004-08-26 23:30:29.061446776 -0700
@@ -90,7 +90,7 @@ static void svcauth_unix_domain_release(
 
 struct ip_map {
 	struct cache_head	h;
-	char			*m_class; /* e.g. "nfsd" */
+	char			m_class[8]; /* e.g. "nfsd" */
 	struct in_addr		m_addr;
 	struct unix_domain	*m_client;
 	int			m_add_change;
@@ -104,7 +104,6 @@ void ip_map_put(struct cache_head *item,
 		if (test_bit(CACHE_VALID, &item->flags) &&
 		    !test_bit(CACHE_NEGATIVE, &item->flags))
 			auth_domain_put(&im->m_client->h);
-		kfree(im->m_class);
 		kfree(im);
 	}
 }
@@ -121,8 +120,7 @@ static inline int ip_map_match(struct ip
 }
 static inline void ip_map_init(struct ip_map *new, struct ip_map *item)
 {
-	new->m_class = item->m_class;
-	item->m_class = NULL;
+	strcpy(new->m_class, item->m_class);
 	new->m_addr.s_addr = item->m_addr.s_addr;
 }
 static inline void ip_map_update(struct ip_map *new, struct ip_map *item)
@@ -171,6 +169,8 @@ static int ip_map_parse(struct cache_det
 	/* class */
 	len = qword_get(&mesg, class, 50);
 	if (len <= 0) return -EINVAL;
+	if (len >= sizeof(ipm.m_class))
+		return -EINVAL;
 
 	/* ip address */
 	len = qword_get(&mesg, buf, 50);
@@ -194,9 +194,7 @@ static int ip_map_parse(struct cache_det
 	} else
 		dom = NULL;
 
-	ipm.m_class = strdup(class);
-	if (ipm.m_class == NULL)
-		return -ENOMEM;
+	strcpy(ipm.m_class, class);
 	ipm.m_addr.s_addr =
 		htonl((((((b1<<8)|b2)<<8)|b3)<<8)|b4);
 	ipm.h.flags = 0;
@@ -212,7 +210,6 @@ static int ip_map_parse(struct cache_det
 		ip_map_put(&ipmp->h, &ip_map_cache);
 	if (dom)
 		auth_domain_put(dom);
-	if (ipm.m_class) kfree(ipm.m_class);
 	if (!ipmp)
 		return -ENOMEM;
 	cache_flush();
@@ -272,9 +269,7 @@ int auth_unix_add_addr(struct in_addr ad
 	if (dom->flavour != RPC_AUTH_UNIX)
 		return -EINVAL;
 	udom = container_of(dom, struct unix_domain, h);
-	ip.m_class = strdup("nfsd");
-	if (!ip.m_class)
-		return -ENOMEM;
+	strcpy(ip.m_class, "nfsd");
 	ip.m_addr = addr;
 	ip.m_client = udom;
 	ip.m_add_change = udom->addr_changes+1;
@@ -282,7 +277,7 @@ int auth_unix_add_addr(struct in_addr ad
 	ip.h.expiry_time = NEVER;
 	
 	ipmp = ip_map_lookup(&ip, 1);
-	if (ip.m_class) kfree(ip.m_class);
+
 	if (ipmp) {
 		ip_map_put(&ipmp->h, &ip_map_cache);
 		return 0;
@@ -306,7 +301,7 @@ struct auth_domain *auth_unix_lookup(str
 	struct ip_map key, *ipm;
 	struct auth_domain *rv;
 
-	key.m_class = "nfsd";
+	strcpy(key.m_class, "nfsd");
 	key.m_addr = addr;
 
 	ipm = ip_map_lookup(&key, 0);
@@ -368,7 +363,7 @@ svcauth_null_accept(struct svc_rqst *rqs
 	svc_putu32(resv, RPC_AUTH_NULL);
 	svc_putu32(resv, 0);
 
-	key.m_class = rqstp->rq_server->sv_program->pg_class;
+	strcpy(key.m_class, rqstp->rq_server->sv_program->pg_class);
 	key.m_addr = rqstp->rq_addr.sin_addr;
 
 	ipm = ip_map_lookup(&key, 0);
@@ -464,7 +459,7 @@ svcauth_unix_accept(struct svc_rqst *rqs
 	}
 
 
-	key.m_class = rqstp->rq_server->sv_program->pg_class;
+	strcpy(key.m_class, rqstp->rq_server->sv_program->pg_class);
 	key.m_addr = rqstp->rq_addr.sin_addr;
 
 
_

