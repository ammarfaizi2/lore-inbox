Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135347AbRASQfx>; Fri, 19 Jan 2001 11:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135541AbRASQfn>; Fri, 19 Jan 2001 11:35:43 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:60372 "HELO
	localdomain") by vger.kernel.org with SMTP id <S135347AbRASQfI>;
	Fri, 19 Jan 2001 11:35:08 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Fri, 19 Jan 2001 08:35:55 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Andrea Arcangeli <andrea@suse.de>, Mike Kravetz <mkravetz@sequent.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: "Bill Hartner" <bhartner@us.ibm.com>
In-Reply-To: <OF6A979B75.1B1BFB9F-ON852569D9.004851F0@raleigh.ibm.com>
In-Reply-To: <OF6A979B75.1B1BFB9F-ON852569D9.004851F0@raleigh.ibm.com>
Subject: Re: sched_test_yield benchmark
MIME-Version: 1.0
Message-Id: <01011908355500.01005@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2001 07:59, Bill Hartner wrote:
> Just a couple of notes on the sched_test_yield benchmark.
> I posted it to the mailing list in Dec.  I have a todo to get
> a home for it.  There are some issues though.  See below.
>
> (1) Beware of the changes in sys_sched_yield() for 2.4.0.  Depending
>     on how many processors on the test system and how many threads
>     created, schedule() may or may not be called when calling
>     sched_yield().

In Your test You're using at least 16 tasks with an 8 way SMP, so schedule() 
should be always called ( if You're using my test suite tasks are always 
running ).



>
> (3) For the i386 arch :
>
>     My observations were made on an 8-way 550 Mhz PIII Xeon 2MB L2 cache.

Hey, this should be the machine I've lost two days ago :^)


>
>     The task structures are page aligned.  So when running the benchmark
>     you may see what I *suspect* are L1/L2 cache effects.  The set of
>     yielding threads will read the same page offsets in the task struct
>     and will dirty the same page offsets on it's kernel stack.  So
>     depending on the number of threads and the locations of their task
>     structs in physical memory and the associatively of the caches, you
>     may see (for example) results like :
>
>                 **       **             **
>     50 50 50 50 75 50 50 35 50 50 50 50 75
>
>     Also, the number of threads, the order of the task structs on the
>     run_queue, thread migration from cpu to cpu, and how many times
>     recalculate is done may vary the results from run to run.

Yep, this is the issue.
Why not move scheduling fields in a separate structure with a different 
alignment :

struct s_sched_fields {
 ...
} sched_fields[];

inline struct s_sched_fields * get_sched_fields_ptr(task_struct * ) {

}

This will reduce the probability that scheduling fields will fall onto the 
same cache line.



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
