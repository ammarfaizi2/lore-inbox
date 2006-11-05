Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965772AbWKEBKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965772AbWKEBKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 20:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965773AbWKEBKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 20:10:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:42151 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965772AbWKEBKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 20:10:34 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 12:10:05 +1100
Message-Id: <1162689005.28571.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 15:52 -0800, Linus Torvalds wrote:
> 
> On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> > 
> > I'm tempted to remove those mmio_* things from iomap.c completely. I
> > need to check who uses them, but in all cases, I don't see what they do
> > in iomap.c, it's not their place.
> 
> I don't think you understand the point. The point is that a lot of the 
> tests for whether something is MMIO or PIO can be done _once_, instead of 
> doing it for every access.

  .../...

I think we are just not talking about the same thing here... (and are
quickly jumping on big words :-)

Let me rephrase my point, I think we are simply not understanding each
other.

So Yes, iomap is a library that can be replaced, Yes, all you said is
good about testing the type once and doing the "repeat", and that's
exactly what iomap does.

The Generic iomap basically does something around the lines of

 - define an IO_COND macro that decides wether an adddress is PIO or
MMIO (and that can even be customized in some ways with
HAVE_ARCH_PIO_SIZE, which is all good).

 - implements a set of io{read,write}{8,16,32}{le,be}[_rep] functions
that provide pretty much the complete set of accessors using that macro
such that those accessors operate on both MMIO and PIO provided the
address passed comes pci_iomap/ioport_map.

So far so good, up to this point, we all agree and the world is
beautiful.

The -only- problem I'm talking about is that in order to implement the
above, this IOCOND does something around the line of:

	if (pio)
		use_pio_accessor()
	else
		use_mmio_accessor()

It does that, by using the existing, arch provided, accessors for PIO
and MMIO (inX, outX, readX, writeX), which are doing the right thing vs.
barriers etc, so again, all is good and well.... until you hit cases
where such accessors don't exist !

And that's exactly where the shit hits the fan. That is, when the
appropriate accessor don't already exist, it tries to define it's own,
and that's where I have the problem. This is more specifically for the
following cases:

	- "be" versions of MMIO accesses. Example:

unsigned int fastcall ioread16be(void __iomem *addr)
{
        IO_COND(addr, return inw(port), return be16_to_cpu(__raw_readw(addr)));
}

	- repeat versions of MMIO accessors. Example:

static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
{
        while (--count >= 0) {
                __raw_writel(*src, addr);
                src++;
        }
}

Followed by

void fastcall ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
{
        IO_COND(addr, insl(port,dst,count), mmio_insl(addr, dst, count));
}

In both those cases, as you can see, we are using an existing arch
provided accessor for the PIO case which does the right thing. But due
to the lack of standard "stream" (ie. "repeat") accessors provided by
archs for MMIO, we invent one based on __raw_* and due to the lack of
"big endian" standard accessor (see my point below), we invent one based
on be16_to_cpu(__raw*).

The problem with the above is that these "replacement" accessors we make
up for MMIO based on __raw, because they use __raw, don't provide any
barrier _at_all_. They are thus incorrect for some platforms like
PowerPC.

So yes, we can have our own iomap alltogether. In fact, we do right now
and it works fine. It's just that I need to do this specific option for
powerpc where IO accessors can be hooked (to workaround HW and
Hypervisor issues) when building for some platforms, in which case, I
can't use our current iomap implementation and what I need is really
just the generic one ... except for those couple of issues with
"missing" MMIO accessors.

Hence my proposal: instead of having iomap create it's own versions of
the missing MMIO accessors, have them defined generally, and have the
generic iomap use them.

In the above case, that means defining generally some "repeat" version
of the PCI MMIO accessors (readsb, readsw, etc...) which would have a
consistent naming with the IO versions and would even be useable by
MMIO-only PCI drivers who don't wnat to take the iomap overhead. In
fact, as Russell mentioned, ARM already have those and I have a patch
adding them to PowerPC. It should be trivial to use the implementation
abvoe based on __raw_* as a default for archs that don't provide them
for now too.

In the remaning case of the "be" versions, I suppose we still have a
problem... I'd be almost tempted to use swab16(readw) instead of the
current be16_to_cpu(__raw_readw(addr) (which should probably be
cpu_to_be16 btw).

Now I'm not -that- big about it. As you said, and I agree, I can just do
my own (or rather, have powerpc have 2 versions of iomap, the current
one, and a modified version of the generic one for when my "IOs can be
hooked" option is set.

I just felt that it was a bit of a waste considering that most of the
generic iomap just fits nicely, only those few MMIO operations that
aren't generically defined and that iomap tries to define itself based
on the __raw_ versions are a problem.

(BTW. That leads to the point that the __raw_ accessors are generally
not useful as they both don't endian swap and don't do barriers and that
we don't provide generic barrier ops that can be used to do the job
manually afaik).

Cheers,
Ben.


