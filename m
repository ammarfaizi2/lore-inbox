Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbREXN7U>; Thu, 24 May 2001 09:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbREXN7K>; Thu, 24 May 2001 09:59:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:46322 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S261980AbREXN64>; Thu, 24 May 2001 09:58:56 -0400
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@redhat.com
Subject: Task Ornaments [was Re: Win32 Kernel Module]
In-Reply-To: Your message of "Fri, 18 May 2001 08:51:06 EDT."
             <Pine.LNX.4.33.0105180848350.13012-100000@devserv.devel.redhat.com> 
Date: Thu, 24 May 2001 14:58:54 +0100
Message-ID: <11089.990712734@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar <mingo@redhat.com> wrote:
> i saw (and like) the ornaments stuff, and TUX could use it too: right now
> TUX has an extra field in task_struct to do exit()-time deregistering of
> processes. Linus suggested to use a more generic mechanizm. I think some
> already existing things, like the SysV semaphore exit()-time cleanup
> feature can be handled with the ornaments feature as well.

I was thinking about this, and have come up with another possible way of using
task ornaments:

What if the SIGCHLD notification mechanism used it too?:

 (1) When a process forks a child, it would insert an ornament into that
     child's ornament list. This ornament would points back to itself.

 (2) This ornament overloads the signal and exit methods of the ornament, and
     would use these to obtain notification of death signals, stop signals and
     exits from the child (on which basis it can raise SIGCHLD in the parent
     process).

 (3) If a debugger attaches to a process, it would insert an ornament in front
     of the one inserted by the parent.

 (4) This ornament would allow the child's signals to be intercepted, and
     would permit the following operations to be performed:

     (a) raising SIGCHLD (or some other signal) in the debugger process and/or
	 releasing of suspended wait() calls.

     (b) cancellation of the signal (so the child doesn't receive it),

     (c) prevention of propagation to ornaments further along the list.

     This would allow the debugger to attach _without_ reparenting the
     process.

 (5) If a debugger want's to follow-fork, then the fork notification method
     can be overloaded in it's ornament to stick an ornament into the forked
     grandchild.

 (6) If the process's parent dies, then

     (a) the process can be reparented to init, and the ornament can be simply
	 removed.

     (b) the ornament can be pointed instead to another thread of the same
	 group.

If this is worthwhile doing, it may well be worth simplifying the notification
iteration functions to lock the task_struct, notify all ornaments (removing
those that indicate that they should be removed), drop the lock and reschedule
if necessary.

This means that a task ornament can't add more task ornaments to the same
process, but I'm not sure this matters.

It may also be worth saying that all task ornaments have to be a particular
size, and using the slab memory stuff to manage them, rather than embedding
them as I currently envisiage, particularly as there'd be quite a lot of them.

	struct task_ornament {
		struct task_ornament_ops *to_ops;
		struct list_head *to_list;
		void *to_private;
	}

David
