Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287464AbRLaFsJ>; Mon, 31 Dec 2001 00:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287461AbRLaFsA>; Mon, 31 Dec 2001 00:48:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:59918 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287464AbRLaFrs>; Mon, 31 Dec 2001 00:47:48 -0500
Message-ID: <3C2FFB2F.D02095A2@zip.com.au>
Date: Sun, 30 Dec 2001 21:44:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch] Prefetching file_read_actor()
In-Reply-To: <20011231033220.A1686@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> After noticing file_read_actor() showing up in profiles quite
> a bit, I grepped old l-k messages, and turned up a post by
> Manfred Spraul in which he posted a patch using inline asm
> to prefetch read data.  This was x86 specific in generic code,
> so was a little hackish..
> Now that we have the prefetch macros, I decided to play with
> this a little tonight, and came up with this patch..

Well I don't know diddly about the prefetch instruction, but.

> ...
> +
> +       if (size > 128) {
> +               int i;
> +               for(i=0; i<size; i+=64) {
> +                       prefetch (kaddr+offset);
> +                       prefetch (kaddr+offset+(L1_CACHE_BYTES*2));
> +               }
> +       }
> +
>         left = __copy_to_user(desc->buf, kaddr + offset, size);
>         kunmap(page);
> 

This needs to be inside ARCH_HAS_PREFETCH.  Otherwise, for
architectures which do not implement prefetch, we have

	for (i = 0; i < size; i += 64) {
		{;}
		{;}
	}

and the compiler will *not* optimise this away.   The compiler deliberately
leaves this construct alone because it assumes the programmer is asking for
a busywait loop.

We shouldn't add a busywait loop to file_read_actor(), yes?

<ot>
Reminds me of a version of the Microsoft C compiler back in about '85 which
"optimise" away

	for ( ; ; )
		;

Completely.
</ot>

Is prefetching 4k at a time optimal?  Should the prefetch be embedded
in copy_*_user?

The code assumes that L1_CACHE_BYTES equates to the prefetch chunk.
Is this reasonable, or should it be abstracted out to a new PREFETCH_BYTES?

That `64' needs to be PREFETCH_BYTES * 2 or L1_CACHE_BYTES * 2, yes?

How come the code keeps prefetching the same address?  Shouldn't
we be adding `i' to the address in there?

The code makes no attempt to align the prefetch address to anything.
Should it?

What happens if a prefetch spills over the end of the page and
faults?

> Comments ?

That'll do for now :)

-
