Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317680AbSFRX7r>; Tue, 18 Jun 2002 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSFRX7q>; Tue, 18 Jun 2002 19:59:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45284 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317680AbSFRX7p>;
	Tue, 18 Jun 2002 19:59:45 -0400
Date: Wed, 19 Jun 2002 01:57:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>, <colpatch@us.ibm.com>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <1024443480.1514.33.camel@w-hbaum>
Message-ID: <Pine.LNX.4.44.0206190145580.28144-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jun 2002, Michael Hohnbaum wrote:

> A bit mask is a very good choice for the sched_setaffinity()
> interface.  [...]

thanks :)

> [...] I would suggest an additional argument be added
> which would indicate the resource that the process is to be
> affined to.  That way this interface could be used for binding
> processes to cpus, memory nodes, perhaps NUMA nodes, and, 
> as discussed recently in another thread, other processes.
> Personally, I see NUMA nodes as an overkill, if a process
> can be bound to cpus and memory nodes.

are you sure we want one generic, process-based affinity interface?

i think the affinity to certain memory regions might need to be more
finegrained than this. Eg. it could be useful to define a per-file
(per-inode) 'backing store memory node' that the file is affine to. This
will eg. cause the pagecache to be allocated in the memory node.
Process-based affinity does not describe this in a natural way. Another
example, memory maps: we might want to have a certain memory map (vma)  
allocated in a given memory node, independently of where the process that
is faulting a given pages resides.

and it might certainly make sense to have some sort of 'default memory
affinity' for a process as well, but this should be a different syscall -
it really does a much different thing than CPU affinity. The CPU resource
is 'used' only temporarily with little footprint, while memory usage is
often for a very long timespan, and the affinity strategies differ
greatly. Also, memory as a resource is much more complex than CPU, eg. it
must handle things like over-allocation, fallback to 'nearby' nodes if a
node is full, etc.

so i'd suggest to actually create a good memory-affinity syscall interface
instead of trying to generalize it into the simple, robust, finite
CPU-affinity syscalls.

	Ingo

