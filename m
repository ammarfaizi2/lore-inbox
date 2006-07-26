Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWGZHIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWGZHIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWGZHIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:08:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932484AbWGZHIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:08:14 -0400
Date: Wed, 26 Jul 2006 00:04:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: mingo@elte.hu, reiserfs-list@namesys.com, reiserfs-dev@namesys.com,
       viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, reiser@namesys.com,
       linux-kernel@vger.kernel.org, jesper.juhl@gmail.com
Subject: Re: [patch] lockdep: annotate vfs_rmdir for filesystems that take
 i_mutex in delete_inode
Message-Id: <20060726000452.52179c32.akpm@osdl.org>
In-Reply-To: <1153896441.2896.11.camel@laptopd505.fenrus.org>
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
	<20060725223327.b6d039b2.akpm@osdl.org>
	<1153896441.2896.11.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006 08:47:21 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> On Tue, 2006-07-25 at 22:33 -0700, Andrew Morton wrote:
> > On Wed, 26 Jul 2006 00:16:42 +0200
> > The VFS takes the directory i_mutex and reiserfs_delete_inode() takes the
> > to-be-deleted file's i_mutex.
> > 
> > That's notabug and lockdep will need to be taught about it.
> 
> [2nd try, now with coffee]
> 
> This is another 3 level locking ordering:
> do_rmdir takes the mutex of the parent directory
> vfs_rmdir takes the mutex of the victim
> shrink_dcache_parent ends up in the reiser delete_inode which takes the
> mutex of dead children of the victim
> 
> the I_MUTEX ordering rules are
> 
> I_MUTEX_PARENT -> I_MUTEX_CHILD -> <normal>
> 
> do_rmdir already has I_MUTEX_PARENT, delete_inode does <normal> so
> vfs_rmdir needs I_MUTEX_CHILD (which is also logical)
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> Index: linux-2.6.18-rc2-git5/fs/namei.c
> ===================================================================
> --- linux-2.6.18-rc2-git5.orig/fs/namei.c
> +++ linux-2.6.18-rc2-git5/fs/namei.c
> @@ -1967,7 +1967,7 @@ int vfs_rmdir(struct inode *dir, struct 
>  
>  	DQUOT_INIT(dir);
>  
> -	mutex_lock(&dentry->d_inode->i_mutex);
> +	mutex_lock_nested(&dentry->d_inode->i_mutex, I_MUTEX_CHILD);
>  	dentry_unhash(dentry);
>  	if (d_mountpoint(dentry))
>  		error = -EBUSY;

If there's a reason why a filesystem shuld take an i_mutex under
vfs_rmdir() then fine.  But I don't think there is, in which case the
warning can be kept.

Can a reiserfs person please comment?
