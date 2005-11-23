Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVKWEFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVKWEFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVKWEFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:05:17 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:7863 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932505AbVKWEFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:05:15 -0500
Date: Wed, 23 Nov 2005 12:06:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm-kswapd-incmin.patch problem
Message-ID: <20051123040619.GA4386@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20051122074818.GA3801@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122074818.GA3801@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Nov 22, 2005 at 03:48:18PM +0800, Wu Fengguang wrote:
> Hi, your vm-kswapd-incmin.patch looks nice, and I'd like to base my age
> balancing patch upon it. But while trying it, I ran into a problem.
> 
> $ cp bigfile /dev/null
> $ free -m    
>              total       used       free     shared    buffers     cached
> Mem:           501        495          6          0          2        321
> -/+ buffers/cache:        171        330
> Swap:          127          2        125
> $ sleep 10
> $ free -m    
>              total       used       free     shared    buffers     cached
> Mem:           501        244        257          0          4         66
> -/+ buffers/cache:        173        328
> Swap:          127          2        125
> 
> In a short time, the bigfile was totally evicted from page cache?
> 
> Before/after the huge free pages:
> 
> $ cat /proc/sys/fs/dentry-state
> 3393    28      45      0       0       0
> $ cat /proc/sys/fs/dentry-state
> 3626    260     45      0       0       0
> 
> 
> linux-2.6.15-rc1-mm2 without the patch seems ok.
> Any suggestions? Thanks.

Maybe I found the answer to it :)

I listed the dentry-state in several other normal machines, they all have
more than 10k unused dentries:

        54215   42155   45      0       0       0
        91704   81376   45      0       0       0
        96304   88832   45      0       0       0
        30057   26999   45      0       0       0

Then I disabled the shrinker by:
        echo 0 > /proc/sys/vm/vfs_cache_pressure

That increased the number from
        3393    28      45      0       0       0
to
        6247    2672    45      0       0       0
And there is no sudden huge increases of free pages any more.

Maybe your patch is shrinking the slabs much more, though I cannot confirm this
from the source code. But one thing I'm sure is that there should be a lower
bound for the unused dentries, either absolutely or relatively, something like
this:

--- linux-2.6.15-rc1-mm2.orig/fs/dcache.c
+++ linux-2.6.15-rc1-mm2/fs/dcache.c
@@ -860,7 +860,7 @@ static int shrink_dcache_memory(int nr, 
 			return -1;
 		prune_dcache(nr);
 	}
-	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
+	return (dentry_stat.nr_unused / 1000) * 10 * sysctl_vfs_cache_pressure;
 }
 
 /**


The original 100 is way too small. It should be much more than the SHRINK_BATCH(128).

Thanks,
Wu
