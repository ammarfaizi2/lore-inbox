Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130757AbRASOxE>; Fri, 19 Jan 2001 09:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130762AbRASOwy>; Fri, 19 Jan 2001 09:52:54 -0500
Received: from Cantor.suse.de ([194.112.123.193]:38159 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130757AbRASOwi>;
	Fri, 19 Jan 2001 09:52:38 -0500
Date: Fri, 19 Jan 2001 15:52:31 +0100
From: Andi Kleen <ak@suse.de>
To: Bill Hartner <bhartner@us.ibm.com>
Cc: Davide Libenzi <davidel@xmail.virusscreen.com>,
        Andrea Arcangeli <andrea@suse.de>, Mike Kravetz <mkravetz@sequent.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] sched_test_yield benchmark
Message-ID: <20010119155231.A19700@gruyere.muc.suse.de>
In-Reply-To: <OF6A979B75.1B1BFB9F-ON852569D9.004851F0@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF6A979B75.1B1BFB9F-ON852569D9.004851F0@raleigh.ibm.com>; from bhartner@us.ibm.com on Fri, Jan 19, 2001 at 09:30:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 09:30:55AM -0500, Bill Hartner wrote:
> (3) For the i386 arch :
> 
>     My observations were made on an 8-way 550 Mhz PIII Xeon 2MB L2 cache.
> 
>     The task structures are page aligned.  So when running the benchmark
>     you may see what I *suspect* are L1/L2 cache effects.  The set of
>     yielding threads will read the same page offsets in the task struct
>     and will dirty the same page offsets on it's kernel stack.  So
>     depending on the number of threads and the locations of their task
>     structs in physical memory and the associatively of the caches, you
>     may see (for example) results like :

This is a know problem. It is caused by the way 2.2+ "current" works on i386.
It is at the bottom of the kernel stack and is computed from the stack pointer
using an and.  The kernel stack needs to be page aligned because of the 
allocator and the way the and works. 

The reason current cannot be put into a normal global variable is that there is 
usually no easy way to find out which CPU you're running on and the global
variable would need to be indexed by the CPU. Also using a real global on UP
is a real loser in terms of code size on i386 (several KB difference) 

This unfortunately means that task_struct ends up on similar cache 
colours and depending on the CPU could not use the caches very well.
One hope for i386 is that future CPUs have better caches so that too
aggressive cache colouring may not be worth it (actually I think that was already 
hoped for the P2) 

E.g. on IA64, m68k, x86-64 and other architectures which have enough registers
the kernel can afford to just put current into a global register variable. 
This means a cache colouring allocation could be used for the task_struct because
it doesn't need to be on a maskable address [the ports currently do not do that, 
but they could] 

It would be interesting if you could also rerun your tests with prefetching
in the scheduler loop enabled.  I can supply a patch for that.

-Andi 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
