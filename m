Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVBOAar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVBOAar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVBOAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:30:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:16851 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261397AbVBOAaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:30:21 -0500
Message-ID: <42114279.5070202@sgi.com>
Date: Mon, 14 Feb 2005 18:29:45 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de>
In-Reply-To: <m1vf8yf2nu.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Ray Bryant <raybry@sgi.com> writes:
> 
>>set of pages associated with a particular process need to be moved.
>>The kernel interface that we are proposing is the following:
>>
>>page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> 
> 
> [Only commenting on the interface, haven't read your patches at all]
> 
> This is basically mbind() with MPOL_F_STRICT, except that it has a pid 
> argument. I assume that's for the benefit of your batch scheduler.
> 
> But it's not clear to me how and why the batch scheduler should know about
> virtual addresses of different processes anyways. Walking
> /proc/pid/maps? That's all inherently racy when the process is doing
> mmap in parallel. The only way I can think of to do this would be to
> check for changes in maps after a full move and loop, but then you risk
> livelock.
> 
> And you cannot also just specify va_start=0, va_end=~0UL because that
> would make the node arrays grow infinitely.
> 
> Also is there a good use case why the batch scheduler should only
> move individual areas in a process around, not the full process?
> 

The batch scheduler interface will be to move entire jobs (groups of
processes) around from one set of nodes to another.  But that interface
doesn't work at the kernel level.  The problem is that one just can't
ask the kernel to move the entire address space of a process for a number
of reasons:

(1)  You really don't want to migrate the code pages of shared libraries
      that are mapped into the process address space.  This causes a
      useless shuffling of pages which really doesn't help system
      performance.  On the other hand, if a shared library is some
      private thing that is only used by the processes being migrated,
      then you should move that.

(2)  You really only want to migrate pages once.  If a file is mapped
      into several of the pid's that are being migrated, then you want
      to figure this out and issue one call to have it moved wrt one of
      the pid's.
      (The page migration code from the memory hotplug patch will handle
      updating the pte's of the other processs (thank goodness for
      rmap...))

(3)  In the case where a particular file is mapped into different
      processes at different file offsets (and we are migrating both
      of the processes), one has to examine the file offsets to figure
      out if the mappings overlap or not. If they overlap, then you've
      got to issue two calls, each of which describes a non-overlapping
      region; both calls taken together would cover the entire range
      of pages mapped to the file.  Similarly if the ranges do not
      overlap.

Figuring all of this out seems to me to be way too complicated to
want to stick into the kernel.  Hence we proposed the kernel interface
as discussed in the overview note.  This interface would be used by
a user space library, whose batch scheduler interface would look
something like this:

migrate_processes(pid_count, pid_list, node_count, old_nodes, new_nodes);

which is what you are asking for, I think.  The library's job
(in addition to suspending all of the processes in the list for
the duration of the migration operation, plus do some other things
that are specific to sn2 hardware) would be to examine the
/proc/pid/maps entries for each pid that we are
migrating, and figure out from that what portions of which pid's
address spaces need to migrated so that we satisfy the constraints
given above.  I admit that this may be viewed as ugly, but I really
can't figure out a better solution than this without shuffling a
ton of ugly code into the kernel.

One issue that hasn't been addressed is the following:  given a
particular entry in /proc/pid/maps, how does one figure out whether
that entry is mapped into some other process in the system, one
that is not in the set of processes to be migrated?   One could
scan ALL of the /proc/pid/maps entries, I suppose, but that is
pretty expensive task on a 512 processor NUMA box.  The approach
I would like to follow would be to add a reference count to
/proc/pid/maps.  The reference could would tell how many VMAs
point at this particular /proc/pid/map entry.  Using this, if
all of the processes in the set to be migrated account for all
of the references, then this map entry represents an address
range that should be migrated.  If there are other references
then you shouldn't migrate the address range.

Note also that the data so reported represents a performance
optimization, not a correctness issue.  If some of the /proc/pid/map
info changes after we have read it and made our decision as
to what address ranges in which PIDs to migrate, the result
may be suboptimal performance.  But in most cases that we have
been able to think of where this could happen, it is not that
big of a deal.  (The typical example is library private.so
is used by an instance of batch job J1.  We decide to migrate
J1.  We look at the /proc/pid/maps info and find out that
only processes in J1 references private.so.  So we decide to migrate
private.so.  After we read the /proc/pid/maps info, job J2
starts up and it also uses private.so.  Well, in this case
there is no good solution anyway, because private.so will
either be on J1's set of nodes or J2's, but not both.  So
if we migrate private.so, it will slow down J1 for a bit
while are migrating it, but in the end, it won't matter.)

> I think the only sane way for an external process to move another 
> around is to do it for the whole process. For that you wouldn't need
> most of the arguments, but just a simple move_process_vm call,
> or perhaps just a file in /proc where the new node can be written to.
> 

Not so for the reasons given above.  You simply cannot move an
entire address space without deciding what to do with all of the
shared stuff.  And the shared stuff comprises most of the entrues
in /proc/pid/maps for most procesess.

> There may be an argument to do this for individual 
> tmpfs/hugetlbfs/sysv shm segments too, but mbind() already supports
> that (just map them from a different process and change the policy there)
>

Changing the policy will handle the placement of new pages.  Unless
you scan the tmpfs/hugetlbfs/sysv shm segments and look for misplaced
pages, and then migrate them, you won't have moved pages off of the
old nodes, and won't have freed up the storage that this whole
migration thing is really about.  We could certainly fix up the
mbind() code to do this, ala what Steve Longerbeam has done, but
that code needs to interface to the page migration code in that case
as well.

If we did this, we still have to have the page migration system call
to handle those cases for the tmpfs/hugetlbfs/sysv shm segments whose
pages were placed by first touch and for which there used to not be
a memory policy.  As discussed in a previous note, we are not in a
position to require that each memory object in the system has an
associated memory policy.  AFAIK, very few of our programs are using
the NUMA API to do placement.  Instead, I think that most programs
do memory placement by first touch, during initialization.  This is,
in part, because most of our codes originate on non-NUMA systems,
and we've typically done very just what is necessary to make them
NUMA aware.  For this reason, I don't think an approach of embedding
the migration facility into the NUMA API is going to work.

> For process use you could just do it in mbind() or perhaps
> part of the process policy (move page around when touched by process). 
> 
> -Andi
> 


-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
