Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272110AbRHVUdw>; Wed, 22 Aug 2001 16:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272113AbRHVUdn>; Wed, 22 Aug 2001 16:33:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18181 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272110AbRHVUdd>; Wed, 22 Aug 2001 16:33:33 -0400
Date: Wed, 22 Aug 2001 16:05:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: tommy@teatime.com.tw, Linux Kernel <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>
Subject: Re: Memory Problem in 2.4.9 ?
In-Reply-To: <20010822192559Z16191-32383+888@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108221604300.2685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Aug 2001, Daniel Phillips wrote:

> On August 22, 2001 06:47 am, Tommy Wu wrote:
> >    I've tried the patch in the kernel list. Got the result as following...
> >    This message for command: 
> >    dd if=/dev/zero of=test.dmp bs=1000k count=2500
> >    on a PIII 1G SMP box with 1G RAM (HIGHMEM enabled)
> >    kernel 2.4.9 with XFS filesystem patch.
> >
> > Aug 22 11:51:04 standby kernel: __alloc_pages: 0-order allocation failed
> > (gfp=0x30/1).
> > Aug 22 11:51:11 standby last message repeated 111 times
> 
> OK, this is a straight-up design bug.  Although this can also happen with 
> normal memory, it's much more likely to happen with highmem because of heavy 
> demand for bounce buffers while a process is in PF_MEMALLOC state.  You can 
> just turn off highmem and these messages will go away, or become so rare that 
> you are unlikely to ever see one.
> 
> Now lets chase the real problem.  The gfp=0x30 tells us the requestor is 
> willing to wait (0x10) and that it is not allowed to do any io (0x40) or call 
> ->writepage (0x80).  (By process of elimination, it's a bounce buffer.) 
> Furthermore, this is a recursive memory request (/1) so __alloc_pages won't 
> call page_launder because that could hit another allocation request resulting 
> in a fatal infinite recursion (note to self: why couldn't we call 
> page_launder here, with NOIO?).
> 
> There are probably dirty pages in flight and __alloc_pages is allowed to wait 
> for them, but it doesn't - it trys reclaim_page once (in 
> __alloc_pages_limit), falls the rest of the way through __alloc_pages and 
> gives up with NULL.  This is clearly a bad thing because whoever wanted the 
> page needs it to do writeout.  Memory users are supposed to be able to 
> tolerate alloc failure, but in a case like this, there isn't much choice 
> other than to spin.
> 
> So what could we do better here?  Well, obviously when there are writeout 
> pages in flight, __alloc_pages should wait and not give up.  Secondly, we 
> should be sure that when writeout does complete, the newly freeable page is 
> given to a PF_MEMALLOC waiter in preference to a normal user.  We don't have 
> mechanisms in place for doing either of those things right now, although some 
> preliminary design ideas have been discussed.  This gets way outside the 
> bound of what we should be doing in 2.4, we will need such things as 
> reservations (which Ben has done some work on) and orderly prioritization of 
> requests in __alloc_pages, with explicit blocking for low priority requests.  
> 
> What can we do right now?  We could always just comment out the alloc failed 
> message.  The result will be a lot of busy waiting on dirty page writeout 
> which will work but it will keep us from focussing on the question: how did 
> we get so short of bounce buffers?  Well, maybe we are submitting too much IO 
> without intelligent throttling (/me waves at Ben).  That sounds like the 
> place to attack first.

We can just wait on the writeout of lowmem buffers at page_launder()
(which will not cause IO buffering since we are doing lowmem IO, duh), and
then we are done.

Take a look at the patch I posted before (__GFP_NOBOUNCE). 

