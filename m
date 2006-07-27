Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWG0VCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWG0VCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWG0VCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751199AbWG0VCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/30] NFS: Use the dentry superblock directly in nfs_statfs() [try #11]
Date: Thu, 27 Jul 2006 21:52:50 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205250.8443.5984.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the nominated dentry's superblock directly in the NFS statfs() op to get a
file handle, rather than using s_root (which will become a dummy dentry in a
future patch).

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ce24b52..4e128fe 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -235,11 +235,10 @@ #endif
  */
 static int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct super_block *sb = dentry->d_sb;
-	struct nfs_server *server = NFS_SB(sb);
+	struct nfs_server *server = NFS_SB(dentry->d_sb);
 	unsigned char blockbits;
 	unsigned long blockres;
-	struct nfs_fh *rootfh = NFS_FH(sb->s_root->d_inode);
+	struct nfs_fh *fh = NFS_FH(dentry->d_inode);
 	struct nfs_fattr fattr;
 	struct nfs_fsstat res = {
 			.fattr = &fattr,
@@ -248,7 +247,7 @@ static int nfs_statfs(struct dentry *den
 
 	lock_kernel();
 
-	error = server->rpc_ops->statfs(server, rootfh, &res);
+	error = server->rpc_ops->statfs(server, fh, &res);
 	buf->f_type = NFS_SUPER_MAGIC;
 	if (error < 0)
 		goto out_err;
@@ -258,7 +257,7 @@ static int nfs_statfs(struct dentry *den
 	 * case where f_frsize != f_bsize.  Eventually we want to
 	 * report the value of wtmult in this field.
 	 */
-	buf->f_frsize = sb->s_blocksize;
+	buf->f_frsize = dentry->d_sb->s_blocksize;
 
 	/*
 	 * On most *nix systems, f_blocks, f_bfree, and f_bavail
@@ -267,8 +266,8 @@ static int nfs_statfs(struct dentry *den
 	 * thus historically Linux's sys_statfs reports these
 	 * fields in units of f_bsize.
 	 */
-	buf->f_bsize = sb->s_blocksize;
-	blockbits = sb->s_blocksize_bits;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
+	blockbits = dentry->d_sb->s_blocksize_bits;
 	blockres = (1 << blockbits) - 1;
 	buf->f_blocks = (res.tbytes + blockres) >> blockbits;
 	buf->f_bfree = (res.fbytes + blockres) >> blockbits;
