Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUG2NYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUG2NYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUG2NYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:24:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264609AbUG2NYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:24:31 -0400
Message-ID: <4108FA8B.5000305@RedHat.com>
Date: Thu, 29 Jul 2004 09:24:27 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NFSv4@linux-nfs.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [NFSv4] Oops in error paths
Content-Type: multipart/mixed;
 boundary="------------080702060609040301000501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080702060609040301000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here are some oops I found in error paths in the mounting
pathes while debugging something else...  I sent it out a while
ago, but it didn't seem to get any traction....

The nfs_fill_super() fix is obvious and in nfs4_fill_super(),
the server->client ptr needs to be set before the cl_idmap check,
since rpc_shutdown_client() needs it when the check fails.

SteveD.

--------------080702060609040301000501
Content-Type: text/plain;
 name="linux-2.6.8-nfs-errorpaths.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8-nfs-errorpaths.patch"

--- linux-2.6.7/fs/nfs/inode.c.org	2004-06-16 01:19:44.000000000 -0400
+++ linux-2.6.7/fs/nfs/inode.c	2004-06-28 14:08:35.964873256 -0400
@@ -456,7 +456,7 @@ nfs_fill_super(struct super_block *sb, s
 
 	/* Create RPC client handles */
 	server->client = nfs_create_client(server, data);
-	if (server->client == NULL)
+	if (IS_ERR(server->client))
 		goto out_fail;
 	/* RFC 2623, sec 2.3.2 */
 	if (authflavor != RPC_AUTH_UNIX) {
@@ -1550,16 +1550,17 @@ static int nfs4_fill_super(struct super_
 		err = PTR_ERR(clnt);
 		goto out_remove_list;
 	}
+
+	clnt->cl_intr     = (server->flags & NFS4_MOUNT_INTR) ? 1 : 0;
+	clnt->cl_softrtry = (server->flags & NFS4_MOUNT_SOFT) ? 1 : 0;
+	server->client    = clnt;
+
 	err = -ENOMEM;
 	if (server->nfs4_state->cl_idmap == NULL) {
 		printk(KERN_WARNING "NFS: failed to create idmapper.\n");
 		goto out_shutdown;
 	}
 
-	clnt->cl_intr     = (server->flags & NFS4_MOUNT_INTR) ? 1 : 0;
-	clnt->cl_softrtry = (server->flags & NFS4_MOUNT_SOFT) ? 1 : 0;
-	server->client    = clnt;
-
 	if (clnt->cl_auth->au_flavor != authflavour) {
 		if (rpcauth_create(authflavour, clnt) == NULL) {
 			printk(KERN_WARNING "NFS: couldn't create credcache!\n");

--------------080702060609040301000501--
