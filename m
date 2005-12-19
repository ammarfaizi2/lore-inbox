Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVLSWej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVLSWej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVLSWej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:34:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45255 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965013AbVLSWei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:34:38 -0500
Date: Mon, 19 Dec 2005 16:34:35 -0600
From: Cliff Wickman <cpw@sgi.com>
To: John F Flynn III <flynnj@cs.fiu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very rare crash in prune_dcache
Message-ID: <20051219223435.GA2576@sgi.com>
References: <43A7286F.3080104@cs.fiu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A7286F.3080104@cs.fiu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen the below on at 2.6.5 kernel (SuSE SLES9) at SGI.
Does it look like your crash?

The panic is by kswapd0:

    <1>Unable to handle kernel NULL pointer dereference (address
0000000000000078)
    <4>kswapd0[122]: Oops 8813272891392 [1]

whose stack shows:
[<a0000001001cecf0>] clear_inode+0x1b0/0x2c0
[<a0000001001d03d0>] generic_drop_inode+0x3b0/0x400
[<a0000001001ccf30>] iput+0x130/0x1c0
[<a00000020b6f0cd0>] nfs_dentry_iput+0x170/0x1c0 [nfs]
[<a0000001001ca050>] prune_dcache+0x510/0x540
[<a0000001001ca0c0>] shrink_dcache_memory+0x40/0x80
[<a00000010014c360>] shrink_slab+0x2e0/0x440

Both generic_shutdown_super()'s calls to shrink_dcache_parent() or
shrink_dcache_anon(), and kswapd0's call to shrink_dcache_memory()
call prune_dcache().
I suspect a race condition inside prune_dcache().

The prune_dcache() function:
        lock dcache_lock
        scan the dentry_unused list of dentry's for a given number ("count") of
        dentry's to free:
                if a dentry to free, call prune_one_dentry()
                        dentry_iput()
                                unlock dcache_lock
                                iput() any associated inode
                        d_free() the dentry
                        lock dcache_lock
        unlock dcache_lock

Two processors entering prune_dcache() near the same time will both scan
the dentry_unused list and could try to iput() the same inode twice.  That is
because the dcache_lock is released while running iput().

I suppose the dcache_lock must be released here because the iput() may take
a long time.  And the dcache_lock is used many places in the system
to protect the dentry cache's lists.

It would seem to me that a straighforward fix would be to add another
lock to protect just the scan of the dentry_unused list only here in
prune_dcache()

-Cliff Wickman

On Mon, Dec 19, 2005 at 04:38:55PM -0500, John F Flynn III wrote:
> Good evening, folks...
> 
> We have been experiencing a very rare (on average once every two to 
> three months) crash on some of our servers.
> 
> uname -a:
> Linux cheetah 2.6.9-22.0.1.ELsmp #1 SMP Thu Oct 27 13:14:25 CDT 2005 
> i686 i686 i386 GNU/Linux
> 
> (This is a CentOS provided kernel)
> 
> Here is a photo of the bottom of the panic. Unfortunately the kernel has 
> no chance to log this anywhere else:
> 
> http://www.cs.fiu.edu/~flynnj/cheetah-crash.jpg
> 
> 
> The crash appears to be in prune_dcache, and has happened on several 
> distinct machines, so we do not believe it is a hardware problem.
> 
> If anyone has pointers on what bug could be causing this crash, or if 
> it's been fixed in newer kernels we could try, it would be greatly 
> appreciated. This only seems to happen on loaded production machines, 
> and it happens so rarely that more detailed debugging is nearly impossible.
> 
> Thanks in advance,
> -John Flynn
> 
> -- 
> John Flynn                              flynnj@cs.fiu.edu
> =========================================================
> Systems and Network Administration             /\_/\
> School of Computer Science                    ( O.O )
> Florida International University               >   <
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cliff Wickman
Silicon Graphics, Inc.
cpw@sgi.com
(651) 683-3824
