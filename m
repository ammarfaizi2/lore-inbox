Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWHSQtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWHSQtS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWHSQtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:49:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751281AbWHSQtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:49:17 -0400
Date: Sat, 19 Aug 2006 09:48:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       aviro@redhat.com, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's
 list [try #2]
Message-Id: <20060819094840.083026fd.akpm@osdl.org>
In-Reply-To: <2138.1155893924@warthog.cambridge.redhat.com>
References: <13319.1155744959@warthog.cambridge.redhat.com>
	<1155743399.5683.13.camel@localhost>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<5910.1155741329@warthog.cambridge.redhat.com>
	<2138.1155893924@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 10:38:44 +0100
David Howells <dhowells@redhat.com> wrote:

> NFS: Replace null dentries that appear in readdir's list [try #2]
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

The funny-looking dentries in /net/bix have gone away.

But `ls -l /net/bix/usr/src' doesn't mount bix:/usr/src.
