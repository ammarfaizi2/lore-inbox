Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWHDPsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWHDPsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWHDPsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:48:15 -0400
Received: from navgwout.symantec.com ([198.6.49.12]:36787 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id S1161254AbWHDPsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:48:15 -0400
Date: Fri, 4 Aug 2006 16:47:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mulyadi Santosa <mulyadi.santosa@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accounting per process swapped out pages
In-Reply-To: <200608041351.52695.mulyadi.santosa@gmail.com>
Message-ID: <Pine.LNX.4.64.0608041616330.10681@blonde.wat.veritas.com>
References: <200608041351.52695.mulyadi.santosa@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Aug 2006 15:48:04.0188 (UTC) FILETIME=[5F57C1C0:01C6B7DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Mulyadi Santosa wrote:
> 
> Here is patch to count per process swapped out pages. This patch is 
> created against 2.6.16.1. So far, I had tested by forcing certain task 
> to swap out (tail -f /dev/zero) and wait until top/vmstat/free reported
> that swap is occupied.
> 
> Comments and feedbacks are  greatly appreciated. Please keep me CC'ed 
> since I am not subscribed to linux-kernel mailing list.

To be honest, I don't think there's much interest in this particular
VmSwp statistic; and if there's little interest in it, we'd rather
not spend the time and space on collecting it.  But I could be wrong:
let's see who speaks up for it.

A few comments on the mechanics of your patch.

You waste space in every vm_area_struct for your swapped_out count,
then /proc/<pid>/status has to loop over the vmas adding them up.
Much better to make it an mm_counter like anon_rss, then you only
use space in mm_struct, and don't have to add them up at the end,
and avoid dirtying (vma) cachelines unnecessarily, and (in some
cases) avoid the atomic operations.

While you've caught the main places where you'd need to adjust
swapped_out, you've missed a couple (maybe I've missed more):
copy_pte_range (fork) needs to increment the count, zap_pte_range
(munmap or truncate or exit) needs to decrement it.  Check wherever
anon_rss is adjusted, some not all would need swapped_out adjusted.

Oh, you are doing something in zap_pte_range, but I'm sorry to say
what you do there is nonsense: the number you're subtracting has
nothing to do with the number of swapped out pages.

And you probably wouldn't want that printk in your final patch!

Hugh
