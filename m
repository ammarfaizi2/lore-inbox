Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270672AbRHJW5k>; Fri, 10 Aug 2001 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270674AbRHJW5b>; Fri, 10 Aug 2001 18:57:31 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:33038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270673AbRHJW5Q>; Fri, 10 Aug 2001 18:57:16 -0400
Date: Fri, 10 Aug 2001 15:57:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: free_task_struct() called too early?
In-Reply-To: <E15VKzz-0001md-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108101552130.1048-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Aug 2001, Alan Cox wrote:
> >
> > If I modify the following line in include/asm-i386/processor.h
> >
> > #define free_task_struct(p)   free_pages((unsigned long) (p), 1) to
> > #define free_task_struct(p)   memset((void*) (p), 0xf, PAGE_SIZE*2);
> > free_pages((unsigned long) (p), 1)
> > then kernel will boot to init and lockup on when first task terminates.
> >
> > Has anyone looked into or aware of this issue?
>
> 2.4.8pre fixed a case with semaphores on the stack. It might not be the only
> one. Your #define is wrong though, if a single free_task_struct path is an
> if you will not do what you expect
>
> 	do { memset(), free_pages } while(0);
>
> would be safer.

No no no.

You can NOT do a "memset()" before you free the task-struct: it's can
still be actively used, and will be marked such by having an elevated page
count (ie the "free()" may not be doing anything but atomically decrement
the page count).

This is, in fact, a very very common thing - I bet that you will reboot
the first time you touch a /proc/<pid>/xx file or do a "ptrace()", because
that code will do the free_task_struct too after having incremented the
usage count while they held on to it.

If you really really want to, you can do the memset() at the top of
"free_pages_ok()" - it will slow down the system considerably (because
_every_ page will be memset after being free'd), but hey, it's going to be
an even better stress-tester.

Oh, if you do it there, do something like thisL

	memset(page_address(page), 0xf0, PAGE_SIZE << order);

and realize that the above will not work on HIGHMEM machines (and making
it work on highmem machines is simply not worth it).

		Linus

