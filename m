Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSKOICJ>; Fri, 15 Nov 2002 03:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSKOICI>; Fri, 15 Nov 2002 03:02:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40882 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265886AbSKOIBe>;
	Fri, 15 Nov 2002 03:01:34 -0500
Date: Fri, 15 Nov 2002 13:43:38 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115134338.C5088@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021115114012.A5088@in.ibm.com> <Pine.LNX.4.44.0211150225490.2750-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211150225490.2750-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Fri, Nov 15, 2002 at 02:40:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:40:10AM -0500, Zwane Mwaikambo wrote:
> On Fri, 15 Nov 2002, Dipankar Sarma wrote:
> > The RCU part is fairly simple - you want to avoid having to acquire
> > a lock for every NMI event to walk the handler so you do it
> > lockfree. If a process running in a different CPU tries to
> > free an nmi handler, it removes it from the list, issues an
> > rcu callback (to be invoked after all CPUs have gone through
> > a context switch or executed user-level code ensuring that the
> > deleted nmi handler can't be running) and waits for completion of
> 
> How are you so sure the handler isn't running? You can get an NMI after 
> any cpu instruction inbetween all of that happening, not to mention that 
> it can happen on multiple processors means since its a shared nmi handler 
> list, you're almost never going to find that list not being traversed at 
> some stage by a processor. Try synchronising the cpus for a removal when 
> they're all handling an NMI every millisecond.

Once you remove a handler from the list, any subsequent NMI is *not*
going to see the handler. So even if another CPU is executing the same
handler, if you wait for the RCU callback, you can guarantee that
no-one is executing the deleted handler. RCU will wait for all the
CPUs to context switch or execute user-level code atleast once.
That meant any other CPU which might have been executing the NMI
handler at the time of deletion has now exited from the handler.

> I don't think you can rely on completion() to ensure this. Its hardly an 

Corey's code doesn't rely on completion() to ensure this, it relies
on RCU to make sure that nobody is running the handler. The key is
that once the pointers between the prev and the next of the deleted
NMI handler are set, subsequent NMIs aren't going to see that handler.
context switch/user-level means that CPU must have exited any
NMI handler it may have been executing at the time of deletion.


> atomic operation in this context, whats wrong with spin_trylock(nmi_handler_lock) 
> and do an early bailout on failure?

spin_trylock modifies the lock cacheline, so cacheline bouncing.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
