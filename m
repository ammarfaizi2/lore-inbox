Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946252AbWJSRJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946252AbWJSRJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946248AbWJSRI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:08:56 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946244AbWJSRGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:10 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607103:sNHT19209800"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.65993.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 05/11] NFS: Fix NFSv4 callback regression
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:28.0192 (UTC) FILETIME=[EA8ACE00:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

The change in semantics for nfs_find_client() introduced by David breaks
the NFSv4 callback channel.

Also, replace another completely broken BUG_ON() in nfs_find_client().
In initialised clients, clp->cl_cons_state == 0, and callers of that
function should in any case never want to see clients that are
uninitialised.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/client.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8b123f6..5fea638 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -232,11 +232,15 @@ void nfs_put_client(struct nfs_client *c
  * Find a client by address
  * - caller must hold nfs_client_lock
  */
-static struct nfs_client *__nfs_find_client(const struct sockaddr_in *addr, int nfsversion)
+static struct nfs_client *__nfs_find_client(const struct sockaddr_in *addr, int nfsversion, int match_port)
 {
 	struct nfs_client *clp;
 
 	list_for_each_entry(clp, &nfs_client_list, cl_share_link) {
+		/* Don't match clients that failed to initialise properly */
+		if (clp->cl_cons_state < 0)
+			continue;
+
 		/* Different NFS versions cannot share the same nfs_client */
 		if (clp->cl_nfsversion != nfsversion)
 			continue;
@@ -245,7 +249,7 @@ static struct nfs_client *__nfs_find_cli
 			   sizeof(clp->cl_addr.sin_addr)) != 0)
 			continue;
 
-		if (clp->cl_addr.sin_port == addr->sin_port)
+		if (!match_port || clp->cl_addr.sin_port == addr->sin_port)
 			goto found;
 	}
 
@@ -265,11 +269,12 @@ struct nfs_client *nfs_find_client(const
 	struct nfs_client *clp;
 
 	spin_lock(&nfs_client_lock);
-	clp = __nfs_find_client(addr, nfsversion);
+	clp = __nfs_find_client(addr, nfsversion, 0);
 	spin_unlock(&nfs_client_lock);
-
-	BUG_ON(clp && clp->cl_cons_state == 0);
-
+	if (clp != NULL && clp->cl_cons_state != NFS_CS_READY) {
+		nfs_put_client(clp);
+		clp = NULL;
+	}
 	return clp;
 }
 
@@ -292,7 +297,7 @@ static struct nfs_client *nfs_get_client
 	do {
 		spin_lock(&nfs_client_lock);
 
-		clp = __nfs_find_client(addr, nfsversion);
+		clp = __nfs_find_client(addr, nfsversion, 1);
 		if (clp)
 			goto found_client;
 		if (new)
