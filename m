Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRG0UdZ>; Fri, 27 Jul 2001 16:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbRG0UdQ>; Fri, 27 Jul 2001 16:33:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:1299 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268957AbRG0UdH>; Fri, 27 Jul 2001 16:33:07 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: swap_free: swap-space map bad (entry 00000100)
Date: Fri, 27 Jul 2001 19:13:38 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9jseh2$lfg$1@penguin.transmeta.com>
In-Reply-To: <20010727111313.1da63aca.samuel@dupas.com>
X-Trace: palladium.transmeta.com 996261324 24458 127.0.0.1 (27 Jul 2001 19:15:24 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Jul 2001 19:15:24 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010727111313.1da63aca.samuel@dupas.com>,
Samuel Dupas  <samuel@dupas.com> wrote:
>
>Is it a kernel problem, a hardware problem ?

Could be either. However, there thing you quote looks like a traditional
one-bit error.

>Jul 25 02:05:12 euro kernel: Unable to handle kernel NULL pointer
>dereference at virtual address 00000114 
>Jul 25 02:05:12 euro kernel: current->tss.cr3 = 0f0be000, %%cr3 = 0f0be000
>
>Jul 25 02:05:12 euro kernel: *pde = 00000000 
>Jul 25 02:05:12 euro kernel: Oops: 0000 
>Jul 25 02:05:12 euro kernel: CPU:    0 
>Jul 25 02:05:12 euro kernel: EIP:    0010:[try_to_free_buffers+18/136] 
>Jul 25 02:05:12 euro kernel: EFLAGS: 00010206 
>Jul 25 02:05:12 euro kernel: eax: 00000100   ebx: c055e360   ecx: 0001207c  edx: 00040000 
>Jul 25 02:05:12 euro kernel: esi: 00000100   edi: 00000100   ebp: c055e360  esp: da98be90

%esi is supposed to contain a kernel pointer to the per-page buffer list
at this point. 

However, it contains the value 0x00000100, which is not a valid kernel
pointer, so dereferencing it (with an offset of 20, which is why you see
the virtual address 0x00000114) will cause an oops. 

Now, I suspect that the value it _should_ contain is just zero. We
probably have the case that "page->buffers" should have been NULL (no
buffers allocated at all), but a one-bit error has turned it into
0x00000100, and then the page freeing logic will try to free the
"buffers" associated with the page.

And obviously, since "page->buffers" was bogus, when it tries to do

	if (buffer_busy(tmp))

it will oops.

Now, that one-bit error could easily have come from a software source
too, of course. It might not be your RAM. But it's not as if you're
running an experimental kernel or anything like that..

And if you've also seen a bad page table entry 00000100, it _really_
starts to sound like one bit of your memory is stuck on.  Run a memory
tester. 

NOTE: hard errors are quite uncommon. It's more likely that you have a
bit (or a row) that has soft-errors: it doesn't necessarily show up
every time, but shows up under heavy memory activity when the RAM chip
or the machine starts heating up..  The fact that this happens when
swapping may be indicative not so much of swapping problems per se, but
just the fact that that's when your machine is under the most load.

			Linus
