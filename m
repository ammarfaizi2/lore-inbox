Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWHQHm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWHQHm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHQHm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:42:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932189AbWHQHm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:42:58 -0400
Date: Thu, 17 Aug 2006 00:42:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       aviro@redhat.com, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
 list
Message-Id: <20060817004219.44c45bbd.akpm@osdl.org>
In-Reply-To: <13319.1155744959@warthog.cambridge.redhat.com>
References: <1155743399.5683.13.camel@localhost>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<5910.1155741329@warthog.cambridge.redhat.com>
	<13319.1155744959@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 17:15:59 +0100
David Howells <dhowells@redhat.com> wrote:

> 
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Better still, in the case of a negative dentry: just call d_drop().
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

That fixes the bad dentries, but...

sony:/home/akpm> ls -l /net/bix
total 1025288
drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
drwxr-xr-x 98 root root       8192 Aug 16 04:03 etc
drwxr-xr-x  7 root root       4096 Apr  1  2004 home
drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
drwx------  2 root root      16384 Mar 10  2004 lost+found
drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
drwxr-xr-x 19 root root       4096 Jul  3 15:29 mnt
drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
-rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
drwxrwxrwt 14 root root      16384 Aug 17 00:38 tmp
drwxr-xr-x 17 root root       4096 Mar 22  2005 usr
drwxr-xr-x 27 root root       4096 Mar 10  2004 var
sony:/home/akpm> sudo umount bix:/
sony:/home/akpm> dmesg|tail -n 1
VFS: Busy inodes after unmount of 0:15. Self-destruct in 5 seconds.  Have a nice day...

