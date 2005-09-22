Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVIVODT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVIVODT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVIVODT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:03:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030357AbVIVODS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:03:18 -0400
Message-ID: <4332B96F.1040007@RedHat.com>
Date: Thu, 22 Sep 2005 10:02:23 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: NFS@lists.sourceforge.net
Subject: Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm versions)
References: <mailman.1127394541.15384.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1127394541.15384.linux-kernel2news@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090601080802080107090704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601080802080107090704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Max Kellermann wrote:
> Your -mm patches make the sunrpc client connect to the portmapper with
> a non-privileged source port.  This is due to a change in
> net/sunrpc/pmap_clnt.c, which manually resets the xprt->resvport
> field.  My tiny patch removes this line.  I have no idea why the line
> was added in the first place, does somebody know better?
Yes this is a bug, since most Linux portmapper will not
allow ports to be set or unset using non-privilege ports.
But non-privilege ports can be used to get ports information.
So I would suggest the following patch that stops the
use of privileges ports on only get port requests.

steved.

--------------090601080802080107090704
Content-Type: text/x-patch;
 name="2.6.14-rc2-mm1-sunrpc-getports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.14-rc2-mm1-sunrpc-getports.patch"

Privilege ports are need for services to set and unset ports, but
are not needed to get ports. This patch eliminates the use of
privilege ports for PMAP_GETPORT rpcs and restores the use
of privilege ports for PMAP_SET  and  PMAP_UNSET rpcs.

Signed-off-by: Steve Dickson <steved@redhat.com>

-------------------------
--- 2.6.14-rc2-mm1/net/sunrpc/pmap_clnt.c.orig	2005-09-22 09:42:28.394681000 -0400
+++ 2.6.14-rc2-mm1/net/sunrpc/pmap_clnt.c	2005-09-22 09:52:51.777617000 -0400
@@ -70,6 +70,8 @@ rpc_getport(struct rpc_task *task, struc
 		task->tk_status = PTR_ERR(pmap_clnt);
 		goto bailout;
 	}
+	/* Don't need reserved ports to get ports from portmappers */
+	pmap_clnt->cl_xprt->resvport = 0;
 	task->tk_status = 0;
 
 	/*
@@ -208,7 +210,6 @@ pmap_create(char *hostname, struct socka
 	if (IS_ERR(xprt))
 		return (struct rpc_clnt *)xprt;
 	xprt->addr.sin_port = htons(RPC_PMAP_PORT);
-	xprt->resvport = 0;
 
 	/* printk("pmap: create clnt\n"); */
 	clnt = rpc_new_client(xprt, hostname,

--------------090601080802080107090704--
