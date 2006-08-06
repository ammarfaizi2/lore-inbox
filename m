Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWHFCiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWHFCiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 22:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWHFCiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 22:38:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:58468 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751305AbWHFCiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 22:38:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=tC+FAk0AnYiNbvzrezpeX/7EfmVpqMsanQvL+jkdN/G5r7FQh0mx/bFP101HdOkNrGKAQDGmamKffmwAz8VuYQO1f/Iu7rZp/V4qgczJJkZQe+eQkpccaZrO2cDXva8wOTHZ4qgLHo221VBkUKWvEFfH2N6ZxRqv1fK1vlLiJhM=
Date: Sun, 6 Aug 2006 06:38:06 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH -mm] fs.h: ifdef security fields
Message-ID: <20060806023806.GA13480@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BSD security levels are deleted in -mm, assuming this below]

The only user of i_security, f_security, s_security fields is SELinux,
so ifdef them with CONFIG_SECURITY_SELINUX. Following Stephen Smalley's
suggestion, i_security initialization is moved to security_inode_alloc()
to not clutter core code with ifdefs and make alloc_inode() codepath
tiny little bit smaller and faster.

The user of (highly greppable) struct fown_struct::security field is
still to be found. I've checked every "fown_struct" and every "f_owner"
occurence. Additionally, it's removal doesn't break i386 allmodconfig
build.

struct inode, struct file, struct super_block, struct fown_struct
become smaller.

P.S. Combined with two reiserfs inode shrinking patches sent to
linux-fsdevel, I can finally suck 12 reiserfs inodes into one page.

		/proc/slabinfo

	-ext2_inode_cache	388	10
	+ext2_inode_cache	384	10
	-inode_cache		280	14
	+inode_cache		276	14
	-proc_inode_cache	296	13
	+proc_inode_cache	292	13
	-reiser_inode_cache	336	11
	+reiser_inode_cache	332	12 <=
	-shmem_inode_cache	372	10
	+shmem_inode_cache	368	10

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/inode.c               |    1 -
 include/linux/fs.h       |    8 ++++++--
 include/linux/security.h |    1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -133,7 +133,6 @@ #endif
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_rdev = 0;
-		inode->i_security = NULL;
 		inode->dirtied_when = 0;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -552,7 +552,9 @@ struct inode {
 	unsigned int		i_flags;
 
 	atomic_t		i_writecount;
+#ifdef CONFIG_SECURITY_SELINUX
 	void			*i_security;
+#endif
 	union {
 		void		*generic_ip;
 	} u;
@@ -645,7 +647,6 @@ struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
-	void *security;
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
@@ -688,8 +689,9 @@ struct file {
 	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
+#ifdef CONFIG_SECURITY_SELINUX
 	void			*f_security;
-
+#endif
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
 
@@ -877,7 +879,9 @@ struct super_block {
 	int			s_syncing;
 	int			s_need_sync_fs;
 	atomic_t		s_active;
+#ifdef CONFIG_SECURITY_SELINUX
 	void                    *s_security;
+#endif
 	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_inodes;	/* all inodes */
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1549,6 +1549,7 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
+	inode->i_security = NULL;
 	return security_ops->inode_alloc_security (inode);
 }
 

