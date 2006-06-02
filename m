Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWFBCYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFBCYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWFBCYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:24:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60342 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751138AbWFBCYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:24:16 -0400
Date: Fri, 2 Jun 2006 12:23:39 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dgc@sgi.com,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060602022339.GY7418631@melbourne.sgi.com>
References: <20060601095125.773684000@hasse.suse.de> <20060601180659.56e69968.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601180659.56e69968.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 06:06:59PM -0700, Andrew Morton wrote:
> On Thu, 01 Jun 2006 11:51:25 +0200
> jblunck@suse.de wrote:
> 
> > This is an attempt to have per-superblock unused dentry lists.
> 
> Fairly significant clashes with
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/broken-out/fix-dcache-race-during-umount.patch 
> 
> I guess Neil's patch will go into the 2.6.18 tree, so you'd be best off
> working against that.

Though this patch series fixes the same problem in a much cleaner
way. It effectively obsoletes Neil's fix.

> Also, you're making what appears to be a quite deep design change to a
> pretty important part of the memory reclaim code and all the info we have
> is this:
> 
> 
> +				/*
> +				 * Try to be fair to the unused lists:
> +				 *  sb_count/sb_unused ~ count/global_unused
> +				 *
> +				 * Additionally, if the age_limit of the
> +				 * superblock is expired shrink at least one
> +				 * dentry from the superblock
> +				 */
> +				tmp = sb->s_dentry_stat.nr_unused /
> +					((unused / count) + 1);
> +				if (!tmp && time_after(jiffies,
> +						       sb->s_dentry_unused_age))
> +					tmp = 1;
> 
> 
> Please, we'll need much much more description of what this is trying to
> achieve, why it exists, analysis, testing results, etc, etc.  Coz my
> immediate reaction is "wtf is that, and what will that do to my computer?".

Discussed in this thread:

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=114890371801114&w=2

Short summary of the problem: due to SHRINK_BATCH resolution, a proportional
reclaim based on "count" across all superblocks will not shrink anything on
lists 2 orders of magnitude smaller than the longest list as tmp will evaluate
as zero.  Hence to prevent small unused lists from never being reclaimed and
pinning memory until >90% of the dentry cache has been reclaimed we need to
turn them over slowly. However, if we turn them over too quickly, the dentry
cache does no caching for small filesystems.

This is not a problem a single global unused list has...

> In particular, `jiffies' has near-to-zero correlation with the rate of
> creation and reclaim of these objects, so it looks highly inappropriate
> that it's in there.  If anything can be used to measure "time" in this code
> it is the number of scanned entries, not jiffies.

Sure, but SHRINK_BATCH resolution basically makes it impossible to reconcile
lists of vastly different lengths. If the shrinker simply called us
with the entire count it now hands us in batches, I doubt that this would be
an issue.

In the mean time, we need some other method to ensure we do eventually free
up these items on small lists. The above implements an idle timer used to
determine when we start to turn over a small cache. Maybe if we wrap it in:

> +				if (!tmp && dentry_lru_idle(sb))
> +					tmp = 1;

with a more appropriate comment it would make more sense?

Suggestions on other ways to resolve the problem are welcome....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
