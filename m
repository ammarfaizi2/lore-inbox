Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUEWCrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUEWCrB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 22:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUEWCrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 22:47:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52124 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262103AbUEWCqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 22:46:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
	<m165aorm70.fsf@ebiederm.dsl.xmission.com>
	<20040522180837.3d3cc8a9.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 May 2004 20:45:32 -0600
In-Reply-To: <20040522180837.3d3cc8a9.akpm@osdl.org>
Message-ID: <m11xlbsvxv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > >
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> 
> > >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> 
> > > 
> > > 
> > > add-i386-readq.patch
> > >   add i386 readq()/writeq()
> > 
> > > static inline u64 readq(void *addr)
> > > {
> > > 	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> > > }
> > > 
> > > static inline void writeq(u64 v, void *addr)
> > > {
> > > 	u32 v32;
> > > 
> > > 	v32 = v;
> > > 	writel(v32, addr);
> > > 	v32 = v >> 32;
> > > 	writel(v32, addr + 4);
> > > }
> > > 
> > > #endif
> > 
> > The implementation is broken and it will break drivers that actually
> > expect writeq and readq to be 64bit reads and writes.
> 
> I don't think we can expect all architectures to be able to implement
> atomic 64-bit IO's, can we?

No I don't think we can expect all architectures to be able to
generate 64-bit bus cycles.  Although I think we can expect a majority
of them to, and I believe that majority encompasses all the platforms
we want to run drivers that require readq and writeq.

There are some drivers that cannot be implemented on architectures
without 64bit transactions on the I/O bus.  This is not always a race
issue that can be fixed with locking.  I know of at least mtd map
driver where if you don't feed the device 64bit writes you will store
corrupt data.

If we want to use the above quoted functions we need to call them
readq_emulated and writeq_emulated.  Because they are not the real
mccoy.  Likely only readq_emulated and writeq_emulated can be
implemented on all architectures.

As I understand the current situation every architecture that
implements readq/writeq generates true 64bit bus cycles.  A driver can
test if it the support exists at compile time with a simple #ifdef to
see if the function is present.  If the function is not supported at
compile time the driver can implement a work around (like
readq_emulated) or it can fail to compile.

> ergo, drivers which want to use readq and writeq should provide the
> appropriate locking.

Hmm.  I thought the logic:
   I am going to introduce a broken implementation of a generic
   function and this will reduce the maintainability of your driver in
   subtle incomprehensible ways by not doing what is advertised.  In
   addition I will not even attempt to fix all of the drivers in the
   tree when I generate the patch.
did not fly in linux.

I am worried about the general and subtle breakage that may occur
from a driver that works when real 64bit read/writes are generated
on the bus, and fails when we emulate them.

Knowing of two drivers off the top of my head that will break
with this patch, I am opposed to it on general grounds.  The
infiniband driver is not in the tree and it can have locking
added to correct the additional race.  The 64bit mtd map drivers
I have seen for some ppc platrrom will break as soon as they stop
rolling readq/writeq by hand, and no amount of locking will help
there.  I don't know what else in the tree will break.

> > I attempted to suggest some alternative implementations earlier
> > in the original thread that brought this up but it looks like
> > you missed that.
> 
> I saw some stuff float past, but I don't recall seeing anything which would
> work on all architectures?

I am not yet convinced you can write code that will work on all
architectures.  I have yet to see generic code that with all
existing drivers.

I was attempting to start the conversation, because I don't know all
of the answers, I can just detect failures.  In general on a 32bit
arch you need to use the FPU to implement a 64bit read or write. This
is not something you can code casually in the kernel or that you can
write generically.  Although the basic idiom will likely be the same
for different architectures.

Currently I know of a safe version that will work on x86 on processors
with sse support.   And I how to generate 64bit I/O cycles with using
mmx or x87 registers,  but don't know if I can write code that touches
the FPU registers that is interrupt safe.

Eric


