Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVLVPhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVLVPhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVLVPhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:37:50 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:22413 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751117AbVLVPht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:37:49 -0500
To: Andrey Volkov <avolkov@varma-el.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 22 Dec 2005 10:37:45 -0500
In-Reply-To: <43A98F90.9010001@varma-el.com>
Message-ID: <yq0d5jpuoqe.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrey" == Andrey Volkov <avolkov@varma-el.com> writes:

Andrey> Hello Jes and all I try to use your allocator (gen_pool_xxx),
Andrey> idea of which is a cute nice thing. But current implementation
Andrey> of it is inappropriate for a _device_ (aka onchip, like
Andrey> framebuffer) memory allocation, by next reasons:

Andrey,

Keep in mind that genalloc was meant to be simple for basic memory
allocations. It was never meant to be an over complex super high
performance allocation mechanism.

Andrey>  1) Device memory is expensive resource by access time and/or
Andrey> size cost.  So we couldn't use (usually) this memory for the
Andrey> free blocks lists.

This really is irrelevant, the space is only used within the object
when it's on the free list. Ie. if all memory is handed out there's
no space used for this purpose.

Andrey> 3) Obvious (IMHO) workflow of mem. allocator
Andrey> look like: - at startup time, driver allocate some big
Andrey> (almost) static mem. chunk(s) for a control/data structures.
Andrey> - during work of the device, driver allocate many small
Andrey> mem. blocks with almost identical size.  such behavior lead to
Andrey> degeneration of buddy method and transform it to the
Andrey> first/best fit method (with long seek by the free node list).

This is only really valid for network devices, and even then it's not
quite so. For things like uncached allocations your observation is
completely off.

For the case of more traditional devices, the control structures will
be allocated from one end of the block, the rest will be used for
packet descriptors which will be going in and out of the memory pool
on a regular basis. In most normal cases these will all be of the same
size and it doesn't matter where in the memory space they were
allocated.

Andrey> 4) The simple binary buddy method is far away from perfect for
Andrey> a device due to a big internal fragmentation. Especially for a
Andrey> network/mfd devices, for which, size of allocated data very
Andrey> often is not a power of 2.

For network devices it's perfectly adequate as it will almost always
satisfy what I described above. Incoming packets will always be
allocated for a full MTU sized packet hence all allocated blocks will
be of the same size. For outgoing packets, the allcation is short
lived and while it may be that a good chunk of packets aren't all full
MTU sized, it is rarely worth the hassle of trying to make the
allocator allow to-the-byte sized allocations as the number of
outstanding outgoing packets will be very limited.

Andrey> I start to modify your code to satisfy above demands, but
Andrey> firstly I wish to know your, or somebody else, opinion.

I honestly don't think the majority of your demands are valid.
genalloc was meant to be simple, not an ultra fast at any random
block size allocator. So far I don't see any reason for changing to
the allocation algorithm into anything much more complex - doesn't
mean there couldn't be a reason for doing so, but I don't think you
have described any so far.

You mentioned frame buffers, but what is the kernel supposed to do
with those allocation wise? If you have a frame buffer console, the
memory is allocated once and handed to the frame buffer driver.
Ie. you don't need a ton of on demand allocations for that and for
X, the memory management is handled in the X server, not by the
kernel.

The only thing I think would make sense to implement is to allow it to
use indirect descriptor blocks for the memory it manages. This is not
because it's wrong to use the memory for the free list, as it will
only be used for this when the chunk is not in use, but because access
to certain types of memory isn't always valid through normal direct
access. Ie. if one used descriptor blocks residing in normal
GFP_KERNEL memory, it would be possible to use the allocator to manage
memory sitting on the other side of a PCI bus.

Regards,
Jes
