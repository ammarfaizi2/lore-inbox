Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313939AbSDKCRH>; Wed, 10 Apr 2002 22:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313940AbSDKCRG>; Wed, 10 Apr 2002 22:17:06 -0400
Received: from web21204.mail.yahoo.com ([216.136.131.77]:43060 "HELO
	web21204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313939AbSDKCRG>; Wed, 10 Apr 2002 22:17:06 -0400
Message-ID: <20020411021705.62404.qmail@web21204.mail.yahoo.com>
Date: Wed, 10 Apr 2002 19:17:05 -0700 (PDT)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: csum_and_copy_from_user, tcp_sendmsg and zero-copy question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have been writing a driver for a SAN device. This
device supports packetization (including header gen,
checksums, etc) of data buffers. Ideally, in order to
minimize host cpu utilization, the driver could just
convert the caller's scatter-gather list into a bus
address scatter-gather list and pass that to the hw. 
I believe that from this perspective, the ideal code 
for the driver's tcp_sendmsg looks like:

tcp_sendmsg(sk,...)
{
   housekeeping();
   
   if (isUserSpace(iov)) {
     bussglist = convert_useg_iov_to_bus_sglist(iov);
     supply_sglist_to_hw(sk,bussglist);
   } else {
     convert_kseg_iov_to_bus_sglist(iov);
     supply_sglist_to_hw(sk,bussglist);
   }

   if (blocking) wait_for_tcp_send_dma_done(sk);
   
   housekeeping();
}

The convert_useg_iov_to_bus_sglist would be something
that would make sure the application's user space
buffers are paged into physical memory (handling
physical memory pressure by sleeping), convert each
entry in the application's scatter gather list into
bus address/lengths.

I don't have enough experience or knowledge to know
whether a convert_useg_iov_to_bus_sglist type scheme
is a good thing. I understand that there are security
issues that doing DMA to/from user space buffers 
introduces. And system stablity issues as well due to
allowing applications to increase physical memory
pressure directly. I see that zero-copy for TCP (of
the nature I described) has already been discussed 
on lkml. However, I couldn't see a clear consensus
on a conclusion. I apologize if this is an inaccurate
interpretation on my behalf.

I think that a subset of zero-copy TCP has been
implemented in the linux kernel as of the 2.4.4 
kernel (David Miller's patch). I say subset because
examining the tcp_sendmsg code, I see tcp_copy_to_page
which calls csum_and_copy_from_user which does a copy
from user. Is my interpretation correct that the 
tcp_sendmsg codepath does zerocopy (for eth drivers
that support the appropriate dev->feature) but does
a single copy from user of the data buffer?

If this is so, I would greatly appreciate advice/
opinions /etc on what steps I could take to achieve
the full zero-copy goal (if it's the right goal to
have).

Thanks,
Melkor



__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
