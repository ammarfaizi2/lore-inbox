Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUGQA42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUGQA42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUGQA42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:56:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:24771 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266572AbUGQA4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:56:24 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup 
In-reply-to: Your message of "Thu, 15 Jul 2004 23:27:32 MST."
             <20040716062732.GG3411@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Jul 2004 10:55:59 +1000
Message-ID: <903.1090025759@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004 23:27:32 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>The gist of all this is that busywait-free atomic updates are only
>implementable for data structures that don't link through the object
>but rather maintain an external index with a single pointer to elements
>needing updates, like radix trees, B+ trees, arrays of pointers, and
>open-addressed hashtables.

There are algorithms for busywait-free (lock free) traversal and
concurrent update of lists and structures that contain embedded
pointers.  I once had to implement one on an O/S where the user space
to kernel wait/alarm semantics could not satisfy the timing
requirements of the calling code (don't ask).

The beauty of these lockfree algorithms on large structures is that
nothing ever stalls indefinitely.  If the underlying SMP cache hardware
is fair, everything running a lockfree list will make progress.  These
algorithms do not suffer from reader vs. writer starvation.

The downside is that the algorithms rely on an extra sequence field per
word.  They copy out the structure, modify the local copy, write back
with an update of sequence field.  Writing back detects if any other
update has invalidated the current structure, at which point the second
update is discarded and the writer redrives its update.  Readers are
guaranteed to see a consistent view of the copy, even if the master
structure is being updated at the same time as it is being read.

Bottom line, it can be done but ...

* The structure size doubles with the addition of the sequence fields.
* The hardware must support cmpxchg on the combination of the sequence
  field and the data word that it protects.  LL/SC can be used instead
  of cmpxchg if the hardware supports LL/SC.
* If the hardware only supports cmpxchg4 then the sequence field is
  restricted to 2 bytes, which increases the risk of wraparound.  If an
  update is delayed for exactly the wraparound interval then the data
  may be corrupted, that is a standard risk of small sequence fields.
* The extra copy out just to read a structure needs more memory
  bandwidth, plus local allocation for the copy.
* The internal code of the API to traverse a list containing lockfree
  structures is pretty messy, although that is hidden from the caller.
* All writers must preserve enough state to redrive their update from
  scratch if a concurrent update has changed the same structure.  Note,
  only the curent structure, not the rest of the list.
* It requires type stable storage.  That is, once a data area has been
  allocated to a particular structure type, it always contains that
  structure type, even when it has been freed from the list.  Each list
  requires its own free pool, which can never be returned to the OS.

Nice research topics, but not suitable for day to day work.  I only
used the lockfree algorithms because I could not find an alternative on
that particular OS.  I am not sure that the Linux kernel has any
problems that require the additional complexity.

For some light reading, the code I implemented was based on Practical
Implementations of Non-Blocking Synchronization Primitives by Mark Moir
http://research.sun.com/scalable/Papers/moir-podc97.ps.  Note that page
6, line 6 has an error.  Replace "y := z" with "y := addr->data[i];".

I implemented a completely lockfree 2-3-4 tree with embedded pointers
using Moir's algorithm.  The implementation allowed multiple concurrent
readers and writers.  It even allowed concurrent list insert, delete
and rebalancing, while the structures on the were being read and
updated.

2-3-4 trees are self balancing, which gave decent lookup performance.
Since red-black trees are logically equivalent to 2-3-4 trees it should
be possible to use lockfree red-black trees.  However I could not come
up with a lockfree red-black tree, mainly because an read-black insert
requires atomic changes to multiple structures.  The 2-3-4 tree only
needs atomic update to one structure at a time.

