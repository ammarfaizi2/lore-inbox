Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281614AbRKPWmj>; Fri, 16 Nov 2001 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281604AbRKPWlg>; Fri, 16 Nov 2001 17:41:36 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:34718 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S281603AbRKPWlX>; Fri, 16 Nov 2001 17:41:23 -0500
Date: Fri, 16 Nov 2001 16:41:08 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200111162241.QAA98422@tomcat.admin.navo.hpc.mil>
To: kravetz@us.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Real Time Runqueue
Cc: Davide Libenzi <davidel@xmailserver.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <kravetz@us.ibm.com>:
> 
> As you may know, a few of us are experimenting with multi-runqueue
> scheduler implementations.  One area of concern is where to place
> realtime tasks.  It has been my assumption, that POSIX RT semantics
> require a specific ordering of tasks such as SCHED_FIFO and SCHED_RR.
> To accommodate this ordering, I further believe that the simplest
> solution is to ensure that all realtime tasks reside on the same
> runqueue.  In our MQ scheduler we have a separate runqueue for all
> realtime tasks.  The problem is that maintaining a separate realtime
> runqueue is a pain and results in some fairly complex/ugly code.
> 
> Since I'm not a realtime expert, I would like to ask if my assumption
> about strict ordering of RT tasks is accurate.  Also, is anyone aware
> of other ways to approach this problem?

I used to do real-time (seismic survey navigation - sea, land and aircraft
based systems). I've always admired some of the approaches used by the old
VAX system (we did an adaptation for PDP-11/73 systems).

The operation provided a mixed environment of RR and fixed priority operation.
The core scheduler is based on a bit vector of no larger than 64 fixed priority
queues. Each queue could then be handled in a FIFO or RR manner. Selection
of the queue was done by a "first bit set" selection. This identified the
queue that the process was to be selected. Each queue had a selection fuction
that could implement any choses scheduling algorithm, but we only used FIFO
and RR. Several properties were required:

1. Only runnable processes are permitted to exist in the queues.
2. An empty queue had the corresponding bit value of zero.
3. Any queue with pending processes had the corresponding bit set to 1.

Our adaption took the bit vector, converted it to floating point, and
subtracted the exponent bias from the exponent. This gave us the "first bit
set" in the vector. This index can then be used to select the queue and
the selection algorithim. The return value is always the process to run.
If the current process matches the original value, then return to the
already loaded context; otherwise a context swich was called for. Also note
that the current context contained the queue identifier. This makes it
simple to save the current context. Of course, if the vector were zero then
the idle task was invoked.

We found that most of the time the queues only held one or two processes,
making for a fast selection (we only had one processor so we didn't have
to deal with SMP issues).

When only one process/queue exists you have fixed priority queueing.

If a queue has more than one process, then the possibility for FIFO or RR is
available, with FIFO becoming a "complete current process" before it ever
looks at the other processes at the same priority.

I think the VMS useage was to have the first 16 bits in the vector for
realtime kernel processes, the second 16 for realtime user mode processes, the
next 32 were timesharing user processes, with various priorities.

Now as to strict realtime ordering, yes and no. This is because some things
MUST be done - in our case range computations had to be completed before the
next range came in. This put it at the highest fixed priority, NO
interference from other tasks.

Distance/bearing/location came next (if a new range was not available, then
dead reckon the location) and was strictly scheduled on time.

These two tasks were fixed priority and were the only processes in their
corresponding priority queue.

A lower level task called for data recording when a certain distance had
been covered. This would be FIFO with a display update process. (we ended
up with a ship representation display with known local obsticals.. oil rigs,
entered base line markers, wrecks, sandbars...)

Lower level tasks handled command input and was scheduled RR with a
data calculator functions (geodesic distance/time computation), navigation
parameter initialization ...

The idle task ended up handling a location plotter (spin on flag interface,
no interrupt available... stupid thing was too fast for an interrupt, but
required about 100 iterations per output byte).

Inter-process communication was done with SHORT messages. The largest was
the data recording snapshot -between 128 and 150 bytes long); the shortest
was about 32 bytes - latitude/longitude/bering/distance. The kernel
suspended scheduling during the message copy.

Along with this was the usual device drivers (tape/printer/keyboard/serial)
for communicating with external customer devices. There were also special
drivers for controlling the range input device, early GPS recievers,
LORAN-C recievers,...

This is in part a description in favor of your multi queue scheduler.

Complexity is relative - usually the hard part is deciding whether all
processes must exist in the queue at all times -idle/ready/sleeping/...
or if the queues only contain runnable processes.

If (and this may depend on hardware) it is easy to insert/remove from
queues, then having the process out of the queues when idle will speed up
the selection process. Having only active processes also makes it feasable
to use the bit vector.

I believe we opted to leave all process in the queues to speed up the
state change procedures. The selection process was always at the end of
a processing cyle (either clock interrupt, or the process did an I/O)
so the overhead was always measured relative to the previous running
process.

I always liked the trick of converting the bit vector to a floating point to
use the exponent to determine the active queue - it took far fewer instructions
than a loop to check each queue in an array. The added overhead when doing
the queue insertion became one instruction. It does require that only active
processes be in the queue, though. Otherwise you have to have a queue scan
since the queue MAY have all processes idle, even though the bit is set (have
to clear it and start the queue selection over - bummer. (a "find first set
bit" instruction is really usefull here).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
