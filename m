Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSEPIYA>; Thu, 16 May 2002 04:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSEPIX7>; Thu, 16 May 2002 04:23:59 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:50959 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S316603AbSEPIX7>;
	Thu, 16 May 2002 04:23:59 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205160804.JAA24761@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Thu, 16 May 2002 09:04:31 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com,
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200205160515.g4G5F0I29175@oboe.it.uc3m.es> from "Peter T. Breuer" at May 16, 2002 07:15:00 AM
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

[snip]
> 
> I don't see any reason to introduce a second flag to say when a flag
> has been set .. Initial reports are that symptoms go away when
> 
>     current->flags |= PF_MEMALLOC;
> 
> is set in the process about to do networking (and unset afterwards).
> 
> There will be more news later today. I believe that this will remove
> deadlock against VM for tcp buffers, but I don't believe it will 
> stop deadlocks against "nothing", when we simply are out of buffers.
> The only thing that can do that is reserved memory for the socket.
> Any pointers?
> 
> Peter
> 

The reason for adding the second flag is that I suspect that nbd_send_req()
can be called by processes which already have PF_MEMALLOC set, in which case
we don't want to alter that. The "priority inversion" that I mentioned occurs
when you get processes without PF_MEMALLOC set calling nbd_send_req() as when
they call through to page_alloc.c:__alloc_pages() they won't use any memory
once the free pages hits the min mark even though there is memory available
(see the code just before and after the rebalance label).

Once one process has started sleeping waiting for memory in nbd_send_req()
thats is, since tx_lock prevents any further writeouts until the sleeping
process has completed. Unfortunately this has to be the case in order to
ensure that nbd's requests are sent atomically.

So rather than reserve memory specifically for sockets, in effect the
min free pages for each zone place a limit on what "normal" allocations
may use as a maximum. This is fine provided allocations in the write out
path are not "normal" as well, but able to use whatever they need. At first
I thought "we only need to set PF_MEMALLOC if we are writing" but in fact
we have to set it for reads too so that reads don't block writes I think.

There is a difference though between preventing the deadlock and adjusting
the system so that we get the maximum performance, so it will be interesting
to see whether we ought to adjust the min free pages figure in order to
get higher performance, or whether its ok as it is.

I'm not sure yet that the PF_MEMALLOC change I described actually fixes the
problem either, although it should make things a lot better. Thats
something else for further investigation.

Steve.

