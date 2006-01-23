Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWAWFXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWAWFXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAWFXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:23:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932155AbWAWFXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:23:44 -0500
Date: Sun, 22 Jan 2006 21:22:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <jblunck@suse.de>
Cc: viro@zeniv.linux.org.uk, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_dcache_parent() races against
 shrink_dcache_memory()
Message-Id: <20060122212243.20ce26c5.akpm@osdl.org>
In-Reply-To: <20060120203645.GF24401@hasse.suse.de>
References: <20060120203645.GF24401@hasse.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <jblunck@suse.de> wrote:
>
> Kirill Korotaev <dev@sw.ru> discovered a race between shrink_dcache_parent()
> and shrink_dcache_memory(). That one is based on dput() is calling
> dentry_iput() too early and therefore is giving up the dcache_lock. This leads
> to the situation that the parent dentry might be still referenced although all
> childs are already dead. This parent is ignore by a concurrent select_parent()
> call which might be the reason for busy inode after umount failures.
> 
> This is from Kirill's original patch:
> 
> CPU 1                    CPU 2
> ~~~~~                    ~~~~~
> umount /dev/sda1
> generic_shutdown_super   shrink_dcache_memory
> shrink_dcache_parent     prune_one_dentry
> select_parent            dput     <<<< child is dead, locks are released,
>                                        but parent is still referenced!!! >>>>
> skip dentry->parent,
> since it's d_count > 0
> 
> message: BUSY inodes after umount...
>                                   <<< parent is left on dentry_unused list,
>                                       referencing freed super block >>>
> 
> This patch is introducing dput_locked() which is doing all the dput work
> except of freeing up the dentry's inode and memory itself. Therefore, when the
> dcache_lock is given up, all the reference counts of the parents are correct.
> prune_one_dentry() must also use the dput_locked version and free up the
> inodes and the memory of the parents later. Otherwise we have an incorrect
> reference count on the parents of the dentry to prune.
> 
> ...

> -void dput(struct dentry *dentry)
> +static void dput_locked(struct dentry *dentry, struct list_head *list)
>  {
>  	if (!dentry)
>  		return;
>  
> -repeat:
> -	if (atomic_read(&dentry->d_count) == 1)
> -		might_sleep();
> -	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
> +	if (!atomic_dec_and_test(&dentry->d_count))
>  		return;
>  
> +
>
> ...
>
> +void dput(struct dentry *dentry)
> +{
> +	LIST_HEAD(free_list);
> +
> +	if (!dentry)
> +		return;
> +
> +	if (atomic_add_unless(&dentry->d_count, -1, 1))
> +		return;
> +
> +	spin_lock(&dcache_lock);
> +	dput_locked(dentry, &free_list);
> +	spin_unlock(&dcache_lock);

This seems to be an open-coded copy of atomic_dec_and_lock()?

