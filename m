Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbULROFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbULROFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbULROFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:05:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261248AbULROFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:05:01 -0500
Date: Sat, 18 Dec 2004 09:02:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James Pearson <james-p@moving-picture.com>, linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041218110247.GB31040@logos.cnet>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217172104.00da3517.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James,

Can apply Andrew's patch and examine the results?

I've merged it to mainline because it looks sensible.

Thanks Andrew!

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
> _
> 
> 
> >  What triggers the 'normal ageing round'? Is it possible to trigger this 
> >  earlier (at a lower memory usage), or give a higher priority to cached data?
> 
> You could also try lowering /proc/sys/vm/vm_mapped_ratio.  That will cause
> inodes to be reaped more easily, but will also cause more swapout.
