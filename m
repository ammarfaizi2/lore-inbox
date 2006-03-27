Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWC0Gy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWC0Gy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 01:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWC0Gy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 01:54:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1953 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750757AbWC0Gy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 01:54:57 -0500
Date: Mon, 27 Mar 2006 12:24:47 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       prasanna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: RFC - Approaches to user-space probes
Message-ID: <20060327065447.GA25745@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

As Andrew Morton suggested, here is a document on user-space probes
discussing known approaches and design issues.

Please provide your comments and suggestions.

Thanks
Prasanna
----

The basic need is to provide infrastructure for user-space dynamic
instrumentation. As with kprobes, there is no need to recompile or
restart the applications for instrumentation, under a debugger for
instance.

Some of the use-cases are:

- To find out the memory leaks dynamically just by inserting probes on
  malloc and free library routines.
- Can be used to identify resouce contention bottlenecks.
- Do performance measurements in real time.
- Logging and changing the registers and global data structures.

This document also discusses Christoph's suggested approach

Method Used:

1. Using breakpoint instruction and executing the instrumentation
   code from within the breakpoint handler in interrupt context.

The advantages of this approach are listed below

- A single tool providing data capture in a consistent manner
  eases the problems of correlation of events across multiple tools
  (for kernel and user space)
- The dynamic aspect allows ad-hoc probepoints to be inserted  where
  no existing instrumentation is provided (emergency debug scenario
  for example).
- Low overhead and user can have thousands of active probes on the
  system and detect any instance when the probe was hit including
  probes on shared library etc.

Design Issues:

==============================
BREAKPOINT VS JUMP INSTRUCTION
==============================

- Breakpoint instruction is the smallest instruction that can
  replace any other instruction with less overhead (details
  please refer to the issues discussed with method 1 and 2 below).

============================
UNIQUE PROBE INDENTIFICATION
============================

- Probes being tracked by an (inode, offset) tuple rather than by
  virtual address so that they can be shared across all processes
  mapping the executable/library even at different virtual addresses,
  etc.

===========================================================
LOCAL PROBES(PER PROCESS) VS GLOBAL PROBES(EXECUTABLE FILE)
===========================================================

- All processes take a trap since the same executable file
  gets mapped into different address_space.

- Compare this with ptrace breakpoints (hence strace and gdb) where
  tracepoints and breakpoints are localized to a specified set of
  processes.  To support local probes the text pages are privatized
  for that process. Global user-probes does not have the side effects
  (privatization of pages) that ptrace has.

- Global probes does not require the executable pages to be present
  in memory just to place a probe on them (hence zero overhead for
  probes which are very unlikely to be hit).

- Global probes does not add restrictions on evicting a page with a
  probe on it from memory.

- Global probes does not require pages to be marked with copy-on-write.

- Global probes are even visible across fork() syscalls.

- In case of global probes, per process instrumentation data can still
  be obtained easily by logging & filtering based on pid/process name.


=====================================
PROBES ON EXECUTABLE MAPPED WRITEABLE
=====================================

- Probes can be inserted to the all the vma's that map the same
  executable.

===================================
PROBES ON YET TO START APPLICATIONS
===================================

- User probes also supports the registering of the probepoints before
  an the probed code is loaded. The clearly has advantages for
  catching initialization problems. This involves modifying the probed
  applications address_space readpage() and readpages() pointers
  routine. Overhead of changing the address_space readpage/s()
  pointers is limited to only the probed application until all probes
  are removed from that application.

=========================================
NEED FOR A KERNEL MODULE TO INSERT PROBES
=========================================

1. Probes can be applied on system wide bases.
2. Low overhead of executing the handler from the kernel mode.
3. Executing the handler in user-mode requires additional application
   / daemon to share its address_space containing instrumentation code
   with the probed application.

===========
LIMITATIONS
===========

1. Probes are visible if a copy of probed executable is made when
   probes are applied.

2. Can only dump the data present in the memory when probe was
  hit.

3. Can only run the handler the handler in the kernel mode.

4. Debuggers and probes cannot coexist at the same "address", even
   though they can have breakpoints elsewhere in the same executable
   mapped in memory.

Initial prototype of the above approach is being posted on lkml.
http://www.ussg.iu.edu/hypermail/linux/kernel/0603.2/1186.html

Some issues were pointed out during review and those will be fixed
based on the design consensus.
Other possible approaches which were looked up:

1. Attaching or loading the application into a trace tool.

In this method the user application must be loaded into a trace tool
or the trace tool is attached to already running application. Before
the user can instrument an application the user should decide what
that instrumentation will consist of. Dynaprof uses such a mechanism.

http://www.dyninst.org/tools.html

2. Using a "jump" instruction to a trampoline and trampoline executing
   the instrumented code in user-space.

Eg: Paradyn tool. (http://www.paradyn.org/ and
		http://www.paradyn.org/tracetool.html)

Issues with method 1 and 2 are:

- Induces Intel erratum E49 where the other processors see stale data
  while one processor replaces the jump instruction.
- Instruction can only be replaced atomically if the size of the jump
  instruction is greater than or equal to the original instruction.
- Other processors need to be stopped if the "jump" instruction size
  is less than the original instruction.

3. Christoph's approach of providing a ptrace-like syscall interface
   to insert/remove probes

I'd like to request Christoph for more details on the approach.

Questions with this approach are

1. Should  this support per process probes or pre executable file
   probes?
2. Should the handler be executed within kernel/user mode?
3. If kernel mode how do you insert the handlers with the kernel mode?
4. If user mode where should the handler exists ?
5. If user mode should it follow the ptrace way of giving control to
   the handler?

  Some of these questions may well be answered, once more details are
  worked out about this approach

Limitations:

1. Large memory overhead if per-process copy of text pages is made.

2. Ptrace has a over-head of making a syscall for each probe hit to
   access/modify the data.

Ptrace already allows the user to access and modify data from
user-mode.

=====
TODO:
=====
- evaluate suggestions about approach
- update the existing patchset based on the comments received
  or work on approach agreed upon.
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
