Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268842AbRHBHeB>; Thu, 2 Aug 2001 03:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268841AbRHBHdv>; Thu, 2 Aug 2001 03:33:51 -0400
Received: from rj.sgi.com ([204.94.215.100]:48771 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268842AbRHBHdc>;
	Thu, 2 Aug 2001 03:33:32 -0400
Date: Thu, 2 Aug 2001 00:31:52 -0700 (PDT)
From: jeremy@classic.engr.sgi.com (Jeremy Higdon)
Message-Id: <10108020031.ZM229058@classic.engr.sgi.com>
In-Reply-To: Andrea Arcangeli <andrea@suse.de>
        "Re: changes to kiobuf support in 2.4.(?)4" (Aug  2,  8:43am)
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> 
	<20010802084259.H29065@athlon.random>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: changes to kiobuf support in 2.4.(?)4
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 2,  8:43am, Andrea Arcangeli wrote:
> 
> OTOH I'm a little biased in the above reasoning since I use the kiobuf
> only for doing direct I/O (I always end calling brw_kiovec somehow,
> otherwise I wouldn't be using the kiobufs at all). If you are using the
> kiobufs for framebuffers and other drivers that never ends calling
> brw_kiovec I think you should be using the mmap callback and

By "mmap callback", you're referring to the mmap entry in the file_operations
structure?

> remap_page_range instead as most drivers correctly do to avoid the
> overhead of the kiobufs. But ok if you really want to use the kiobuf for
> non I/O things instead of remap_page_range (dunno why) we could split
> off the bh-array allocation from the kiobuf to make it a bit lighter so
> you could use it for non-IO operations without the overhead of the bhs,
> but still we should adapt rawio to preallocate the bh at open/close time
> (separately from the kiovec).
> 
> Andrea

I am doing direct I/O.  I'm using the kiobuf to hold the page addresses
of the user's data buffer, but I'm calling directly into my driver
after doing the map_user_kiobuf() (I have a read/write request, a file
offset, a byte count, and a set of pages to DMA into/out of, and that
gets directly translated into a SCSI command).

It turns out that the old kmem_cache_alloc was very lightweight, so I
could get away with doing it once per I/O request, so I would indeed
profit by going back to a light weight kiobuf, or at least an optional
allocation of the bh and blocks arrays (perhaps turn them into pointers
to arrays?).

thanks

jeremy
