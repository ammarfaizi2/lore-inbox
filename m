Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263311AbSIPXHs>; Mon, 16 Sep 2002 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSIPXHs>; Mon, 16 Sep 2002 19:07:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:34906 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263311AbSIPXHj>; Mon, 16 Sep 2002 19:07:39 -0400
Date: Tue, 17 Sep 2002 01:13:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: Oops in sched.c on PPro SMP
Message-ID: <20020916231303.GF11605@dualathlon.random>
References: <20020916154446.GI11605@dualathlon.random> <8BA3FD1E-C9B9-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BA3FD1E-C9B9-11D6-8873-00039387C942@mac.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 11:16:20PM +0200, Peter Waechtler wrote:
> Am Montag den, 16. September 2002, um 17:44, schrieb Andrea Arcangeli:
> 
> >On Mon, Sep 16, 2002 at 03:49:27PM +0100, Alan Cox wrote:
> >>Also does turning off the nmi watchdog junk make the box stable ?
> >
> >good idea, I didn't though about this one since I only heard the nmi to
> >lockup hard boxes after hours of load, never to generate any
> >malfunction, but certainly the nmi handling isn't probably one of the
> >most exercised hardware paths in the cpus, so it's a good idea to
> >reproduce with it turned off (OTOH I guess you probably turned it on
> >explicitly only after you got these troubles, in order to debug them).
> >
> 
> I only turned the nmi watchdog on, on the one "unknown" version Oops.
> 
> This box was running fine with 2.4.18-SuSE with uptimes 40+days. _Now_
> I am almost sure, that it's _not_ a hardware problem (FENCE counting
> here as software - since there is a software workaround).
> 
> I had 3 lockups in 2 days, when I switched to 2.4.19 - and even lower
> room temperature. No, there _must_ be a bug :)

possible. Which was the previous kernel running in the machine before
2.4.18-SuSE?

It could be an unlucky trashing pattern run by the tasklist walking that
is eliminated in the SuSE kernel, so it may not be a bug in mainline,
but we don't know for sure.

> With the relocation you are right - I thought it would test against 
> NULL :-(
> 
> I think that the tasklist is broken inbetween - either due to broken
> readlocks (no working EFENCE on PPRO)

The SuSE kernel should have exactly the same read/write locks and you
said the SuSE kernel works fine for you (the read/write locks aren't
used only in the tasklist).

> Can someone explain me the difference for label 1 and 2?
> Why is the "js 2f" there? This I don't understand fully -
> it looks broken to me.

it's correct, if not we would have noticed since a long time ;)

What it does is to subtract 1 to the lock, if it goes negative (signed)
it jumps into  the looping slow path  (label 2), then when it finally
stops looping because it acquired the lock, it jumps back to 1 and
enters the critical section. The slow path takes care of acquiring the
lock internally, first polling and doing without requiring the cacheline
exclusive the trylock again.

> 
> include/asm-i386/rwlock.h
> 
> #define __build_read_lock_ptr(rw, helper)   \
>     asm volatile(LOCK "subl $1,(%0)\n\t" \
>              "js 2f\n" \
>              "1:\n" \
>              LOCK_SECTION_START("") \
>              "2:\tcall " helper "\n\t" \
>              "jmp 1b\n" \
>              LOCK_SECTION_END \
>              ::"a" (rw) : "memory")

As said the oops shows clear corruption in the tasklist, that contains
null pointers or random values. So I still tend to think this is
not shown in the SuSE kernel because it doesn't need to loop through all
the long tasklist to make the scheduling decision reducing signficantly
the cacheline trashing and memory I/O. You can also try to run a loop
like:

	import os

	while 1:
		x = os.listdir('/proc')

that will trigger a frequent tasklist walking too, even if it's not a
tight loop like the one that schedule triggered. You could try to
simulate it with a kernel module too. If you make it easily reproducible
it'll be easier to find what's wrong.

You can also try to backout the dynsched patch from the 8.0 kernel, and
see if it returns reproducible then (you should find the patch in the srpm
or in my kernel.org directory).

You can also compare the number of tasks in the system with the number
of simultaneously runnable tasks. And also have a look if the problem
goes away if you stop setiathome.

Hope this helps,

Andrea
