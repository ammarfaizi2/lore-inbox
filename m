Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933897AbWKTCZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933897AbWKTCZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933878AbWKTCY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47377 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933874AbWKTCYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:21 -0500
Date: Mon, 20 Nov 2006 03:24:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/lockd/host.c: make 2 functions static
Message-ID: <20061120022420.GP31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following needlessly global functions static:
- nlm_lookup_host()
- nsm_find()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/lockd/host.c             |   53 +++++++++++++++++++-----------------
 include/linux/lockd/lockd.h |    2 -
 2 files changed, 28 insertions(+), 27 deletions(-)

--- linux-2.6.19-rc5-mm2/include/linux/lockd/lockd.h.old	2006-11-20 02:01:44.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/lockd/lockd.h	2006-11-20 01:55:53.000000000 +0100
@@ -164,14 +164,12 @@
  */
 struct nlm_host * nlmclnt_lookup_host(const struct sockaddr_in *, int, int, const char *, int);
 struct nlm_host * nlmsvc_lookup_host(struct svc_rqst *, const char *, int);
-struct nlm_host * nlm_lookup_host(int server, const struct sockaddr_in *, int, int, const char *, int);
 struct rpc_clnt * nlm_bind_host(struct nlm_host *);
 void		  nlm_rebind_host(struct nlm_host *);
 struct nlm_host * nlm_get_host(struct nlm_host *);
 void		  nlm_release_host(struct nlm_host *);
 void		  nlm_shutdown_hosts(void);
 extern void	  nlm_host_rebooted(const struct sockaddr_in *, const char *, int, u32);
-struct nsm_handle *nsm_find(const struct sockaddr_in *, const char *, int);
 void		  nsm_release(struct nsm_handle *);
 
 
--- linux-2.6.19-rc5-mm2/fs/lockd/host.c.old	2006-11-20 01:56:05.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/lockd/host.c	2006-11-20 01:58:26.000000000 +0100
@@ -36,34 +36,14 @@
 static void			nlm_gc_hosts(void);
 static struct nsm_handle *	__nsm_find(const struct sockaddr_in *,
 					const char *, int, int);
-
-/*
- * Find an NLM server handle in the cache. If there is none, create it.
- */
-struct nlm_host *
-nlmclnt_lookup_host(const struct sockaddr_in *sin, int proto, int version,
-			const char *hostname, int hostname_len)
-{
-	return nlm_lookup_host(0, sin, proto, version,
-			       hostname, hostname_len);
-}
-
-/*
- * Find an NLM client handle in the cache. If there is none, create it.
- */
-struct nlm_host *
-nlmsvc_lookup_host(struct svc_rqst *rqstp,
-			const char *hostname, int hostname_len)
-{
-	return nlm_lookup_host(1, &rqstp->rq_addr,
-			       rqstp->rq_prot, rqstp->rq_vers,
-			       hostname, hostname_len);
-}
+static struct nsm_handle *	nsm_find(const struct sockaddr_in *sin,
+					 const char *hostname,
+					 int hostname_len);
 
 /*
  * Common host lookup routine for server & client
  */
-struct nlm_host *
+static struct nlm_host *
 nlm_lookup_host(int server, const struct sockaddr_in *sin,
 					int proto, int version,
 					const char *hostname,
@@ -195,6 +175,29 @@
 }
 
 /*
+ * Find an NLM server handle in the cache. If there is none, create it.
+ */
+struct nlm_host *
+nlmclnt_lookup_host(const struct sockaddr_in *sin, int proto, int version,
+			const char *hostname, int hostname_len)
+{
+	return nlm_lookup_host(0, sin, proto, version,
+			       hostname, hostname_len);
+}
+
+/*
+ * Find an NLM client handle in the cache. If there is none, create it.
+ */
+struct nlm_host *
+nlmsvc_lookup_host(struct svc_rqst *rqstp,
+			const char *hostname, int hostname_len)
+{
+	return nlm_lookup_host(1, &rqstp->rq_addr,
+			       rqstp->rq_prot, rqstp->rq_vers,
+			       hostname, hostname_len);
+}
+
+/*
  * Create the NLM RPC client for an NLM peer
  */
 struct rpc_clnt *
@@ -495,7 +498,7 @@
 	return nsm;
 }
 
-struct nsm_handle *
+static struct nsm_handle *
 nsm_find(const struct sockaddr_in *sin, const char *hostname, int hostname_len)
 {
 	return __nsm_find(sin, hostname, hostname_len, 1);

