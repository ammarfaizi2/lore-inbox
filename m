Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHSgk>; Thu, 8 Feb 2001 13:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHSgb>; Thu, 8 Feb 2001 13:36:31 -0500
Received: from colorfullife.com ([216.156.138.34]:65292 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129031AbRBHSgM>;
	Thu, 8 Feb 2001 13:36:12 -0500
Message-ID: <3A82E732.4229045F@colorfullife.com>
Date: Thu, 08 Feb 2001 19:36:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: sse for fast_clear_page()?
In-Reply-To: <m14Qv0z-000OaDC@amadeus.home.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> In article <3A82D325.9068BC07@colorfullife.com> you wrote:
> > fast_clear_page() uses mmx instructions for clearing a page, what about
> > using sse instructions?
> > sse instructions can store 128 bit in one instruction, mmx only 64 bit.
> 
> the sse FP registers might be lossy.

I thought that too, thus I only implemented memset(,0,) with sse.

But then I found this document on Intel website:
http://developer.intel.com/software/idap/media/pdf/copy.pdf

Intel recommends using sse registers for generic memcopy - they can't be
lossy.

> On my athlon, the in-kernel mmx
> functions are memory-bound (eg > 1 Gbyte/sec throughput)
>
You are using an Athlon with SDRAM?

A Pentium 4 has a 3.2 GB memory bus and I saw a benchmark that compared
mmx and sse memmove, and sse was _much_ faster.

I've implemented a user space sse copy_page, and:

* mmx is the slowest version! (~12000 cpu ticks/page).
* movsd is slightly faster (~11850 cpu ticks/page). Probably due to the
special 'rep movsd' optimization in the Pentium III (cpu notices that
ecx is large and switches to a cache line copy mode).
* sse is the fastest version (~ 11500 cpu ticks/page)

Everything with cold caches.

> Userspace program for the athlon code:
> 
> http://www.fenrus.demon.nl/athlon.c
>
I'll check it.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
