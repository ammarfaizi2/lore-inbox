Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbULTNsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbULTNsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 08:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULTNsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 08:48:03 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:21140 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S261510AbULTNrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 08:47:51 -0500
Message-ID: <41C6D802.7070901@moving-picture.com>
Date: Mon, 20 Dec 2004 13:47:46 +0000
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org> <20041218110247.GB31040@logos.cnet>
In-Reply-To: <20041218110247.GB31040@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested the patch on my test setup - running a 'find $disk -type f' 
and a cat of large files to /dev/null at the same time does indeed 
reduce the size of the inode and dentry caches considerably - the first 
column numbers for fs_inode, linvfs_icache and dentry_cache in 
/proc/slabinfo hover at about 400-600 (over 900000 previously).

However, is this going a bit to far the other way? When I boot the 
machine with 4Gb RAM, the inode and dentry caches are squeezed to the 
same amounts, but it may be the case that it would be more beneficial to 
have more in the inode and dentry caches? i.e. I guess some sort of 
tunable factor that limits the minimum size of the inode and dentry 
caches in this case?

But saying that, I notice my 'find $disk -type f' (with about 2 million 
files) runs a lot faster with the smaller inode/dentry caches - about 1 
or 2 minutes with the patched kernel compared with about 5 to 7 minutes 
with the unpatched kernel - I guess it was taking longer to search the 
inode/dentry cache than reading direct from disk.

James Pearson

Marcelo Tosatti wrote:
> James,
> 
> Can apply Andrew's patch and examine the results?
> 
> I've merged it to mainline because it looks sensible.
> 
> Thanks Andrew!
> 
> On Fri, Dec 17, 2004 at 05:21:04PM -0800, Andrew Morton wrote:
> 
>>James Pearson <james-p@moving-picture.com> wrote:
>>
>>>It seems the inode cache has priority over cached file data.
>>
>>It does.  If the machine is full of unmapped clean pagecache pages the
>>kernel won't even try to reclaim inodes.  This should help a bit:
>>
>>--- 24/mm/vmscan.c~a	2004-12-17 17:18:31.660254712 -0800
>>+++ 24-akpm/mm/vmscan.c	2004-12-17 17:18:41.821709936 -0800
>>@@ -659,13 +659,13 @@ int fastcall try_to_free_pages_zone(zone
>> 
>> 		do {
>> 			nr_pages = shrink_caches(classzone, gfp_mask, nr_pages, &failed_swapout);
>>-			if (nr_pages <= 0)
>>-				return 1;
>> 			shrink_dcache_memory(vm_vfs_scan_ratio, gfp_mask);
>> 			shrink_icache_memory(vm_vfs_scan_ratio, gfp_mask);
>> #ifdef CONFIG_QUOTA
>> 			shrink_dqcache_memory(vm_vfs_scan_ratio, gfp_mask);
>> #endif
>>+			if (nr_pages <= 0)
>>+				return 1;
>> 			if (!failed_swapout)
>> 				failed_swapout = !swap_out(classzone);
>> 		} while (--tries);
>>_
>>
>>
>>
>>> What triggers the 'normal ageing round'? Is it possible to trigger this 
>>> earlier (at a lower memory usage), or give a higher priority to cached data?
>>
>>You could also try lowering /proc/sys/vm/vm_mapped_ratio.  That will cause
>>inodes to be reaped more easily, but will also cause more swapout.
> 
> 

