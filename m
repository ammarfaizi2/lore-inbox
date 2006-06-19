Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWFSBA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWFSBA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWFSBA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:00:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26596 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750835AbWFSBA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:00:58 -0400
Date: Mon, 19 Jun 2006 11:00:13 +1000
From: David Chinner <dgc@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Jan Blunck <jblunck@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060619010013.GC2114946@melbourne.sgi.com>
References: <20060601095125.773684000@hasse.suse.de> <17539.35118.103025.716435@cse.unsw.edu.au> <20060616155120.GA6824@hasse.suse.de> <17555.12234.347353.670918@cse.unsw.edu.au> <20060618235654.GB2114946@melbourne.sgi.com> <17557.61307.364404.640539@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17557.61307.364404.640539@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 10:27:39AM +1000, Neil Brown wrote:
> On Monday June 19, dgc@sgi.com wrote:
> > 
> > > I can see that shrink_dcache_sb could take a long time and should be
> > > fixed, which should be as simple as replacing it with
> > > shrink_dcache_parent; shrink_dcache_anon.
> > 
> > But these are not guaranteed to reclaim all the dentries from a given
> > superblock. Yes, they move the dentries to the LRU, but other activity in the
> > system means that they may not get reclaimed during the subsequent calls
> > to prune_dcache() and hence they may live beyond the unmount....
> > 
> 
> My proposed patch earlier in this thread (I can post it again if you
> like) addresses exactly this issue.  Instead of moving dentries to the
> global LRU, it moves them to a private LRU, and the calls prune_dcache
> on that.  So there is no room for other activity to get in the way of
> prune_dcache doing what needs to be done.

Ok. That sounds like it would work.


> > > But I'm still puzzled as to why a long dcache LRU slows down
> > > unmounting. 
> > > 
> > > Can you give more details?
> > 
> > It's not the unmount that slows down - it's the fact that the dcache lock
> > is held for so long that rest of the system halts for time it takes
> > to run shrink_dcache_sb(). We've seen up to 50s to do a (touch fred; rm fred)
> > when the LRU has grown to several million dentries and shrink_dcache_sb()
> > is running. When this happens, it's not uncommon to see every CPU in the
> > machine spinning on the dcache_lock...
> 
> Definitely a problem.
> Maybe it was hoped that the call to cond_resched_lock(&dcache_lock)
> would avoid this, but apparently not.

The first pass over the LRU doesn't even do that....

> I still maintain that we should replace shrink_dcache_sb with calls to
> shrink_dcache_anon and shrink_dcache_parent.  That, together with my
> previous patch, should fix this problem quite cleanly.  If I send you
> a combined patch against the latest -mm can you test?

Ok. Send me the patch and I'll try to get some tests done on it...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
