Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSCEVWv>; Tue, 5 Mar 2002 16:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310240AbSCEVWn>; Tue, 5 Mar 2002 16:22:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36070 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293725AbSCEVWZ>;
	Tue, 5 Mar 2002 16:22:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com
Subject: Futexes III :  performance numbers
Date: Tue, 5 Mar 2002 16:23:14 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305212210.B10A33FF04@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 02:01 am, Rusty Russell wrote:
> 1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
> 2) Fix for the "decrement wraparound" problem (Paul Mackerras)
> 3) x86 fixes: tested on dual x86 box.
>
> Example userspace lib attached,
> Rusty.


I did a quick hack to enable ulockflex to run on the latest interface that 
Rusty posted.

The command run was
./ulockflex -c 2 -a 1 -t 2 -o 5 -m -1 -R 499 -r 0 -x 0 -L f

that is 2 children, 1 lock, 2 seconds in a tight loop contending for the lock.
Tue Mar  5 15:12:56 EST 2002:  calibrated at 496
base arguments are <-t 10 -o 5 -m 8 -R 496 -P>
 c #number of children
 a #number of locks            (always one in this case)
 t #second of each run
 i #number of iterations
 L locktype (capital letter means spinning version)
 p patience of spinning if any
 r  mean runtime usecs without holding a lock
 x  mean runtime usces with lock held.
 WC lock contention on write lock
 RC read contention on read lock (for shared lock)
 R  percentage of failed lock attempts resolved by spinning OR
    average times in calock a failed attempt needed to retry
 COV coefficient of variance between children (fairness)
 ThPut Throughput achieved per second

Lock types:
e:  empty locks no lock/unlock performed
k:  sysv semaphores 
f:   usema (Hubertus Franke)  
m:   mutex  (Rusty Russell)
c:  convoy avoidance lock  (Hubertus Franke)
 
RAW OVERHEAD/

First the raw overhead numbers for 1 process
 c  a t   i L      p   r  x     WC      RC      R     COV       ThPut
 1  1  2  1 e      0   0   0    0.00   0.00   0.00 0.000000  2316611 
 1  1  2  1 k      0   0   0    0.00   0.00   0.00 0.000000    539468 
 1  1  2  1 m      0   0   0    0.00   0.00   0.00  0.000000 2022462
 1  1  2  1 f      0   0   0    0.00   0.00   0.00 0.000000    1979692      
 1  1  2  1 c      0   0   0    0.00   0.00   0.00 0.000000  1936554   

User locks are about 4 times faster than kernel locking techniques.

Let's look at the contention issue 2 processes
 2  1  5  4 k      0   0   0   99.77   0.00   0.00 0.003608   289920
 2  1  5  4 m      0   0   0    9.67   0.00   0.00 0.086198   843918  
 2  1  5  4 f      0   0   0   97.90   0.00   0.00 0.028389   328755 
 2  1  5  4 c      0   0   0    6.80   0.00   0.06 0.001428   933587      

This analysis reveals a few interesting points. First again userlocks
are much faster. 
RR's version does not provide a FIFO locking order !!!!!!!!!! 
This can be seen by the fact that the only 9.67% of the times the 
lock was requested, the kernel was called. Also has a high COV 8%.
As a result RR's mutex are about 2.5 times faster than my semaphores
which process in strict FIFO order. This is due to the fact that
I separate user state and kernel state as described in various previous 
messages. 

We need to know whether FIFO processing is required.
I have provided similar locks to RR mutex I called convoy avoidance locks
and you see they are about 10% better than RR locks.

Now 3 processes
 3  1  5  4 k      0   0   0   99.98   0.00   0.00 0.033284   242040 
 3  1  5  4 m     0   0   0    0.29   0.00   0.00 0.018406  1979992
 3  1  5  4 f      0   0   0   99.71   0.00   0.00 0.028083   306140  
 3  1  5  4 c      0   0   0    7.79   0.00   4.00 0.437084   774175 

Interesting... the strict FIFO ordering of my fast semaphores limits
performance as seen by 99.71% contention, so we always ditch
into the kernel. Convoy Avoidance locks 2.5 times better.
Wohh futex rock, BUT... with 0.29% contention it basically tells
me that we are exhausting our entire quantum getting the lock
without contention. So their is some serious fairness issue here
at least for the tightly scheduled locks. Compare the M numbers
for 2 and 3 children.

Let's rock again....  100 processes
100  1 10  4 k      0   0   0  100.00   0.00   0.00 0.422294    17776  
100  1 10  4 m     0   0   0    0.58   0.00   0.00 0.278172  1793520 
100  1 10  4 f      0   0   0   99.50   0.00   0.00 0.478905    52834
100  1 10  4 c      0   0   0    8.05   0.00  12.02 0.522363   563151

Same as above, futexes rock, but at very tight arrival rates are highly 
unfair, but they avoid the so called convoy phenomena.

Linus, or for that matter anybody else, what's your take: is some level of 
starvation acceptable when deploying fast user locks ?
 
REALIST ARRIVAL RATE
----------------------------
Let's switch to something more realistic   1 usec mean lock holdtime and
10 usecs mean nonlock time.

 3  1 10  4 k      0  10   1   98.70   0.00   0.00 0.005531   129429
 3  1 10  4 m      0  10   1    7.29   0.00   0.00 0.113565   122602 
 3  1 10  4 f      0  10   1   98.19   0.00   0.00 0.009873   138952   
 3  1 10  4 c      0  10   1   10.61   0.00   8.45 0.325935   139446      

Once the convoy disappears actually my locks seem to perform better.
Reason for that is likely that the in kernel hashing is faster (guess).


100  1 10  4 k      0  10   1   99.96   0.00   0.00 0.003876    12811
100  1 10  4 m      0  10   1    9.36   0.00   0.00 0.051076   139238
100  1 10  4 f      0  10   1  100.00   0.00   0.00 0.162686    36601
100  1 10  4 c      0  10   1   10.58   0.00   9.33 0.326738   138602

Again at the relevant cases convoy avoidance locks do roughly what
the RR's futex do. Fair locks don't do that well, still due to the FIFO order.

Now two takes possible:

(a) we need FIFO ordering even for fast user level locks
(b) I don't give a rat's hyni  ; if you want FIFO use sysv locks.

Comments, stands .....

Again, we better settle this one soon.

-- Hubertus
