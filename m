Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSBZQKz>; Tue, 26 Feb 2002 11:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSBZQKu>; Tue, 26 Feb 2002 11:10:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57245 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290823AbSBZQKc>;
	Tue, 26 Feb 2002 11:10:32 -0500
Date: Tue, 26 Feb 2002 11:09:39 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org, lse@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020226110939.A6781@elinux01.watson.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0202231551300.4173-100000@localhost.localdomain> <Pine.LNX.4.33.0202231017310.9185-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202231017310.9185-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Feb 23, 2002 at 10:20:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 10:20:04AM -0800, Linus Torvalds wrote:
> 
> 

In the hope to be included into this discussion and keep this discussion
active.

As previously reported, I wrote a user level locking or fast semaphore
package, which resolves the uncontended case in shared memory and through
atomic operations, while the contended case falls back into the kernel.
Yesterday I layed out some of my assumptions/approach of my implementation.

download available under 
	http://prdownloads.sourceforge.net/lse/ulocks-2.4.17.tar.bz2.

> On Sat, 23 Feb 2002, Ingo Molnar wrote:
> >
> > On Sat, 23 Feb 2002, Rusty Russell wrote:
> >
> > > 1) Interface is: open /dev/usem, pread, pwrite.
> >
> > i like the patch, but the interface is ugly IMO. Why not new syscalls?
> 
> I agree - I dislike magic device files a whole lot more than just abotu
> every alternative.
> 
> Also, one thing possibly worth looking into is to just put the actual
> semaphore contents into a regular file backed setup.
> 

As of Linus's request to put the content into a regular file backe setup.
I support that as well. I also support different virtual addresses in
the various processes. It should simply be shared memory wether through
shmat or mmap.

> 		Linus
> 

Currently I was fixated on semaphores/calocks/rwlocks which require at most
two queues. Ben LeHaise yesterday more or less stated that any number of queues
is desirable to implement whatever-you-like lock. I second that motion and
will modify the code accordingly, should be a quick hack.

In the following I first describe again what my implementation provides
I will follow with performance numbers, lock contention, retry rates, and fairness
under various load conditions for a synthetic benchmark.


WHAT HAS BEEN IMPLEMENTED
=========================

(a)  EXCLUSIVE LOCKS
   (a1)  SysV IPC semaphores: I need these to have a base for comparision.
   (FAIR)
   (a2)  usema: semaphore implementation. (FAIR)
   (a3)  usema_spin: same as above, however, I will spin for a period of
   time, called patience,before actually entering into the kernel on
   contention. (FAIR)
   (a4)  calock: convoy avoidance lock. This lock is not fair. On unlock
   operation, the lock is made available even if a waiting process has to
   be woken up. The woken process then must content for the lock again,
   which (a) is unfair and (b) can result into multiple reentrances into
   the kernel for waiting  (NOT FAIR).
   (a5) calock_spin: same as above, but we spin for a while.

   Some notes here: all but for (a1,a2) all locks required compare_exchange
   functionality.

(b) SHARED LOCKS
   (b1) rwlock:  multiple reader/single writer. On wakeup preference is
   given to the readers, not the writers. (FAIR)


What has been tested and how?

I wrote a micro benchmark, that allows me to
(a) test the correctness of the locks (and believe me that helped, some
obvious solutions particularly for the spinning just don't work) and
(b) measure the performance. I wrote a program, called ulockflex. It allows
me to control the type of lock used, the number of children, the mean lock
hold time and non-lock hold time, the patience.

In return it tells me a lot of things about the individual locks.
I have integrated lock contention measurement right into the base lock
routines.
They come extremely cheap, in most cases a single atomic increment or
simple increment and don't really show up at the application level at all
(sometimes even help due to the spinning affect).

The performance of the locks is measured by the cummulative throughput/sec
of the children through the following loop.
for (;;) {
      run_lock_not_held(uniform(mean_non_locktime));
      lock();
      run_lock_held(uniform(mean_non_locktime));
      unlock();
}

uniform(x) gives me a uniformly distributed random value in the interval
[ .5x .. 1.5x].
I also measure the fairness of the locks among children. A fair lock should
give everybody the same number of loops over a meaningful execution time.
small changes are due to the random distribution. This is measured as  the
coefficient of variance
which is a normalized value compared to the mean. 0.0 is fair, and the
higher the value the less the fair it becomes.

So without further due, here is the output of my regression/performance
test. I split it up with some comments and point out some irregularities.
All tests run on a 2-way PIII 550MHZ machine.

PERFORMANCE
===========


Wed Feb 20 23:02:33 EST 2002:  calibrated at 273
base arguments are <-t 10 -o 5 -m 8 -R 273 -P>

First the legend
 c #number of children
 a #number of locks
 t #second of each run
 i #number of iterations (if less than 7) we reached 95% confidence
interval. (1 warmup run)
                        otherwise the result is statistically not
significant. I don't have
                        the exact confidence number.
 L locktype (capital letter means spinning version)
            e ::= no locks
            k ::= sysv ipc sem
            f ::= usema
            F ::= usema_spinning
            c ::= calock
            C ::= calock_spinning
            s<x> ::= with <x> the percentage of read sharing lock requests

 p patience of spinning if any
 WC lock contention on write lock
 RC read contention on read lock (for shared lock only)
 R  percentage of failed lock attempts resolved by spinning OR
    average times in calock lock attempt that failed needed to go into the
kernel (1 min).
 COV coefficient of variance between children (fairness)
 ThPut Cummulative throughput achieved per second for all children

 c  a t   i L      p   r  x     WC      RC      R     COV       ThPut

 1  1 10  5 e      0   0   0    0.00   0.00   0.00 0.000000  1398321  (A1)
 1  1 10  5 k      0   0   0    0.00   0.00   0.00 0.000000   309423
 1  1 10  5 f      0   0   0    0.00   0.00   0.00 0.000000  1157684
 1  1 10  5 F      0   0   0    0.00   0.00   0.00 0.000000  1136268
 1  1 10  5 F      3   0   0    0.00   0.00   0.00 0.000000  1136147
 1  1 10  5 c      0   0   0    0.00   0.00   0.00 0.000000  1115431
 1  1 10  5 C      0   0   0    0.00   0.00   0.00 0.000000  1150488
 1  1 10  5 C      3   0   0    0.00   0.00   0.00 0.000000  1150368

(A1) this is the base number without any locking. Every loop takes about 400 cycles
    We can see that he sysv kernel implementation has high overhead just getting in
    and out of the kernel and inspecting the ipc object namely ~1400 cycles of overhead.
    The remainder are all very much the same, since there is no contention, neither
    spinning nor any kernel calls are issued, simply an atomic instruction.

 1  1 10  5 e      0   0  10    0.00   0.00   0.00 0.000000    93978
 1  1 10  5 k      0   0  10    0.00   0.00   0.00 0.000000    76133
 1  1 10  5 f      0   0  10    0.00   0.00   0.00 0.000000    93136
 1  1 10  5 F      0   0  10    0.00   0.00   0.00 0.000000    92945
 1  1 10  5 F      3   0  10    0.00   0.00   0.00 0.000000    92968
 1  1 10  5 c      0   0  10    0.00   0.00   0.00 0.000000    63579 (*)
 1  1 10  5 C      0   0  10    0.00   0.00   0.00 0.000000    92993
 1  1 10  5 C      3   0  10    0.00   0.00   0.00 0.000000    93018

 1  1 10  5 e      0   7   3    0.00   0.00   0.00 0.000000    93850
 1  1 10  5 k      0   7   3    0.00   0.00   0.00 0.000000    76055
 1  1 10  5 f      0   7   3    0.00   0.00   0.00 0.000000    70352 (*)
 1  1 10  5 F      0   7   3    0.00   0.00   0.00 0.000000    92848
 1  1 10  5 F      3   7   3    0.00   0.00   0.00 0.000000    92858
 1  1 10  5 c      0   7   3    0.00   0.00   0.00 0.000000    81495 (*)
 1  1 10  5 C      0   7   3    0.00   0.00   0.00 0.000000    92882
 1  1 10  5 C      3   7   3    0.00   0.00   0.00 0.000000    92900

 1  1 10  5 e      0   9   1    0.00   0.00   0.00 0.000000    93882
 1  1 10  5 k      0   9   1    0.00   0.00   0.00 0.000000    76137
 1  1 10  5 f      0   9   1    0.00   0.00   0.00 0.000000    65751 (*)
 1  1 10  5 F      0   9   1    0.00   0.00   0.00 0.000000    92844
 1  1 10  5 F      3   9   1    0.00   0.00   0.00 0.000000    92846
 1  1 10  5 c      0   9   1    0.00   0.00   0.00 0.000000    88650 (*)
 1  1 10  5 C      0   9   1    0.00   0.00   0.00 0.000000    92875
 1  1 10  5 C      3   9   1    0.00   0.00   0.00 0.000000    92877

Same case, no contention, but we increase the loop time to 10usecs,
splitting it up into (0,10) (7,3) and (10,0) for (nonlock-time,lock time).
This will serve as a base number again. Surprisingly (*) have
subpar performance, this indicates some scheduler irregularities, since it
doesn't really do anything different than in (A). This observation repeats
itself several times and I'll try to hunt it down. I'll try the newest MQ
scheduler. Nevertheless, the overhead of sysv-ipc is apparent.

Now let's turn to the real cases, 2 children with lock contention.

 2  1 10  5 e      0   0   0    0.00   0.00   0.00 0.003351  2696755
 2  1 10  5 k      0   0   0   99.44   0.00   0.00 0.000786   159238
 2  1 10  6 f      0   0   0   42.33   0.00   0.00 0.034375   391065
 2  1 10  5 F      0   0   0   71.06   0.00   4.41 0.004886   242038
 2  1 10  5 F      3   0   0   46.02   0.00  26.55 0.043065   254974
 2  1 10  5 c      0   0   0    7.58   0.00   0.18 0.007522   695978
 2  1 10  5 C      0   0   0    3.84   0.00   0.12 0.004054   713464
 2  1 10  5 C      3   0   0    6.22   0.00   0.00 0.007328   706955

In this tied race we can clearly see the superior performance that can
be achieved with f and c locks. Note that most of the time is spent in
the loop preparation of determining the random values etc. Its also astounding
how little contention there exists in the calock.

Now looking at the 2 children 2 locks, there ofcourse is no contention
and these numbers should be double the 1 child/1 lock case and they are.
The strange cases (*) are pointed out again.

 2  2 10  5 e      0   0  10    0.00   0.00   0.00 0.002096   127205
 2  2 10  5 k      0   0  10    0.00   0.00   0.00 0.000616   145450
 2  2 10  5 f      0   0  10    0.00   0.00   0.00 0.002025   185794
 2  2 10  5 F      0   0  10    0.00   0.00   0.00 0.000511   185242
 2  2 10  5 F      3   0  10    0.00   0.00   0.00 0.000798   185239
 2  2 10  5 c      0   0  10    0.00   0.00   0.00 0.001097   126782 (*)
 2  2 10  5 C      0   0  10    0.00   0.00   0.00 0.000506   185478
 2  2 10  5 C      3   0  10    0.00   0.00   0.00 0.002143   185473

 2  2 10  5 e      0   7   3    0.00   0.00   0.00 0.002369   127126
 2  2 10  5 k      0   7   3    0.00   0.00   0.00 0.000970   143495
 2  2 10  5 f      0   7   3    0.00   0.00   0.00 0.000154   140287
 2  2 10  5 F      0   7   3    0.00   0.00   0.00 0.000251   185045
 2  2 10  5 F      3   7   3    0.00   0.00   0.00 0.000295   185046
 2  2 10  5 c      0   7   3    0.00   0.00   0.00 0.001159   162488 (*)
 2  2 10  5 C      0   7   3    0.00   0.00   0.00 0.001096   185233
 2  2 10  5 C      3   7   3    0.00   0.00   0.00 0.001196   185249

 2  2 10  5 e      0   9   1    0.00   0.00   0.00 0.000680   127125
 2  2 10  5 k      0   9   1    0.00   0.00   0.00 0.001323   144927
 2  2 10  5 f      0   9   1    0.00   0.00   0.00 0.000906   131147 (*)
 2  2 10  5 F      0   9   1    0.00   0.00   0.00 0.002069   185095
 2  2 10  5 F      3   9   1    0.00   0.00   0.00 0.000214   185082
 2  2 10  5 c      0   9   1    0.00   0.00   0.00 0.000668   176828 (*)
 2  2 10  5 C      0   9   1    0.00   0.00   0.00 0.003634   185237
 2  2 10  5 C      3   9   1    0.00   0.00   0.00 0.002531   185207

 2  1 10  5 k      0   0  10   99.92   0.00   0.00 0.039162    59885
 2  1 10  5 f      0   0  10   99.91   0.00   0.00 0.031926    59141
 2  1 10  5 F      0   0  10   99.90   0.00   0.00 0.058318    58287
 2  1 10  5 F      3   0  10   99.63   0.00   0.01 0.000769    49363 (C1)
 2  1 10  5 c      0   0  10    0.07   0.00 1365.3 0.010231    48821 (C2)
 2  1 10  5 C      0   0  10    1.89   0.00  52.95 0.274067    64882 (C3)
 2  1 10  5 C      3   0  10    2.43   0.00  41.12 0.227824    64425 (C4)

Above is a really interesting case, where the lock is 100% contended.
In that case spinning (C1) doesn't pay. Interesting are the cases
C2-C4, take a look at the R column, which tells me that on average a
contended case (RW) needed to retry 1365, 52, 41 times respectively.
Though the contention was minimal, this is high and results in unfair
locking, which reflects itself in an extremely high COV value (22%).


 2  1 10  5 k      0   7   3   42.65   0.00   0.00 0.000456    92178
 2  1 10  5 f      0   7   3   20.55   0.00   0.00 0.001683   110963
 2  1 10  5 F      0   7   3   33.35   0.00   8.62 0.002107   121134
 2  1 10  5 F      3   7   3   21.84   0.00  49.51 0.002057   161271
 2  1 10  5 c      0   7   3   28.93   0.00   2.24 0.001609   132291
 2  1 10  5 C      0   7   3   22.22   0.00   1.72 0.001753   150395
 2  1 10  5 C      3   7   3   20.94   0.00   0.06 0.003021   147583

 2  1 10  5 k      0   9   1   18.30   0.00   0.00 0.000911   114569
 2  1 10  5 f      0   9   1    6.62   0.00   0.00 0.003179   121252
 2  1 10  5 F      0   9   1   10.48   0.00  23.20 0.002029   163215
 2  1 10  5 F      3   9   1    9.49   0.00  49.94 0.002685   172780
 2  1 10  5 c      0   9   1   12.82   0.00   1.01 0.002806   150094
 2  1 10  5 C      0   9   1    9.79   0.00   0.77 0.003529   157167
 2  1 10  5 C      3   9   1    9.19   0.00   0.03 0.003280   154746

 3  1 10  5 k      0   0  10   99.99   0.00   0.00 0.005466    59116
 3  1 10  5 f      0   0  10   99.99   0.00   0.00 0.071828    48826
 3  1 10  5 F      0   0  10   99.98   0.00   0.00 0.061724    49281
 3  1 10  5 F      3   0  10   99.96   0.00   0.00 0.030956    49393
 3  1 10  5 c      0   0  10    4.04   0.00  24.75 0.111655    47918
 3  1 10  5 C      0   0  10   14.32   0.00   6.98 0.050590    62455
 3  1 10  5 C      3   0  10   16.63   0.00   6.01 0.057665    63155

 3  1 10  5 k      0   7   3   97.59   0.00   0.00 0.004165    78487
 3  1 10  5 f      0   7   3   85.77   0.00   0.00 0.022811    98692
 3  1 10  5 F      0   7   3   96.15   0.00   0.20 0.013047   103924
 3  1 10  7 F      3   7   3   43.21   0.00  26.81 0.018630   124829
 3  1 10  5 c      0   7   3   29.11   0.00   3.43 0.002640   126916
 3  1 10  5 C      0   7   3   22.50   0.00   4.44 0.019857   138407
 3  1 10  7 C      3   7   3   20.95   0.00   4.76 0.014293   129526

 3  1 10  5 k      0   9   1   88.33   0.00   0.00 0.022545   110836
 3  1 10  5 f      0   9   1   73.99   0.00   0.00 0.007920   107787  (*)
 3  1 10  5 F      0   9   1   76.47   0.00   1.08 0.010588   135066
 3  1 10  5 F      3   9   1   11.39   0.00  44.85 0.011170   170034
 3  1 10  7 c      0   9   1   12.82   0.00   7.23 0.007448   134004
 3  1 10  7 C      0   9   1    9.78   0.00   6.90 0.014131   144045
 3  1 10  7 C      3   9   1    9.14   0.00   7.54 0.020201   138368

 4  1 10  5 k      0   0  10  100.00   0.00   0.00 0.065016    57854
 4  1 10  5 f      0   0  10  100.00   0.00   0.00 0.059136    49980
 4  1 10  5 F      0   0  10  100.00   0.00   0.00 0.084718    49467
 4  1 10  5 F      3   0  10  100.00   0.00   0.00 0.026923    48819
 4  1 10  5 c      0   0  10    3.12   0.00  32.05 0.267046    47519
 4  1 10  5 C      0   0  10   14.91   0.00   6.71 0.022086    61074
 4  1 10  5 C      3   0  10   18.18   0.00   5.50 0.039526    60815

 4  1 10  6 k      0   7   3   99.91   0.00   0.00 0.003822    85681
 4  1 10  5 f      0   7   3   94.27   0.00   0.00 0.010577    98893
 4  1 10  5 F      0   7   3   97.29   0.00   0.13 0.032502   107599
 4  1 10  5 F      3   7   3   69.03   0.00  11.04 0.032696   119276
 4  1 10  5 c      0   7   3   29.09   0.00   3.43 0.012937   126950
 4  1 10  5 C      0   7   3   22.42   0.00   4.43 0.011381   138405
 4  1 10  5 C      3   7   3   20.95   0.00   4.75 0.012371   129167

 4  1 10  5 k      0   9   1   97.52   0.00   0.00 0.008442   114210
 4  1 10  5 f      0   9   1   94.32   0.00   0.00 0.015333   104639
 4  1 10  5 F      0   9   1   93.78   0.00   0.23 0.007120   131777
 4  1 10  5 F      3   9   1   22.86   0.00  26.04 0.010409   161190
 4  1 10  5 c      0   9   1   12.84   0.00   7.77 0.017105   132406
 4  1 10  6 C      0   9   1    9.75   0.00  10.22 0.010480   137857
 4  1 10  7 C      3   9   1    9.23   0.00  10.46 0.029786   135441

To summarize the small process(children) case. Not counting the (*) cases
we clearly see that the user level locks substantially outperform (+20%)
the kernel implementation if lock contention does not hoover above
95%, a case we don't optimize for anyway.
Surprisingly, they are even reasonable fair in most cases, (c) in various
cases had a high COV value, but that's what the lock is for.
Spinning helps (sometimes).


Now let's turn our attention to the 100 process case.

100  1 10  5 k      0   0  10  100.00   0.00   0.00 0.756951    16866
100  1 10  5 f      0   0  10  100.00   0.00   0.00 0.536551    49233
100  1 10  5 F      0   0  10  100.00   0.00   0.00 0.516478    49096
100  1 10  5 F      3   0  10  100.00   0.00   0.00 0.592092    49216
100  1 10  5 c      0   0  10    5.19   0.00  19.27 0.324299    46064
100  1 10  7 C      0   0  10   15.17   0.00   6.59 0.071464    53429
100  1 10  7 C      3   0  10   16.96   0.00   5.90 0.075513    52285

not a lot of difference in the fully contended case. Striking again how
often the lock acquisition in the calock succeeds even for this fully
contended case. The fairness is totally down the drain even in the
k and f lock, which indicates to me that the run time might not have been long
enough.

100  1 10  7 k      0   7   3  100.00   0.00   0.00 0.028202    12168
100  1 10  5 f      0   7   3  100.00   0.00   0.00 0.082430    24693
100  1 10  5 F      0   7   3  100.00   0.00   0.00 0.083701    26918
100  1 10  5 F      3   7   3  100.00   0.00   0.00 0.084006    26489
100  1 10  5 c      0   7   3   29.10   0.00   3.43 0.253149   127234
100  1 10  5 C      0   7   3   22.23   0.00   4.49 0.198701   138257
100  1 10  5 C      3   7   3   20.81   0.00   4.79 0.235070   129320


100  1 10  7 k      0   9   1  100.00   0.00   0.00 0.014891    12297
100  1 10  5 f      0   9   1  100.00   0.00   0.00 0.079500    67188 (E1)
100  1 10  5 F      0   9   1  100.00   0.00   0.00 0.077384    25207 (E2)
100  1 10  5 F      3   9   1  100.00   0.00   0.00 0.077485    25148
100  1 10  5 c      0   9   1   12.73   0.00   7.81 0.194209   133376
100  1 10  5 C      0   9   1    9.71   0.00  10.28 0.153369   137555
100  1 10  5 C      3   9   1    8.85   0.00  11.24 0.163615   134339

The last two cases are SHOWTIME. Clearly we get superior behavior user
level
locking. (E1)is very high as compared to (E2). I don't have any explanation
for this.

Userlocks on VIAGRA: 1000 processes contending for a single lock.

1000  1 10  5 k      0   9   1  100.00   0.00   0.00 0.026477     1358
1000  1 10  7 f      0   9   1  100.00   0.00   0.00 0.544364     2640
1000  1 10  7 F      0   9   1   99.84   0.00   0.00 0.588966     2507
1000  1 10  7 F      3   9   1   99.45   0.00   0.03 0.362092     2245
1000  1 10  7 c      0   9   1    6.87   0.00  14.38 0.596546   104738
1000  1 10  6 C      0   9   1    9.22   0.00  10.78 0.696058   136075
1000  1 10  5 C      3   9   1    7.74   0.00  12.71 0.749075   134492

Note we did not get to statistically significant runs for f,F,c.
The results speak for themselves!!!!

SHARED LOCKS
------------

Here I check how the shared locks work for (0,10) (10,0) case 2 processes.
I increase the lock sharing from 0 to 100 %. As can be seen the performance
increases with it. Interesting again is that the (0,10) case is faster
than the the (10,0) case for 100% sharing ?

 2  1 10  5 s  0   0   0  10   99.90   0.00   0.00 0.020436    58331
 2  1 10  5 s 20   0   0  10   99.00  79.67   0.00 0.003076    55887
 2  1 10  5 s 40   0   0  10   97.08  59.75   0.00 0.001201    59823
 2  1 10  5 s 60   0   0  10   94.34  39.78   0.00 0.000268    71217
 2  1 10  5 s 80   0   0  10   91.42  19.91   0.00 0.001100    96733
 2  1 10  5 s100   0   0  10    0.00   0.00   0.00 0.001839   172432

 2  1 10  5 s  0   0  10   0    0.49   0.00   0.00 0.001672   121785
 2  1 10  5 s 20   0  10   0    0.51   0.58   0.00 0.000147   121616
 2  1 10  5 s 40   0  10   0    0.67   0.51   0.00 0.001209   121057
 2  1 10  5 s 60   0  10   0    0.88   0.41   0.00 0.001455   120407
 2  1 10  5 s 80   0  10   0    0.96   0.22   0.00 0.002061   120161
 2  1 10  5 s100   0  10   0    0.00   0.00   0.00 0.000782   120306



Comments particular to the questions previously posted and posted here again.

At this point, could be go through and delineate some of the requirements
first.
E.g.  (a) filedescriptors vs. vaddr
      (b) explicit vs. implicite allocation
      (c) system call interface vs. device driver
      (d) state management in user space only or in kernel as well
                i.e. how many are waiting, how many are woken up.
      (e) semaphores only or multiple queues
      (f) protection through an exported handle with some MAGIC or
          through virtual memory access rights
      (g) persistence on mmap or not
 
Here is my point of view:
(a) vaddr
(b) implicite
(c) syscall
(d) user only
(e) multiple queues
(f) virtual memory access rights.
(g) persistent  (if you don't want persistence you remove the underlying object)



-- Hubertus Franke
