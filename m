Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRASOb2>; Fri, 19 Jan 2001 09:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132001AbRASObS>; Fri, 19 Jan 2001 09:31:18 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20436 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131806AbRASObJ>; Fri, 19 Jan 2001 09:31:09 -0500
Importance: Normal
Subject: sched_test_yield benchmark
To: Davide Libenzi <davidel@xmail.virusscreen.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Mike Kravetz <mkravetz@sequent.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
From: "Bill Hartner" <bhartner@us.ibm.com>
Date: Fri, 19 Jan 2001 09:30:55 -0500
Message-ID: <OF6A979B75.1B1BFB9F-ON852569D9.004851F0@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.3 (Intl)|21 March 2000) at
 01/19/2001 09:31:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a couple of notes on the sched_test_yield benchmark.
I posted it to the mailing list in Dec.  I have a todo to get
a home for it.  There are some issues though.  See below.

(1) Beware of the changes in sys_sched_yield() for 2.4.0.  Depending
    on how many processors on the test system and how many threads
    created, schedule() may or may not be called when calling
    sched_yield().

    I included sys_sched_yield() at the end of this note.

warning : from this point on I wonder in and out of gray space
so correct me if I am wrong.

(2) The benchmark uses student's t-distribution (0.95) with a
    1% interval width.  On 2.4.0, convergence is pretty good so I
    feel comfortable with the results it reports.  But, be aware of
    the (3) below.

    Run the benchmark multiple times for a certain number of threads
    on a specified number of CPUs. Look for the following in (3).

(3) For the i386 arch :

    My observations were made on an 8-way 550 Mhz PIII Xeon 2MB L2 cache.

    The task structures are page aligned.  So when running the benchmark
    you may see what I *suspect* are L1/L2 cache effects.  The set of
    yielding threads will read the same page offsets in the task struct
    and will dirty the same page offsets on it's kernel stack.  So
    depending on the number of threads and the locations of their task
    structs in physical memory and the associatively of the caches, you
    may see (for example) results like :

                **       **             **
    50 50 50 50 75 50 50 35 50 50 50 50 75

    Also, the number of threads, the order of the task structs on the
    run_queue, thread migration from cpu to cpu, and how many times
    recalculate is done may vary the results from run to run.

    I am looking into this, but not very actively though, busy with
    other stuff.  Hope to get back to it soon.

    What I may do to address this is to allocate more threads than
    requested and then examine the physical address of the task
    structure and then select a subset of the task structs (threads) to
    use in the run.  The benchmark may produce more consistent results
    from run to run (assuming what I suspect is going on is really the
    case).

    You mileage may vary.

Thoughts ?

Bill Hartner
IBM Linux Technology Center - kernel performance
bhartner@us.ibm.com

------from kernel/sched.c 2.4.0 -------

asmlinkage long sys_sched_yield(void)
{
     /*
      * Trick. sched_yield() first counts the number of truly
      * 'pending' runnable processes, then returns if it's
      * only the current processes. (This test does not have
      * to be atomic.) In threaded applications this optimization
      * gets triggered quite often.
      */

     int nr_pending = nr_running;

#if CONFIG_SMP
     int i;

     // Substract non-idle processes running on other CPUs.
     for (i = 0; i < smp_num_cpus; i++)
          if (aligned_data[i].schedule_data.curr != idle_task(i))
               nr_pending--;
#else
     // on UP this process is on the runqueue as well
     nr_pending--;
#endif
     if (nr_pending) {
          /*
           * This process can only be rescheduled by us,
           * so this is safe without any locking.
           */
          if (current->policy == SCHED_OTHER)
               current->policy |= SCHED_YIELD;
          current->need_resched = 1;
     }
     return 0;
}



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
