Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263193AbVGODOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbVGODOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbVGODOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:14:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263187AbVGODMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:12:35 -0400
Date: Thu, 14 Jul 2005 20:11:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-Id: <20050714201120.73570316.akpm@osdl.org>
In-Reply-To: <42D72705.8010306@tu-harburg.de>
References: <42D72705.8010306@tu-harburg.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <j.blunck@tu-harburg.de> wrote:
>
> This patch adds bogo dirent sizes for ramfs like already available for 
> tmpfs.
> 
> Although i_size of directories isn't covered by the POSIX standard it is 
> a bad idea to always set it to zero. Therefore pretend a bogo dirent 
> size for directory i_sizes.
> 

Does it really matter?

+static int ramfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
> +{
> +	dir->i_size += BOGO_DIRENT_SIZE;
> +	return simple_link(old_dentry, dir, dentry);
> +}
> +
> +static int ramfs_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	dir->i_size -= BOGO_DIRENT_SIZE;
> +	return simple_unlink(dir, dentry);
> +}
> +
> +static int ramfs_rmdir(struct inode *dir, struct dentry *dentry)
> +{
> +	int ret;
> +
> +	ret = simple_rmdir(dir, dentry);
> +	if (ret != -ENOTEMPTY)
> +		dir->i_size -= BOGO_DIRENT_SIZE;
> +
> +	return ret;
> +}
> +
> +static int ramfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> +			struct inode *new_dir, struct dentry *new_dentry)
> +{
> +	int ret;
> +
> +	ret = simple_rename(old_dir, old_dentry, new_dir, new_dentry);
> +	if (ret != -ENOTEMPTY) {
> +		old_dir->i_size -= BOGO_DIRENT_SIZE;
> +		new_dir->i_size += BOGO_DIRENT_SIZE;
> +	}
> +
> +	return ret;
> +}
> +

I wonder if these should be in libfs - sysfs has the same problem, for
example and someone might want to come along and fix that up too.
