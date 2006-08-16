Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWHPPuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWHPPuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWHPPuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:50:22 -0400
Received: from pat.uio.no ([129.240.10.4]:40345 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932088AbWHPPuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:50:21 -0400
Subject: Re: [PATCH] NFS: Revalidate on readdir referring to null dentry
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       aviro@redhat.com, Ian Kent <raven@themaw.net>
In-Reply-To: <5910.1155741329@warthog.cambridge.redhat.com>
References: <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <5910.1155741329@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 11:49:59 -0400
Message-Id: <1155743399.5683.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.975, required 12,
	autolearn=disabled, AWL 0.51, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 16:15 +0100, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > This kernel breaks autofs /net handling.  Bisection shows that the bug is
> > introduced by git-nfs.patch.
> 
> Does this patch fix your problem?
> 
> David
> ---
> NFS: Revalidate on readdir referring to null dentry
> 
> From: David Howells <dhowells@redhat.com>
> 
> Have nfs_readdir_lookup() force dentry revalidation when it comes across a
> name specified by a READDIR RPC call that corresponds to a negative dentry in
> the dcache.
> 
> This can be caused by an optimisation in nfs_lookup() that causes a dentry to
> be incorrectly left as negative when mkdir() or similar is aborted by SELinux
> mid-procedure.
> 
> This can be triggered by mounting through autofs4 a server:/ NFS share for
> which there are other exports available on that server.  SELinux also has to
> be turned on in enforcing mode to abort mid-flow the mkdir operation performed
> by autofs4.
> 
> The problematic sequence of events is this:
> 
>  (1) nfs_lookup() is called by sys_mkdirat() -> lookup_create() ->
>      __lookup_hash() with intent to create exclusively set in the nameidata:
> 
> 	nd->flags == LOOKUP_CREATE
> 	nd->intent.open.flags == O_EXCL
> 
>  (2) nfs_lookup() has an optimisation to avoid going to the server in this
>      case, presumably since the nfs_mkdir() op or whatever will deal with the
>      conflict.
> 
>  (3) nfs_lookup() returns successfully, leaving the dentry in a negative state,
>      but attached to the parent directory.
> 
>  (4) sys_mkdirat() calls vfs_mkdir() which calls may_create().  may_create()
>      checks that the directory has MAY_WRITE and MAY_EXEC permissions.
> 
>  (5) may_create() calls nfs_permission(), which grants permission.
> 
>  (6) may_create() calls security_inode_permission(), which calls SELinux, which
>      then _DENIES_ permission.
> 
>  (7) may_create() fails, and vfs_mkdir() then fails and sys_mkdirat() then
>      fails (as does sys_mkdir).
> 
>      _However_, the new dentry is left in the negative state, with no
>      consultation of the server.
> 
>  (8) The parent directory is listed, and the name of the new dentry is
>      returned.
> 
>  (9) stat on the new dentry fails (because it's negative), and "ls -l" returns
>      "?---------" as the file type and mode.
> 
> This fix makes step (8) cause a revalidation to occur on the dentry at the
> start of step (9).
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/nfs/dir.c           |   16 +++++++++++++++-
>  include/linux/dcache.h |    5 +++++
>  2 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e746ed1..901b382 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -745,6 +745,13 @@ static int nfs_lookup_revalidate(struct 
>  	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
>  	inode = dentry->d_inode;
>  
> +	if (dentry->d_flags & DCACHE_NEED_REVALIDATE) {

This flag is redundant. There already exist methods for determining if a
dentry needs revalidation by means of the nfs_*_verifier() functions. If
you want to force a dentry lookup upon next revalidation, then add
something like

void nfs_dentry_force_revalidate(struct inode *dir, struct dentry *dentry)
{
	nfs_set_verifier(dentry, nfs_save_change_attribute(dir) - 1);
}

Better still, in the case of a negative dentry: just call d_drop().

Cheers,
  Trond

> +		spin_lock(&dentry->d_lock);
> +		dentry->d_flags &= ~DCACHE_NEED_REVALIDATE;
> +		spin_unlock(&dentry->d_lock);
> +		goto out_bad;
> +	}
> +
>  	if (!inode) {
>  		if (nfs_neg_need_reval(dir, dentry, nd))
>  			goto out_bad;
> @@ -1105,8 +1112,15 @@ static struct dentry *nfs_readdir_lookup
>  	}
>  	name.hash = full_name_hash(name.name, name.len);
>  	dentry = d_lookup(parent, &name);
> -	if (dentry != NULL)
> +	if (dentry != NULL) {
> +		/* negative dentries must be reconsidered */
> +		if (!IS_ERR(dentry) && !dentry->d_inode) {
> +			spin_lock(&dentry->d_lock);
> +			dentry->d_flags |= DCACHE_NEED_REVALIDATE;
> +			spin_unlock(&dentry->d_lock);
> +		}
>  		return dentry;
> +	}
>  	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
>  		return NULL;
>  	/* Note: caller is already holding the dir->i_mutex! */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 63f64a9..c401a7d 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -176,6 +176,11 @@ #define DCACHE_UNHASHED		0x0010	
>  
>  #define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
>  
> +#define DCACHE_NEED_REVALIDATE	0x0040
> +	/* Dentry needs revalidation by filesystem.  Set by NFS, for example,
> +	 * when we see in a directory listing a file for which we have a
> +	 * negative dentry */
> +
>  extern spinlock_t dcache_lock;
>  
>  /**

