Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWDYJFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWDYJFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWDYJFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:05:32 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:61642 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751472AbWDYJFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:05:32 -0400
Date: Tue, 25 Apr 2006 10:05:27 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
 independent manner V4
In-Reply-To: <20060425104855.42c6ca62.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604250948080.7250@skynet.skynet.ie>
References: <20060424202009.20409.89016.sendpatchset@skynet>
 <20060425104855.42c6ca62.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, KAMEZAWA Hiroyuki wrote:

> On Mon, 24 Apr 2006 21:20:09 +0100 (IST)
> Mel Gorman <mel@csn.ul.ie> wrote:
>
>> This is V4 of the patchset to size zones and memory holes in an
>> architecture-independent manner.
>>
>
> Could you add some documentation about 'how to use' your generic funcs ?
> I think more archs can use your generic routine if well documented.
>
> All initialization path can be written in following way ?
> ==
> for_all_memory_region()
> 	add_active_range(nid, start, end)
> free_area_init_nodes(max_dma, max_dma32, max_low_pfn, max_pfn);
> ==

Yes, that is accurate. I can write in some documentation.

>
> And following functions are really needed ?

Most of them, yes. Without them, the arch-specific could would need to be 
able to iterate through the list of active regions which would lead to 
more similar-looking code.

> ==

> +extern void remove_all_active_ranges(void);

Used by x86_64 when it finds the SRAT table is bad and needs to rediscover 
active regions in another way. Spontaneous reboots were possible without 
it.

> +extern void get_pfn_range_for_nid(unsigned int nid,
> +			unsigned long *start_pfn, unsigned long *end_pfn);

Currently only used by power when initialising the boot allocator. There 
were no obvious canditates for use elsewhere.

> +extern unsigned long find_min_pfn_with_active_regions(void);

This does not need to be in a header.

> +extern unsigned long find_max_pfn_with_active_regions(void);

Could be dropped, only required by x86_64.

> +extern int early_pfn_to_nid(unsigned long pfn);

Removed two copies of similar functions from power and x86. I thought I 
could replace the IA64 one as well, but the code was unusual enough there 
that I decided not to.

> +extern void free_bootmem_with_active_regions(int nid,
> +						unsigned long max_low_pfn);

Removes similar-looking code from power and x86_64.

> +extern void sparse_memory_present_with_active_regions(int nid);

This is only used by power.

> +extern unsigned long absent_pages_in_range(unsigned long start_pfn,
> +						unsigned long end_pfn);
>

Removes similar looking code from x86_64. For all other architectures, it 
does the job of the existing functions that calculate zholes_size[].

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
