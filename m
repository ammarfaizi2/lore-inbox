Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVAMU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVAMU6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVAMUzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:55:07 -0500
Received: from ns1.coraid.com ([65.14.39.133]:45484 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261519AbVAMUxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:53:06 -0500
To: Andi Kleen <ak@muc.de>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
References: <20050113000949.A7449@flint.arm.linux.org.uk>
	<20050113085035.GC2815@suse.de> <m1wtuh2kah.fsf@muc.de>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 13 Jan 2005 15:52:05 -0500
Message-ID: <87is616oi2.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

...
> In general I think it was a bad idea to merge this driver at all.
> The protocol is obviously broken by design - they use a 16 bit sequence
> number space which has been proven for many years (in ip fragmentation)
> to be far too small for modern network performance.

While that experience may apply well to IP, this is a non-IP protocol
for a single LAN.  For any given AoE device, there are only a few
outstanding packets at any given time.

For existing AoE devices that number of outstanding packets is only
three!  So, with only three packets on the wire at any time for a
given device, 16 bits is overkill.  In fact, the AoE protocol allows
the AoE device to specify how many outstanding packets it supports.
That number is only 16 bits wide.  

If it ever did become desirable, we could use a couple more bits for
the sequence number by borrowing from the low bits of jiffies that we
use to estimate the RTT, but it doesn't seem likely to ever be
desirable.

> Also the memory allocation without preallocation in the block write
> out path looks quite broken too and will most likely will lead to deadlocks
> under high load.
>
> (I wrote a detailed review when it was posted but apparently it 
> disappeared or I never got any answer at least) 

I think you're talking about your suggestion that the skb allocation
could lead to a deadlock.  If I'm correct, this issue is similar to
the one that led us to create a mempool for the buf structs we use.

> IMHO this thing should have never been merged in this form. Can it 
> still be backed out?

The sequence number is a non-issue, and for the deadlock danger you
originally suggested that we add a warning against using aoe storage
for swap.  We could add such a warning to the driver's documentation
and start working on a patch that avoids deadlocking on the skb
allocation.  There's no need to panic and force users go get a third
party driver.

-- 
  Ed L Cashin <ecashin@coraid.com>

