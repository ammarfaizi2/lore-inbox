Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUHHO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUHHO2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUHHO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 10:28:32 -0400
Received: from colin2.muc.de ([193.149.48.15]:35335 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265398AbUHHO2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 10:28:30 -0400
Date: 8 Aug 2004 16:28:29 +0200
Date: Sun, 8 Aug 2004 16:28:29 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow to disable shmem.o
Message-ID: <20040808142829.GC94449@muc.de>
References: <m3vffulhou.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0408081248560.1443-100000@localhost.localdomain> <20040808140705.GH16310@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808140705.GH16310@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 09:07:05AM -0500, Matt Mackall wrote:
> +extern struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev);
> +extern struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
> +	 int flags, const char *dev_name, void *data);
> +extern struct file_operations ramfs_file_operations;
> +extern struct vm_operations_struct generic_file_vm_ops;

This should be all in header files.

> + */
> +struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags)
> +{
> +	int error;
> +	struct file *file;
> +	struct inode *inode;
> +	struct dentry *dentry, *root;
> +	struct qstr this;
> +
> +	if (IS_ERR(shm_mnt))
> +		return (void *)shm_mnt;

Why this strange cast? 

> +
> +	error = -ENOMEM;
> +	this.name = name;
> +	this.len = strlen(name);
> +	this.hash = 0; /* will go */
> +	root = shm_mnt->mnt_root;
> +	dentry = d_alloc(root, &this);
> +	if (!dentry)
> +		goto put_memory;
> +
> +	error = -ENFILE;
> +	file = get_empty_filp();
> +	if (!file)
> +		goto put_dentry;
> +
> +	error = -ENOSPC;
> +	inode = ramfs_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);

Hmm, won't this allow everybody else to open it in /proc/pid/fd/ ? 
(existing shmem.c seems to use it too, but it looks a bit bogus) 

-AndI
