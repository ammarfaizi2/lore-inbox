Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUGPG2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUGPG2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 02:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUGPG2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 02:28:00 -0400
Received: from holomorphy.com ([207.189.100.168]:48042 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266490AbUGPG1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 02:27:53 -0400
Date: Thu, 15 Jul 2004 23:27:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040716062732.GG3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714045640.GB1220@obelix.in.ibm.com> <20040714081737.N1973@build.pdx.osdl.net> <200407151022.53084.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407151022.53084.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 14, 2004 11:17 am, Chris Wright wrote:
>> I'm curious, how much of the performance improvement is from RCU usage
>> vs. making the basic syncronization primitive aware of a reader and
>> writer distinction?  Do you have benchmark for simply moving to rwlock_t?

On Thu, Jul 15, 2004 at 10:22:53AM -0400, Jesse Barnes wrote:
> That's a good point.  Also, even though the implementation may be 'lockless', 
> there are still a lot of cachelines bouncing around, whether due to atomic 
> counters or cmpxchg (in fact the latter will be worse than simple atomics).
> It seems to me that RCU is basically rwlocks on steroids, which means that 
> using it requires the same care to avoid starvation and/or other scalability 
> problems (i.e. we'd better be really sure that a given codepath really should 
> be using rwlocks before we change it).

Primarily not for either of your benefit(s):

files->lock actually started as an rwlock and was changed to a spinlock
on the grounds that cmpxchg for rwlocks sucked on Pentium 4.

Typical rwlock implementations don't have such starvation issues.
Normally attempts at acquiring them for write exclude new readers with
various forms of bias. Linux has come to rely on an unfair
implementation by means of recursion, both directly (I hear somewhere
in the net stack and haven't looked) and via recursive acquisition in
interrupt context (for signal delivery). The unfairness does cause
problems in practice, e.g. writers starving on tasklist_lock takes out
machines running large numbers of processes.

RCU does not have such fairness issues. While it is heavily read
biased, readers do not exclude writers. Things can, however, delay
freeing of memory if tasks don't voluntarily yield for long periods
of time (e.g. involuntary context switches caused by kernel preemption)
as the freeing of the data structures potentially referenced by readers
must be delayed until all cpus have gone through a voluntary context
switch. This generally resolves itself as waiting for memory involves a
voluntary context switch. Readers merely disable preemption, and only
writers require atomicity or mutual exclusion, which is more typical in
Linux in part owing to preferred data structures. I suspect this is in
part due to its initial usage for doubly-linked lists that are never
traversed backward. RCU is actually a lockless update protocol and can
be done with atomic updates on the write side as opposed to spinlocks
around the updates. This happily doesn't involve busywait on machines
able to implement such things directly, but also depends heavily on the
data structure.

For instance, an open-addressed hash table or a 4-way associative cache
could simply atomically update the pointers to the elements. To see why
things get much harder when you try to go completely lockfree with less
suitable data structures, a singly-linked list would require a cmpxchg
loop inside a retry loop, temporarily marking next pointers with some
invalid value that signals accessors to retry the read operation, and
some external method of preventing simultaneous removals of the same
element (e.g. refcounting), as the next pointer of the predecessor must
be what was expected during removal, the removed element's next pointer
remain be what was expected, and the updated predecessor must be what
was discovered in the list, and more still for cpus not supporting
cmpxchg or similar operations, though that's probably not an entirely
complete or accurate description of the headaches involved when the
data structure doesn't mesh well with lock-free atomic updates. The
gist of all this is that busywait-free atomic updates are only
implementable for data structures that don't link through the object
but rather maintain an external index with a single pointer to elements
needing updates, like radix trees, B+ trees, arrays of pointers, and
open-addressed hashtables. Otherwise, spinlocks on the write side are
probably better than the completely lock-free alternative for smaller
systems, though larger systems hate sharing the cachelines.


-- wli
