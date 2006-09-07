Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWIGWKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWIGWKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIGWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:10:09 -0400
Received: from spirit.analogic.com ([204.178.40.4]:57102 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932079AbWIGWKG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:10:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 07 Sep 2006 22:10:05.0134 (UTC) FILETIME=[5F560EE0:01C6D2CA]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
Subject: Re: Uses for memory barriers
Date: Thu, 7 Sep 2006 18:10:04 -0400
Message-ID: <Pine.LNX.4.61.0609071728400.29915@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.44L0.0609071549340.6535-100000@iolanthe.rowland.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Uses for memory barriers
thread-index: AcbSyl9fInmzV9NqQBmk5/mNS6ByQg==
References: <Pine.LNX.4.44L0.0609071549340.6535-100000@iolanthe.rowland.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "David Howells" <dhowells@redhat.com>,
       "Kernel development list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Sep 2006, Alan Stern wrote:

> Paul:
>
> Here's something I had been thinking about back in July but never got
> around to discussing:  Under what circumstances would one ever want to use
> "mb()" rather than "rmb()" or "wmb()"?
>
> The canonical application for memory barriers is where one CPU writes two
> locations and another reads them, to make certain that the ordering is
> preserved (assume everything is initially equal to 0):
>
> 	CPU 0			CPU 1
> 	-----			-----
> 	a = 1;			y = b;
> 	wmb();			rmb();
> 	b = 1;			x = a;
> 				assert(x==1 || y==0);
>
> In this situation the first CPU only needs wmb() and the second only needs
> rmb().  So when would we need a full mb()?...
>
> The obvious extension of the canonical example is to have CPU 0 write
> one location and read another, while CPU 1 reads and writes the same
> locations.  Example:
>
> 	CPU 0			CPU 1
> 	-----			-----
> 	while (y==0) relax();	y = -1;
> 	a = 1;			b = 1;
> 	mb();			mb();
> 	y = b;			x = a;
> 				while (y < 0) relax();
> 				assert(x==1 || y==1);	//???
>
> Apart from the extra stuff needed to make sure that CPU 1 sees the proper
> value stored in y by CPU 0, this is just like the first example except for
> the pattern of reads and writes.  Naively one would think that if the
> first half of the assertion fails, so x==0, then CPU 1 must have completed
> all of the first four lines above by the time CPU 0 completed its mb().
> Hence the assignment to b would have to be visible to CPU 0, since the
> read of b occurs after the mb().  But of course we know that naive
> reasoning isn't always right when it comes to the operation of memory
> caches.
>
> The opposite approach would use reads followed by writes:
>
> 	CPU 0			CPU 1
> 	-----			-----
> 	while (x==0) relax();	x = -1;
> 	x = a;			y = b;
> 	mb();			mb();
> 	b = 1;			a = 1;
> 				while (x < 0) relax();
> 				assert(x==0 || y==0);	//???
>
> Similar reasoning can be applied here.  However IIRC, you decided that
> neither of these assertions is actually guaranteed to hold.  If that's the
> case, then it looks like mb() is useless for coordinating two CPUs.
>
> Am I correct?  Or are there some easily-explained situations where mb()
> really should be used for inter-CPU synchronization?
>
> Alan
>

It's simpler to understand if you know what the underlying problem
may be. Many modern computers don't have direct, interlocked, connections
to RAM anymore. They used to be like this:

                 CPU0            CPU1
                 cache           cache
                 [memory controller]
                         |
                       [RAM]

The memory controller handled the hardware to make sure that reads
and writes didn't occur at the same time and a read would be held-off
until a write completed. That made sure that each CPU read what was
last written, regardless of who wrote it.

The situation is not the same anymore. It's now like this:

                CPU0            CPU1
                cache           cache
                 |                |
             [serial link]  [serial link]
                 |                |
                 |                |
                 |________________|
                         |
                 [memory controller]
                         |
                       [RAM]

The serial links have a common characteristic: writes can be
queued, but a read forces all writes to complete before the
read occurs. Nothing is out of order [1], as seen by an individual
CPU, but you could have some real bad problems if you didn't
realize that the other CPUs' writes might get interleaved with
your CPU's writes!

So, if it is important what another CPU may write to your
variable, you need a memory-barrier which tells the compiler
to not assume that the variable just written contains the
value just written! It needs to read it again so that all
pending writes from anybody are finished before using
that memory value. Many times it's not important because
your variable may already be protected by a spin-lock so
it's impossible for any other CPU to muck with it. Other
times, as in the case of spin-locks themselves, memory
barriers are very important to make the lock work.

In your example, you cannot tell *when* one CPU may have
written to what you are reading. What you do know is
that the CPU that read a common variable, will read the
value that exists after all pending writes have occurred.
Since you don't know if there were any pending writes, you
need to protect such variables with spin-locks anyway.
These spin-locks contain the required memory barriers.

[1] Some CPUs now implement a 'sfence' instruction. Since
write combining can occur as a hardware optimization, this
can make it look to hardware as though writes occurred out-of
order. This only affects what the hardware 'sees' not what
any CPU sees. If write ordering is important (it may be when
setting up DMA for instance, where the last write is
supposed to be the one that starts the DMA), then a 'sfence'
instruction should occur before such important writes. For
CPUs that don't have such an instruction, just read something
in the same address-space to force all pending writes to complete.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
