Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264409AbRFON0v>; Fri, 15 Jun 2001 09:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264410AbRFON0b>; Fri, 15 Jun 2001 09:26:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264409AbRFON00>; Fri, 15 Jun 2001 09:26:26 -0400
Date: Fri, 15 Jun 2001 09:26:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Schwartz <davids@webmaster.com>
cc: Roger Larsson <roger.larsson@norran.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: SMP spin-locks
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKGEDMPOAA.davids@webmaster.com>
Message-ID: <Pine.LNX.3.95.1010615085030.26603A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2001, David Schwartz wrote:

> 
> > Spinlocks are machine dependent. A simple increment of a byte
> > memory variable, spinning if it's not 1 will do fine. Decrementing
> > this variable will release the lock. A `lock` prefix is not necessary
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > because  all Intel byte operations are atomic anyway. This assumes
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > that the lock was initialized to 0. It doesn't have to be. It
> > could be initialized to 0xaa (anything) and spin if it's not
> > 0xab (or anything + 1).
> 
> 	If this is true, atomicity isn't enough to do it. Atomicity means that
> there's a single instruction (and so it can't be interrupted mid-modify).
> Atomicity (at least as the term is normally used) doesn't prevent the
> cache-coherency logic from ping-ponging the memory location between two
> processor's caches during the atomic operation.
> 
> 	DS

Try it. You'll like it. There are no simultaneous accesses from
different CPUs to any address space of any kind on an Intel-based
SMP machine. That is a fact. This is because there is only one
group of decodes for this address space. This applies for both memory
and I/O. Basically, the bus even though it may be broken into
several units of different speeds, operates as a unit. So, only
one operation can be occurring at any instant. 

Now, suppose you have a DSP that accesses it's own memory. It's
on a different board than the main CPU. You provide a mechanism
whereby your CPU can share a portion (or all) of this memory.
For this, you "dual-port" the memory, or you access it via a
PCI bus. Anyway, the DSP's memory now appears in your address
space. When you access this memory at a time that the DSP could
be writing to it, you need a `lock` prefix. Also hardware needs
to handle the #LOCK signal properly or you may get some funny
values from the DSP.

As shown in the '486 manual, if you perform a read/modify/write
operation you may need a lock prefix. Unlike CPUs that can only
perform load and store operations upon memory, the ix86 can
perform many operations directly. Amongst many of these wonderful
instructions is the ability to increment or decrement a byte anywhere
in memory. The CPU does not perform a read/modify/write operation
in the general sense when it does this. Instead, the data is read,
modified, and written in a single bus cycle. There is no way
that another CPU can access the bus in between these operations.
Memory access instructions that are complete in a single bus cycle
(this is not a single CPU clock), would never need a lock prefix.
The lock-prefix executes in only a single CPU clock.

The idea is not to get rid of this. The idea is to get rid of the
awful spin_lock_irqsave()/ spin_lock_irqrestore() code that has grown
like some virus and replace it with simple working code that
does not use a seperate segment for the spinning, etc.

Also, the cache of all CPUs "knows" when a write within its cache-line
has occurred so the next CPU will correctly see the result of
the previous operation. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


