Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUGNN2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUGNN2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 09:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUGNN2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 09:28:34 -0400
Received: from holomorphy.com ([207.189.100.168]:48540 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267386AbUGNN2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 09:28:25 -0400
Date: Wed, 14 Jul 2004 06:22:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040714132256.GR3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Osterlund <petero2@telia.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org> <40ED049B.2020406@yahoo.com.au> <Pine.LNX.4.58.0407081126360.3104@telia.com> <20040714052010.GE3411@holomorphy.com> <m2u0wayisp.fsf@telia.com> <20040714105713.GP3411@holomorphy.com> <m2hdsabvdu.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2hdsabvdu.fsf@telia.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 02:55:57PM +0200, Peter Osterlund wrote:
> Out of memory: pid 2655, comm xterm        , gfp 0x466, order 0
[...]
>  [<c0131d69>] out_of_memory+0xb2/0x105
>  [<c013a0bd>] try_to_free_pages+0x143/0x190
>  [<c0132bae>] __alloc_pages+0x1c3/0x347
>  [<c013595b>] do_page_cache_readahead+0x13b/0x197
>  [<c012fb50>] filemap_nopage+0x2d8/0x371
>  [<c013cfe9>] do_no_page+0xb7/0x30f
>  [<c013d431>] handle_mm_fault+0xd6/0x171
>  [<c0111076>] do_page_fault+0x346/0x548
>  [<c01d5868>] __copy_to_user_ll+0x48/0x6c
>  [<c015c7c3>] sys_select+0x228/0x4b0
>  [<c0110d30>] do_page_fault+0x0/0x548
>  [<c01040a1>] error_code+0x2d/0x38
> Out of Memory: Killed process 2666 (memalloc2).

$ printf "%lx\n" $(( 0x100 | 0x80 | 0x40 | 0x10 | 0x2 ))
1d2
$ egrep '(0x100|0x80|0x40|0x10) |0x02' /mnt/dm0/laptop-2.6.8-rc1/include/linux/gfp.h                               
#define __GFP_HIGHMEM   0x02
#define __GFP_WAIT      0x10    /* Can wait and reschedule? */
#define __GFP_IO        0x40    /* Can start physical IO? */
#define __GFP_FS        0x80    /* Can call down to low-level FS? */
#define __GFP_COLD      0x100   /* Cache-cold page required */

Hmm, I wonder why we didn't just fail the allocation. Maybe we should
check (gfp_mask & __GFP_NOFAIL) instead of !(gfp_mask & __GFP_NORETRY);
everything else should be allowed to fail, except things loop if
without __GFP_NORETRY, as presumably only __GFP_NOFAIL allocations are
ones that supposedly can't handle failures in-context.

The only difference laptop_mode should have is dirty memory handling,
but you don't have any dirty memory. Maybe swapcache is fooling things.
Most notably, add_to_swap() sets the page dirty...

Something is very wrong here... could you try this?


- wli

Index: oom-2.6.8-rc1/mm/vmscan.c
===================================================================
--- oom-2.6.8-rc1.orig/mm/vmscan.c	2004-07-14 06:17:13.876343912 -0700
+++ oom-2.6.8-rc1/mm/vmscan.c	2004-07-14 06:22:15.986416200 -0700
@@ -417,7 +417,8 @@
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (laptop_mode && !sc->may_writepage &&
+							!PageSwapCache(page))
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
