Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289876AbSAWXPC>; Wed, 23 Jan 2002 18:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290200AbSAWXOv>; Wed, 23 Jan 2002 18:14:51 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:8464 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S290192AbSAWXOm>;
	Wed, 23 Jan 2002 18:14:42 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201232314.g0NNEXe457847@saturn.cs.uml.edu>
Subject: Re: Athlon/AGP issue update
To: benh@kernel.crashing.org
Date: Wed, 23 Jan 2002 18:14:33 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        davem@redhat.com (David S. Miller), drobbins@gentoo.org,
        linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        akpm@zip.com.au, vherva@niksula.hut.fi, lwn@lwn.net, paulus@samba.org
In-Reply-To: <20020123171419.29358@mailhost.mipsys.com> from "benh@kernel.crashing.org" at Jan 23, 2002 06:14:19 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benh@kernel.crashing.org writes:
> [Albert Cahalan]

>> AGP might be non-coherent. If so, then the CPU should use a
>> non-coherent mapping to avoid useless memory bus traffic.
>> User code has access to some cache control instructions,
>> so one may mark the memory cacheable for better performance
>> even when it is non-coherent. ("flush when you're done")
>
> That's unfortunately not enough. The mapping of the page to
> userland and the in-kernel mapping of the AGP aperture are done
> with non-cacheable attribute.

This is the slowest choice, but will work correctly.

It is better to make the user do explicit "dcbf", etc.
on cached memory. (use non-coherent mappings to avoid
wasting memory bus cycles on cache coherency traffic)
As long as users go through a library, they won't mind.

> _BUT_, that same memory is also
> mapped as part of the RAM linear mapping of the kernel (the
> BAT mapping on PPC). The problem happens when some code working
> near the end of a different page via this linear mapping cause
> a speculative access to happen on the next page. This will have
> the side-effect of loading the cache with a line from the page
> used by AGP.
>
> I think PPC does only speculative reads, but even those (non dirty
> cache lines) may cause trouble in our case.

Speculative reads only cause trouble if:

1. they are cached by an access through the BAT mapping
2. reads through the uncached page mapping use the cache
3. user code cares... AGP memory is for WRITING video frames, yes?

Speculative writes are like speculative reads, unless the PPC
is stupid enough to set the dirty bit even when the write does
not get performed.

> Now, we have to check if the PPC is allowed to do speculative
> reads accross page boundaries. If it's the case, then we are screwed
> and I will have to cleanup the code allowing the kernel to run without
> the BAT mapping (with a performance impact unfortunately).

It's a waste to use BAT mappings for the kernel anyway, because
we try to keep the huge computations and graphics in userspace.
With page tables under BAT mappings, privileged user code could
be allowed to steal BAT registers for locked memory or IO memory.

So at the very least, you can keep the BAT mappings enabled
until user code wants AGP memory or is allowed to have the
BAT registers. When the user is done, the BAT registers may
be used to cover kernel space again. Other than the memory
used for page tables, there doesn't seem to be any harm in
having page tables that match the BAT registers in use.
