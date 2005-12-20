Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVLTGmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVLTGmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 01:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVLTGmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 01:42:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40664 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750811AbVLTGmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 01:42:14 -0500
Date: Tue, 20 Dec 2005 12:16:29 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Cliff Wickman <cpw@sgi.com>
Cc: John F Flynn III <flynnj@cs.fiu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Very rare crash in prune_dcache
Message-ID: <20051220064629.GA31099@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <43A7286F.3080104@cs.fiu.edu> <20051219223435.GA2576@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219223435.GA2576@sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cliff,

On Mon, Dec 19, 2005 at 04:34:35PM -0600, Cliff Wickman wrote:
> We've seen the below on at 2.6.5 kernel (SuSE SLES9) at SGI.
> Does it look like your crash?
> 
> The panic is by kswapd0:
> 
>     <1>Unable to handle kernel NULL pointer dereference (address
> 0000000000000078)
>     <4>kswapd0[122]: Oops 8813272891392 [1]
> 
> whose stack shows:
> [<a0000001001cecf0>] clear_inode+0x1b0/0x2c0
> [<a0000001001d03d0>] generic_drop_inode+0x3b0/0x400
> [<a0000001001ccf30>] iput+0x130/0x1c0
> [<a00000020b6f0cd0>] nfs_dentry_iput+0x170/0x1c0 [nfs]
> [<a0000001001ca050>] prune_dcache+0x510/0x540
> [<a0000001001ca0c0>] shrink_dcache_memory+0x40/0x80
> [<a00000010014c360>] shrink_slab+0x2e0/0x440
> 
> Both generic_shutdown_super()'s calls to shrink_dcache_parent() or
> shrink_dcache_anon(), and kswapd0's call to shrink_dcache_memory()
> call prune_dcache().
> I suspect a race condition inside prune_dcache().
> 
> The prune_dcache() function:
>         lock dcache_lock
>         scan the dentry_unused list of dentry's for a given number ("count") of
>         dentry's to free:
>                 if a dentry to free, call prune_one_dentry()
>                         dentry_iput()
>                                 unlock dcache_lock
>                                 iput() any associated inode
>                         d_free() the dentry
>                         lock dcache_lock
>         unlock dcache_lock
> 
> Two processors entering prune_dcache() near the same time will both scan
> the dentry_unused list and could try to iput() the same inode twice.  That is
> because the dcache_lock is released while running iput().
> 
> I suppose the dcache_lock must be released here because the iput() may take
> a long time.  And the dcache_lock is used many places in the system
> to protect the dentry cache's lists.
> 
> It would seem to me that a straighforward fix would be to add another
> lock to protect just the scan of the dentry_unused list only here in
> prune_dcache()
> 

Isn't this what dcache_lock doing presently ? As per vanilla 2.6.5 kernel
I don't see how the race condition you mention above can happen.

In prune_dcache(), a dentry is first removed off the dentry_unused list
(under dcache_lock) before calling prune_one_dentry(). So how is it 
possible that an another thread executing prune_dcache() will hit
the same dentry again ?

Regards,
Bharata.
