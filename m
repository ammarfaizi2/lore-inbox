Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTBSWc4>; Wed, 19 Feb 2003 17:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTBSWc4>; Wed, 19 Feb 2003 17:32:56 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:22504
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S262380AbTBSWcy>; Wed, 19 Feb 2003 17:32:54 -0500
Date: Wed, 19 Feb 2003 17:41:39 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "David S. Miller" <davem@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
In-Reply-To: <1045692476.14306.14.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0302191706330.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2003, David S. Miller wrote:

> I don't think you are making things any better by adding
> a new ifdef to all the drivers.

I'm adding an ifdef to types.h, not to all the drivers -- the drivers can 
use it if they choose to.

> And frankly, trying to super-optimize a driver
> because it has two different descriptor format is a mess you as a driver
> author choose to get involved in.

Indeed. But why would you want to make my life miserable if you make that 
choice? Take a look at starfire.c to see how all that 32/64 bit code is 
neatly handled by a few very simple macros, and the only really hideous 
part is the #ifdef which decides if dma_addr_t is 32- or 64-bit.

I would gladly define my own macros if cpp groked sizeof(). But it 
doesn't, that's why I want this simple macro where it belongs: next to the 
definition of dma_addr_t.

> Nearly all cards today are 64-bit DMA address descriptors only.
> So if anything, this new ifdef will get less and less used over
> time.

Not true. Even if the only descriptors available are 64-bit, there is no 
reason why I should have to care about the upper 32 bits when I know that 
my dma_addr_t will always be 32-bit, at compile time. I can simply 
memset(0) the entire descriptor and initialize only the bottom 32 bits. 

What you're saying is, in essence, "screw your card, screw your 32-bit
platform, the future is all-64-bit anyway and/or everyone has gobs of
memory and is using highmem". A little bit exagerated, of course, but...

> > 3. use run-time checks all over the place, of the 
> > "sizeof(dma_addr_t)==sizeof(u64)" kind, which adds unnecessary overhead to 
> > all platforms.
> 
> The compiler optimizes this completely away, it becomes
> a compile time test and the unused code block and the test
> never make it into the assembler.
> 
> So this argument is bogus, as is the define.

It's not completely bogus, although I already conceded that the code is
indeed optimized away by the compiler. What the compiler does not optimize
away is the larger data structures needed to hold 64 bit values.

As I said in a different email, this is what I'll end up using if the new 
define is not accepted.

On 19 Feb 2003, David S. Miller wrote:

> On Wed, 2003-02-19 at 10:20, Ion Badulescu wrote:
> > Well, yes and no. Indeed those checks are optimized away, but as a result 
> > of using them most data-access macros must be converted to inline 
> > functions. And, last I heard at least, gcc was optimizing inline functions 
> > much worse than preprocessor macros.
> 
> Not true, you can still use macros and GCC is saner with inlines
> these days.

I'm curious about this, actually. If I do something like

#if DMA_ADDR_T_SIZE == 64
#define cpu_to_dma(x) cpu_to_le64(x)
#else
#define cpu_to_dma(x) cpu_to_le32(x)
#endif

descr.addr = cpu_to_dma(dma_addr)

or

if (sizeof(dma_addr_t) == sizeof(u64))
	descr64.addr = cpu_to_le64(dma_addr);
else
	descr32.addr = cpu_to_le32(dma_addr);

then the compiler generates equivalent code? Even if that's true, which 
code fragment strikes you as uglier and/or harder to read, particularly if 
it's repeated multiple times in close succession?


Or maybe you are suggesting an abomination like

void assign_dma_addr(descr64_t *descr64, descr32_t *descr32, dma_addt_t dma_addr)
{
	if (sizeof(dma_addr_t) == sizeof(u64))
		descr64->addr = cpu_to_le64(dma_addr);
	else
		descr32->addr = cpu_to_le32(dma_addr);
}

or, worse, the gcc-specific abomination

#define cpu_to_dma(x) \
({ dma_addr_t dma_addr; \
   if (sizeof(dma_addr_t) == sizeof(u64)) \
     dma_addr = cpu_to_le64(x); \
   else \
     dma_addr = cpu_to_le32(x); \
   dma_addr; \
});


And all these just for avoiding a very clearly-defined #ifdef's in a 
header file?...

> Your arguments are nice to encourage your patch to be accepted,
> they are however not correct.

I think you're being a bit harsh here. :) "Some arguments were not 100% 
correct" would be a better description...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

