Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289863AbSAWNx0>; Wed, 23 Jan 2002 08:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289862AbSAWNxQ>; Wed, 23 Jan 2002 08:53:16 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:57800 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S289859AbSAWNxK>; Wed, 23 Jan 2002 08:53:10 -0500
From: <benh@kernel.crashing.org>
To: <drobbins@gentoo.org>, "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <alan@redhat.com>,
        <akpm@zip.com.au>, <vherva@niksula.hut.fi>, <lwn@lwn.net>,
        <paulus@samba.org>
Subject: Re: Athlon/AGP issue update
Date: Wed, 23 Jan 2002 03:46:10 +0100
Message-Id: <20020123024610.30988@mailhost.mipsys.com>
In-Reply-To: <20020123.021819.21955581.davem@redhat.com>
In-Reply-To: <20020123.021819.21955581.davem@redhat.com>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This means that the fix belongs in the DRM drivers, specifically
>DRM(mmap_dma) should clear the cacheability bits in the
>vma->vm_page_prot at mmap time.

I'm afraid there might be more to this, see below.

>I always thought the idea was that the AGP device accessed main memory
>through GART with full cache coherency with the processor.  This
>should be pretty easy to implement since the PCI controller has to do
>this already.

AFAIK, most (if not all) AGP bridges do not enforce cache coherency
for AGP transactions (while they do for PCI transactions through the
AGP port). AGP memory has to be mapped uncacheable.?

>I'm really surprised that both the NVIDIA driver and DRM both get this
>wrong.
>
>Actually, the AMD guys say this:
>
>	This situation is fundamentally illegal because GART is non-coherent and
>	all translations that the processor could use to access the AGP memory
>	must, therefore, be non-cacheable.  Although we have seen no intentional
>	access to the AGP memory by the processor via the 4MB cacheable
>	translation we have seen legitimate, speculative, accesses performed by
>	the processor.
>
>"access by the processor" to the 4MB cacheable translation or
>somewhere else?  This needs clarification.

I'm not sure exactly about the AMD case, but there is at least a potential
problem with PPC in this regard. The issue is that in addition to the
non-cacheable mapping setup by the AGP driver (both the vma setup for
userland clients and the ioremap or whatever mapping setup for in kernel
clients), there is the kernel's own mapping of entire physical memory
(at least in non-highmem setup) which is cacheable. That means that there
is the theorical possibility of getting some AGP mapped cache lines
polluting the cache and causing coherency problem if

 - That memory is accessed via the kernel mapping of physical memory
(which shouldn't happen, but we should still make sure we properly
invalidate that memory from the cache when we actually setup the
AGP mapping)

 - That memory becomes the target of a speculative access by the CPU
(either read or write). This _can_ actually happen if the CPU can do
speculative accesses accross page boundaries. A 4k page mapped to AGP
can very well be physically located between 2 completely unrelated pages
that are used by the kernel via the kernel main RAM mapping. Accessing
some datas at the end of the previous page could cause the CPU to do
a speculative access to the next page as the mapping exist and is cacheable
and non-guarded.

The workaround here would be for AGP to also _unmap_ the AGP pages from
the main kernel mapping, which isn't always possible, for example on PPC
we use the BATs to map the kernel lowmem, we can't easily make "holes" in
a BAT mapping. That's one reason why I did some experiments to make the
PPC kernel able to disable it's BAT mapping.

Now the question is: Which CPUs can do speculative access accross page
boundaries ?


Ben.



