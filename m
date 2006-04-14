Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWDNDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWDNDnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 23:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWDNDnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 23:43:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35553 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751243AbWDNDnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 23:43:41 -0400
Date: Fri, 14 Apr 2006 13:43:33 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: shrink_dcache_sb scalability problem.
Message-ID: <20060414034332.GN1484909@melbourne.sgi.com>
References: <20060413082210.GM1484909@melbourne.sgi.com> <20060413015257.5b9d0972.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413015257.5b9d0972.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 01:52:57AM -0700, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >
> > After recently upgrading a build machine to 2.6.16, we started seeing
> > 10-50s pauses where the machine would appear to hang.
> 
> This sounds like the recent thread "Avoid excessive time spend on concurrent
> slab shrinking" over on linux-mm.  Have you read through that?
> 
> http://marc.theaimsgroup.com/?l=linux-mm&r=1&b=200603&w=2
> http://marc.theaimsgroup.com/?l=linux-mm&r=3&b=200604&w=2

Yes, I even made comments directly in the thread and it really
wasn't a problem with the slab shrinking infrastructure. It
was (obvious to us XFS folk) just another XFS inode caching
scalability problem that this machine has uncovered over
the past few years.

> It ended up somewaht inconclusive, but it looks like we do have a bit of a
> problem, but it got exacerbated by an XFS slowness.

I've already fixed that problem with:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1fc5d959d88a5f77aa7e4435f6c9d0e2d2236704

and the machine showing the shrink_dcache_sb() problems is
already running that fix. That problem masked the shrink_dcache_sb
one - who notices a 10s hang when the machine has been really,
really slow for 20 minutes?

So this is not (directly) related to reclaim of inodes or dentries.
It can be seen during reclaim of dentries if someone is mounting or
unmounting a filesystem at the same time, but fundamentally it's
a result of a large number of cached dentries on a single list
protected by a single lock and having to walk that list atomically.

Given the complexity of the dcache, I really don't know enough
about it or have the time available to invest in learning all I
need to know about it to solve the problem. That's why I'm
asking for help from the experts....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
