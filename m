Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUIIGxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUIIGxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUIIGxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:53:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55960 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269182AbUIIGxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:53:05 -0400
Date: Thu, 9 Sep 2004 16:52:55 +1000
From: Dave Chinner <dgc@sgi.com>
To: Steve Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Major XFS problems...
Message-ID: <20040909165255.C2738@melbourne.sgi.com>
References: <20040908133954.GB390@unthought.net> <20040909074533.B3958243@wobbly.melbourne.sgi.com> <413F823F.3020507@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <413F823F.3020507@xfs.org>; from lord@xfs.org on Wed, Sep 08, 2004 at 05:05:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ing back to lkml]

On Wed, Sep 08, 2004 at 05:05:51PM -0500, Steve Lord wrote:
> 
> I wonder what the effect of /proc/sys/vm/swappiness
> and /proc/sys/vm/vfs_cache_pressure is on these situations.

Hi Steve.

I very much doubt vm_swappiness will have any effect on this - it
just determines whether to throw away page cache pages or swap out
mapped pages - it won't affect the dentry cache size. The best
it can do is allow us to swap out more pages so the dentry cache
can grow larger....

Looking at vfs_cache_pressure (documented in Documentation/
filesystems/proc.txt), it is used to make the number of unused
inodes and dentries used by the system appear to be smaller or
larger to the slab shrinker function:

661 static int shrink_dcache_memory(int nr, unsigned int gfp_mask)
662 {
663         if (nr) {
664                 if (!(gfp_mask & __GFP_FS))
665                         return -1;
666                 prune_dcache(nr);
667         }
668         return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
669 }

and hence the shrinker will tend to remove more or less dentries or
inodes when the cache is asked to be shrunk.  It will have no real
effect if the unused dentry list is small (i.e. we're actively
growing the dentry cache) which seems to be the case here.

FWIW, it appears to me that the real problem is that shrink_dcache_memory()
does not shrink the active dentry cache down - I think it needs to do more
than just free up unused dentries. I'm not saying this is an easy thing
to do (I don't know if it's even possible), but IMO if we allow the dentry
cache to grow without bound or without a method to shrink the active
tree we will hit this problem a lot more often as filesystems grow larger.

For those that know this code well, it looks like there's a bug
in the above code - the shrinker calls into this function first with
nr = 0 to determine how much it can reclaim from the slab.

If the dentry_stat.nr_unused is less than 100, then we'll return 0
due to integer division (99/100 = 0), and the shrinker calculations
will see this as a slab that does not need shrinking because:

185         list_for_each_entry(shrinker, &shrinker_list, list) {
186                 unsigned long long delta;
187 
188                 delta = (4 * scanned) / shrinker->seeks;
189                 delta *= (*shrinker->shrinker)(0, gfp_mask);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
190                 do_div(delta, lru_pages + 1);
191                 shrinker->nr += delta;
192                 if (shrinker->nr < 0)
193                         shrinker->nr = LONG_MAX;        /* It wrapped! */
194 
195                 if (shrinker->nr <= SHRINK_BATCH)
196                         continue;

because we returned zero and therefore delta becomes zero and
shrinker->nr never gets larger than SHRINK_BATCH.

Hence in low memory conditions when you've already reaped most of
the unused dentries, you can't free up the last 99 unused dentries.
Maybe this is intentional (anyone?) because there isn't very much to
free up in this case, but some memory freed is better than none when
you have nothing at all left.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Engineer
SGI Australian Software Group
