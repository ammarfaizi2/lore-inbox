Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVAJSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVAJSML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAJSMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:12:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18911 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262400AbVAJSJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:09:08 -0500
Subject: [PATCH 5/6] 2.4.19-rc1 rpc_call_sync() stack reduction patch
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-SxTOT5E8wy/ZlsK93zU/"
Organization: 
Message-Id: <1105378897.4000.144.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:41:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SxTOT5E8wy/ZlsK93zU/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-SxTOT5E8wy/ZlsK93zU/
Content-Disposition: attachment; filename=rpc_call_sync.patch
Content-Type: text/plain; name=rpc_call_sync.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.4.29-rc1.org/net/sunrpc/clnt.c	2003-11-28 10:26:21.000000000 -0800
+++ linux-2.4.29-rc1/net/sunrpc/clnt.c	2005-01-09 23:08:31.000000000 -0800
@@ -238,7 +238,7 @@ void rpc_clnt_sigunmask(struct rpc_clnt 
  */
 int rpc_call_sync(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
 {
-	struct rpc_task	my_task, *task = &my_task;
+	struct rpc_task	*task;
 	sigset_t	oldset;
 	int		status;
 
@@ -253,8 +253,11 @@ int rpc_call_sync(struct rpc_clnt *clnt,
 
 	rpc_clnt_sigmask(clnt, &oldset);		
 
-	/* Create/initialize a new RPC task */
-	rpc_init_task(task, clnt, NULL, flags);
+	status = -ENOMEM;
+	task = rpc_new_task(clnt, NULL, flags);
+	if (task == NULL)
+		goto out;
+
 	rpc_call_setup(task, msg, 0);
 
 	/* Set up the call info struct and execute the task */
@@ -265,6 +268,7 @@ int rpc_call_sync(struct rpc_clnt *clnt,
 		rpc_release_task(task);
 	}
 
+out:
 	rpc_clnt_sigunmask(clnt, &oldset);		
 
 	return status;

--=-SxTOT5E8wy/ZlsK93zU/--

