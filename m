Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVAMWVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVAMWVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMWSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:18:53 -0500
Received: from ns1.coraid.com ([65.14.39.133]:48301 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261777AbVAMWP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:15:58 -0500
To: Andi Kleen <ak@muc.de>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
References: <20050113000949.A7449@flint.arm.linux.org.uk>
	<20050113085035.GC2815@suse.de> <m1wtuh2kah.fsf@muc.de>
	<87is616oi2.fsf@coraid.com> <20050113215346.GB1504@muc.de>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 13 Jan 2005 17:12:21 -0500
Message-ID: <87ekgp567u.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Thu, Jan 13, 2005 at 03:52:05PM -0500, Ed L Cashin wrote:
>> Andi Kleen <ak@muc.de> writes:
>> 
>> ...
>> > In general I think it was a bad idea to merge this driver at all.
>> > The protocol is obviously broken by design - they use a 16 bit sequence
>> > number space which has been proven for many years (in ip fragmentation)
>> > to be far too small for modern network performance.
>> 
>> While that experience may apply well to IP, this is a non-IP protocol
>> for a single LAN.  For any given AoE device, there are only a few
>> outstanding packets at any given time.
>> 
>> For existing AoE devices that number of outstanding packets is only
>> three!  So, with only three packets on the wire at any time for a
>> given device, 16 bits is overkill.  In fact, the AoE protocol allows
>> the AoE device to specify how many outstanding packets it supports.
>> That number is only 16 bits wide.  
>> 
>> If it ever did become desirable, we could use a couple more bits for
>
> It likely will if someone ever adds significant write cache to such
> devices.
>
>> the sequence number by borrowing from the low bits of jiffies that we
>> use to estimate the RTT, but it doesn't seem likely to ever be
>> desirable.
>
> Can this be done now? 

It seems rash to make the change now, because there is no need for it.

>> > Also the memory allocation without preallocation in the block write
>> > out path looks quite broken too and will most likely will lead to deadlocks
>> > under high load.
>> >
>> > (I wrote a detailed review when it was posted but apparently it 
>> > disappeared or I never got any answer at least) 
>> 
>> I think you're talking about your suggestion that the skb allocation
>> could lead to a deadlock.  If I'm correct, this issue is similar to
>> the one that led us to create a mempool for the buf structs we use.
>
> For the skbuffs? I don't think it's possible to preallocate them
> because the network stack (intentionally) misses hooks to give
> them back to you.

For the skbuffs, we could use a mempool with GFP_NOIO allocation and
then skb_get them before the network layer ever sees them.  We already
keep track of the packets that we've sent out, so we'll just keep a
pointer to the skbuffs.

> BTW iirc your submit patch did too much allocations anyways because
> in modern Linux skbs you can just stick a pointer to the page
> into the skb when the device announces NETIF_F_SG. 

I thought there was some shared information at the end of the data,
but that's interesting, thanks.  I'll look into it.

-- 
  Ed L Cashin <ecashin@coraid.com>

