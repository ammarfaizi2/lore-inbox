Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWHFFXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWHFFXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 01:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHFFXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 01:23:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:4063 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751525AbWHFFXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 01:23:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=iNo5JeMRoB1OrkeaGqXqQYGZVR9PmBOsUovqZjDB0NRvAe1hO3RUIyZ6ENZ7K1xp68paF4ONOtsTu3kocf/BWravZGneoY8ZkCXRz2CqL65irzWZQx1oKoNBeWNOKTK+ARbTjjcTCg03Dn6Z7ELx6rFE4IWFv/XpirUZefl/0s0=
Date: Sun, 6 Aug 2006 09:23:19 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -mm] fs.h: ifdef security fields
Message-ID: <20060806052319.GA7251@martell.zuzino.mipt.ru>
References: <20060806023806.GA13480@martell.zuzino.mipt.ru> <20060806042549.GA3999@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806042549.GA3999@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 11:25:49PM -0500, Serge E. Hallyn wrote:
> Quoting Alexey Dobriyan (adobriyan@gmail.com):
> > [BSD security levels are deleted in -mm, assuming this below]
> >
> > The only user of i_security, f_security, s_security fields is SELinux,
> > so ifdef them with CONFIG_SECURITY_SELINUX. Following Stephen Smalley's
>
> The SLIM security module, which is trying to get upstream, uses at least
> i_security and f_security.

OK, see it.

> The Argus module supposedly being submitted "soon" which is used in
> their LSPP product, surely must use them all.

If they're going to use struct fown_struct::security, they'll just
re-add it. Preferably under different name, so grepping for it won't be
painful.

> Maybe you still want to make these CONFIG_SECURITY_SELINUX until the
> other modules are upstreamed, but I just wanted to make sure you knew
> other modules, trying to get upstream, are using them.
>
> Personally I'd say these are a core part of the LSM framework, and if
> you don't want LSM, compile it out.

That's what I'm trying to do. This time for real. ;-)

> But since I realize that using only
> capabilities must be a pretty common case, how about just adding a
> config option CONFIG_SECURITY_OBJFIELDS, which is auto-enabled with
> SELINUX and default off, which hides these fields instead?

Ahh, this is getting more and more complex, so I'll just put it under
CONFIG_SECURITY and leave it.

> Patch should be trivial, and I can aim to send one tomorrow.

No need.
-------------------------------------------------------
[PATCH] fs.h: ifdef security fields

[assuming BSD security levels are deleted]
The only user of i_security, f_security, s_security fields is SELinux,
however, quite a few security modules are trying to get into kernel.
So, wrap them under CONFIG_SECURITY. Adding config option for each
security field is likely an overkill.

Following Stephen Smalley's suggestion, i_security initialization is
moved to security_inode_alloc() to not clutter core code with ifdefs
and make alloc_inode() codepath tiny little bit smaller and faster.

The user of (highly greppable) struct fown_struct::security field is
still to be found. I've checked every "fown_struct" and every "f_owner"
occurence. Additionally it's removal doesn't break i386 allmodconfig
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
+#ifdef CONFIG_SECURITY
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
+#ifdef CONFIG_SECURITY
 	void			*f_security;
-
+#endif
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
 
@@ -877,7 +879,9 @@ struct super_block {
 	int			s_syncing;
 	int			s_need_sync_fs;
 	atomic_t		s_active;
+#ifdef CONFIG_SECURITY
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
 

