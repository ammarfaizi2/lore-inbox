Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWHPQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWHPQgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWHPQgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:36:07 -0400
Received: from pat.uio.no ([129.240.10.4]:15057 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751157AbWHPQgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:36:04 -0400
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
	list
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       aviro@redhat.com, Ian Kent <raven@themaw.net>
In-Reply-To: <13319.1155744959@warthog.cambridge.redhat.com>
References: <1155743399.5683.13.camel@localhost>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <5910.1155741329@warthog.cambridge.redhat.com>
	 <13319.1155744959@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 12:35:44 -0400
Message-Id: <1155746145.5683.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.979, required 12,
	autolearn=disabled, AWL 0.51, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 17:15 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Better still, in the case of a negative dentry: just call d_drop().
> 
> How about this then?

Yup. That would do it.

Cheers,
  Trond

> David
> ---
> NFS: Replace null dentries that appear in readdir's list
> 
> From: David Howells <dhowells@redhat.com>
> 
> Have nfs_readdir_lookup() drop and replace any null dentry when it
> that gets listed by a READDIR RPC call.
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
> This fix makes step (8) replace the dentry looked up in steps (1) - (3).
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/nfs/dir.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e746ed1..bb8b5f0 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1105,8 +1105,13 @@ static struct dentry *nfs_readdir_lookup
>  	}
>  	name.hash = full_name_hash(name.name, name.len);
>  	dentry = d_lookup(parent, &name);
> -	if (dentry != NULL)
> -		return dentry;
> +	if (dentry != NULL) {
> +		/* negative dentries must be reconsidered */
> +		if (!IS_ERR(dentry) && !dentry->d_inode)
> +			d_drop(dentry);
> +		else
> +			return dentry;
> +	}
>  	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
>  		return NULL;
>  	/* Note: caller is already holding the dir->i_mutex! */

