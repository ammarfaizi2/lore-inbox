Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbUCZJGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbUCZJGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:06:32 -0500
Received: from [129.183.4.3] ([129.183.4.3]:41128 "EHLO ecbull20.frec.bull.fr")
	by vger.kernel.org with ESMTP id S263972AbUCZJGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:06:09 -0500
Message-ID: <4063F188.66DB690A@nospam.org>
Date: Fri, 26 Mar 2004 10:02:00 +0100
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Migrate pages from a ccNUMA node to another
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Migrate pages from a ccNUMA node to another.
============================================

Version 0.1, 25th of March 2004
By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart_AT_bull.net@no.spam.org>
The usual GPL applies.

What is it all about ?
----------------------

The old golden days of the Symmetrical Multi-Processor systems are over.
Gone forever.
We are left with (cache coherent) Non Uniform Memory Architectures.
I can see the future.
I can see systems with hundreds, thousands of processors, with less and less
uniform memory architectures.
The "closeness" of a processor to its working set of memory will have the most
important effect on the performance.

You can make use of the forthcoming NUMA APIs to set up your NUMA environment:
to bind processes to (groups of ) processors, to define the memory placement
policy, etc.

Yes, the initial placement is very much important. It affects tremendously the
performance you obtain.

Yet, what if
- the application changes its behavior over time ?
 (which processor uses which part of the memory)
- you have not got the source of the application ?
- you cannot add the NUMA services to it ?
- you are not authorized to touch it ? (e.g. it is a reference benchmark)

Page migration tries to help you out in these situations.

What can this service do ?
--------------------------

- Migrate pages identified by their physical addresses to another NUMA node
- Migrate pages of a virtual user address range to another NUMA node

How can it be used ?
--------------------

1. Hardware assisted migration
..............................

As you can guess, it is very much platform dependent.
I can only give you an example. Any advice on how to define a platform
independent interface will be appreciated.

We've got an Intel IA64 based machine for development / testing.
It consists of 4 "Tiger boxes" connected together by a pair of Scalability Port
Switches. A "Tiger box" is built around a Scalable Node Controller (SNC), and
includes 4 Itanium-2 processors and some Gbytes of memory.
The NUMA factor is 1 : 2.25.
The SNC contains 2048 counters which allow us to count how many times these 2048
zones of memory are touched from each node in a given observation period.
An "artificial intelligence" can make predictions from these usage statistics
and decide what pages are to be migrated and where.

(Unfortunately, the SNCs are buggy - even the version C.1 is - we've got to use
a couple of work-arounds, much of the work has to be done in software.
This wastes about 10 seconds of CPU time while executing a benchmark of
2 minutes. I hope, one day...)

2. Application driven migration
...............................

An application can exploit the forthcoming NUMA APIs to specify its initial
memory placement policy.
Yet what if the application wants to change its behavior ?

Allocating room on the destination node, copying the data by the application
itself, and finally freeing the original room of the data is not very efficient.

An application can ask the migration service to move a range of its virtual
address space to the destination node.

Example:
A process of an application prepares a huge amount of data and hands it over to
Its fellow processes (which happen to be bound to another NUMA node) for their
(almost) exclusive usage.
Migrating a page costs 128 remote accesses (assuming a page size of 16 Kbytes
and a bus transaction size of 128 bytes) + some administration.
Assuming the consumers of the data will frequently touch the page (cache misses)
a considerable number of times, say more that 1000 times, then the migration
becomes largely profitable.

3. NUMA aware scheduler
.......................

A NUMA aware scheduler tries to keep processes on their "home" node where they
have allocated (most of) their memory. What if the processors in this node are
overloaded while several processors in the other nodes are largely in idle ?

Should the scheduler select some other processors in the other nodes to execute
these processes, at the expense of considerable number of extra node
transactions ?
Or should the scheduler leave the processors in the other nodes doing nothing ?
Or should it move some processes with their memory working set to another node ?
Let's leave this dilemma for the NUMA aware scheduler for the moment.

Once the scheduler has made up its mind, the migration service can move the
working set of memory of the selected processes to their new "home" node.

User mode interface
-------------------

This prototype of the page migration service is implemented as a system call,
the different forms of which are wrapped by use of some small,
static, inline functions.

NAME
        migrate_ph_pages        - migrate pages to another NUMA node
        migrate_virt_addr_range - migrate virtual address range to another node

SYNOPSIS

        #include <sys/types.h>
        #include "page_migrate.h"

        int migrate_ph_pages(
                const phaddr_t * const table,
                const size_t length,
                const int node,
                struct _un_success_count_ * const p,
                const pid_t pid);

        int migrate_virt_addr_range(
                const caddr_t address,
                const size_t length,
                const int node,
                struct _un_success_count_ * const p,
                const pid_t pid);

DESCRIPTION

        The "migrate_ph_pages()" system call is used to migrate pages - their
        physical addresses of "phaddr_t" type are given in "table" - to "node".
        "length" indicates the number of the physical addresses in "table" and
        should not be greater than "PAGE_SIZE / sizeof(phaddr_t)".
        Only the pages belonging to the process indicated by "pid" and its
        child processes cloned via "clone2(CLONEVM)" are treated, the other
        processes' pages are silently ignored.

        The "migrate_virt_addr_range()" system call is used to migrate pages of
        a virtual address range of "length" starting at "address" to "node".
        The virtual address range belongs to the process indicated by "pid" and
        to its cloned children. If "pid" is zero then the current
        process's virtual address range is moved.

        Some statistics are returned via "p":

        struct _un_success_count_ {
                unsigned int    successful;     // Pages successfully migrated
                unsigned int    failed;         // Minor failures
        };

RETURN VALUE

        "migrate_ph_pages()" and "migrate_virt_addr_range()" return 0 on
        success, or -1 if a major error occurred (in which case, "errno" is set
        appropriately). Minor errors are silently ignored (migration continues
        with the rest of the pages).

ERRORS

        ENODEV:         illegal destination node
        ESRCH:          no process of "pid" can be found
        EPERM:          no permission
        EINVAL:         invalid system call parameters
        EFAULT:         illegal virtual user address
        ENOMEM:         cannot allocate memory

RESTRICTIONS

        We can migrate a page if it belongs to a single "mm_struct" / PGD,
        i.e. it is private to a process or shared with its child processes
        cloned via "clone2(CLONEVM)".

Notes:

- A "major error" prevents us from carrying on the migration, but it is not a
  real error for the "victim" application that can continue (it is guaranteed
  not to be broken). The pages already migrated are left in their new node.

- Migrating a page shared among other than child processes cloned via
  "clone2(CLONEVM)" would require locking all the page owners' PGDs.
  I've got serious concerns about locking more than one PGDs:
  + It is not foreseen in the design of the virtual memory management.
  + Obviously, the PGDs have to be "trylock()"-ed in order to avoid dead locks.
    However, "trylock()"-ing lots of PGDs, possibly thousands of them, would
    lead to starvation problems. A performance enhancement tool consuming so
    much in the event of not concluding...

Some figures
------------

One of our customers has an OpenMP benchmark which was used to measure the
machine described above. It uses 1 Gbytes of memory and runs on 16 processors,
on 4 NUMA nodes.

If the benchmark is adapted to our NUMA architecture, then it takes 86 seconds
to complete.

As results are not accepted if obtained by modifying the benchmark in any
way, the best we can do is to use a random or round robin memory allocation
policy. We end up with a locality rate of 25 % and the benchmark executes in 121
seconds.

If we had a zero-overhead migration tool, then - I estimate - it would complete
In 92 seconds (the benchmark starts in a "pessimized" environment, and it takes
time for the locality ramp up from 25 % to almost 100 %).

Actually it takes 2 to 3 seconds to move 750 Mbytes of memory (on a heavily
loaded machine), reading out the counters of the SNCs and making some quick
decisions take 1 to 2 seconds, and we lose about 10 seconds due to the buggy
SNCs. We end up with 106 seconds.

Some if's
---------

- if the benchmark used more memory, then it would be more expensive to migrate
  all of it's pages
- if the benchmark ran for longer without changing its memory usage
  pattern, then it could spend a greater percentage of its lifetime in a well
  localized environment
- if you had a NUMA factor higher than ours, then obviously, you would gain
  more in performance by use of the migration service
- if we used Madison processors with 6 Mbytes of cache (twice as much we have
  right now), then the NUMA factor would be masked more efficiently
- if the clock frequency of the processors increases, then you run out of cached
  data more quickly and the NUMA factor becomes a higher performance cut factor

TODOs
------

As I have not got access to machines other than IA64 based ones, any help to
test page migration on other architectures will be appreciated.


I include some demo programs:
.............................

test/ph.c:	migrates some of its pages by use of their physical addresses
test/v.c:	migrates a part of its virtual address range
test/vmig.c:	migrates a part of the virtual address range of "test/victim.c"
test/migstat.c:	displays some internal counters if the kernel has been compiled
		with "_NEED_STATISTICS_" defined

I'll send the patch in the next letter.
Should the list refuse the patch due to its length, please pick it up at our
anonymous FTP server: ftp://visibull.frec.bull.fr/pub/linux/migration 

The patch is against:
	patch-2.6.4.-bk4 
	kdb-v4.3-2.6.3-common-b0
	kdb-v4.3-2.6.3-ia64-1

Your remarks will be appreciated.

Zoltan Menyhart
