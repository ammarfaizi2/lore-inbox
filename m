Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVCKRHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVCKRHz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVCKRHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:07:54 -0500
Received: from [205.233.219.253] ([205.233.219.253]:48353 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261211AbVCKRHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:07:46 -0500
Date: Fri, 11 Mar 2005 12:04:49 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       willy@debian.org, nathans@sgi.com
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-ID: <20050311170449.GS1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <20050311053144.GP1111@conscoop.ottawa.on.ca> <20050310215652.76c47856.akpm@osdl.org> <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 12:27:47PM +0000, Matthew Wilcox wrote:

> > But I guess it's a bit hard to justify adding more infrastructure to
> > support a single callsite which has a simple alternative.  So if you could
> > please add the separate counter?
> 
> It's pretty *small* infrastructure, and it gives me something to whine at
> people about when they use atomic_read on something that isn't an atomic.

Agreed, but I don't mind adding a separate counter.  However...

> If we are going to get rid of sem_getcount, could we rename the 'count'
> variables, at least on i386 and ppc to make it clear that you're not
> supposed to do this ... maybe to 'count_$ARCH'?

I'm working on a patch to do just that.  It fails when building XFS:

fs/xfs/xfs_inode_item.c: In function `xfs_inode_item_pushbuf':
fs/xfs/xfs_inode_item.c:803: error: structure has no member named `count'
fs/xfs/xfs_inode_item.c:825: error: structure has no member named `count'

fs/xfs/linux-2.6/sema.h:
#define valusema(sp)                    (atomic_read(&(sp)->count))

It seems getting the value of a semaphore is more common than it appears
at first glance.  I don't see how this code could possibly work on
parisc.  Therefore I propose:

1. Adding sem_getcount() everywhere, as in my original patch.
2. Renaming count to count_$ARCH as willy suggested.
3. Anyone who abuses semaphores will now break.  Fix them to use
   sem_getcount().

I'll work on that over the weekend unless anyone has any better ideas.

Jody


> 
> -- 
> "Next the statesmen will invent cheap lies, putting the blame upon 
> the nation that is attacked, and every man will be glad of those
> conscience-soothing falsities, and will diligently study them, and refuse
> to examine any refutations of them; and thus he will by and by convince 
> himself that the war is just, and will thank God for the better sleep 
> he enjoys after this process of grotesque self-deception." -- Mark Twain

-- 
