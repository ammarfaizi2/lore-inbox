Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263922AbRFEIqq>; Tue, 5 Jun 2001 04:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263924AbRFEIqg>; Tue, 5 Jun 2001 04:46:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:38129 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263922AbRFEIqX>; Tue, 5 Jun 2001 04:46:23 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15132.22933.859130.119059@pizda.ninka.net> 
In-Reply-To: <15132.22933.859130.119059@pizda.ninka.net>  <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net> <20010605155550.C22741@metastasis.f00f.org> 
To: "David S. Miller" <davem@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush. 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Tue, 05 Jun 2001 09:46:09 +0100
Message-ID: <25587.991730769@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
> Chris Wedgwood writes:
> > What if the memory is erased underneath the CPU being aware of
> > this? In such a way ig generates to bus traffic...

> This doesn't happen on x86.  The processor snoops all transactions
> done by other agents to/from main memory.  The processor caches are
> always up to date. 

No. My original mail presented two situations in which this assumption is 
false.

1. Bank-switched RAM. You want to force a writeback before switching pages.
   I _guarantee_ you that the CPU isn't snooping my access to the I/O port
   which sets the latch that drives the upper few address bits of the RAM 
   chips.

2. Flash. A few writes of magic data to magic addresses and a whole erase
   block suddenly contains 0xFF. The CPU doesn't notice that either.

What I want is a function like simon_says_flush_page_to_ram(). In this 
case, I _do_ know better than the CPU. It is _not_ coherent with these 
devices.

I'm actually working on a MIPS box at the moment - the particular problems
with doing it on i386 don't interest me too much. To be honest, I could do
it by sticking asm instructions inside ifdefs in what is otherwise
arch-independent code. I'd rather not do it like that, though. 

Surely stuff like that should be exported by the arch-specific code or
include files somehow. Possibly with a #define or function I can use to tell
whether a selective flush is actually available on the current CPU. If it's
not possible to flush the dcache selectively, then the cost of doing a full
flush probably outweighs the benefit¹ of running the flash cached in the
first place. But it should still be possible to do it from arch-independent
code without manually inserting asm instructions to do it.

--
dwmw2

¹ The _assumed_ benefit, admittedly. I should get some benchmarks to back up
the comment about molasses in arch/cris/drivers/axisflashmap.c


