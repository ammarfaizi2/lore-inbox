Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbULTTWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbULTTWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULTTWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:22:48 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:15330 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261617AbULTTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:21:25 -0500
Date: Mon, 20 Dec 2004 20:20:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James Pearson <james-p@moving-picture.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041220192046.GM4630@dualathlon.random>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217172104.00da3517.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 05:21:04PM -0800, Andrew Morton wrote:
> James Pearson <james-p@moving-picture.com> wrote:
> >
> > It seems the inode cache has priority over cached file data.
> 
> It does.  If the machine is full of unmapped clean pagecache pages the
> kernel won't even try to reclaim inodes.  This should help a bit:
> 
> --- 24/mm/vmscan.c~a	2004-12-17 17:18:31.660254712 -0800
> +++ 24-akpm/mm/vmscan.c	2004-12-17 17:18:41.821709936 -0800
> @@ -659,13 +659,13 @@ int fastcall try_to_free_pages_zone(zone
>  
>  		do {
>  			nr_pages = shrink_caches(classzone, gfp_mask, nr_pages, &failed_swapout);
> -			if (nr_pages <= 0)
> -				return 1;
>  			shrink_dcache_memory(vm_vfs_scan_ratio, gfp_mask);
>  			shrink_icache_memory(vm_vfs_scan_ratio, gfp_mask);
>  #ifdef CONFIG_QUOTA
>  			shrink_dqcache_memory(vm_vfs_scan_ratio, gfp_mask);
>  #endif
> +			if (nr_pages <= 0)
> +				return 1;
>  			if (!failed_swapout)
>  				failed_swapout = !swap_out(classzone);
>  		} while (--tries);


I'm worried this is too aggressive by default and it may hurt stuff. The
real bug is that we don't do anything when too many collisions happens
in the hashtables. That is the thing to work on. We should free
colliding entries in the background after a 'touch' timeout. That should
work pretty well to age the dcache proprerly too. But the above will
just shrink everything all the time and it's going to break stuff.
For 2.6 we can talk about the background shrink based on timeout.

My only suggestion for 2.4 is to try with vm_cache_scan_ratio = 20 or
higher (or alternatively vm_mapped_ratio = 50 or = 20).  There's a
reason why everything is tunable by sysctl.

I don't think the vm_lru_balance_ratio is the one he's interested
about. vm_lru_balance_ratio controls how much work is being done at
every dcache/icache shrinking.

His real objective is to invoke the dcache/icache shrinking more
frequently, how much work is being done at each pass is a secondary
issue. If we don't invoke it, nothing will be shrunk, no matter what is
the value of vm_lru_balance_ratio.

Hope this helps funding an optimal tuning for the workload.
