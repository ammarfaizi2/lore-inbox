Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277296AbRJJQ0A>; Wed, 10 Oct 2001 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277306AbRJJQZu>; Wed, 10 Oct 2001 12:25:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8871 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277296AbRJJQZk>; Wed, 10 Oct 2001 12:25:40 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
 insertion
To: dipankar@beaverton.ibm.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF75C1C410.48EFE2FF-ON88256AE1.0057C29E@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Wed, 10 Oct 2001 09:00:21 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/10/2001 10:25:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So I'm still at a loss for what this could actually be _used_. IP
routing?
> > Certainly not sockets (which have uniqueness requirements).
>
> Yes. We used it in IP routing in DYNIX/ptx back then at Sequent as well
> as for Multipath I/O routes for storage. That is all I can remember,
> but Paul will remember and know more about it. Paul ?

Hello!

RCU was used in the following portions of PTX:

o    Distributed lock manager: recovery, lists of callbacks used to
     report completions and error conditions to user processes, and
     lists of server and client lock data structures.

o    TCP/IP: routing tables, interface tables, and protocol-control-block
     lists.  As Linus suspected, RCU was -not- applied to the socket
     data structures.  ;-)

o    Storage-area network (SAN): routing tables and error-injection
     tables (used for stress testing).

o    Clustered journalling file systems: in-core inode lists and
     distributed-locking data structures.

o    Lock-contention measurement: data structure used to map from
     spinlock addresses to the corresponding measurement data.  (This
     was needed since PTX locks are one byte long, and you can't put
     much extra data into one byte.)

o    Application regions manager (which is a workload-management
     subsystem): maintains a list of "regions" into which processes
     may be confined.

o    Process management: per-process system-call tables and MP trace
     data structures used for debuggers that handle multi-threaded
     processes.

o    LAN drivers to resolve races between shutting down a LAN device
     and packets being received by that device.  (This use is in many
     ways similar to that of Rusty's, Anton's, and Greg's hotplug
     patch).

PTX used RCU on an as-needed basis.  K42 made more
pervasive use of a very similar technique.

RCU is definitely -not- a wholesale replacement for all locking.
For example, as Dipankar noted, it can be integrated with reference-count
schemes.  It -can- be used to replace reference counts, but only in
cases where no task blocks while holding a reference.

RCU works best in read-mostly data structures.  The most common use
is to allow lock-free dereferencing of pointers, for example, removing
the lock on a -list-, keeping locking/reference counts only on the
elements themselves.

In addition, when moving from one element in a list to the next, RCU
allows you to drop the refcnt/lock of the preceding element -before-
traversing the pointer to the next element.  This can make the
traversal code a bit simpler.

                              Thanx, Paul

