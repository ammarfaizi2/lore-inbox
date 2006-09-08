Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWIHSjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWIHSjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIHSjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:39:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:8970 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750741AbWIHSjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:39:13 -0400
Date: Fri, 8 Sep 2006 14:39:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <Pine.LNX.4.61.0609071728400.29915@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L0.0609081422350.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments, although they did not directly address the 
question I asked.

On Thu, 7 Sep 2006, linux-os (Dick Johnson) wrote:

> It's simpler to understand if you know what the underlying problem
> may be. Many modern computers don't have direct, interlocked, connections
> to RAM anymore. They used to be like this:
> 
>                  CPU0            CPU1
>                  cache           cache
>                  [memory controller]
>                          |
>                        [RAM]
> 
> The memory controller handled the hardware to make sure that reads
> and writes didn't occur at the same time and a read would be held-off
> until a write completed. That made sure that each CPU read what was
> last written, regardless of who wrote it.
> 
> The situation is not the same anymore. It's now like this:
> 
>                 CPU0            CPU1
>                 cache           cache
>                  |                |
>              [serial link]  [serial link]
>                  |                |
>                  |                |
>                  |________________|
>                          |
>                  [memory controller]
>                          |
>                        [RAM]
> 
> The serial links have a common characteristic: writes can be
> queued, but a read forces all writes to complete before the
> read occurs. Nothing is out of order [1], as seen by an individual
> CPU, but you could have some real bad problems if you didn't
> realize that the other CPUs' writes might get interleaved with
> your CPU's writes!

That's not the whole story.  An important aspect is that CPUs are free to 
execute instructions out-of-order.  In this code, even with a compiler 
barrier present:

	a = 1;
	barrier();
	b = 1;

the CPU is allowed to execute the write to b before the write to a.  It's
not clear whether or not this agrees with what you wrote above: "Nothing
is out of order, as seen by an individual CPU".

> So, if it is important what another CPU may write to your
> variable, you need a memory-barrier which tells the compiler
> to not assume that the variable just written contains the
> value just written!

My questions concern memory barriers only, not compiler barriers.

> It needs to read it again so that all
> pending writes from anybody are finished before using
> that memory value. Many times it's not important because
> your variable may already be protected by a spin-lock so
> it's impossible for any other CPU to muck with it. Other
> times, as in the case of spin-locks themselves, memory
> barriers are very important to make the lock work.
> 
> In your example, you cannot tell *when* one CPU may have
> written to what you are reading. What you do know is
> that the CPU that read a common variable, will read the
> value that exists after all pending writes have occurred.

That's not at all clear.  Exactly what does it mean for a write to be
pending?  Can't a read be satisfied right away from a CPU's local cache
even if another CPU has a pending write to the same variable?  (In the 
absence of instantaneous communication between processors it's hard to see 
how this could fail to be true.)

> Since you don't know if there were any pending writes, you
> need to protect such variables with spin-locks anyway.
> These spin-locks contain the required memory barriers.

The point of my question was to understand more precisely how memory
barriers work.  Saying that spinlocks should always be used, as they
contain all the required barriers, doesn't further my understanding at
all.

Alan Stern

