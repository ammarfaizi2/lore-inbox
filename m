Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVBTXgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVBTXgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 18:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBTXgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 18:36:49 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:58884 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262110AbVBTXgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 18:36:39 -0500
Message-ID: <42191ED8.8030303@tu-harburg.de>
Date: Mon, 21 Feb 2005 00:35:52 +0100
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
References: <m34qg84em2.fsf@bzzz.home.net> <m3zmy02zq5.fsf@bzzz.home.net>
In-Reply-To: <m3zmy02zq5.fsf@bzzz.home.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> +static inline struct semaphore * lock_sem(struct inode *dir, struct qstr *name)
> +{
> +	if (IS_PDIROPS(dir)) {
> +		struct super_block *sb;
> +		/* name->hash expected to be already calculated */
> +		sb = dir->i_sb;
> +		BUG_ON(sb->s_pdirops_sems == NULL);
> +		return sb->s_pdirops_sems + name->hash % sb->s_pdirops_size;
> +	}
> +	return &dir->i_sem;
> +}
> +
> +static inline void lock_dir(struct inode *dir, struct qstr *name)
> +{
> +	down(lock_sem(dir, name));
> +}
> +

> @@ -1182,12 +1204,26 @@
>  /*
>   * p1 and p2 should be directories on the same fs.
>   */
> -struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
> +struct dentry *lock_rename(struct dentry *p1, struct qstr *n1,
> +				struct dentry *p2, struct qstr *n2)
>  {
>  	struct dentry *p;
>  
>  	if (p1 == p2) {
> -		down(&p1->d_inode->i_sem);
> +		if (IS_PDIROPS(p1->d_inode)) {
> +			unsigned int h1, h2;
> +			h1 = n1->hash % p1->d_inode->i_sb->s_pdirops_size;
> +			h2 = n2->hash % p2->d_inode->i_sb->s_pdirops_size;
> +			if (h1 < h2) {
> +				lock_dir(p1->d_inode, n1);
> +				lock_dir(p2->d_inode, n2);
> +			} else if (h1 > h2) {
> +				lock_dir(p2->d_inode, n2);
> +				lock_dir(p1->d_inode, n1);
> +			} else
> +				lock_dir(p1->d_inode, n1);
> +		} else
> +			down(&p1->d_inode->i_sem);
>  		return NULL;
>  	}
>  
> @@ -1195,31 +1231,35 @@
>  
>  	for (p = p1; p->d_parent != p; p = p->d_parent) {
>  		if (p->d_parent == p2) {
> -			down(&p2->d_inode->i_sem);
> -			down(&p1->d_inode->i_sem);
> +			lock_dir(p2->d_inode, n2);
> +			lock_dir(p1->d_inode, n1);
>  			return p;
>  		}
>  	}
>  
>  	for (p = p2; p->d_parent != p; p = p->d_parent) {
>  		if (p->d_parent == p1) {
> -			down(&p1->d_inode->i_sem);
> -			down(&p2->d_inode->i_sem);
> +			lock_dir(p1->d_inode, n1);
> +			lock_dir(p2->d_inode, n2);
>  			return p;
>  		}
>  	}
>  
> -	down(&p1->d_inode->i_sem);
> -	down(&p2->d_inode->i_sem);
> +	lock_dir(p1->d_inode, n1);
> +	lock_dir(p2->d_inode, n2);
>  	return NULL;
>  }

With luck you have s_pdirops_size (or 1024) different renames altering 
concurrently one directory inode. Therefore you need a lock protecting 
your filesystem data. This is basically the job done by i_sem. So in my 
opinion you only move "The Problem" from the VFS to the lowlevel 
filesystems. But then there is no need for i_sem or your s_pdirops_sems 
anymore.

Regards,
Jan
