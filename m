Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274611AbRJAF62>; Mon, 1 Oct 2001 01:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274610AbRJAF6J>; Mon, 1 Oct 2001 01:58:09 -0400
Received: from chiara.elte.hu ([157.181.150.200]:15122 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S274596AbRJAF57>;
	Mon, 1 Oct 2001 01:57:59 -0400
Date: Mon, 1 Oct 2001 07:55:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Bernd Harries <bha@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <3BB71715.A57FA7D4@gmx.de>
Message-ID: <Pine.LNX.4.33.0110010732140.1792-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Sep 2001, Bernd Harries wrote:

> Is there a guarantee that the n - 1 pages above the 1st one are not
> donated to other programs while my driver uses them?

yes. The 2MB block of 512 x 4k pages (we should perhaps call it a 'order 9
page') is yours.

> > is it a fundamental property of the hardware that it needs a continuous
> > physical memory buffer?
>
> Yes. The FW on the card demands it.

ok. then i'd suggest to do all this allocation at boot-time, and do not
deallocate it. This is the safest method. Unless it's a point to have the
driver as a module (for other than development purposes).

> I'll move the code to init_module later once it is stable.

even init_module() can be executed much later: eg. kmod removes the module
because it's unused, and it's reinserted later. So generally it's really
unrobust to expect a 9th order allocation to succeed at module_init()
time.

the fundamental issue is not the lazyness of Linux VM developers. 99.9% of
all allocations are order 0. 99.9% of the remaining allocations are order
1 or 2. It takes a fair amount of overhead and complexity to handle
high-order allocations 'well' - it takes even more effort (and a perverse
limitation on the use of pointers) to guarantee the success of such
allocations all the time.

there is a longer-term and robust solution that could be used though. We
could support a generic 'physical memory pool', that gets allocated on
bootup (via eg. a physmem=10m kernel boot option), and never gets used for
other than such critical allocations. Your driver could call eg.
alloc_physmem(size) and free_physmem(). It would work similarly to
bootmem.c. This 'physical memory pool' would never be used by generic
subsystems - only drivers which support hardware with such limitations are
allowed to use it. The advantage of this approach is that there would be
one generic way to put physically continuous RAM aside for such drivers -
so the driver would not have to worry about the VM situation. The other
advantage is that we could decrease MAX_ORDER significantly (to around 7)
- support for higher orders increases the runtime overhead of the buddy
allocator, even for low-order allocations.

(later on we could even add support to grow and shrink the size of the
physical memory pool (within certain boundaries), so it could be sized
boot-time.)

would anything like this be useful? Since it's a completely separate pool
(in fact it wont even show up in the normal memory statistics), it does
not disturb the existing VM in any way.

	Ingo

