Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWDNFXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWDNFXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 01:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWDNFXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 01:23:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965102AbWDNFXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 01:23:45 -0400
Date: Thu, 13 Apr 2006 22:23:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: shrink_dcache_sb scalability problem.
Message-Id: <20060413222325.77f9ec9b.akpm@osdl.org>
In-Reply-To: <20060414034332.GN1484909@melbourne.sgi.com>
References: <20060413082210.GM1484909@melbourne.sgi.com>
	<20060413015257.5b9d0972.akpm@osdl.org>
	<20060414034332.GN1484909@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> On Thu, Apr 13, 2006 at 01:52:57AM -0700, Andrew Morton wrote:
>  > David Chinner <dgc@sgi.com> wrote:
>  > >
>  > > After recently upgrading a build machine to 2.6.16, we started seeing
>  > > 10-50s pauses where the machine would appear to hang.
>  > 
>  > This sounds like the recent thread "Avoid excessive time spend on concurrent
>  > slab shrinking" over on linux-mm.  Have you read through that?
>  > 
>  > http://marc.theaimsgroup.com/?l=linux-mm&r=1&b=200603&w=2
>  > http://marc.theaimsgroup.com/?l=linux-mm&r=3&b=200604&w=2
> 
>  Yes, I even made comments directly in the thread and it really
>  wasn't a problem with the slab shrinking infrastructure. It
>  was (obvious to us XFS folk) just another XFS inode caching
>  scalability problem that this machine has uncovered over
>  the past few years.

OK.

>  > It ended up somewaht inconclusive, but it looks like we do have a bit of a
>  > problem, but it got exacerbated by an XFS slowness.
> 
>  I've already fixed that problem with:
> 
>  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1fc5d959d88a5f77aa7e4435f6c9d0e2d2236704
> 
>  and the machine showing the shrink_dcache_sb() problems is
>  already running that fix. That problem masked the shrink_dcache_sb
>  one - who notices a 10s hang when the machine has been really,
>  really slow for 20 minutes?

So the problem is shrink_dcache_sb() and not regular memory reclaim?

What is happening on that machine to be triggering shrink_dcache_sb()? 
automounts?

We fixed a similar problem in the inode cache a year or so back by creating
per-superblock inode lists, so that
search-a-global-list-for-objects-belonging-to-this-superblock thing went
away.  Presumably we could fix this in the same manner.  But adding two
more pointers to struct dentry would hurt.

An alternative might be to remove the global LRU altogether, make it
per-superblock.  That would reduce the quality of the LRUing, but that
probably wouldn't hurt a lot.

Another idea would be to take shrinker_sem for writing when running
shrink_dcache_sb() - that would prevent tasks from coming in and getting
stuck on dcache_lock, but there are plentry of other places which want
dcache_lock.

I don't immediately see any simple tweaks which would allow us to avoid that
long lock hold time.  Perhaps the scanning in shrink_dcache_sb() could use
just rcu_read_lock()...

OT, I'm a bit curious about this:

		list_del_init(tmp);
		spin_lock(&dentry->d_lock);
		if (atomic_read(&dentry->d_count)) {
			spin_unlock(&dentry->d_lock);
			continue;
		}

So we rip the dentry off dcache_unused and just leave it floating about? 
Dipankar, do you remember why that change was made, and why it's not a bug?


