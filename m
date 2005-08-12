Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVHLCHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVHLCHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVHLCHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:07:23 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:3475 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S964775AbVHLCHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:07:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Phil Dier <phil@icglink.com>
Date: Fri, 12 Aug 2005 12:07:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17148.1113.664829.360594@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, ziggy <ziggy@icglink.com>,
       Scott Holdren <scott@icglink.com>, Jack Massari <jack@icglink.com>
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
In-Reply-To: message from Phil Dier on Thursday August 11
References: <20050811105954.31f25407.phil@icglink.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 11, phil@icglink.com wrote:
> Hi,
> 
> I posted an oops a few days ago from 2.6.12.3 [1].  Here are the results
> of my tests on 2.6.13-rc6.  The kernel oopses, but it the box isn't completely
> hosed; I can still log in and move around.  It appears that the only things that are
> locked are the apps that were doing i/o to the test partition.  More detailed info 
> about my configuration can be found here:
> 
> <http://www.icglink.com/debug-2.6.13-rc6.html>

You don't seem to give details on how lvm is used to combine the md
arrays, though I'm not sure that would help particularly.


> 
> Here is the oops:
> 
> Oops: 0000 [#1]
> SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0116dd0>]    Not tainted VLI
> EFLAGS: 00010207   (2.6.13-rc6)
> EIP is at kmap+0x10/0x30
> eax: 00000003   ebx: d0977440   ecx: c9efb470   edx: 00000000
> esi: c1000000   edi: 00000000   ebp: ce59d570   esp: f7adde18
> ds: 007b   es: 007b   ss: 0068
> Process md4_raid1 (pid: 6442, threadinfo=f7adc000 task=f70eda20)
> Stack: c014e0bd c9efb470 00000001 00000000 00000000 cb129000 00000001 e0c65f00
>        f7dcbe18 087641ef 00000000 f7dcbe18 c014e146 f7dcbe18 f7addeb0 c3146940
>        c033f03f f7dcbe18 f7addeb0 0021d906 00000000 0000003f 00000040 00000000
> Call Trace:
>  [<c014e0bd>] __blk_queue_bounce+0x20d/0x260
--snip---
> Code: 00 40 c7 46 0c 90 30 15 c0 c7 46 10 90 31 15 c0 eb b9 90 90 90 90 90 90 90 90 90 8b 4c 24 04 8b 01 c1 e8 1e 8b 14 85 14 f4 63 c0 <8b> 82 0c 04 00 00 05 00 09 00 00 39 c2 74 05 e9 ac 73 03 00 89
> 

The code is Oopsing in a call to kmap in arch/i386/highmem.c
The PageHighMem macro calls is_highmem(page_zone(page)).
page_zone is defined in mm.h
static inline struct zone *page_zone(struct page *page)
{
	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
			ZONETABLE_MASK];
}

Now at the point of the crash, eax is
    (page->flags >> ZONETABLE_PGSHIFT),
which is '3'.  So it seems that this page is in zone 3.
However  zone_table[3] is now in edx, and we can see it is '0'.
There are only 3 zones (normal, dma, highmem), so nothing should ever
by in zone 3.  This page is clearly bad.

However that is as far as I can get.  I don't know whether this is a
bad page pointer passed down from jfs or nfsd, a page pointer that was
corrupted by either lvm or md, or a valid page pointer that has
managed to get a bad zone number encoded in it's flags.

You could possibly put something like

	struct bio_vec *from;
	int i;
	bio_for_each_segment(from, bio, i)
		BUG_ON(page_zone(from->bv_page)==NULL);

in generic_make_requst in drivers/block/ll_rw_blk.c, just before
the call to q->make_request_fn.
This might trigger the bug early enough to see what is happening.


> 
> Thanks for looking..
> 

Thanks for testing.

NeilBrown
