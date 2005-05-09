Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVEITQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVEITQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVEITQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:16:44 -0400
Received: from main.gmane.org ([80.91.229.2]:35514 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261477AbVEITQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:16:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joe Seigh" <jseigh_02@xemaps.com>
Subject: RCU + SMR for preemptive kernel/user threads.
Date: Mon, 09 May 2005 15:09:33 -0400
Message-ID: <opsqivh7agehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can get rid of the requirement to disable interrupts or use K2 type
techniques if you combine RCU with SMR (hazard pointers).   Basically
you define the quiescent states for RCU to be anything that is equivalent  
to a
full memory barrier, e.g. interrupts, context switches, syscalls, signals,
etc...   For read access you use SMR hazard pointers without the
usual store/load memory barrier (so they're really fast on a pipelined
machine *).  For write access, you use the usual RCU technique but
after every processor/thread has gone through a quiescent state at
least once, you then do a hazard pointer scan before freeing the resource.
Doing it in this way ensures that the hazard pointer guarded load is
observed correctly even though there is no store/load memory barrier. **

This method combines the load overhead of RCU with the granularity
or SMR hazard pointers.  So you can have threads do long term read
accesses without tying up resources, only the resource they are
referencing.

If, besides the quiescent states mentioned above, you can query the
run state of the thread, you can use any not running states as quiescent
states since that implies a context switch.  This takes care of the problem
of low priority threads not making forward progress and not passing through
quiescent states in a timely and periodic matter.  This is not only  
important
for user threads, but kernel threads.  One of the ways you can implement
this is by looking at processor, rather than thread,  counts of events that
would be considered quiescent states, e.g. interrupts, timer values, etc...
While events of this sort may be considered to occur with frequent  
periodicity,
that's only true if Linux is running on real hardware.  If it's running on  
virtual
hardware, a processor may behave more like a user level thread in that
respect.  If the vm allows that, you may want an api that allows querying
the virtual processor's run state.

This is fairly portable.  For user threads, it can even be implemented on
windows using some old NT api's that are still around until Longhorn
arrives anyway.   For OS X and Solaris there are api's that let you query
various per thread counters and run states.  For Linux, there's /proc/stat
which appears to have per cpu times. ***   This is more efficient than  
querying
threads, since there will likely be more threads than processors for a  
while.
Plus you don't have to worry about thread run state for this method, at
least for non-virtual processors anyway.

This virtualization poses interesting problems.  What would you do about
a thread that's running on a non running virtual processor?  It's in a  
quiescent
state.  There needs to be a way to determine this.  You need to think about
virtualization more and about exposing this information at an application  
level.

Anyway, the problems that user level threads have will be the same problem
the kernel has with virtualization.  Even if the vm implementations don't
currently support this, defining a public api would send a message to the
vm vendors and give Linux proactive control over these issues.

                         ====

* Did I say fast?  On an iBook with 1.2 Mhz ppc and slow iBook memory
running OS X running a testcase that has reader threads traversing a linked
list that is being concurrently modified by writer threads, and pausing
during the traversal using sched_yield just to live dangerously, I get
about 500,000 reads (traversals) per second per thread with the RCU+SMR,
about 25,000 to 150,000 reads/sec/thread using my older lockfree methods,
and about 700 to 1000 reads/sec/thread using mutex or rwlocks.

On a single processor Linux system, it hard to get as dramatic numbers due
to the amount of scheduler artifacts that exist when trying this kind of  
stuff
on a single processor Linux system.   I get about 500 reads/sec/thread with
RCU+SMR, about 100 reads/sec/thread with the old lock-free stuff, and the
mutex and rwlock versions hang with writer starvation.

The main differenct between the old lock-free stuff and the RCU+SMR is
the old stuff uses memory barriers and/or interlocked instructions.

A raw timing loop shows the hazard pointer load sequence (a load,
store, load, compare, branch condtional) to be about 2x to 3x a
raw pointer load on both ia32 and ppc.


**  If the quiescent state occurred before the SMR hazard pointer load,  
then the
thread will correctly observe the changed global pointer.  If the  
quiescent state
occurred after hazard pointer load, the hazard pointer scan will see the
value stored in the hazard pointer.  If it occurred in the middle of a  
hazard
pointer load, any partitioning of the hazard pointer program sequential  
operations
into two sets, the first set executed before the second set in processor  
allowed
order, will work correctly.  I'm assuming some familiarity with SMR hazard  
pointer
logic and with RCU logic.


*** The per cpu times are in jiffies rounded off from some higher  
resolution value.
This means that for n time counters, you may have to wait up to n jiffies  
for
at least one round up to occur.  It would be nicer to have the higher  
resolution
value or even better a per processor number of interrupts to allow more  
flexibility
and finer granularity in polling intervals.


-- 
Joe Seigh

