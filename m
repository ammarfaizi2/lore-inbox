Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVA0WUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVA0WUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVA0WUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:20:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:61609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261245AbVA0WSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:18:33 -0500
Date: Thu, 27 Jan 2005 14:23:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: kernel bad access while booting diskless client
Message-Id: <20050127142333.0ba81907.akpm@osdl.org>
In-Reply-To: <20050127215619.56535.qmail@web52309.mail.yahoo.com>
References: <20050127215619.56535.qmail@web52309.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Herranz <albert_herranz@yahoo.es> wrote:
>
> Hi,
> 
> I'm getting a kernel Oops while booting 2.6.11-rc2-mm1
> on a diskless (nfsroot based) embedded ppc system.
> Vanilla 2.6.11-rc2 works Ok.
> 
> [...]
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 112k init
> INIT: version 2.86 booting
> Oops: kernel access of bad area, sig: 11 [#1]
> [...]
> TASK = c1643ae0[1] 'init' THREAD: c1646000
> Last syscall: 106
> [...]
> NIP [c0060934] vfs_getattr+0x1c/0xa8
> LR [c0060a14] vfs_stat+0x54/0x64
> Call trace:
>  [c0060a14] vfs_sysstat+0x54/0x64
>  [c0060f24] sys_newstat+0x1c/0x54
>  [c0003c40] ret_from_syscall+0x0/0x44
> Kernel panic - not syncing: Attempted to kill init!
> 
> 
> The cause of the bad access is a null inode->i_op
> field that is passed to vfs_getattr() through the
> corresponding struct dentry.
> It triggers when vfs_getattr() blindly tries to check
> inode->i_op->getattr without first checking that
> inode->i_op is useable.
> 
> The attached patch workarounds the problem, by
> checking inode->i_op before using it.
> 
> It is still unknown to me which code change is causing
> now the appearance of the null i_op field on -rc2-mm1.
> But probably you guys have better clues than me.
> 

OK, that's super-helpful, thanks.

> --- a/fs/stat.c	2004-12-24 22:34:02.000000000 +0100
> +++ b/fs/stat.c	2005-01-27 00:52:15.000000000 +0100
> @@ -47,7 +47,7 @@ int vfs_getattr(struct vfsmount *mnt, st
>  	if (retval)
>  		return retval;
>  
> -	if (inode->i_op->getattr)
> +	if (inode->i_op && inode->i_op->getattr)
>  		return inode->i_op->getattr(mnt, dentry, stat);
>  
>  	generic_fillattr(inode, stat);
> 
> 
> 

Can you tell us which filesystem is being bad?  Add this:

	if (!inode->i_op)
		printk("%s is naughty\n", inode->i_sb->s_id);

It's probably NFS - there has been some work done in there in -mm.
