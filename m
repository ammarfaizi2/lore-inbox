Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWFBER6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWFBER6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWFBER6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:17:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11969 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751100AbWFBER5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:17:57 -0400
Date: Fri, 2 Jun 2006 14:17:14 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060602041714.GZ7418631@melbourne.sgi.com>
References: <20060601095125.773684000@hasse.suse.de> <20060601180659.56e69968.akpm@osdl.org> <20060602022339.GY7418631@melbourne.sgi.com> <20060601194912.8173705a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601194912.8173705a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 07:49:12PM -0700, Andrew Morton wrote:
> On Fri, 2 Jun 2006 12:23:39 +1000 David Chinner <dgc@sgi.com> wrote:
> > On Thu, Jun 01, 2006 at 06:06:59PM -0700, Andrew Morton wrote:
> > > Please, we'll need much much more description of what this is trying to
> > > achieve, why it exists, analysis, testing results, etc, etc.  Coz my
> > > immediate reaction is "wtf is that, and what will that do to my computer?".
> > 
> > Discussed in this thread:
> > 
> > http://marc.theaimsgroup.com/?l=linux-fsdevel&m=114890371801114&w=2
> > 
> > Short summary of the problem: due to SHRINK_BATCH resolution, a proportional
> > reclaim based on "count" across all superblocks will not shrink anything on
> > lists 2 orders of magnitude smaller than the longest list as tmp will evaluate
> > as zero.  Hence to prevent small unused lists from never being reclaimed and
> > pinning memory until >90% of the dentry cache has been reclaimed we need to
> > turn them over slowly. However, if we turn them over too quickly, the dentry
> > cache does no caching for small filesystems.
> > 
> > This is not a problem a single global unused list has...
> 
> Reasonable.  Whatever we do needs to be fully communicated in the comment
> text please.

*nod*

> > > In particular, `jiffies' has near-to-zero correlation with the rate of
> > > creation and reclaim of these objects, so it looks highly inappropriate
> > > that it's in there.  If anything can be used to measure "time" in this code
> > > it is the number of scanned entries, not jiffies.
> > 
> > Sure, but SHRINK_BATCH resolution basically makes it impossible to reconcile
> > lists of vastly different lengths. If the shrinker simply called us
> > with the entire count it now hands us in batches, I doubt that this would be
> > an issue.
> > 
> > In the mean time, we need some other method to ensure we do eventually free
> > up these items on small lists. The above implements an idle timer used to
> > determine when we start to turn over a small cache. Maybe if we wrap it in:
> > 
> > > +				if (!tmp && dentry_lru_idle(sb))
> > > +					tmp = 1;
> > 
> > with a more appropriate comment it would make more sense?
> > 
> > Suggestions on other ways to resolve the problem are welcome....
> 
> Don't do a divide?
> 
> 	sb->s_scan_count += count;
> 	...	
> 	tmp = sb->s_dentry_stat.nr_unused /
> 		(global_dentry_stat.nr_unused / sb->s_scan_count + 1);
> 	if (tmp) {
> 		sb->s_scan_count -= <can't be bothered doing the arith ;)>;
> 		prune_dcache_sb(sb, tmp);
> 	}
> 
> That could go weird on us if there are sudden swings in
> sb->s_dentry_stat.nr_unused or global_dentry_stat.nr_unused, but
> appropriate boundary checking should fix that?

Hmm - I'll have to run some numbers through this what the curves
look like and determine what we need to do on the decrement. The
count accumulation does solve the resolution problem, though...

Thanks, Andrew.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
