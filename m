Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbSLSKXl>; Thu, 19 Dec 2002 05:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbSLSKXl>; Thu, 19 Dec 2002 05:23:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:59355 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267618AbSLSKXi>;
	Thu, 19 Dec 2002 05:23:38 -0500
Message-ID: <3E01A004.58F2B880@digeo.com>
Date: Thu, 19 Dec 2002 02:31:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
References: <3E015ECE.9E3BD19@digeo.com> <20021219085426.GJ1922@holomorphy.com> <20021219092853.GK1922@holomorphy.com> <20021219101219.GS31800@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 10:31:33.0172 (UTC) FILETIME=[CCE3AF40:01C2A749]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Wed, Dec 18, 2002 at 09:53:18PM -0800, Andrew Morton wrote:
> >>> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.52/2.5.52-mm2/
> 
> On Thu, Dec 19, 2002 at 12:54:26AM -0800, William Lee Irwin III wrote:
> >> Kernel compile on ramfs, shpte off, overcommit on (probably more like a
> >> stress test for shpte):
> 
> On Thu, Dec 19, 2002 at 01:28:53AM -0800, William Lee Irwin III wrote:
> > With shpte on:
> 
> With the following patch:
> 
> c013d4d4 94944    0.310788    zap_pte_range
> c01355d0 104773   0.342962    nr_free_pages
> c014f65c 107566   0.352105    __fput
> c01b1750 112055   0.366799    __copy_user_intel
> c0115350 121040   0.39621     smp_apic_timer_interrupt
> c0119814 126089   0.412738    kmap_atomic
> c014b6cc 145095   0.474952    pte_unshare
> c01fb11c 145992   0.477888    sync_buffer
> c0122a78 148079   0.484719    current_kernel_time
> c01168b8 193805   0.634398    x86_profile_hook
> c013f140 205233   0.671806    do_no_page
> c0164aac 235356   0.77041     d_lookup
> c01b18f8 257358   0.842431    __copy_from_user
> c0131f7c 275559   0.90201     find_get_page
> c011a560 282341   0.92421     scheduler_tick
> c0140090 300128   0.982434    vm_enough_memory
> c013f4bc 310474   1.0163      handle_mm_fault
> c014f3d0 312725   1.02367     get_empty_filp
> c011a0a8 365066   1.195       load_balance
> c014f9e9 502737   1.64565     .text.lock.file_table
> c01b1890 719105   2.35391     __copy_to_user
> c0135768 911894   2.98498     __get_page_state
> c013ee50 952823   3.11895     do_anonymous_page
> c01436d0 1079864  3.53481     page_add_rmap
> c01438cc 1186938  3.8853      page_remove_rmap
> c0106f38 17763755 58.1476     poll_idle

Is that improved?

> pfn_to_nid() got lots of icache misses. Try using a macro.

What's the callsite?

Actually, just looking at mmzone.h, I have to say "ick".  The
non-NUMA case seems unnecessarily overdone.  eg:

#define page_to_pfn(page)
	((page - page_zone(page)->zone_mem_map) + page_zone(page)->zone_start_pfn)

Ouch.  Why can't we have the good old `page - mem_map' here?
