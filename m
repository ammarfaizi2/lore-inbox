Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWG0U4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWG0U4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWG0UyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:54:03 -0400
Received: from mx2.redhat.com ([66.187.237.31]:49121 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1750888AbWG0UxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/30] NFS: Start rpciod in server common management [try #11]
Date: Thu, 27 Jul 2006 21:53:05 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205305.8443.6740.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start rpciod in the server common (nfs_client struct) management code rather
than in the superblock management code.  This means we only need to "start" it
once per server instead of once per superblock.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c |   31 ++++++-------------------------
 1 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index f3f229d..321f0d7 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -717,18 +717,15 @@ static int nfs_clone_generic_sb(struct n
 	if (server->hostname == NULL)
 		goto free_server;
 	memcpy(server->hostname, hostname, len);
-	error = rpciod_up();
-	if (error != 0)
-		goto free_hostname;
 
 	sb = fill_sb(server, data);
 	if (IS_ERR(sb)) {
 		error = PTR_ERR(sb);
-		goto kill_rpciod;
+		goto free_hostname;
 	}
 
 	if (sb->s_root)
-		goto out_rpciod_down;
+		goto out_share;
 
 	server = fill_server(sb, data);
 	if (IS_ERR(server)) {
@@ -740,14 +737,11 @@ out_deactivate:
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
 	return error;
-out_rpciod_down:
-	rpciod_down();
+out_share:
 	kfree(server->hostname);
 	nfs_put_client(server->nfs_client);
 	kfree(server);
 	return simple_set_mnt(mnt, sb);
-kill_rpciod:
-	rpciod_down();
 free_hostname:
 	kfree(server->hostname);
 free_server:
@@ -934,22 +928,14 @@ #endif /* CONFIG_NFS_V3 */
 		goto out_err;
 	}
 
-	/* Fire up rpciod if not yet running */
-	error = rpciod_up();
-	if (error < 0) {
-		dprintk("%s: couldn't start rpciod! Error = %d\n",
-				__FUNCTION__, error);
-		goto out_err;
-	}
-
 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
-		goto out_err_rpciod;
+		goto out_err;
 	}
 
 	if (s->s_root)
-		goto out_rpciod_down;
+		goto out_share;
 
 	s->s_flags = flags;
 
@@ -962,13 +948,10 @@ #endif /* CONFIG_NFS_V3 */
 	s->s_flags |= MS_ACTIVE;
 	return simple_set_mnt(mnt, s);
 
-out_rpciod_down:
-	rpciod_down();
+out_share:
 	kfree(server);
 	return simple_set_mnt(mnt, s);
 
-out_err_rpciod:
-	rpciod_down();
 out_err:
 	kfree(server);
 out_err_noserver:
@@ -989,8 +972,6 @@ static void nfs_kill_super(struct super_
 	if (!(server->flags & NFS_MOUNT_NONLM))
 		lockd_down();	/* release rpc.lockd */
 
-	rpciod_down();		/* release rpciod */
-
 	nfs_free_iostats(server->io_stats);
 	kfree(server->hostname);
 	nfs_put_client(server->nfs_client);
