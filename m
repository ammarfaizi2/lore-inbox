Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUIWUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUIWUzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIWUxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:53:20 -0400
Received: from soda.CSUA.Berkeley.EDU ([128.32.112.233]:20744 "EHLO
	soda.csua.berkeley.edu") by vger.kernel.org with ESMTP
	id S267346AbUIWUsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:48:39 -0400
Message-ID: <4153369A.2030804@csua.berkeley.edu>
Date: Thu, 23 Sep 2004 13:48:26 -0700
From: Mark Goodman <mgoodman@CSUA.Berkeley.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Make locks work on NFS3 krb5 mounts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes locks work on NFS3 krb5 mounts. In particular, it makes 
gconf-sanity-check-1 succeed when my home directory is a NFS3 krb5 
mount. gconf-sanity-check-1 is part of GConf. It applies to 2.6.9-rc2. 
Please consider applying.

Signed-off-by: Mark Goodman <mgoodman@csua.berkeley.edu>

--- linux-2.6.9-rc2/net/sunrpc/clnt.c.orig    2004-09-12 
22:32:17.000000000 -0700
+++ linux-2.6.9-rc2/net/sunrpc/clnt.c    2004-09-23 13:35:12.028606648 -0700
@@ -425,6 +425,16 @@ rpc_call_setup(struct rpc_task *task, st
 {
     task->tk_msg   = *msg;
     task->tk_flags |= flags;
+
+    /*
+     * For a nfs3 krb5 mount, lockd tries to use a RPCSEC cred with UNIX
+     * auth. If that's the case, get a UNIX cred.
+     */
+    if (task->tk_msg.rpc_cred != NULL &&
+        task->tk_msg.rpc_cred->cr_auth->au_ops != task->tk_auth->au_ops) {
+        task->tk_msg.rpc_cred = NULL;
+    }
+
     /* Bind the user cred */
     if (task->tk_msg.rpc_cred != NULL) {
         rpcauth_holdcred(task);




