Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSE1RYp>; Tue, 28 May 2002 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSE1RYo>; Tue, 28 May 2002 13:24:44 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:35561 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316847AbSE1RYn>; Tue, 28 May 2002 13:24:43 -0400
Date: Tue, 28 May 2002 19:24:01 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com, andrea@suse.de
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020528192401.A29950@averell>
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com> <20020528182806.A21303@in.ibm.com> <20020528.054043.06045639.davem@redhat.com> <m3bsb06zt7.fsf@averell.firstfloor.org> <1022605393.9255.116.camel@irongate.swansea.linux.org.uk> <20020528183409.A23001@averell> <1022609447.4123.126.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 08:10:47PM +0200, Alan Cox wrote:
> On Tue, 2002-05-28 at 17:34, Andi Kleen wrote:
> > And gain tons of new atomic_incs and decs everywhere in the process?  
> > I would prefer RCU. 
> 
> RCU is a great way to make sure people get module unloading *wrong*. It
> has to be simple for the driver authors. The odd locked operation on
> things like open() of a device file is not a performance issue, not
> remotely. 

open() of device file is not the problem. The problem are lots of other
data structures that gain module owners and atomic counters all the time.

> 
> Lots of people write drivers, many of them not SMP kernel locking gurus
> who have time to understand RCU and when they can or cannot sleep, and
> what happens if their unload is pre-empted and RCU is in use. The kernel

The current RCU patch doesn't kick in for preemption, so preemption is 
a non issue.

They have to understand when things can or cannot sleep. Without that
I think they shouldn't write linux drivers, because they will get many things
wrong (like spinlocks or even interrupt disabling in 2.5) 

With the "simple" module unload RCU variant you just stick a 
synchronize_kernel() after the module destructor call

It's also no problem for them to sleep in the destructor, the simple
variant obviously makes no difference here. It also doesn't change any sleeping
rules; or at least they are not different than in 2.0/2.2.

Just this simple variant plugs a lot of the races and would allow dropping
some module counts. It also makes all the nasty "cannot do MOD_*USE_COUNT in
the driver code itself" issues go away.

The remaining hole is driver reentering while the cleanup runs. The simple
rcu unload assumes that open and cleanup are atomic to each other, which
is usually not true. Fixing that properly likely requires two stage 
cleanup as proposed by Rusty/Kaos. 

Still given that the simple variant is not a complete solution, just making
the issue of not being able to do MOD_*_COUNT in driver code go away would
be imho a bit step forward. In fact following your initial point it would
make some code much more obvious to device driver writers.

-Andi
