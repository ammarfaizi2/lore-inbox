Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136473AbRD3Hqb>; Mon, 30 Apr 2001 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136474AbRD3HqW>; Mon, 30 Apr 2001 03:46:22 -0400
Received: from www.wen-online.de ([212.223.88.39]:2316 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136473AbRD3HqG>;
	Mon, 30 Apr 2001 03:46:06 -0400
Date: Mon, 30 Apr 2001 09:45:41 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Frank de Lange <frank@unternet.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Severe trashing in 2.4.4
In-Reply-To: <20010429200419.C11681@unternet.org>
Message-ID: <Pine.LNX.4.33.0104300834030.601-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, Frank de Lange wrote:

> On Sun, Apr 29, 2001 at 01:58:52PM -0400, Alexander Viro wrote:
> > Hmm... I'd say that you also have a leak in kmalloc()'ed stuff - something
> > in 1K--2K range. From your logs it looks like the thing never shrinks and
> > grows prettu fast...
>
> Same goes for buffer_head:
>
> buffer_head        44236  48520     96 1188 1213    1 :  252  126
>
> quite high I think. 2.4.3 shows this, after about the same time and activity:
>
> buffer_head          891   2880     96   72   72    1 :  252  126

hmm:  do_try_to_free_pages() doesn't call kmem_cache_reap() unless
there's no free page shortage.  If you've got a leak...

	if (free_shortage()) {
		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
	} else {
		/*
		 * Illogical, but true. At least for now.
		 *
		 * If we're _not_ under shortage any more, we
		 * reap the caches. Why? Because a noticeable
		 * part of the caches are the buffer-heads,
		 * which we'll want to keep if under shortage.
		 */
		kmem_cache_reap(gfp_mask);
	}

You might try calling it if free_shortage() + inactive shortage() >
freepages.high or some such and then see what sticks out.  Or, for
troubleshooting the leak, just always call it.

Printk says we fail to totally cure the shortage most of the time
once you start swapping.. likely the same for any sustained IO.

	-Mike

(if you hoard IO until you can't avoid it, there're no cleanable pages
left in the laundry chute [bye-bye cache] except IO pages.. i digress;)

