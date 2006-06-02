Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWFBPda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWFBPda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFBPda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:33:30 -0400
Received: from mx1.suse.de ([195.135.220.2]:4034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932405AbWFBPd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:33:29 -0400
Date: Fri, 2 Jun 2006 17:33:26 +0200
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060602153326.GI4377@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de> <20060601180659.56e69968.akpm@osdl.org> <20060602022339.GY7418631@melbourne.sgi.com> <20060601194912.8173705a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601194912.8173705a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, Andrew Morton wrote:

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
> 

Yes, you are right. As I expected that this isn't the final patch I was a
little bit too lazy. Will do that for the next version.

> > > In particular, `jiffies' has near-to-zero correlation with the rate of
> > > creation and reclaim of these objects, so it looks highly inappropriate
> > > that it's in there.  If anything can be used to measure "time" in this code
> > > it is the number of scanned entries, not jiffies.

Ouch! Totally missed that. The measurement should be kind of round-based
instead.

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

  if (tmp) {
     sb->s_scan_count -= count;
     sb->s_scan_count -= sb->s_scan_count ? min(sb->s_scan_count, count/2) : 0;
     prune_dcache_sb(sb, tmp);
  }

  if (!sb->s_dentry_stat.nr_unused)
     sb->s_scan_count = 0;

In a normal situations, s_scan_count should be zero (add count and subtract it
again).
s_scan_count is increasing when we don't prune anything from that
superblock. If we finally reach the point where the s_scan_count is that high
that we actually prune some dentries, we slowly (count/2) decrease the
s_scan_count level again.
If the superblock doesn't have any unused dentries we reset the s_scan_count to
zero.

So s_scan_count is some kind of badness counter. I hope that this will still
be good enough for you, David.

Jan
