Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBVVmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBVVmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVBVVmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:42:18 -0500
Received: from alog0055.analogic.com ([208.224.220.70]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261279AbVBVVl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:41:56 -0500
Date: Tue, 22 Feb 2005 16:40:54 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Chris Friesen <cfriesen@nortel.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
In-Reply-To: <421B9C86.8090800@nortel.com>
Message-ID: <Pine.LNX.4.61.0502221619330.5460@chaos.analogic.com>
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
 <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no>
 <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com>
 <421B9018.7020007@nodivisions.com> <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl>
 <421B9C86.8090800@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Chris Friesen wrote:

> Horst von Brand wrote:
>> Anthony DiSante <theant@nodivisions.com> said:
>
>>> That's one of the things I asked a few messages ago.  Some people on the 
>>> list were saying that it'd be "really hard" and would "require a lot of 
>>> bookkeeping" to "fix" permanently-D-stated processes... which is 
>>> completely different than "impossible."
>> 
>> Most people here have little clue. It can't be done.
>
> I realize it would be extremely difficult if not impossible to do in the 
> current linux architecture, but I find it hard to believe that it is 
> technically impossible if one were allowed to design the system from scratch.
>

No. It has nothing to do with the architecture. These problems go
all the way back to the first multi-tasking systems.

> Maybe I'm on crack, but would it not be technically possible to have all 
> resource usage be tracked so that when a task tries to do something and 
> hangs, eventually it gets cleaned up?

It's not the "task" that's hung. That's just the symptoms. It's
the SHARED RESOURCE that is hung!  Once some task attempts
to use a shared resource, it must (somehow) get in-line so
that the it can use that task without somebody else coming
along and mucking with it. To get "in-line" means to
execute some kind of MUTEX. There are many kinds. VAXen
had a "lock manager", there are simple sleeping-loops using
semaphores, etc. Linux uses such loops, the two most
commonly used are "down()" and "up()".

Now, somebody needs a resource. It executes down(&semaphore);
once it gets control again, it has that resource. It attempts
to use that resource through a driver. The driver waits forever.
The resource is now permanently dorked --forever because its
driver is waiting forever. The user code never returns from
the driver so it can never execute up(&semaphore).

If you, somehow, grab hold of the program-counter (like
a long-jump), and force a return so that up(&semaphore) gets
executed, the wrong thread unlocks the semaphore but its
forever broken anyway because the resource it protects is
hung.

>
> We already handle cleaning up stuff for userspace (memory, file descriptors, 
> sockets, etc.).  Why not enforce a design that says "all entities taking a 
> lock must specify a maximum hold time".  After that time expires, they are 
> assumed to be hung, and all their resources (which were being tracked by some 
> system) get cleaned up.
>

Time won't do it. It's not a matter of "cleaning up" it's a matter
of not waiting forever in the first place. If you were able to
"clean up" by reinitializing the semaphores, etc., killing anything
that was attached,  etc., the next instance of attempting to use
that resource will hang the exact same way.

We are not talking about some broken semaphore code that sometimes
gets hung. We are talking about the resource it protects. The
semaphore code is fine.

> It would probably be complicated, slow, and generally not worth the effort. 
> But it seems at least technically possible.
>
> Chris
> -

The problem is not "Waiting in D state". That's the symptom.
The problem is waiting forever after a lock has been taken.
That is the problem.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
