Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWIZKbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWIZKbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWIZKbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:31:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:9896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750981AbWIZKbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:31:46 -0400
X-Authenticated: #704063
Subject: [Patch] Possible dereference in fs/nfsd/nfs4callback.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:30:59 +0200
Message-Id: <1159266659.5413.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

the following commit introduced a possible NULL pointer dereference
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ae5c79476f36512d1100e162606bb5691f2cce5a

we set cb->cb_client to NULL and pass it to rpc_shutdown_client() which dereferences it.
The easy fix below.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/fs/nfsd/nfs4callback.c.orig	2006-09-26 12:24:23.000000000 +0200
+++ linux-2.6.18-git5/fs/nfsd/nfs4callback.c	2006-09-26 12:24:40.000000000 +0200
@@ -450,7 +450,8 @@ out_rpciod:
 	rpciod_down();
 	cb->cb_client = NULL;
 out_clnt:
-	rpc_shutdown_client(cb->cb_client);
+	if (cb->cb_client)
+		rpc_shutdown_client(cb->cb_client);
 out_err:
 	dprintk("NFSD: warning: no callback path to client %.*s\n",
 		(int)clp->cl_name.len, clp->cl_name.data);


