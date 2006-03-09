Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWCIGdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWCIGdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWCIGdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:33:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:44681 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751001AbWCIGdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:33:41 -0500
Date: Thu, 9 Mar 2006 12:03:30 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jan Blunck <jblunck@suse.de>
Cc: akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de, neilb@suse.de,
       dev@openvz.org, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309063330.GA23256@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060308145105.GA4243@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308145105.GA4243@hasse.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 03:51:05PM +0100, Jan Blunck wrote:
> Andrew, I have test this patch for a while now and none of the users has seen
> the "busy inodes" message for a while now. Can you please apply and test it in
> -mm?
> 
> This is an updated version of the patch which adresses some issues that came
> up during discussion. Although sb->prunes usually is 0, I'm testing it now
> before calling wake_up(). Besides that, the shrink_dcache_parent() is only
> waiting for prunes if we are called through generic_shutdown_super() when
> sb->s_root is NULL.
> 
> Original patch description:
> 
> Kirill Korotaev <dev@sw.ru> discovered a race between shrink_dcache_parent()
> and shrink_dcache_memory() which leads to "Busy inodes after unmount".
> When unmounting a file system shrink_dcache_parent() is racing against a
> possible shrink_dcache_memory(). This might lead to the situation that
> shrink_dcache_parent() is returning too early. In this situation the
> super_block is destroyed before shrink_dcache_memory() could put the inode.
> 
> This patch fixes the problem through introducing a prunes counter which is
> incremented when a dentry is pruned but the corresponding inoded isn't put
> yet.When the prunes counter is not null, shrink_dcache_parent() is waiting and
> restarting its work.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>

Looks good, small cosmetic comment below

<snip>

> +/*
> + * If we slept on waiting for other prunes to finish, there maybe are
> + * some dentries the d_lru list that we have "overlooked" the last
> + * time we called select_parent(). Therefor lets restart in this case.
> + */
>  void shrink_dcache_parent(struct dentry * parent)
>  {
>  	int found;
> +	struct super_block *sb = parent->d_sb;
>  
> + again:
>  	while ((found = select_parent(parent)) != 0)
>  		prune_dcache(found);
> +
> +	/* If we are called from generic_shutdown_super() during
> +	 * umount of a filesystem, we want to check for other prunes */
> +	if (!sb->s_root && wait_on_prunes(sb))
> +		goto again;
>  }

cosmetic - could we do this with a do { } while() loop instead of a goto?

I think though that after select_parent(), wait_on_prunes() can sleep just
once, so we do not need a goto. Just calling wait_on_prunes() should
fix the race. For all the dentries missed in the race, wait_on_parent()
will ensure that they are dput() by prune_one_dentry() before wait_on_parent()
returns.

But, I do not have anything against the goto, so this patch should be just
fine.

<snip>

>  	if (root) {
>  		sb->s_root = NULL;
> -		shrink_dcache_parent(root);
>  		shrink_dcache_anon(&sb->s_anon);
> +		shrink_dcache_parent(root);
>  		dput(root);

This change might conflict with the NFS patches in -mm.

<snip>

Thanks,
Balbir
