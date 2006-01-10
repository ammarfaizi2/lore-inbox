Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWAJMpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWAJMpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWAJMpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:45:23 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:15067 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932193AbWAJMpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:45:22 -0500
Subject: Re: [patch 2/2] Access Control Lists for tmpfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060108231235.440671000@blunzn.suse.de>
References: <20060108230116.073177000@blunzn.suse.de>
	 <20060108231235.440671000@blunzn.suse.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 10 Jan 2006 07:50:52 -0500
Message-Id: <1136897452.19934.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 00:01 +0100, Andreas Gruenbacher wrote:
> plain text document attachment (tmpfs-acl.diff)
> Add access control lists for tmpfs.
> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

> Index: linux-2.6.15-git4/mm/shmem.c
> ===================================================================
> --- linux-2.6.15-git4.orig/mm/shmem.c
> +++ linux-2.6.15-git4/mm/shmem.c
> @@ -1843,6 +1852,50 @@ static struct inode_operations shmem_sym
>  	.put_link	= shmem_put_link,
>  };
>  
> +#ifdef CONFIG_TMPFS_POSIX_ACL
> +/* The vfs implements defaults for the security.* xattr namespace for inodes
> + * that don't have xattr iops. We have xattr iops for the acls, so we must
> + * also implement the security.* defaults here.
> + */
> +static size_t shmem_xattr_security_list(struct inode *inode, char *list,
> +					size_t list_len, const char *name,
> +					size_t name_len)
> +{
> +	return security_inode_listsecurity(inode, list, list_len);
> +}
> +
> +static int shmem_xattr_security_get(struct inode *inode, const char *name,
> +				    void *buffer, size_t size)
> +{
> +	if (strcmp(name, "") == 0)
> +		return -EINVAL;
> +	return security_inode_getsecurity(inode, name, buffer, size,
> +					  -EOPNOTSUPP);
> +}
> +
> +static int shmem_xattr_security_set(struct inode *inode, const char *name,
> +				    const void *value, size_t size, int flags)
> +{
> +	if (strcmp(name, "") == 0)
> +		return -EINVAL;
> +	return security_inode_setsecurity(inode, name, value, size, flags);
> +}
> +
> +struct xattr_handler shmem_xattr_security_handler = {
> +	.prefix = XATTR_SECURITY_PREFIX,
> +	.list   = shmem_xattr_security_list,
> +	.get    = shmem_xattr_security_get,
> +	.set    = shmem_xattr_security_set,
> +};

This seems like a regression, given that this code was just removed in
2.6.14 by the generic VFS fallback support for security xattrs,
http://marc.theaimsgroup.com/?l=git-commits-head&m=112597810414161&w=2

Could you instead provide a generic VFS fallback for ACLs as well?

-- 
Stephen Smalley
National Security Agency

