Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbQKQRNM>; Fri, 17 Nov 2000 12:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130243AbQKQRNC>; Fri, 17 Nov 2000 12:13:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4874 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130202AbQKQRMx>; Fri, 17 Nov 2000 12:12:53 -0500
Date: Fri, 17 Nov 2000 08:42:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: schwidefsky@de.ibm.com
cc: Andrea Arcangeli <andrea@suse.de>, mingo@chiara.elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
In-Reply-To: <C125699A.005B0F7E.00@d12mta07.de.ibm.com>
Message-ID: <Pine.LNX.4.10.10011170838040.2272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000 schwidefsky@de.ibm.com wrote:
> 
> >> Whats the reasoning behind these ifs ?
> >
> >To catch memory corruption or things running out of control in the kernel.
> I was refering to the "if (!order) goto try_again" ifs in alloc_pages, not
> the "if (something) BUG()" ifs.

Basically, if you try to wait for orders > 0, you may have to wait for a
LOONG time.

It actually works reasonably well on machines with big memories, because a
buddy allocator _will_ try to coalesce memory allocations as much as
possible. But it has nasty cases where you can be really unlucky. Feel
free to run simulations to see, but basically if you have reasonably
random allocation and free patterns and you want to get an order-X
contiguous allocation, you may have to free up a noticeable portion of
your memory before it succeeds.

Sure, you could do "directed freeing", where you actually try to look at
which pages would be worth freeing to find a large free area, but the
complexity is not insignificant, and quite frankly the proper approach has
always been "don't do that then". Don't rely on big contiguous chunks of
memory. Having an mm that can guarantee contiguous chunks of physical
memory would be cool, but I suspect strongly that it would have some
serious downsides.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
