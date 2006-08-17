Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWHQFMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWHQFMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHQFMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:12:41 -0400
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:5028 "EHLO
	mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org with ESMTP
	id S1751267AbWHQFMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:12:40 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.08,134,1154880000"; 
   d="scan'208"; a="605027706:sNHT1200481798"
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
	list
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <13319.1155744959@warthog.cambridge.redhat.com>
References: <1155743399.5683.13.camel@localhost>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <5910.1155741329@warthog.cambridge.redhat.com>
	 <13319.1155744959@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 13:12:41 +0800
Message-Id: <1155791561.2969.14.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 17:15 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Better still, in the case of a negative dentry: just call d_drop().

Yes, unhashing the dentry will make it invisible but I thought your
point was that the server hadn't actually been contacted when I
suggested it before. Is that a concern?

> 
> How about this then?
> 
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
