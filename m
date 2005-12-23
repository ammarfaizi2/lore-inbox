Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbVLWK7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbVLWK7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbVLWK7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:59:25 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:59043 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1030486AbVLWK7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:59:25 -0500
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Pantelis Antoniou <panto@intracom.gr>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com> <yq0d5jpuoqe.fsf@jaguar.mkp.net>
	<43AAEE12.5030009@varma-el.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 23 Dec 2005 05:59:23 -0500
In-Reply-To: <43AAEE12.5030009@varma-el.com>
Message-ID: <yq08xuculis.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrey" == Andrey Volkov <avolkov@varma-el.com> writes:

Andrey> Hi Jes,
Andrey> Jes Sorensen wrote:
>>  This really is irrelevant, the space is only used within the
>> object when it's on the free list. Ie. if all memory is handed out
>> there's no space used for this purpose.

Andrey> I point out 2 reasons: ACCESS TIME was first :), let take very
Andrey> widespread case: PCI device with some onboard memory and any N
Andrey> GHz proc. - result may be terrible: each access to device mem
Andrey> (which usually uncached) will slowed down this super fast proc
Andrey> to 33 MHZ, i.e same as we made busy-wait with disabled
Andrey> interrupts after each read/write...

Andrey, 

As I said in my response, you need the control blocks because you are
not allowed to directly access things on the other side of the PCI bus
without using the readl/writel equivalent macros. It's got nothing to
do with access speed.

>>  For the case of more traditional devices, the control structures
>> will be allocated from one end of the block, the rest will be used
>> for packet descriptors which will be going in and out of the memory
>> pool on a regular basis.

Andrey> This was main reason why I try to modify genalloc: I needed in
Andrey> generic allocator for both short-live strictly aligned blocks
Andrey> and long-live blocks with restriction by size.

genalloc is perfectly adequate for that purpose. The long lived
allocations will just be taken out first, the rest will be used for
the short lived.

>> In most normal cases these will all be of the same size and it
>> doesn't matter where in the memory space they were allocated.

Andrey> And thats also why I consider that 'buddy' is not appropriate
Andrey> to be 'generic' (most cases == generic, isn't is :)?): when
Andrey> you're allocate mainly same sized blocks, 'buddy' degraded to
Andrey> the first-fit.

huh?

>>  I honestly don't think the majority of your demands are valid.
>> genalloc was meant to be simple, not an ultra fast at any random
>> block size allocator. So far I don't see any reason for changing to
>> the allocation algorithm into anything much more complex - doesn't
>> mean there couldn't be a reason for doing so, but I don't think you
>> have described any so far.
Andrey> I disagree here, generic couldn't be very simple and slow,
Andrey> because in this case simply no one will be use it, and hence
Andrey> we'll get today's picture: reimplemented allocators in many
Andrey> drivers.

Of course it can. I will continue to claim that you are trying to turn
it into something it doesn't need to be. The allocator I used was
based on the allocator from the old sym2 driver, which is a perfect
example of it being used by a device driver.

>>  You mentioned frame buffers, but what is the kernel supposed to do
>> with those allocation wise? If you have a frame buffer console, the
>> memory is allocated once and handed to the frame buffer driver.
>> Ie. you don't need a ton of on demand allocations for that and for
>> X, the memory management is handled in the X server, not by the
>> kernel.

Andrey> For video-only device this is true, but if device is a
Andrey> multifunctional, which is frequent case in embedded systems,
Andrey> then kernel must control of device memory
Andrey> allocation. Currently, however, even video cards for desktops
Andrey> become more and more multifunctional (VIVO/audio etc.).

For multi functional devices you still often split the memory up at
init time. Some memory is never going to be given back (like the frame
buffer itself), other blocks are like the network packet descriptors
in a network device.

>>  The only thing I think would make sense to implement is to allow
>> it to use indirect descriptor blocks for the memory it
>> manages. This is not because it's wrong to use the memory for the
>> free list, as it will only be used for this when the chunk is not
>> in use, but because access to certain types of memory isn't always
>> valid through normal direct access. Ie. if one used descriptor
>> blocks residing in normal GFP_KERNEL memory, it would be possible
>> to use the allocator to manage memory sitting on the other side of
>> a PCI bus.
Andrey> I describe above, why we couldn't/wouldn't use onboard memory
Andrey> for allocator specific data.

As I pointed out, your description wasn't valid. You are not allowed
to directly dereference memory on the other side of a PCI bus.

Regards,
Jes
