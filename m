Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVAMV7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVAMV7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVAMV4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:56:20 -0500
Received: from colin2.muc.de ([193.149.48.15]:30476 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261728AbVAMVxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:53:47 -0500
Date: 13 Jan 2005 22:53:46 +0100
Date: Thu, 13 Jan 2005 22:53:46 +0100
From: Andi Kleen <ak@muc.de>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
Message-ID: <20050113215346.GB1504@muc.de>
References: <20050113000949.A7449@flint.arm.linux.org.uk> <20050113085035.GC2815@suse.de> <m1wtuh2kah.fsf@muc.de> <87is616oi2.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87is616oi2.fsf@coraid.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 03:52:05PM -0500, Ed L Cashin wrote:
> Andi Kleen <ak@muc.de> writes:
> 
> ...
> > In general I think it was a bad idea to merge this driver at all.
> > The protocol is obviously broken by design - they use a 16 bit sequence
> > number space which has been proven for many years (in ip fragmentation)
> > to be far too small for modern network performance.
> 
> While that experience may apply well to IP, this is a non-IP protocol
> for a single LAN.  For any given AoE device, there are only a few
> outstanding packets at any given time.
> 
> For existing AoE devices that number of outstanding packets is only
> three!  So, with only three packets on the wire at any time for a
> given device, 16 bits is overkill.  In fact, the AoE protocol allows
> the AoE device to specify how many outstanding packets it supports.
> That number is only 16 bits wide.  
> 
> If it ever did become desirable, we could use a couple more bits for

It likely will if someone ever adds significant write cache to such
devices.

> the sequence number by borrowing from the low bits of jiffies that we
> use to estimate the RTT, but it doesn't seem likely to ever be
> desirable.

Can this be done now? 

> 
> > Also the memory allocation without preallocation in the block write
> > out path looks quite broken too and will most likely will lead to deadlocks
> > under high load.
> >
> > (I wrote a detailed review when it was posted but apparently it 
> > disappeared or I never got any answer at least) 
> 
> I think you're talking about your suggestion that the skb allocation
> could lead to a deadlock.  If I'm correct, this issue is similar to
> the one that led us to create a mempool for the buf structs we use.

For the skbuffs? I don't think it's possible to preallocate them
because the network stack (intentionally) misses hooks to give
them back to you.

BTW iirc your submit patch did too much allocations anyways because
in modern Linux skbs you can just stick a pointer to the page
into the skb when the device announces NETIF_F_SG. 

> 
> > IMHO this thing should have never been merged in this form. Can it 
> > still be backed out?
> 
> The sequence number is a non-issue, and for the deadlock danger you
> originally suggested that we add a warning against using aoe storage
> for swap.  We could add such a warning to the driver's documentation

It's not only swap, the same problem occurs when any file on such
a device is writeable mmaped.

-Andi
