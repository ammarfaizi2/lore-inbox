Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULRSGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULRSGD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 13:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbULRSGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 13:06:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261210AbULRSFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 13:05:51 -0500
Date: Sat, 18 Dec 2004 13:02:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: James Pearson <james-p@moving-picture.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041218150226.GC31040@logos.cnet>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C37AB6.10906@moving-picture.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 12:32:54AM +0000, James Pearson wrote:
> Marcelo Tosatti wrote:
> >
> >>Or am I looking in completely the wrong place i.e. the inode cache is 
> >>not the problem?
> >
> >
> >No, in your case the extreme inode/dcache sizes indeed seem to be a 
> >problem. 
> >The default kernel shrinking ratio can be tuned for enhanced reclaim 
> >efficiency.
> >
> >
> >>xfs_inode         931428 931428    408 103492 103492    1 :  124   62
> >>dentry_cache      499222 518850    128 17295 17295    1 :  252  126
> >
> >
> >vm_vfs_scan_ratio:
> >------------------
> >is what proportion of the VFS queues we will scan in one go.
> >A value of 6 for vm_vfs_scan_ratio implies that 1/6th of the
> >unused-inode, dentry and dquot caches will be freed during a
> >normal aging round.
> >Big fileservers (NFS, SMB etc.) probably want to set this
> >value to 3 or 2.
> >
> >The default value is 6.
> >=============================================================
> >
> >Tune /proc/sys/vm/vm_vfs_scan_ratio increasing the value to 10 and so on 
> >and examine the results.
> 
> Thanks for the info - but doesn't increasing the value of 
> vm_vfs_scan_ratio mean that less of the caches will be freed?

Right - what I said was wrong - its the other way around:
Decreasing the value increases the percentage of VFS caches scanned at each "aging pass".

Now Andrew's changed the ageing round pass. 

Quoting him "If the machine is full of unmapped clean pagecache pages the kernel 
won't even try to reclaim inodes".

vm_vfs_scan_ratio now is more meaningful. 

kswapd is awaken as soon as a zone's low watermark is reached, and will
work to free pages until it reaches the zone's high watermark.

There are three zones: DMA (1) , Normal (2) and Highmem (3).

 * On machines where it is needed (eg PCs) we divide physical memory
 * into multiple physical zones. On a PC we have 3 zones:
 *
 * ZONE_DMA       < 16 MB       ISA DMA capable memory
 * ZONE_NORMAL  16-896 MB       direct mapped by the kernel
 * ZONE_HIGHMEM  > 896 MB       only page cache and user processes

So these thresolds are used to calculate each zone's min, low and high
watermarks using the following calculation (mm/page_alloc.c):

	mask = (realsize / zone_balance_ratio[j]);
	if (mask < zone_balance_min[j])
     	mask = zone_balance_min[j];
              else if (mask > zone_balance_max[j])
                        mask = zone_balance_max[j];
                zone->watermarks[j].min = mask;
                zone->watermarks[j].low = mask*2;
                zone->watermarks[j].high = mask*3;

To trigger the normal aging round earlier the "low" watermark has to be increased,
but you better increase the "high" watermark which makes kswapd work up longer
until such high free page watermark is reached, one can try for example

 zone->watermarks[j].high = mask*4

But hopefully you wont need such modification (it would be nice if they were all boot 
configurable BTW) with Andrew's change.
