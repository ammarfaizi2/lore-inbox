Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSJJSaD>; Thu, 10 Oct 2002 14:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSJJS3H>; Thu, 10 Oct 2002 14:29:07 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:13065 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261936AbSJJS2x>; Thu, 10 Oct 2002 14:28:53 -0400
Date: Thu, 10 Oct 2002 19:34:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, ext2-devel@sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/5] ACL support for ext2/3
Message-ID: <20021010193433.A26873@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
	linux-kernel@vger.kernel.org, ext2-devel@sourceforge.net
References: <E17zVaD-00069Y-00@snap.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17zVaD-00069Y-00@snap.thunk.org>; from tytso@mit.edu on Thu, Oct 10, 2002 at 01:10:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/version.h>

shouldn't be needed

> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <asm/atomic.h>
> +#include <linux/fs.h>
> +#include <linux/posix_acl.h>
> +#include <linux/module.h>
> +
> +#include <linux/smp_lock.h>

not needed

> +MODULE_AUTHOR("Andreas Gruenbacher <a.gruenbacher@computer.org>");
> +MODULE_DESCRIPTION("Generic Posix Access Control List (ACL) Manipulation");
> +MODULE_LICENSE("GPL");

looks pretty pointless as this can't be a module.. :)

> +struct posix_acl *
> +get_posix_acl(struct inode *inode, int type)
> +{
> +	struct posix_acl *acl;
> +
> +	if (!inode->i_op->get_posix_acl)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	down(&inode->i_sem);
> +	acl = inode->i_op->get_posix_acl(inode, type);
> +	up(&inode->i_sem);
> +
> +	return acl;
> +}
> +
> +/*
> + * Set the POSIX ACL of an inode.
> + */
> +int
> +set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
> +{
> +	int error;
> +
> +	if (!inode->i_op->set_posix_acl)
> +		return -EOPNOTSUPP;
> +	down(&inode->i_sem);
> +	error = inode->i_op->set_posix_acl(inode, type, acl);
> +	up(&inode->i_sem);
> +
> +	return error;
> +}
> diff -Nru a/include/linux/fs.h b/include/linux/fs.h
> --- a/include/linux/fs.h	Wed Oct  9 23:53:33 2002
> +++ b/include/linux/fs.h	Wed Oct  9 23:53:33 2002
> @@ -770,6 +770,9 @@
>  	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>  };
>  
> +/* posix_acl.h */
> +struct posix_acl;
> +
>  struct inode_operations {
>  	int (*create) (struct inode *,struct dentry *,int);
>  	struct dentry * (*lookup) (struct inode *,struct dentry *);
> @@ -791,6 +794,8 @@
>  	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
>  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
>  	int (*removexattr) (struct dentry *, const char *);
> +	struct posix_acl *(*get_posix_acl) (struct inode *, int);
> +	int (*set_posix_acl) (struct inode *, int, struct posix_acl *);

Either you make all setting/retrieving of ACLs go through this interface or
just rip it.  We don't need more than one way to fiddle with ACLs.

Also they should take dentries..

