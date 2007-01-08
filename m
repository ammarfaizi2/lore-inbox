Return-Path: <linux-kernel-owner+w=401wt.eu-S1422739AbXAHUsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbXAHUsO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbXAHUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:47:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932673AbXAHUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:47:19 -0500
Date: Mon, 8 Jan 2007 15:47:17 -0500
Message-Id: <200701082047.l08KlHwK001925@dantu.rdu.redhat.com>
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: esandeen@redhat.com, aviro@redhat.com
Subject: [PATCH 3/3] have pipefs ensure i_ino uniqueness by calling iunique and hashing the inode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts pipefs to use the new scheme. Here we're calling iunique to get
a unique i_ino value for the new inode, and then hashing it afterward. We
call iunique with a max_reserved value of 1 to avoid collision with the root
inode.  Since the inode is now hashed, we need to take care that we end up in
generic_delete_inode rather than generic_forget_inode or we'll create a nasty
leak, so we clear_nlink when we destroy the pipe info.

I'm not certain that this is the right place to add the clear_nlink, though
it does seem to work. I'm open to suggestions on a better place to put
this, or of a better way to make sure that we end up with i_nlink == 0 at
iput time.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/pipe.c b/fs/pipe.c
index 68090e8..1d44ff0 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -825,6 +825,7 @@ void free_pipe_info(struct inode *inode)
 {
 	__free_pipe_info(inode->i_pipe);
 	inode->i_pipe = NULL;
+	clear_nlink(inode);
 }
 
 static struct vfsmount *pipe_mnt __read_mostly;
@@ -871,6 +872,8 @@ static struct inode * get_pipe_inode(void)
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_ino = iunique(pipe_mnt->mnt_sb, 1);
+	insert_inode_hash(inode);
 
 	return inode;
 
