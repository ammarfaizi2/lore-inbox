Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292885AbSB0TEf>; Wed, 27 Feb 2002 14:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292888AbSB0TEO>; Wed, 27 Feb 2002 14:04:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5315 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292885AbSB0TDw>;
	Wed, 27 Feb 2002 14:03:52 -0500
Date: Wed, 27 Feb 2002 14:04:41 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Martin Wirth <Martin.Wirth@dlr.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semphores...
Message-ID: <20020227140441.A1573@elinux01.watson.ibm.com>
In-Reply-To: <3C7C9C41.5080400@dlr.de> <20020227102446.A838@elinux01.watson.ibm.com> <3C7D14B5.1020702@dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D14B5.1020702@dlr.de>; from Martin.Wirth@dlr.de on Wed, Feb 27, 2002 at 06:17:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 06:17:41PM +0100, Martin Wirth wrote:
> Hubertus Franke wrote:
> 
> > Again, the trick is to not
> > sync the state of the kernel and the user level. It comes naturally 
> > if you properly separate the duties.
> > 
> 
> Your code for usema_down is simply:
> 
> int usema_down(ulock_t *ulock)
> {
> 	if (!__ulock_down(ulock)) {
> 		return 0;
> 	}
> 	return ulock_wait(ulock,0);
> }
> 
> This means you do not recheck if the usema is really available after you 
> return form ulock_wait(), but you may have the following situtation:

Not so. First remember the following:

__ulock_down is basically an 
	atomic_dec(&lockword) and returns 0 if lockword after decrement
        is < 0. 

__ulock_up   is basically a
	atomic_inc(&lockword) and returns 0 if lockword after increment
	is >= 0.

After each line I print the value of the lockword after the atomic op.
I assume initial value was "1". Initial value of kernel semaphore is "0".
Let's write this as [ 1, 0 ] state (user,kernel).

> 
> Process 1             Process 2                        Process 3
>   down
    [ 0, 0 ]
> 
>                        down
	                 [ -1, 0 ]
>                          -> call usema_wait
>                          but gets preempted shortly
>                          before it
>                          can enter kernel mode
> 
>   up
    [ 0, 0 ] now signal the kernel but nobody waiting on it yet
    [ 0, 1 ] kernel stores the signal token in its state
>    (kernel sema is free)
    [ 0, 1 ] kernel stores the signal token in its state
> 
>                                                           down -> got it
						(not so........ )
						[-1,1]
						you don't have the lock
						as __ulock_down return !=0
						you are going to call the 							kernel ulock_wait	
	
Two scenarios now:  either P3 get's there first to the kernel or P2.
P3 first.

						[-1,1] (start state from above)
						wait in kernel is through down
						that will succeed and eat 
						the kernel sem token and
						continue out of kernel
						holding the lock
						[-1,0]

			P2 rescheduled..
			down in the kernel
			will block the process
			[ -1, -1 ]

P2 first, assuming that P3 too got preempted before the kernel call 
		("Shit Happens", Forrest Gump)

		
			[-1,1] (start state from above)
			wait in kernel is through down
			that will succeed and eat 
			the kernel sem token and
			continue out of kernel
			holding the lock
			[-1,0]

						P3 rescheduled..
						down in the kernel
						will block the process
			[ -1, -1 ]


Any UP call now will ditch into the kernel and signal the waiting process
to continue, handing the lock over to it.
			[ 0, 0 ]
> 
> 
>                        resume execution,
>                        thinks its also got it
>                        because kernel sema is free!

So, it works and is correct. Hope that clarifies it, if not let me know.
Interestingly enough. This scheme doesn't work for spinning locks.
Goto lib/ulocks.c[91-133], I have integrated this dead code here
to show how not to do it. A similar analysis as above shows
that this approach wouldn't work. You need cmpxchg for these scenarios
(more or less).

> 
> Now you have two owners!!
> 

Not so,  QED.

> 
> Martin Wirth
> 
> 

-- Hubertus Franke 		(frankeh@watson.ibm.com)

> 
