Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285925AbRLJHYn>; Mon, 10 Dec 2001 02:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286172AbRLJHYe>; Mon, 10 Dec 2001 02:24:34 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:12307 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S285925AbRLJHYS>; Mon, 10 Dec 2001 02:24:18 -0500
Date: Mon, 10 Dec 2001 01:24:08 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Leigh Orf <orf@mailbag.com>, "M.H.VanLeeuwen" <vanl@megsinet.net>,
        Mark Hahn <hahn@physics.mcmaster.ca>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 memory badness (fixed?)
Message-ID: <20011210012408.B11697@asooo.flowerfire.com>
In-Reply-To: <200112091607.fB9G7mj01944@orp.orf.cx> <Pine.LNX.4.33.0112091758180.411-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0112091758180.411-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Dec 09, 2001 at 06:17:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about moving the calls to shrink_[di]cache_memory() after the
nr_pages check after the call to kmem_cache_reap?  Or perhaps keep it at
the beginning, but only call it after priority has gone a number of
notches down from DEF_PRIORITY?

Something like that seems like the only obvious way to balance how soon
these caches are flushed without over- or under-kill.

Also, shouldn't shrink_dqcache_memory use priority rather than
DEF_PRIORITY?  I'm also not sure what the reasoning is behind the
nr_pages=chunk_size reset.

In the case that Leigh and I are seeing (and my readprofile runs) it
sounds like shrink_cache is getting called a ton, while the bloated d/i
caches are flushed too little, too late.

Just $0.02 from a newby. ;)

Thanks for the tip, Mike,
-- 
Ken.
brownfld@irridia.com


On Sun, Dec 09, 2001 at 06:17:11PM +0100, Mike Galbraith wrote:
| On Sun, 9 Dec 2001, Leigh Orf wrote:
| 
| > In a personal email, Mike Galbraith wrote to me:
| >
| > |   On Sat, 8 Dec 2001, Leigh Orf wrote:
| > |
| > |   > inode_cache       439584 439586    512 62798 62798    1
| > |   > dentry_cache      454136 454200    128 15140 15140    1
| > |
| > |   I'd try moving shrink_[id]cache_memory to the very top of vmscan.c::shrink_caches.
| > |
| > |   	-Mike
| >
| > Mike,
| >
| > I tried what you suggested starting with a stock 2.4.16 kernel, and it
| > did fix the problem with 2.4.16 ENOMEM being returned.
| >
| > Now with that change and after updatedb runs, here's what the memory
| > situation looks like. Note inode_cache and dentry_cache are almost
| > nothing. Dunno if that's a good thing or not, but I'd definitely
| 
| Almost nothing isn't particularly good after updatedb ;-)
| 
| > consider this for a patch.
| 
| No, but those do need faster pruning imho.  The growth rate can be
| really really fast at times.
| 
| 	-Mike
