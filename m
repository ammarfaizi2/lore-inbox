Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWHBPPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWHBPPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHBPPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:15:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:915 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751086AbWHBPPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:15:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CbfkQn/wkNkQb47ixSLld8iVOUkZU9NEsUNxN6rdvYmRncI0/0bEBzfUJVqVW8JyxCG+wYGqEfXVMaM1Oz3X4kqjK4pL8I58h8Ov9bJUGVq5Otsgo1uKwfUjkXflteLXaggwZmHmlSk5+CIM37jDMjmnwe7jwinnlAwC5SUDt2Q=
Date: Wed, 2 Aug 2006 19:14:55 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs.h: ifdef security fields
Message-ID: <20060802151455.GA6827@martell.zuzino.mipt.ru>
References: <20060801155305.GA6872@martell.zuzino.mipt.ru> <1154458395.3582.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154458395.3582.150.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 02:53:15PM -0400, Stephen Smalley wrote:
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -133,7 +133,9 @@ #endif
> >  		inode->i_bdev = NULL;
> >  		inode->i_cdev = NULL;
> >  		inode->i_rdev = 0;
> > +#ifdef CONFIG_SECURITY
> >  		inode->i_security = NULL;
> > +#endif
>
> Possibly this should just be moved inside the security_inode_alloc
> static inlines?

Agree, it's better.

> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -552,7 +552,9 @@ struct inode {
> >  	unsigned int		i_flags;
> >
> >  	atomic_t		i_writecount;
> > +#ifdef CONFIG_SECURITY
> >  	void			*i_security;
> > +#endif
> >  	union {
> >  		void		*generic_ip;
> >  	} u;
> > @@ -688,8 +690,9 @@ struct file {
> >  	struct file_ra_state	f_ra;
> >
> >  	unsigned long		f_version;
> > +#ifdef CONFIG_SECURITY_SELINUX
>
> This should just be CONFIG_SECURITY.

After another user appear.

> >  	void			*f_security;
> > -
> > +#endif
> >  	/* needed for tty driver, and maybe others */
> >  	void			*private_data;
> >
> > @@ -877,7 +880,9 @@ struct super_block {
> >  	int			s_syncing;
> >  	int			s_need_sync_fs;
> >  	atomic_t		s_active;
> > +#ifdef CONFIG_SECURITY_SELINUX
>
> Likewise.

After second user appear in tree.

> >  	void                    *s_security;
> > +#endif

[PATCH v2] fs.h: ifdef security fields

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/inode.c               |    1 -
 include/linux/fs.h       |    7 ++++++-
 include/linux/security.h |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

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
@@ -552,7 +552,9 @@ #endif
 	unsigned int		i_flags;
 
 	atomic_t		i_writecount;
+#ifdef CONFIG_SECURITY
 	void			*i_security;
+#endif
 	union {
 		void		*generic_ip;
 	} u;
@@ -688,8 +690,9 @@ struct file {
 	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
+#ifdef CONFIG_SECURITY_SELINUX
 	void			*f_security;
-
+#endif
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
 
@@ -877,7 +880,9 @@ struct super_block {
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
@@ -1537,6 +1537,7 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
+	inode->i_security = NULL;
 	return security_ops->inode_alloc_security (inode);
 }
 

