Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSFSXuT>; Wed, 19 Jun 2002 19:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSFSXuS>; Wed, 19 Jun 2002 19:50:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27309 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318063AbSFSXuN>;
	Wed, 19 Jun 2002 19:50:13 -0400
Subject: Re: latest linus-2.5 BK broken
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0206190145580.28144-100000@e2>
References: <Pine.LNX.4.44.0206190145580.28144-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jun 2002 16:48:46 -0700
Message-Id: <1024530532.1543.59.camel@w-hbaum>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 16:57, Ingo Molnar wrote:
> 
> On 18 Jun 2002, Michael Hohnbaum wrote:
> 
> > [...] I would suggest an additional argument be added
> > which would indicate the resource that the process is to be
> > affined to.  That way this interface could be used for binding
> > processes to cpus, memory nodes, perhaps NUMA nodes, and, 
> > as discussed recently in another thread, other processes.
> > Personally, I see NUMA nodes as an overkill, if a process
> > can be bound to cpus and memory nodes.
> 
> are you sure we want one generic, process-based affinity interface?

No, I'm not sure that is what we want.  I see that as a compromise
solution.  Something that would allow some of the simple binding
capabilities, but not necessarily a full blown solution.  

I agree with your comments below that memory binding/allocation is
much more complex than CPU binding, so additional flexibility in
specifying memory binding is needed.  However, wanting to start
simple, the first step is to affine a process to memory on one or
more nodes.


> i think the affinity to certain memory regions might need to be more
> finegrained than this. Eg. it could be useful to define a per-file
> (per-inode) 'backing store memory node' that the file is affine to. This
> will eg. cause the pagecache to be allocated in the memory node.
> Process-based affinity does not describe this in a natural way. Another
> example, memory maps: we might want to have a certain memory map (vma)  
> allocated in a given memory node, independently of where the process that
> is faulting a given pages resides.
> 
> and it might certainly make sense to have some sort of 'default memory
> affinity' for a process as well, but this should be a different syscall -

This is close to what is currently implemented - memory is allocated, 
by default on the node that the process is executing on when the request
for memory is made.  Even if a process is affined to multiple CPUs that
span node boundaries, it is performant to dispatch the process on only
one node (providing the cpu cycles are available).  The NUMA extensions
to the scheduler try to do this.  Similarly, all memory for a process
should be allocated from that one node.  If memory is exhausted on
that node, any other nodes that the process has affinity to cpus on
should then be used.  In other words, each process should have a home
node that is preferred for dispatch and memory allocation.  The process
may have affinity to other nodes, which would be used only if the home
quad had a significant resource shortage.

> it really does a much different thing than CPU affinity. The CPU resource
> is 'used' only temporarily with little footprint, while memory usage is
> often for a very long timespan, and the affinity strategies differ
> greatly. Also, memory as a resource is much more complex than CPU, eg. it
> must handle things like over-allocation, fallback to 'nearby' nodes if a
> node is full, etc.
> 
> so i'd suggest to actually create a good memory-affinity syscall interface
> instead of trying to generalize it into the simple, robust, finite
> CPU-affinity syscalls.

We have attempted to do that.  Please look at the API definition
http://lse.sourceforge.net/numa/numa_api.html  If it would help,
we could break out just the memory portion of this API (both in the
specification and the implementation) and submit those for comment.
What do you think?
> 
> 	Ingo
>

           Michael Hohnbaum
           hohnbaum@us.ibm.com
 


