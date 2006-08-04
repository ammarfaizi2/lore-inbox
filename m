Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWHDGUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWHDGUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHDGUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:20:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:25301 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751138AbWHDGUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:20:40 -0400
Date: Fri, 4 Aug 2006 10:20:08 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chris Leech <chris.leech@gmail.com>
Cc: Krzysztof Oledzki <olel@ans.pl>, Arnd Hannemann <arnd@arndnet.de>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060804062008.GC413@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru> <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl> <20060803151631.GA14774@2ka.mipt.ru> <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com> <20060803161046.GA703@2ka.mipt.ru> <41b516cb0608031332v9cc383bq37a13254f25f45a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <41b516cb0608031332v9cc383bq37a13254f25f45a9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 04 Aug 2006 10:20:14 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:32:10PM -0700, Chris Leech (chris.leech@gmail.com) wrote:
> >Maximum e1000 frame is 16128 bytes, which is enough before being rounded
> >to 16k to have a space for shared info.
> >My patch just tricks refilling logic to request to allocate slightly less
> >than was setup when mtu was changed.
> 
> The maximum supported MTU size differs between e1000 devices due to
> differences in FIFO size.  For performance reasons the driver won't
> enable a MTU that doesn't allow for at least two frames in the Tx FIFO
> at once - you really want e1000 to be able to DMA the next frame into
> Tx FIFO while the current one is going out on the wire.  This doesn't
> change the fact that with LPE set, anything that can fit into the Rx
> FIFO and has a valid CRC will be DMAed into buffers regardless of
> length.

But still it must be less than MAX_JUMBO_FRAME_SIZE, which is 16128
bytes, at least it is maxiumum allowed mtu in e1000_change_mtu().

> >Hardware is not affected, second patch just checks if there is enough
> >space (e1000 stores real mtu). I can not believe that such modern NIC
> >like e1000 can not know in receive interrupt size of the received
> >packet, if it is true, than in generel you are right and some more
> >clever mechanisms shoud be used (at least turn hack off for small
> >packets and only enable it for less than 16 jumbo frames wheere place
> >always is), if size of the received packet is known, then it is enough
> >to compare aligned size and size of the packet to make a decision for
> >allocation.
> 
> You're changing the size of the buffer without telling the hardware.
> In the interrupt context e1000 knows the size of what was DMAed into
> the skb, but that's after the fact.  So e1000 could detect that memory
> was corrupted, but not prevent it if you don't give it power of 2
> buffers.  Actually, the power of 2 thing doesn't hold true for all
> e1000 devices.  Some have 1k granularity, but not Arnd's 82540.

I can not change it - code checks if requested mtu and additional size
is less than allocated aligned buffer it tricks allocator.
Or do you mean that even after 9k mtu was setup it is possible that card
can receive packets up to 16k?

> You can't know the size of a received packet before it's DMAed into
> host memory, no high performance network controller works that way.

> - Chris

-- 
	Evgeniy Polyakov
