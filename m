Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbVKCVSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbVKCVSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbVKCVSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:18:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:5312 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030490AbVKCVSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:18:11 -0500
Date: Fri, 4 Nov 2005 02:41:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: bad page state under possibly oom situation
Message-ID: <20051103211151.GA22769@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051102143502.GE6137@in.ibm.com> <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com> <4369B051.7050303@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4369B051.7050303@colorfullife.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 07:38:09AM +0100, Manfred Spraul wrote:
> Hugh Dickins wrote:
> 
> >(I don't know that it makes any difference, but was this particular report
> >from 2.6.9-rc2 or from 2.6.14 or from something else?  In both 2.6.9 and
> >2.6.14, flags 0x90 mean PG_slab|PG_dirty.)
> >
> A very odd combination:
> - free_pages_check() ensures that neither PG_slab nor PG_dirty are set
> - prep_new_page() complains that both PG_slab and PG_dirty are set
> - AFAICS slab doesn't set PG_dirty, and noone except slab set PG_slab.
> 
> I don't understand how two wrong bits can end up in page->flags.
> Dipankar, could you modify bad_page() and hexdump +-128 bytes? Perhaps 
> someone overwrites random memory. Or change the value of PG_slab to 20 
> and check if page->flags remains 0x90.

Here is a dump of the page struct when this happens (two different
instances) - 

/* Dump of struct page */
page = ffff810008005550
4000005500009090        ffffffffffffffff        0       0
0       100100  200200  4000000000000000
ffffffffffffffff        0       0       0
ffff8100080055e8        ffffffff805ba370        4000000000000000        ffffffffffffffff

Bad page state at prep_new_page (in process 'rename14', page ffff810008005550)
flags:0x4000005500009090 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff80150388>{bad_page+115} <ffffffff80150bf0>{buffered_rmqueue+501}
       <ffffffff8017e2da>{alloc_inode+18} <ffffffff80150de7>{__alloc_pages+251}
       <ffffffff801535f3>{cache_alloc_refill+581} <ffffffff8015388f>{kmem_cache_alloc+44}
       <ffffffff80169440>{get_empty_filp+71} <ffffffff801670af>{filp_open+49}
       <ffffffff80166e28>{get_unused_fd+98} <ffffffff8016713d>{do_sys_open+59}
       <ffffffff8010e636>{system_call+126}
Trying to fix it up, but a reboot is needed
page = ffff81000800aaa0
4000000000000000        ffffffff00900055        0       0
0       100100  200200  4000000000000000
ffffffffffffffff        0       0       0
ffff81000800ab38        ffffffff805ba370        4000000000000000        ffffffffffffffff
Bad page state at prep_new_page (in process 'rename14', page ffff81000800aaa0)
flags:0x4000000000000000 mapping:0000000000000000 mapcount:0 count:9437270
Backtrace:

Call Trace:<ffffffff80150388>{bad_page+115} <ffffffff80150bf0>{buffered_rmqueue+501}
       <ffffffff80150de7>{__alloc_pages+251} <ffffffff801535f3>{cache_alloc_refill+581}
       <ffffffff8015388f>{kmem_cache_alloc+44} <ffffffff8017cd95>{d_alloc+33}
       <ffffffff801750be>{__lookup_hash+206} <ffffffff8017677b>{open_namei+276}
       <ffffffff801670ce>{filp_open+80} <ffffffff80166e28>{get_unused_fd+98}
       <ffffffff8016713d>{do_sys_open+59} <ffffffff8010e636>{system_call+1

I had set PG_slab to 20, so it is not necessarily a corrupted slab
page.

Thanks
Dipankar
