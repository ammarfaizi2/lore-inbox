Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSFIPmt>; Sun, 9 Jun 2002 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317630AbSFIPms>; Sun, 9 Jun 2002 11:42:48 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:25611 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317628AbSFIPmq>;
	Sun, 9 Jun 2002 11:42:46 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206091542.g59FgWf161572@saturn.cs.uml.edu>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 9 Jun 2002 11:42:32 -0400 (EDT)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <20020609094849.A30062@flint.arm.linux.org.uk> from "Russell King" at Jun 09, 2002 09:48:49 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> On Sun, Jun 09, 2002 at 02:33:35AM -0400, Albert D. Cahalan wrote:

>> For device --> memory DMA:
>>
>> 1. write back cache lines that cross unaligned boundries
>
> What if some of the cache lines inside the DMA region are dirty and...
>
>> 2. start the DMA
>
> get evicted now when the CPU is doing something else?

Ugh. Yes, I guess the very act of starting the DMA
could evict a few. In that case, your method won't
work either.

It sure would be nice to get the DMA started early,
but that would require some way to keep new stuff
out of the cache.

Well gee, the MPC7400 has such an ability. I don't
know if it's fast, but one could do:

1. write back cache lines that cross unaligned boundries
2. sync
3. set L2CR[L2DO] and L2CR[L2IO] (and maybe HID0[DLOCK] too)
4. start the DMA
5. invalidate all cache lines affected by the DMA
6. undo step 3 (clear L2CR[L2DO], L2CR[L2IO], HID0[DLOCK])

Most likely the above needs another sync or two.

> You really need to:
>
>  1. write back cache lines that cross unaligned boundries
>  3. invalidate the above cache lines
>  2. start the DMA
------ write-back happens during DMA; data is ruined ------
>  4. invalidate cache lines that are fully inside the DMA
>
> which is precisely we do on ARM.

>> For memory --> device DMA:
>>
>> 1. write back all cache lines affected by the DMA
>> 2. start the DMA
>> 3. invalidate the above cache lines
>
> What's the point of (3) ?  The data in memory hasn't been changed by DMA.
> What if we were writing out a page that was mmaped into a process, and
> the process wrote to that page while we were DMAing ?

As noted in another email, that was a mistake.
It might be good to invalidate anyway, since
that frees up cache lines for other uses.
The process won't get a chance to touch the page
unless you have SMP or (maybe) preemption.

