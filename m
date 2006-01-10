Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWAJOAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWAJOAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWAJOAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:00:40 -0500
Received: from ns2.suse.de ([195.135.220.15]:30947 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932125AbWAJOAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:00:40 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch 2/2] Access Control Lists for tmpfs
Date: Tue, 10 Jan 2006 15:01:32 +0100
User-Agent: KMail/1.8.2
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
References: <20060108230116.073177000@blunzn.suse.de> <20060108231235.440671000@blunzn.suse.de> <1136897452.19934.125.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136897452.19934.125.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101501.33298.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 13:50, Stephen Smalley wrote:
> On Mon, 2006-01-09 at 00:01 +0100, Andreas Gruenbacher wrote:
> > plain text document attachment (tmpfs-acl.diff)
> > Add access control lists for tmpfs.
> >
> > Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> >
> > Index: linux-2.6.15-git4/mm/shmem.c
> > ===================================================================
> > --- linux-2.6.15-git4.orig/mm/shmem.c
> > +++ linux-2.6.15-git4/mm/shmem.c
> > @@ -1843,6 +1852,50 @@ static struct inode_operations shmem_sym
> >  	.put_link	= shmem_put_link,
> >  };
> >
> > +#ifdef CONFIG_TMPFS_POSIX_ACL
> > +/* The vfs implements defaults for the security.* xattr namespace for
> > inodes + * that don't have xattr iops. We have xattr iops for the acls,
> > so we must + * also implement the security.* defaults here.
> > + */
> > +static size_t shmem_xattr_security_list(struct inode *inode, char *list,
> > +					size_t list_len, const char *name,
> > +					size_t name_len)
> > +{
> > +	return security_inode_listsecurity(inode, list, list_len);
> > +}
> > +
> > +static int shmem_xattr_security_get(struct inode *inode, const char
> > *name, +				    void *buffer, size_t size)
> > +{
> > +	if (strcmp(name, "") == 0)
> > +		return -EINVAL;
> > +	return security_inode_getsecurity(inode, name, buffer, size,
> > +					  -EOPNOTSUPP);
> > +}
> > +
> > +static int shmem_xattr_security_set(struct inode *inode, const char
> > *name, +				    const void *value, size_t size, int flags)
> > +{
> > +	if (strcmp(name, "") == 0)
> > +		return -EINVAL;
> > +	return security_inode_setsecurity(inode, name, value, size, flags);
> > +}
> > +
> > +struct xattr_handler shmem_xattr_security_handler = {
> > +	.prefix = XATTR_SECURITY_PREFIX,
> > +	.list   = shmem_xattr_security_list,
> > +	.get    = shmem_xattr_security_get,
> > +	.set    = shmem_xattr_security_set,
> > +};
>
> This seems like a regression, given that this code was just removed in
> 2.6.14 by the generic VFS fallback support for security xattrs,
> http://marc.theaimsgroup.com/?l=git-commits-head&m=112597810414161&w=2
>
> Could you instead provide a generic VFS fallback for ACLs as well?

Correct, this was when tmpfs only supported security.* xattrs. I didn't like 
this cleanup very much: it removed some reasonably clean abstractions and 
piled up more crap in fs/xattr.c instead. The security.* xattr code in 
fs/xattr.c is not extensible, which is why this patch needs to bring back 
some of the code that was removed. It would be possible to change that code 
so that it works no matter if an inode has xattr iops, but this would require 
a super_block flag that indicates if an inode's xattr ops implement the 
security.* namespace.

Generic acl support would amount to adding i_acl and i_default_acl pointers to 
generic inodes. I'm not sure if this is acceptable: Ext2, ext3, reiserfs, jfs 
have those pointers in their in-memory inodes but others don't, and generic 
acls only makes sense for memory-based filesystems. The wiring code needed in 
filesystems doesn't seem so horrible to me.

ACLs are slightly different from security labels, too: labeled security 
protection needs a label on everything, ACLs are not needed everywhere.

Thanks,
Andreas.
