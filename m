Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130688AbQKQRUC>; Fri, 17 Nov 2000 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130640AbQKQRTw>; Fri, 17 Nov 2000 12:19:52 -0500
Received: from [64.64.109.142] ([64.64.109.142]:51975 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S130448AbQKQRTh>; Fri, 17 Nov 2000 12:19:37 -0500
Message-ID: <3A156116.65CDBBE9@didntduck.org>
Date: Fri, 17 Nov 2000 11:47:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171620.eAHGKgg00324@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Hi,
> 
> I've been looking at a number of VGA cards recently, and I've started
> wondering out the Linux resource management as far as allocation of
> IO ports.  I've come to the conclusion that it does not contain all
> information necessary to allow allocations to be made safely.
> 
> Thus far, VGA cards that I've looked at scatter extra registers through
> out the PCI IO memory region without appearing in the PCI BARs.  In fact,
> for some cards there wouldn't be enough BARs to list them all.
> 
> For example, S3 cards typically use:
> 
>  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
>  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
>  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8,
>  0xff00 - 0xff44

This is an artifact from the ISA 10-bit IO bus.  Many ISA cards do not
decode all 16 address bits so you get aliases of the 0x100-0x3ff region
throughout IO space.  PCI cards should only use the first 256 ports of
any 1k block to avoid aliases unless they claim the base alias.  For
example, all the xxe8 addresses for the S3 are aliases of 0x02e8 to an
ISA card.  Video cards are an exception to the general rule because they
have to support all the legacy VGA crap.

> These aren't guaranteed to be exhaustive listings either.
> 
> Some of these cards require writes to these registers to "wake them up"
> so I think we can assume that these cards are listening for accesses to
> those ports.  If we allocate another device to use that region, we could
> well end up getting IO port clashes.
> 
> Surely we should be reserving these regions before we start to allocate
> resources to PCI cards?

The current code already tries to avoid the ISA alias areas:
/*
 * We need to avoid collisions with `mirrored' VGA ports
 * and other strange ISA hardware, so we always want the
 * addresses to be allocated in the 0x000-0x0ff region
 * modulo 0x400.
 *
 * Why? Because some silly external IO cards only decode
 * the low 10 bits of the IO address. The 0x00-0xff region
 * is reserved for motherboard devices that decode all 16
 * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
 * but we want to try to avoid allocating at 0x2900-0x2bff
 * which might have be mirrored at 0x0100-0x03ff..
 */

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
