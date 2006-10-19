Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946242AbWJSRGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946242AbWJSRGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946240AbWJSRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:14 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946242AbWJSRGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:08 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607083:sNHT24442904"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.30968.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 04/11] nfs4: initialize cl_ipaddr
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:26.0770 (UTC) FILETIME=[E9B1D320:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@fieldses.org>

David forgot to do this.  I'm not sure if this is the right place to put
it....

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/client.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 34c3996..8b123f6 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -849,6 +849,7 @@ #ifdef CONFIG_NFS_V4
  */
 static int nfs4_init_client(struct nfs_client *clp,
 		int proto, int timeo, int retrans,
+		const char *ip_addr,
 		rpc_authflavor_t authflavour)
 {
 	int error;
@@ -865,6 +866,7 @@ static int nfs4_init_client(struct nfs_c
 	error = nfs_create_rpc_client(clp, proto, timeo, retrans, authflavour);
 	if (error < 0)
 		goto error;
+	memcpy(clp->cl_ipaddr, ip_addr, sizeof(clp->cl_ipaddr));
 
 	error = nfs_idmap_new(clp);
 	if (error < 0) {
@@ -888,6 +890,7 @@ error:
  */
 static int nfs4_set_client(struct nfs_server *server,
 		const char *hostname, const struct sockaddr_in *addr,
+		const char *ip_addr,
 		rpc_authflavor_t authflavour,
 		int proto, int timeo, int retrans)
 {
@@ -902,7 +905,7 @@ static int nfs4_set_client(struct nfs_se
 		error = PTR_ERR(clp);
 		goto error;
 	}
-	error = nfs4_init_client(clp, proto, timeo, retrans, authflavour);
+	error = nfs4_init_client(clp, proto, timeo, retrans, ip_addr, authflavour);
 	if (error < 0)
 		goto error_put;
 
@@ -971,7 +974,7 @@ struct nfs_server *nfs4_create_server(co
 		return ERR_PTR(-ENOMEM);
 
 	/* Get a client record */
-	error = nfs4_set_client(server, hostname, addr, authflavour,
+	error = nfs4_set_client(server, hostname, addr, ip_addr, authflavour,
 			data->proto, data->timeo, data->retrans);
 	if (error < 0)
 		goto error;
@@ -1041,6 +1044,7 @@ struct nfs_server *nfs4_create_referral_
 	/* Get a client representation.
 	 * Note: NFSv4 always uses TCP, */
 	error = nfs4_set_client(server, data->hostname, data->addr,
+			parent_client->cl_ipaddr,
 			data->authflavor,
 			parent_server->client->cl_xprt->prot,
 			parent_client->retrans_timeo,
