Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVBLD3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVBLD3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVBLD1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:27:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24746 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262386AbVBLD0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:02 -0500
Date: Fri, 11 Feb 2005 19:25:36 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overview
--------

The purpose of this set of patches is to introduce (one part of) the
necessary kernel infrastructure to support "manual page migration".
That phrase is intended to describe a facility whereby some user program
(most likely a batch scheduler) is given the responsibility of managing
where jobs run on a large NUMA system.  If it turns out that a job needs
to be run on a different set of nodes from where it is running now,
then that user program would invoke this facility to move the job to
the new set of nodes.

We use the word "manual" here to indicate that the facility is invoked
in a way that the kernel is told where to move things; we distinguish
this approach from "automatic page migration" facilities which have been
proposed in the past.  To us, "automatic page migration" implies using
hardware counters to determine where pages should reside and having the
O/S automatically move misplaced pages.  The utility of such facilities,
for example, on IRIX has, been mixed, and we are not currently proposing
such a facility for Linux.

The normal sequence of events would be as follows:  A job is running
on, say nodes 5-8, and a higher priority job arrives and the only place
it can be run, for whatever reason, is nodes 5-8.  Then the scheduler
would suspend the processes of the existing job (by, for example sending
them a SIGSTOP) and start the new job on those nodes.  At some point in
the future, other nodes become available for use, and at this point the
batch scheduler would invoke the manual page migration facility to move
the processes of the suspended job from nodes 5-8 to the new set of nodes.

Note that not all of the pages of all of the processes will need to (or
should) be moved.  For example, pages of shared libraries are likely to be
shared by many processes in the system; these pages should not be moved
merely because a few processes using these libraries have been migrated.
For the moment, we are going to defer the problem of determining which
pages should be moved; a solution to this problem will be the subject
of a subsequent patch set.

So, for now let us assume that we have determined that a particular
set of pages associated with a particular process need to be moved.
The kernel interface that we are proposing is the following:

page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);

Here va_start and va_end are assumed to be mapped by the same vma; these
addresses are effectively ways that we can specify all (or part of)
an address space map as given in /proc/pid/maps.  count is the number
of entries in the old_nodes and new_nodes arrays.  The effect of this
system call is to cause all pages in the page range specified that are
found to be resident on old_nodes[i] to be moved to new_nodes[i].

In addition to its use by batch schedulers, we also envision that
this facility could be used by a program to re-arrange the allocation
of its own pages on various nodes of the NUMA system, most likely
to optimize performance of the application during different phases
of its computation.

Implementation Details
----------------------

This patch depends on the implementation of page migration from the
Memory Hotplug Patch (see http://sr71.net/patches; this patch set is
maintained by Dave Hansen of IBM and many other contributors).  Recently,
I worked with Dave to rearrange the sequence of the hotplug patches so
that the page migration patch could be applied by itself and then the
rest of the Memory Hotplug patches could be applied on top of that patch.
(In the following and in the descriptions of the other patches, we will
refer to the page migration patch and to the Memory Hotplug patch itself
-- by this we mean the patches available as, for example:

patch-2.6.11-rc2-mm3-mhp1-pm.gz

and the rest of the hotplug patches available in

broken-out-2.6.11-rc2-mm2-mhp1.tar.gz

The latter actually includes the page migration patch, but we will use
the term Memory Hotplug patch to mean the patchset that starts with
patch "A1.1-refactor-setup_memory-i386.patch" in the series file for the
broken-out patches.  The page-migration patch consists of the patches
before that, these patches have names ithat start with "AA-".)

Given this powerful underlying framework, the implementation of manual page
migration is relatively straightforward.  There are 7 patches supplied
here, the first 5 of those are cleanup patches of various sorts for the
page migration patch.

Patches 6 and 7 of the series implement the system call described
above.

Limitations of the Current Patch
--------------------------------

This is, after all, an RFC and the current patch is only prototype code.
It is being sent to the list in its current form to get some early
comments back and to allow for careful validation of the approach
that has been selected, before so much code has been written that the
project has solidified and become difficult to be changed.  I welcome the
opportunity for others to examine this patch and provide suggestions,
point out possible improvements, help me to eliminate bugs, or to make
suggestions about improved coding style or algorithms.  I will, however,
be away from the office for the next week, so will likely not be able
to respond until the week of Feb 21st.

There are several things that this patch does not do, however, and
we hope to resolve some of these issues in subsequent versions of the
patchset:

(1)  There is no security or authentication checking.  Any process
     can migrate any pages of any other process.  This needs to
     be addressed.

(2)  We have not figured out yet what to do about the interaction
     between page migration and Andi Kleen's memory policy infrastructure.
     Presumably the memory policy data structures will have to be
     updated either as part of the system call above or through
     a new (or existing) system call.

(3)  As previously mentioned, we have omitted a glaring detail --
     how to determine what pages to migrate.  I have an algorithm
     and code to solve this problem, but it is still a little
     buggy and I wanted to get the ball rolling with what already
     existed and seems to work reasonably well.

(4)  It is likely that we will add a new operation to the vm_ops
     structure -- the "page_migration" routine.  The reason for
     this is to provide a way for each type of memory object to provide
     a way that it's pages can be migrated.  We have not included
     code for this in the current patch.

(5)  There are still some small bugs relating to what happens to
     non-present pages.  These issues should not hinder evaluation
     or discussion of the overall approach, however.

Finally, it is my goal to include the migration cache patch in 
the final version of this code, however, at the moment there are
some issues with this patch that are still being worked out, so
it has not been included in this version of the patch.

So, with all of the disclaimers and other details out of the
way, we should go on, in subsequent notes, to discuss each of the
7 patches.  Remember that only the last 2 are really significant;
the others are mostly cleanup of warnings and the like.

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
