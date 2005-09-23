Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVIWBZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVIWBZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 21:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVIWBZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 21:25:00 -0400
Received: from citi.umich.edu ([141.211.133.111]:2728 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751250AbVIWBZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 21:25:00 -0400
Date: Thu, 22 Sep 2005 21:24:59 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: [Fwd: Re: 2.6.13-mm2]]]
In-Reply-To: <1127426268.8365.174.camel@lade.trondhjem.org>
Message-ID: <Pine.BSO.4.58.0509222123330.16695@citi.umich.edu>
References: <43330970.9030006@citi.umich.edu> <1127426268.8365.174.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Trond Myklebust wrote:

> to den 22.09.2005 Klokka 15:43 (-0400) skreiv Chuck Lever:
> > attached please find the original message containing the pmap reserved
> > port patch.
>
> There's just one problem: it won't apply to my tree. Looks like this is
> relative to something you haven't merged yet.

oops, you're right.  try this one.



[SUNRPC] portmapper doesn't need a reserved port

The in-kernel portmapper does not require a reserved port for making bind
queries.

Test-plan:
Tens of runs of the Connectathon locking suite with TCP and UDP against
several other NFS server implementations using NFSv3, not NFSv4 (which
doesn't require rpcbind).

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 net/sunrpc/pmap_clnt.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/pmap_clnt.c b/net/sunrpc/pmap_clnt.c
--- a/net/sunrpc/pmap_clnt.c
+++ b/net/sunrpc/pmap_clnt.c
@@ -26,7 +26,7 @@
 #define PMAP_GETPORT		3

 static struct rpc_procinfo	pmap_procedures[];
-static struct rpc_clnt *	pmap_create(char *, struct sockaddr_in *, int);
+static struct rpc_clnt *	pmap_create(char *, struct sockaddr_in *, int, int);
 static void			pmap_getport_done(struct rpc_task *);
 static struct rpc_program	pmap_program;
 static DEFINE_SPINLOCK(pmap_lock);
@@ -65,7 +65,7 @@ rpc_getport(struct rpc_task *task, struc
 	map->pm_binding = 1;
 	spin_unlock(&pmap_lock);

-	pmap_clnt = pmap_create(clnt->cl_server, sap, map->pm_prot);
+	pmap_clnt = pmap_create(clnt->cl_server, sap, map->pm_prot, 0);
 	if (IS_ERR(pmap_clnt)) {
 		task->tk_status = PTR_ERR(pmap_clnt);
 		goto bailout;
@@ -112,7 +112,7 @@ rpc_getport_external(struct sockaddr_in
 			NIPQUAD(sin->sin_addr.s_addr), prog, vers, prot);

 	sprintf(hostname, "%u.%u.%u.%u", NIPQUAD(sin->sin_addr.s_addr));
-	pmap_clnt = pmap_create(hostname, sin, prot);
+	pmap_clnt = pmap_create(hostname, sin, prot, 0);
 	if (IS_ERR(pmap_clnt))
 		return PTR_ERR(pmap_clnt);

@@ -171,7 +171,7 @@ rpc_register(u32 prog, u32 vers, int pro

 	sin.sin_family = AF_INET;
 	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	pmap_clnt = pmap_create("localhost", &sin, IPPROTO_UDP);
+	pmap_clnt = pmap_create("localhost", &sin, IPPROTO_UDP, 1);
 	if (IS_ERR(pmap_clnt)) {
 		error = PTR_ERR(pmap_clnt);
 		dprintk("RPC: couldn't create pmap client. Error = %d\n", error);
@@ -198,7 +198,7 @@ rpc_register(u32 prog, u32 vers, int pro
 }

 static struct rpc_clnt *
-pmap_create(char *hostname, struct sockaddr_in *srvaddr, int proto)
+pmap_create(char *hostname, struct sockaddr_in *srvaddr, int proto, int privileged)
 {
 	struct rpc_xprt	*xprt;
 	struct rpc_clnt	*clnt;
@@ -208,6 +208,8 @@ pmap_create(char *hostname, struct socka
 	if (IS_ERR(xprt))
 		return (struct rpc_clnt *)xprt;
 	xprt->addr.sin_port = htons(RPC_PMAP_PORT);
+	if (!privileged)
+		xprt->resvport = 0;

 	/* printk("pmap: create clnt\n"); */
 	clnt = rpc_new_client(xprt, hostname,

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>
