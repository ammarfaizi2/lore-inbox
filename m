Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTJQXzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTJQXzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:55:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:34511 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263639AbTJQXz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:55:29 -0400
Date: Fri, 17 Oct 2003 16:55:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-Id: <20031017165543.2f7e9d49.akpm@osdl.org>
In-Reply-To: <200310171725.10883.bjorn.helgaas@hp.com>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> On Friday 17 October 2003 4:50 pm, Andrew Morton wrote:
> > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > >
> > > Old behavior:
> > > 
> > >     # dd if=/dev/mem of=/dev/null
> > >     <unrecoverable machine check>
> > 
> > I recently fixed this for ia32 by changing copy_to_user() to not oops if
> > the source address generated a fault.  Similarly copy_from_user() returns
> > an error if the destination generates a fault.
> > 
> > In other words: drivers/char/mem.c requires that the architecture's
> > copy_*_user() functions correctly handle faults on either the source or
> > dest of the copy.
> 
> If we really believe copy_*_user() must correctly handle *all* faults,
> isn't the "p >= __pa(high_memory)" test superfluous?

This code was conceived before my time and I don't recall seeing much
discussion, so this is all guesswork..

I'd say that the high_memory test _is_ superfluous and that if anyone
cared, we would remove it and establish a temporary pte against the address if
it was outside the direct-mapped area.  But nobody cares enough to have
done anything about it.

> I don't know how ia32 handles a read to non-existent physical memory.
> Are you saying that copy_*_user() can deal with that just like it does
> a garden-variety TLB fault?

I don't know, and I suspect it depends on the off-CPU hardware
implementation anyway.  But the access will either generate a fault or it
won't and in either case we're OK, yes?

> On ia64, a read to non-existent physical memory causes the processor
> to time out and take a machine check.  I'm not sure it's even possible
> to recover from that.

ick.  That would be very poor form.  What about things like probing for
memory, device hot-unplug, memory hot unplug etc?


Still, the code you have is quite reasonable.  But please structure it
thusly:


#include <asm/io.h>	/* valid_phys_addr_range */

#ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
static inline int valid_phys_addr_range(unsigned long addr, size_t *count)
{
	unsigned long end_mem;

	end_mem = __pa(high_memory);
	if (addr >= end_mem)
		return 0;

	if (*count > end_mem - addr)
		*count = end_mem - addr;

	return 1;
}
#endif

or whatever.  It's a bit more conventional this way and allows other
architectures to do appropriate things.

As for return values: if the requested read or write starts at a
not-present address it should probably return -EFAULT.  This is what ia32
will do.  Arguably this is indistinguishable from a bad address on the
userspace side and we should return -EINVAL but whatever.

If the request starts at a valid phys address but covers a not-present
address it should return a short read or write (returns something less than
`count').



