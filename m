Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSKOHkL>; Fri, 15 Nov 2002 02:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSKOHkL>; Fri, 15 Nov 2002 02:40:11 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:65035
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265647AbSKOHkL>; Fri, 15 Nov 2002 02:40:11 -0500
Date: Fri, 15 Nov 2002 02:40:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       John Levon <levon@movementarian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: NMI handling rework for x86
In-Reply-To: <20021115114012.A5088@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0211150225490.2750-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Dipankar Sarma wrote:

> The RCU part is fairly simple - you want to avoid having to acquire
> a lock for every NMI event to walk the handler so you do it
> lockfree. If a process running in a different CPU tries to
> free an nmi handler, it removes it from the list, issues an
> rcu callback (to be invoked after all CPUs have gone through
> a context switch or executed user-level code ensuring that the
> deleted nmi handler can't be running) and waits for completion of

How are you so sure the handler isn't running? You can get an NMI after 
any cpu instruction inbetween all of that happening, not to mention that 
it can happen on multiple processors means since its a shared nmi handler 
list, you're almost never going to find that list not being traversed at 
some stage by a processor. Try synchronising the cpus for a removal when 
they're all handling an NMI every millisecond.

> the callback. The rcu callback handler wakes it up.
> It is all hidden under list_add_rcu()/list_del_rcu() and __list_for_each_rcu().

I don't think you can rely on completion() to ensure this. Its hardly an 
atomic operation in this context, whats wrong with spin_trylock(nmi_handler_lock) 
and do an early bailout on failure?

	Zwane
-- 
function.linuxpower.ca

