Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267371AbUGNMS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267371AbUGNMS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUGNMS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:18:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:44249 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267371AbUGNMRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:17:35 -0400
Date: Wed, 14 Jul 2004 14:17:25 +0200 (MEST)
Message-Id: <200407141217.i6ECHPT3008341@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] net/sunrpc/xprt.c gcc341 inlining fix
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-3.4.1 errors out in 2.6.8-rc1-mm1 at net/sunrpc/xprt.c:

net/sunrpc/xprt.c: In function `xprt_reserve':
net/sunrpc/xprt.c:84: sorry, unimplemented: inlining failed in call to 'do_xprt_reserve': function body not available
net/sunrpc/xprt.c:1307: sorry, unimplemented: called from here
make[2]: *** [net/sunrpc/xprt.o] Error 1
make[1]: *** [net/sunrpc] Error 2
make: *** [net] Error 2

do_xprt_reserve() is marked inline but used defore its function
body is available. Moving it before its only caller fixes the problem.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.8-rc1-mm1/net/sunrpc/xprt.c.~1~	2004-07-14 12:58:35.000000000 +0200
+++ linux-2.6.8-rc1-mm1/net/sunrpc/xprt.c	2004-07-14 13:47:46.000000000 +0200
@@ -1296,21 +1296,6 @@
 /*
  * Reserve an RPC call slot.
  */
-void
-xprt_reserve(struct rpc_task *task)
-{
-	struct rpc_xprt	*xprt = task->tk_xprt;
-
-	task->tk_status = -EIO;
-	if (!xprt->shutdown) {
-		spin_lock(&xprt->xprt_lock);
-		do_xprt_reserve(task);
-		spin_unlock(&xprt->xprt_lock);
-		if (task->tk_rqstp)
-			del_timer_sync(&xprt->timer);
-	}
-}
-
 static inline void
 do_xprt_reserve(struct rpc_task *task)
 {
@@ -1332,6 +1317,21 @@
 	rpc_sleep_on(&xprt->backlog, task, NULL, NULL);
 }
 
+void
+xprt_reserve(struct rpc_task *task)
+{
+	struct rpc_xprt	*xprt = task->tk_xprt;
+
+	task->tk_status = -EIO;
+	if (!xprt->shutdown) {
+		spin_lock(&xprt->xprt_lock);
+		do_xprt_reserve(task);
+		spin_unlock(&xprt->xprt_lock);
+		if (task->tk_rqstp)
+			del_timer_sync(&xprt->timer);
+	}
+}
+
 /*
  * Allocate a 'unique' XID
  */
