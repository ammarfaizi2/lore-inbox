Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSKOITD>; Fri, 15 Nov 2002 03:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSKOITC>; Fri, 15 Nov 2002 03:19:02 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:19724
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265982AbSKOIS4>; Fri, 15 Nov 2002 03:18:56 -0500
Date: Fri, 15 Nov 2002 03:18:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       John Levon <levon@movementarian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: NMI handling rework for x86
In-Reply-To: <20021115134338.C5088@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0211150307240.2750-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Dipankar Sarma wrote:

> Once you remove a handler from the list, any subsequent NMI is *not*
> going to see the handler. So even if another CPU is executing the same
> handler, if you wait for the RCU callback, you can guarantee that
> no-one is executing the deleted handler. RCU will wait for all the
> CPUs to context switch or execute user-level code atleast once.

I think you're confusing NMI handling, they aren't like your normal 
interrupts. You're not going to see that context switch.

> That meant any other CPU which might have been executing the NMI
> handler at the time of deletion has now exited from the handler.
> 
> > I don't think you can rely on completion() to ensure this. Its hardly an 
> 
> Corey's code doesn't rely on completion() to ensure this, it relies
> on RCU to make sure that nobody is running the handler. The key is
> that once the pointers between the prev and the next of the deleted

Can you change prev and next atomically?

> NMI handler are set, subsequent NMIs aren't going to see that handler.
> context switch/user-level means that CPU must have exited any
> NMI handler it may have been executing at the time of deletion.

Again, are you mistaking this for a normal interrupt?

> > atomic operation in this context, whats wrong with spin_trylock(nmi_handler_lock) 
> > and do an early bailout on failure?
> 
> spin_trylock modifies the lock cacheline, so cacheline bouncing.

At a fair interrupt rate i'd rather have that fill my caches, less time 
spent in the NMI handler means more overall system time.

	Zwane
-- 
function.linuxpower.ca

