Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946247AbWJSRIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946247AbWJSRIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946252AbWJSRIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:08:55 -0400
Received: from mx2.netapp.com ([216.240.18.37]:1709 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946247AbWJSRGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:10 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607104:sNHT46604448"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.96764.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 10/11] SUNRPC: fix race in in-kernel RPC portmapper client
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:28.0395 (UTC) FILETIME=[EAA9C7B0:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

When submitting a request to a fast portmapper (such as the local rpcbind
daemon), the request can complete before the parent task is even queued up
on xprt->binding.  Fix this by queuing before submitting the rpcbind
request.

Test plan:
Connectathon locking test with UDP.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 net/sunrpc/pmap_clnt.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/pmap_clnt.c b/net/sunrpc/pmap_clnt.c
index 919d5ba..e52afab 100644
--- a/net/sunrpc/pmap_clnt.c
+++ b/net/sunrpc/pmap_clnt.c
@@ -101,11 +101,13 @@ void rpc_getport(struct rpc_task *task)
 	/* Autobind on cloned rpc clients is discouraged */
 	BUG_ON(clnt->cl_parent != clnt);
 
-	if (xprt_test_and_set_binding(xprt)) {
-		task->tk_status = -EACCES;	/* tell caller to check again */
-		rpc_sleep_on(&xprt->binding, task, NULL, NULL);
-		return;
-	}
+	/* Put self on queue before sending rpcbind request, in case
+	 * pmap_getport_done completes before we return from rpc_run_task */
+	rpc_sleep_on(&xprt->binding, task, NULL, NULL);
+
+	status = -EACCES;		/* tell caller to check again */
+	if (xprt_test_and_set_binding(xprt))
+		goto bailout_nofree;
 
 	/* Someone else may have bound if we slept */
 	status = 0;
@@ -134,8 +136,6 @@ void rpc_getport(struct rpc_task *task)
 		goto bailout;
 	rpc_release_task(child);
 
-	rpc_sleep_on(&xprt->binding, task, NULL, NULL);
-
 	task->tk_xprt->stat.bind_count++;
 	return;
 
