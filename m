Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWDYPHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWDYPHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWDYPHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:07:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51643 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932249AbWDYPHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:07:43 -0400
Message-ID: <444E3B3D.1020502@watson.ibm.com>
Date: Tue, 25 Apr 2006 11:07:41 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Jes Sorensen <jes@sgi.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       Erich Focht <efocht@ess.nec.de>, Levent Serinol <lserinol@gmail.com>,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [Patch 0/8] per-task delay accounting
References: <444991EF.3080708@watson.ibm.com>
In-Reply-To: <444991EF.3080708@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a repost of my overview of the other stakeholders.
For some reason, lkml keeps rejecting this and its earlier post
wasn't archived either. Retrying.

Following Andrew's suggestion, here's my quick overview
of the various other accounting packages that have been
proposed on lse-tech with a focus on whether they can
utilize the netlink-based taskstats interface being proposed
by the delay accounting patches.

Please note that unification of statistics *collection* is not
being discussed since that kind of merger can be done as these
patches get accepted, if at all, into the kernel. To try and unify right
away would hold every patch (esp. delay accounting !)
hostage to the problems in every other patch unnecessarily. As
long as the interface can be unified, the merger of the collection bits
can always happen without affecting user space.

Stakeholders of each of these patches, on cc, are requested to
please correct any misunderstandings of what their patches do
so we can make forward progress.


--Shailabh


Summary

The following can use the taskstats netlink-based
interface by extending the returned data structure

- Comprehensive System Accounting
- per-process I/O stats
- Microstate accounting
- per cpu time stats


The following patches' interface needs are independent
of taskstats or subsumed by one of above:
- Enhanced Linux System Accounting
- pnotify
- scalable statistics counters



Details
(please correct if these are misunderstood)

1. Comprehensive System Accounting (Jay Lan)
--------------------------------------------

- Collect various per-task statistics and write an accounting record
containing
these stats at task exit. Interface similar to BSD process accounting
but the accounting record structure is quite different.

- CSA could utilize some stats collected/exported by delay accounting
    blkio wait time
    cpu run time for task
- CSA only needs data to be available at task exit, not during the
task's lifetime. Moreover, at task exit, it needs the accounting record
to be written to a file.
- CSA could utilize delay accounting's taskstats netlink interface to
gather task data at exit through
a userspace utility that then writes it out to its expected file.

To do so, CSA would need the taskstats struct to be extended with
whatever additional stats it needs. The additional stats could be
selectively exported only on task exit to avoid imposing a space burden
on users of delay accounting who query a process's statistics during its
lifetime.

Collection of the additional stats needed by CSA may be tied to pnotify
and job patches which are still being reviewed/considered for
acceptance. As such, unification in the collection of stats can be
deferred until status of pnotify/job/CSA patches becomes more clear.



2. per-process I/O statistics (Levent Serinol)
----------------------------------------------

- Exports task->{rchar,wchar} through /proc/tgid/iostat
(earlier version proposed export through /proc/tgid/stats)

- No new stats collection. Just export of existing task fields
- Problem with accepting the patch stems from the accuracy of the
statistics
in these fields. The fields are updated only in three cases today
(sys_read/write, sys_readv/writev, do_sendfile)
so they aren't accurate. async I/O, memory-mapped I/O is not counted
at the very least).

CSA patches also export these fields through their accounting record
but don't appear to be doing anything to improve accuracy of collection
(or maybe it doesn't matter to them).
BSD accounting, which ought to be using the sum of these fields for its
ac_io field, doesn't (it hardcodes the output to zero).

When the fate of task->rchar/wchar is decided, based on CSA's needs,
those fields can be easily added to taskstats.

3. per-cpu time statistics (Erich Focht)
----------------------------------------

- Collects time spent by a task on each cpu of a system
and exports it through new interface /proc/tgid/cpu

- Statistic is needed for performance analysis/debugging (like
schedstats) and not for production systems.
- Unsure why push for acceptance was abandoned. Possibly due to one or
more of:
space overhead of allocating NR_CPUS variables in task_struct
time overhead of collecting the data ?

- Can use taskstats interface to export the data by adding needed fields
to struct taskstats and bumping up the version.



4. Microstate accounting (Peter Chubb)
--------------------------------------

- Measure time spent by a thread in various interesting states, while
accounting for interrupts, and export through /proc/tid/msa and 
through a syscall interface

- Interesting states have some overlap with delay accounting
- Exporting of per-task stats can be done through taskstats netlink
interface


5. Enhanced Linux System Accounting (Guillaume Thouvenine)
----------------------------------------------------------

- Group tasks at a user level into "jobs" and aggregate, at user level,
per-task statistics collected by CSA and/or BSD process accounting.

- ELSA does not introduce any new requirement for either collection or
export of statistics from the kernel. It can use either BSD and/or CSA's
method of using an accounting file.

- ELSA needs notification of forks and exits which it can already get
through the process events connector in the kernel.

Hence ELSA's needs are either met by the kernel today or are a strict
subset of CSA (since BSD accounting is already there).


6. pnotify (Erik Jacobson)
--------------------------

- Infrastructure for kernel modules to be notified when an event (like
fork/exit/exec)
happens to a task. Also provides some per-task data for the modules'
convenience


