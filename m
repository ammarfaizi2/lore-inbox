Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSEQJEA>; Fri, 17 May 2002 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSEQJD7>; Fri, 17 May 2002 05:03:59 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:5649 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S315483AbSEQJD6>;
	Fri, 17 May 2002 05:03:58 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205170844.JAA30049@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Fri, 17 May 2002 09:44:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux kernel), alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
In-Reply-To: <200205162254.g4GMsiP07608@oboe.it.uc3m.es> from "Peter T. Breuer" at May 17, 2002 12:54:44 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> Sorry I didn't pick this up earlier ..
> 
> "Steven Whitehouse wrote:"
> > we don't want to alter that. The "priority inversion" that I mentioned occurs
> > when you get processes without PF_MEMALLOC set calling nbd_send_req() as when
> 
> There aren't any processes that call nbd_send_req except the unique
> nbd client process stuck in the protocol loop in the kernel ioctl
> that it entered at startup.
> 
Assuming that we are still talking kernel nbd here and not enbd, I think
you've got that backwards. nbd_send_req() is called from do_nbd_request()
which is the block device request function and can therefore be called
from any thread running the disk task queue, which I think would normally
mean that its a thread waiting for I/O as in buffer.c:__wait_on_buffer()

The loop that the ioctl runs only does network receives and thus doesn't
do any allocations of any kind itself. The only worry on the receive side
is that buffers are not available in the network device driver, but this
doesn't seem to be a problem. There are no backed up replies in the
server (we can tell from the socket queue lengths) and we know that we
can still ping clients which are otherwise dead due to the deadlock. I
don't think that at the moment there is any problem on the receive side.

> > they call through to page_alloc.c:__alloc_pages() they won't use any memory
> > once the free pages hits the min mark even though there is memory available
> > (see the code just before and after the rebalance label).
> 
> So I think the exact inversion you envisage cannot happen, but ...
> 
> I think that the problem is that the nbd-client process doesn't have
> high memory priority, and high priority processes can scream and holler
> all they like and will claim more memory, but won't make anythung better
> because the nbd process can't run (can't get tcp buffers), and so
> can't release the memory pressure.
> 
> So I think that your PF_MEMALLOC idea does revert the inversion.
> 
> Would it also be good to prevent other processes running? or is it too
> late. Yes, I think it is too late to do any good, by the time we feel
> this pressure.
> 
> Peter
> 
The mechanism works fine for block devices which do not need to allocate
memory in their write out paths. Since we know there is a maximum amount
of memory required by nbd and bounded by the maximum request size plus the
small header per request, it would seem reasonable that to avoid deadlock
we simply need to raise the amount of memory reserved for low memory
situations until we've provided what nbd needs,

Steve.

