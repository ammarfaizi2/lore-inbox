Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUASMUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 07:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUASMUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 07:20:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:12441 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264602AbUASMUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 07:20:11 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 19 Jan 2004 13:15:46 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: caszonyi@rdslink.ro, linux-kernel@vger.kernel.org
Subject: Re: Fw: Slab coruption and oops with 2.6.1-mm4
Message-ID: <20040119121546.GD5498@bytesex.org>
References: <20040118220051.3f3d8420.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118220051.3f3d8420.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> heh, this is the same bug.  Last time we were unlocking an unlocked page. 
> Now we're freeing a free page.

Yes.  Still no idea why that happens through ...

> CONFIG_PREEMPT=y

Bug reproducable with this one turned off?

> Slab corruption: start=c57c2000, len=4096
> 000: 6e 72 6d 71 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> bttv0: skipped frame. no signal? high irq latency? [main=b030000,o_vbi=b030018,o_field=5378000,rc=537801c]
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:275!

page_cache_release()

> EIP is at videobuf_dma_free+0xa9/0xc0 [video_buf]

The code calling page_cache_release looks like this ...

	if (dma->pages) {
		int i;
		for (i=0; i < dma->nr_pages; i++)
			page_cache_release(dma->pages[i]);
		kfree(dma->pages);
		dma->pages = NULL;
	}

... even with videobuf_dma_free() called twice by mistake that shouldn't
double-free the pages.  Maybe videobuf_dma_free() is called from two
places at the same time because one of the call paths misses a lock, but
I can't find any on a quick review.  Hmm.

Does transcode use threads?  If so, does it call into bttv from
different threads?

> Call Trace:
>  [<d08f3a70>] bttv_dma_free+0x60/0xa0 [bttv]
>  [<d08ede63>] bttv_do_ioctl+0x403/0x16a0 [bttv]

must be VIDIOCSYNC ioctl.

>  [<c0335498>] video_usercopy+0xe8/0x1e0
>  [<d08ef13e>] bttv_ioctl+0x3e/0x70 [bttv]
>  [<c0168ef3>] sys_ioctl+0xf3/0x280
>  [<c042e9b7>] syscall_call+0x7/0xb

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
