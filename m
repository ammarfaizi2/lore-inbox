Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVLZP3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVLZP3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 10:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVLZP3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 10:29:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21346 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750830AbVLZP3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 10:29:51 -0500
Date: Mon, 26 Dec 2005 10:29:50 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051225150445.0eae9dd7.akpm@osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, mingo@elte.hu,
       lkml <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       arjanv@infradead.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Message-id: <Pine.LNX.4.64.0512261011060.14654@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org>
 <200512251708.16483.zippel@linux-m68k.org>
 <20051225150445.0eae9dd7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2005, Andrew Morton wrote:

> Ingo has told me offline that he thinks that we can indeed remove the
> current semaphore implementation.
> 
> 90% of existing semaphore users get migrated to mutexes.
> 
> 9% of current semaphore users get migrated to completions.
> 
> The remaining 1% of semaphore users are using the counting feature.  We
> reimplement that in a mostly-arch-independent fashion and then remove the
> current semaphore implementation.  Note that there are no sequencing
> dependencies in all the above.

Great!  I'm glad you're amenable to such changes.  Especially the 
"remove the current semaphore implementation" part many people are 
complaining about for all sorts of reasons.

> Another example: Ingo's VFS stresstest which is hitting i_sem hard: it only
> does ~8000 ops/sec on an 8-way, and it's an artificial microbenchmark which
> is _designed_ to hit that lock hard.  So if/when i_sem is converted to a
> mutex, I figure that the benefits to ARM in that workload will be about a
> 0.01% performance increase.  ie: about two hours' worth of Moore's law in a
> dopey microbenchmark.

There is not only the question of cycles.  There is also kernel text 
size.  And _that_ is significant.  You could argue that only adding a 
function call for every mutex lock/unlock cannot be made smaller.  
However on ARM a function call is quite a costly operation with frame 
pointers, (and frame pointers are on by default on ARM otherwise the 
kernel is undebuggable).  So given that current semaphore fast path is 
inlined to save on the function call overhead, and given that on ARM the 
transition from semaphores to mutexes will shrink that from 8 
instruction down to 3 instructions, or even 2 instructions in some 
cases, will not only save cycles, but a bunch of kernel .text bytes as 
well without compromize on the cycle count.  This is therefore an all 
win situation for ARM.

> Also, there's very little point in adding lots of tricky arch-dependent
> code and generally mucking up the kernel source to squeeze the last drop of
> performance out of the sleeping lock fastpath.  Because if those changes
> actually make a difference, we've already lost - the code needs to be
> changed to use spinlocking.

Consider my text size argument above which is something I believe you 
value more.


Nicolas
