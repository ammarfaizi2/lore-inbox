Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRDFNYy>; Fri, 6 Apr 2001 09:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131629AbRDFNYp>; Fri, 6 Apr 2001 09:24:45 -0400
Received: from [166.70.28.69] ([166.70.28.69]:42063 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S131625AbRDFNYj>;
	Fri, 6 Apr 2001 09:24:39 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <Pine.GSO.3.96.1010405150444.21134E-100000@delta.ds2.pg.gda.pl> <m17l0zw6mx.fsf@frodo.biederman.org> <20010406140920.A4866@jurassic.park.msu.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2001 07:19:09 -0600
In-Reply-To: Ivan Kokshaysky's message of "Fri, 6 Apr 2001 14:09:20 +0400"
Message-ID: <m13dbmw4he.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> On Thu, Apr 05, 2001 at 12:20:22PM -0600, Eric W. Biederman wrote:
> > The point is on the Alpha all ram is always cached, and i/o space is
> > completely uncached.  You cannot do write-combing for video card
> > memory.
> 
> Incorrect. Alphas have write buffers - 6x32 bytes on ev5 and
> 4x64 on ev6, IIRC. So alphas do write up to 32 or 64 bytes
> in a single pci transaction.

Sorry I was thinking the current alpha the ev6.  So what I'm saying
doesn't apply to the alpha architecture in general just it's current
specific implementation.   

Yes for the ev6 you have write buffers but can't say just use the
write buffers,  on an arbitrary area of memory. 
 
> >  Memory barriers are a separate issue.  On the alpha the
> > natural way to implement it would be in the page table fill code.
> > Memory barriers are o.k. but the really don't help the case when what
> > you want to do is read the latest value out of a pci register.  
> 
> You don't need memory barrier for that. "Write memory barriers" are
> used to ensure correct write order, and "memory barriers" are used
> to ensure that all pending reads/writes will complete before next read
> or write.

100% Agreed. That is what I was saying.  What the ev6 doesn't have
is the ability to say this: I am using this area of the memory address
space in a particular way: don't cache it but do write combing on it.

Theoretically you could use memory barrier instructions for this but
it would require an I/O bus that supported a cache coherency
protocol.  At which point the problem moves down to your PCI bus
controller.

I recall on the ev6 all memory accesses to locations with bit 40 set 
are always to IO space are never cached and are never write buffered.
Accesses to memory locations with bit 40 clear are always to RAM are
always cached and always write buffered. 

With the high I/O bus speeds unless you are trying to push things to
the absolute limit you are unlikely to see the IO accesses being the
bottleneck in or out to a PCI device.  At which point DMA probably
already compensates, for most devices.

IIRC For PCI card IO regions where you need maximum IO speed through
the memory address space (like frame buffers) the ev6 falls down.

I really like the alpha this is why this gals me so much about the
ev6.  I hope they have it fixed for the ev7 or ev8.  If those chips
ever actually arrive.  But as the ev7 is just supposed to be the ev6
core with an on chip cache I don't have much hope.

Eric
