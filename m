Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbRF2VE0>; Fri, 29 Jun 2001 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266185AbRF2VEQ>; Fri, 29 Jun 2001 17:04:16 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:43022 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266183AbRF2VEB>;
	Fri, 29 Jun 2001 17:04:01 -0400
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <3652.993803483@warthog.cambridge.redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 29 Jun 2001 23:02:24 +0200
In-Reply-To: David Howells's message of "Fri, 29 Jun 2001 09:31:23 +0100"
Message-ID: <d3bsn7gftr.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Howells <dhowells@redhat.com> writes:

David> Jes Sorensen <jes@sunsite.dk> wrote:
>>  Have you considered the method used by the 8390 Ethernet driver?
>> For each device, add a pointer to the registers and a register
>> shift.

David> And also flags to specify which address space the I/O ports
David> reside in, and which how to adjust the host-PCI bridge to bring
David> the appropriate bit of the PCI address space into view through
David> the CPU address space window. Don't laugh - it happens.

Hmm, I am shocked ;-)

>> I really don't like hacing virtual access functions that makes
>> memory mapped I/O look the same as I/O operations.

David> Why not? It makes drivers a simpler and more flexible if they
David> can treat different types of resource in the same way. serial.c
David> is a really good example of this:

It will also degrade performance if you introduce all these weird
tests or function calls in the hot path.

David> The switch has to be performed at runtime - so you get at least
David> one conditional branch in your code, probably more. My proposal
David> would replace the conditional branch with a subroutine (which
David> lacks the pipline stall).

Actually on some architectures you'd prefer the conditional branch
over the subroutine call when you can do predication like on the ia64.

David> Also a number of drivers (eg: ne2k-pci) have to be bound to
David> compile time to either I/O space or memory space. This would
David> allow you to do it at runtime without incurring conditional
David> branching.

But it's going to cost for the ones who do not support this.

>> For memory mapped I/O you want to be able to smart optimizations to
>> reduce the access on the PCI bus (or similar).

David> I wouldn't have thought you'd want to reduce the number of
David> accesses to the PCI bus. If, for example, you did to writes to
David> a memory-mapped I/O register, you don't want the first to be
David> optimised away.

One good example I can think off is when you update a dma descriptor
in PCI shared memory space (__raw_writel()). In that case you want to
be able to use posted writes so all writes is done in one PCI write
transaction instead of individual ones.

Jes
