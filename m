Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbSKORet>; Fri, 15 Nov 2002 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266585AbSKORet>; Fri, 15 Nov 2002 12:34:49 -0500
Received: from [130.88.200.94] ([130.88.200.94]:26640 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S266584AbSKORep>;
	Fri, 15 Nov 2002 12:34:45 -0500
Date: Fri, 15 Nov 2002 17:41:22 +0000
From: John Levon <levon@movementarian.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115174122.GA83229@compsoc.man.ac.uk>
References: <20021115134338.C5088@in.ibm.com> <Pine.LNX.4.44.0211150307240.2750-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211150307240.2750-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18CkT4-000NSM-00*iai.7rUdd8U* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 03:18:22AM -0500, Zwane Mwaikambo wrote:

> > Once you remove a handler from the list, any subsequent NMI is *not*
> > going to see the handler. So even if another CPU is executing the same
> > handler, if you wait for the RCU callback, you can guarantee that
> > no-one is executing the deleted handler. RCU will wait for all the
> > CPUs to context switch or execute user-level code atleast once.
> 
> I think you're confusing NMI handling, they aren't like your normal 
> interrupts. You're not going to see that context switch.

The dangerous part is when a particular NMI interrupt is holding a
reference to the removed item on the list. Now, after *every* CPU has
been through a normal schedule, none of them can still be running /that
particular/ NMI interrupt: the fact they can be running other NMIs
constantly is neither here nor there, as newly generated NMIs can't see
the deleted element anyway.

> > Corey's code doesn't rely on completion() to ensure this, it relies
> > on RCU to make sure that nobody is running the handler. The key is
> > that once the pointers between the prev and the next of the deleted
> 
> Can you change prev and next atomically?

As long as they're naturally aligned.

> > NMI handler are set, subsequent NMIs aren't going to see that handler.
> > context switch/user-level means that CPU must have exited any
> > NMI handler it may have been executing at the time of deletion.
> 
> Again, are you mistaking this for a normal interrupt?

Zwane you're going to have describe a race if you think you can see one
- neither I nor Dipankar follow your point

> At a fair interrupt rate i'd rather have that fill my caches, less time 
> spent in the NMI handler means more overall system time.

-EPARSE. You will spend more time in the NMI handlers bouncing the line
across. 

regards
john
-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
