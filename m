Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbQKJHey>; Fri, 10 Nov 2000 02:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQKJHee>; Fri, 10 Nov 2000 02:34:34 -0500
Received: from www.wen-online.de ([212.223.88.39]:56332 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130152AbQKJHe0>;
	Fri, 10 Nov 2000 02:34:26 -0500
Date: Fri, 10 Nov 2000 08:34:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jens Axboe <axboe@suse.de>, MOLNAR Ingo <mingo@chiara.elte.hu>,
        Rik van Riel <H.H.vanRiel@phys.uu.nl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
 2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10011091005390.1909-100000@penguin.transmeta.com>
Message-ID: <Pine.Linu.4.10.10011100732250.601-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Linus Torvalds wrote:

> 
> 
> As to the real reason for stalls on /proc/<pid>/stat, I bet it has nothing
> to do with IO except indirectly (the IO is necessary to trigger the
> problem, but the _reason_ for the problem lies elsewhere).
> 
> And it has everything to do with the fact that the way Linux semaphores
> are implemented, a non-blocking process has a HUGE advantage over a
> blocking one. Linux kernel semaphores are extreme unfair in that way.
> 
> What happens is that some process is getting a lot of VM faults and gets
> its VM semaphore. No contention yet. it holds the semaphore over the
> IO, and now another process does a "ps".
> 
> The "ps" process goes to sleep on the semaphore. So far so good.
> 
> The original process releases the semaphore, which increments the count,
> and wakes up the process waiting for it. Note that it _wakes_ it, it does
> not give the semaphore to it. Big difference.
> 
> The process that got woken up will run eventually. Probably not all that
> immediately, because the process that woke it (and held the semaphore)
> just slept on a page fault too, so it's not likely to immediately
> relinquish the CPU.
> 
> The original running process comes back faulting again, finds the
> semaphore still unlocked (the "ps" process is awake but has not gotten to
> run yet), gets the semaphore, and falls asleep on the IO for the next
> page.
> 
> The "ps" process actually gets to run now, but it's a bit late. The
> semaphore is locked again. 
> 
> Repeat until luck breaks the bad circle.
> 
> (This schenario, btw, is much harder to trigger on SMP than on UP. And
> it's completely separate from the issue of simple disk bandwidth issues
> which can obviously cause no end of stalls on anything that needs the
> disk, and which can also happen on SMP).

Unfortunately, it didn't help in the scenario I'm running.

time make -j30 bzImage:

real    14m19.987s  (within stock variance)
user    6m24.480s
sys     1m12.970s

procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
31  2  1     12   1432   4440  12660   0  12    27   151  202   848  89  11   0
34  4  1   1908   2584    536   5376 248 1904   602   763  785  4094  63  32  5
13 19  1  64140  67728    604  33784 106500 84612 43625 21683 19080 52168  28  22  50

I understood the above well enough to be very interested in seeing what
happens with flush IO restricted.

	-Mike

[try_to_free_pages()->swap_out()/shm_swap().. can fight over who gets
to shrink the best candidate's footprint?]

Thanks!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
