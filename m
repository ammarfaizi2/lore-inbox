Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRHaX1K>; Fri, 31 Aug 2001 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269756AbRHaX1B>; Fri, 31 Aug 2001 19:27:01 -0400
Received: from maild.telia.com ([194.22.190.101]:23550 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S269752AbRHaX0y>;
	Fri, 31 Aug 2001 19:26:54 -0400
Message-Id: <200108312327.f7VNR3Y11857@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Russell King <rmk@arm.linux.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Subject: Re: [PATCH] __alloc_pages cleanup -R6 Was: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sat, 1 Sep 2001 01:22:32 +0200
X-Mailer: KMail [version 1.3]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com> <200108302357.BAA11235@mailb.telia.com> <20010831084335.A4222@flint.arm.linux.org.uk>
In-Reply-To: <20010831084335.A4222@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday den 31 August 2001 09:43, Russell King wrote:
> On Fri, Aug 31, 2001 at 01:53:24AM +0200, Roger Larsson wrote:
> > Some ideas implemented in this code:
> > * Reserve memory below min for atomic and recursive allocations.
> > * When being min..low on free pages, free one more than you want to
> > allocate. * When being low..high on free pages, free one less than
> > wanted. * When above high - don't free anything.
> > * First select zones with more than high free memory.
> > * Then those with more than high 'free + inactive_clean -
> > inactive_target' * When freeing - do it properly. Don't steal direct
> > reclaimed pages
>
> Hmm, I wonder.
>
> I have a 1MB DMA zone, and 31MB of normal memory.
>
> The machine has been running lots of programs for some time, but not under
> any VM pressure. 

OK, zones have about PAGES_LOW pages free - these are buddied together as
good as they possibly can. Since direct reclaims put the page on the free
list first before allocating one.

> I now come to open a device which requires 64K in 8K
> pages from the DMA zone.  What happens?

First - is it atomic or not? (device sounds like atomic)

If it is atomic:
1) you get one chance, no retries in __alloc_pages. [not changed]
2) you get one from those already free, no reclaims possible [not changed]
3) you are allowed to allocate below PAGES_MIN [not changed]
The result will depend on how many pages were free, if there are enough order
1 buddies.
With my algorithm it the number of free pages of all zones are very likely to
be close to PAGES_LOW since it tries to move towards it.
The original algorithm is harder to analyze, free pages will not grow unless
one hits PAGES_MIN and then kreclaimd gets started.

As a test I hit Magic-SysRq-M (256 MB RAM):

Free pages:        3836kB (     0kB HighMem) ( Active: 21853, inactive_dirty: 
19101, inactive_clean: 392, free: 959 (383 766 1149) )
0*4kB 1*8kB 8*16kB 8*32kB 4*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB
 = 1800kB)
1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB
 = 2036kB)
 = 0kB)

And a while later I hit it again:
( Active: 22300, inactive_dirty: 18742, inactive_clean: 587, free: 947 (383 
766 1149) )
3*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB
 = 1028kB)
80*4kB 39*8kB 3*16kB 3*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB
 = 2760kB)

For non atomic higher order allocations: There are more changes.
1) Tries to free the same number of pages that it want to alloc later.
2) Does not allow allocs when there are less than PAGES_MIN. [BUG in current 
code, see earlier patch - higher order non atomic allocs could drain the free
reserve if there are a lot of inactive clean pages...]
3) Retries only while there is free shortage - this could be changed...
  until all zones has more than PAGES_HIGH free. Or until there are no
  inactive clean pages left. But why favor non atomic over atomic in this
  way?

>
> I suspect that the chances of it failing will be significantly higher with
> this algorithm - do you have any thoughts for this?
>

Do you still think the risk is higher?
Stephans problem seems to be that this alloc runs over and over...

> I don't think we should purely select the allocation zone based purely on
> how much free it contains, but also if it's special (like the DMA zone).
>

It does prioritize due to the order the zones are checked in.

> You can't clean in-use slab pages out on demand like you can for fs
> cache/user pages.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
