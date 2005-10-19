Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVJSB6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVJSB6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJSB6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:58:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:54470 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932149AbVJSB6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:58:45 -0400
Date: Tue, 18 Oct 2005 21:58:40 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051019015840.GC1027@watt.suse.com>
References: <20051018082609.GC15717@x30.random> <20051018171335.3b308b3e.akpm@osdl.org> <20051019004018.GZ1027@watt.suse.com> <20051018181548.760dbf8c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018181548.760dbf8c.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 06:15:48PM -0700, Andrew Morton wrote:
> > > Well according to my assertion (below), the inode in __sync_single_inode()
> > > cannot have a zero refcount, so the whole if() statement is never executed.
> > 
> > generic_forget_inode->write_inode_now->__writeback_single_inode->
> > __sync_single_inode
> 
> oshit.

When does this ever happen?  Just for private inodes released during
put_super right?

> 
> > We do have I_WILL_FREE, but i_count will be zero.
> 
> yup.
> 
> > > 
> > > The thinking behind that increment is that __sync_single_inode() has just
> > > taken a dirty, zero-refcount inode and has cleaned it.  A dirty inode
> > > cannot have previously been on inode_unused, hence we now are newly moving
> > > it to inode_unused.
> > 
> > nr_unused doesn't seem to count the number of inodes on the unused list.
> > It is actually counting the number of inodes whose i_count is 0.  See
> > generic_forget_inode and invalidate_list to see what I mean.
> 
> hm, OK.  It'd be nice to make that more explicit.  Something like this?

Well, I can't quite convince myself it is wrong, but when 
(!sb || (sb->s_flags & MS_ACTIVE), we're dropping the
inode_lock with an inode with i_count == 0 and nr_unused hasn't been
incremented.

So, if someone (sync_sb_inodes?) comes in and runs __iget,
the counts end up wrong.  Then again, whoever ran __iget would also run
iput and things would go horribly wrong anyway.

Did I mention the part where Andrea and I are hunting a bug where the
count of unused inodes goes negative and the everyone ends up spinning
in shrink_icache_memory?  Andrea's patch doesn't fix the spinning, but
it might have fixed the unused inode count going negative.  We're
waiting for another reproduce on the ppc64 race monster.

> 
> --- devel/fs/inode.c~generic_forget_inode-nr_unused-cleanup	2005-10-18 18:13:22.000000000 -0700
> +++ devel-akpm/fs/inode.c	2005-10-18 18:13:57.000000000 -0700
> @@ -1067,8 +1067,8 @@ static void generic_forget_inode(struct 
>  	if (!hlist_unhashed(&inode->i_hash)) {
>  		if (!(inode->i_state & (I_DIRTY|I_LOCK)))
>  			list_move(&inode->i_list, &inode_unused);
> -		inodes_stat.nr_unused++;
>  		if (!sb || (sb->s_flags & MS_ACTIVE)) {
> +			inodes_stat.nr_unused++;  /* One more 0-ref inode */
>  			spin_unlock(&inode_lock);
>  			return;
>  		}
> @@ -1077,7 +1077,6 @@ static void generic_forget_inode(struct 
>  		write_inode_now(inode, 1);
>  		spin_lock(&inode_lock);
>  		inode->i_state &= ~I_WILL_FREE;
> -		inodes_stat.nr_unused--;
>  		hlist_del_init(&inode->i_hash);
>  	}
>  	list_del_init(&inode->i_list);
> _
> 
> > generic_forget_inode took care of incrementing the unused count when
> > i_count went to zero. So, I don't think we need to worry about the
> > unused count in __writeback_single_inode.
> > 
> 
> How about this for now?

This part looks good.

-chris

