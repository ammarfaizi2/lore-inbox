Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbRGGRzB>; Sat, 7 Jul 2001 13:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbRGGRyw>; Sat, 7 Jul 2001 13:54:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:27922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266507AbRGGRyh>; Sat, 7 Jul 2001 13:54:37 -0400
Date: Sat, 7 Jul 2001 10:53:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <3B4748BC.D9045F12@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0107071046570.31249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jul 2001, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >
> > Now, the fact that the system appears unusable does obviously mean that
> > something is wrong. But you're barking up the wrong tree.
>
> Two more additional data points,
>
> 1) partially kernel-unrelated.  MDK's "make" macro didn't support
> alpha's /proc/cpuinfo output, "make -j$numprocs" became "make -j" and
> fun ensued.

Ahh, well..

The kernel source code is set up to scale quite well, so yes a "make -j"
will parallellise a bit teoo well for most machines, and you'll certainly
run out of memory on just about anything (I routinely get load averages of
30+, and yes, you need at least half a GB of RAM for it to not be
unpleasant - and probably more like a full gigabyte on an alpha).

So I definitely think the kernel likely did the right thing. It's not even
clear that the OOM killer might not have been right - due to the 2.4.x
swap space allocation, 256MB of swap-space is a bit tight on a 384MB
machine that actually wants to use a lot of memory.

> 2) I agree that 200MB into swap and 200MB into cache isn't bad per se,
> but when it triggers the OOM killer it is bad.

Note that it might easily have been 256MB into swap (ie it had eaten _all_
of your swap) at some stage - and you just didn't see it in the vmstat
output because obviously at that point the machine was a bit loaded.

But neutering the OOM killer like Alan suggested may be a rather valid
approach anyway. Delaying the killing sounds valid: if we're truly
livelocked on the VM, we'll be calling down to the OOM killer so much that
it's probably quite valid to say "only return 1 after X iterations".

		Linus

