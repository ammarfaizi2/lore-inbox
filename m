Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSKSN5Z>; Tue, 19 Nov 2002 08:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKSN5Z>; Tue, 19 Nov 2002 08:57:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:29364 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265368AbSKSN5Y>; Tue, 19 Nov 2002 08:57:24 -0500
Date: Tue, 19 Nov 2002 14:05:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.5.48-mm1
In-Reply-To: <3DDA0153.A1971C76@digeo.com>
Message-ID: <Pine.LNX.4.44.0211191338590.1596-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Andrew Morton wrote:
> 
> +loop-balance-pages.patch
> 
>  Small optimisation to loop

I disagree with this one (changing balance_dirty_pages to _ratelimited
when loop_thread writes to file): it's a step in the right direction,
but I think you should remove that balance_dirty_pages call completely.

I'm experimenting with what's needed to prevent deadoralivelock in
loop over tmpfs under heavy memory pressure (thank you for eliminating
wait_on_page_bit from shrink_list!).  One element of that is to ignore
balance_dirty_pages below loop (I hadn't noticed the explicit call,
offhand I'm unsure whether that's the only possible instance).

The loop_thread is working towards undirtying memory (completing
writeback): a loop of blk_congestion_waits is appropriate at the
upper level where the user task generating dirt needs to be throttled,
but I don't believe it's appropriate at this level - we wouldn't want
to throttle the disk, no more should we throttle the loop_thread.

Hugh

