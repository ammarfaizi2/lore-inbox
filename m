Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUHaUHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUHaUHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUHaT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:56:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7334 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269074AbUHaTwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:52:31 -0400
Message-ID: <4134D6E8.9050502@pobox.com>
Date: Tue, 31 Aug 2004 15:52:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] tiny shmem/tmpfs replacement
References: <200408311914.i7VJE6VX021726@hera.kernel.org>
In-Reply-To: <200408311914.i7VJE6VX021726@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1882, 2004/08/31 10:34:47-07:00, mpm@selenic.com
> 
> 	[PATCH] tiny shmem/tmpfs replacement
> 	
> 	A patch to replace tmpfs/shmem with ramfs for systems without swap,
> 	incorporating the suggestions from Andi and Hugh.  It uses ramfs instead.
> 	
> 	Signed-off-by: Matt Mackall <mpm@selenic.com>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

this change needs lib-izing...


> diff -Nru a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> --- a/fs/ramfs/inode.c	2004-08-31 12:14:15 -07:00
> +++ b/fs/ramfs/inode.c	2004-08-31 12:14:15 -07:00
> @@ -31,6 +31,7 @@
>  #include <linux/string.h>
>  #include <linux/smp_lock.h>
>  #include <linux/backing-dev.h>
> +#include <linux/ramfs.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -39,7 +40,6 @@
>  
>  static struct super_operations ramfs_ops;
>  static struct address_space_operations ramfs_aops;
> -static struct file_operations ramfs_file_operations;
>  static struct inode_operations ramfs_file_inode_operations;
>  static struct inode_operations ramfs_dir_inode_operations;
>  
> @@ -48,7 +48,7 @@
>  	.memory_backed	= 1,	/* Does not contribute to dirty memory */
>  };
>  
> -static struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
> +struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
>  {
>  	struct inode * inode = new_inode(sb);
>  
> @@ -146,7 +146,7 @@
>  	.commit_write	= simple_commit_write
>  };
>  
> -static struct file_operations ramfs_file_operations = {
> +struct file_operations ramfs_file_operations = {
>  	.read		= generic_file_read,
>  	.write		= generic_file_write,
>  	.mmap		= generic_file_mmap,
> @@ -199,7 +199,7 @@
>  	return 0;
>  }
>  
> -static struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
> +struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data)
>  {
>  	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
> diff -Nru a/include/linux/ramfs.h b/include/linux/ramfs.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/include/linux/ramfs.h	2004-08-31 12:14:15 -07:00
> @@ -0,0 +1,11 @@
> +#ifndef _LINUX_RAMFS_H
> +#define _LINUX_RAMFS_H
> +
> +struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev);
> +struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
> +	 int flags, const char *dev_name, void *data);
> +
> +extern struct file_operations ramfs_file_operations;
> +extern struct vm_operations_struct generic_file_vm_ops;
> +
> +#endif
> diff -Nru a/mm/filemap.c b/mm/filemap.c
> --- a/mm/filemap.c	2004-08-31 12:14:15 -07:00
> +++ b/mm/filemap.c	2004-08-31 12:14:15 -07:00
> @@ -1488,7 +1488,7 @@
>  	return 0;
>  }
>  
> -static struct vm_operations_struct generic_file_vm_ops = {
> +struct vm_operations_struct generic_file_vm_ops = {
>  	.nopage		= filemap_nopage,
>  	.populate	= filemap_populate,
>  };

a lot of this is libfs material, for example.

	Jeff


