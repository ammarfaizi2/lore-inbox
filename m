Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136447AbREDQEb>; Fri, 4 May 2001 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136438AbREDQEL>; Fri, 4 May 2001 12:04:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50840 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136437AbREDQEF>;
	Fri, 4 May 2001 12:04:05 -0400
Date: Fri, 4 May 2001 12:04:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <3AF2A1CC.C22A48E7@vnet.ibm.com>
Message-ID: <Pine.GSO.4.21.0105041138140.19970-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Todd Inglett wrote:

> Ok, I've got this isolated.  Here's the sequence of events:
> 
> 1.  Some process T (probably "top") opens /proc/N/stat.
> 2.  While holding tasklist_lock the proc code does a get_task_struct()
> to add a ref count to the page.
> 3.  Process N exits.
> 4.  The parent of process N exits.
> 5.  Process T reads from the open file.  This calls proc_pid_stat()
> which dereferences N's task_struct.  This is ok as Alexander points out
> because a reference is held.
> 6.  Using N's task_struct process T attempt to dereference the *parent*
> task struct.  It assumes this is ok because:

	Where?

> 	A) it is holding tasklist_lock so N cannot be reparented in a race.
> 	B) every process *always* has a valid parent.
> 
> But this is where hell breaks loose.  Every process has a valid parent
> -- unless it is dead and nobody cares.  Process N has already exited and
> released from the tasklist while its parent was still alive.  There was
> no reason to reparent it.  It just got released.  So N's task_struct has
> a dangling ptr to its parent.  Nobody is holding the parent task_struct,
> either.  When the parent died memory for its task_struct was released. 
> This is ungood.

	If N is dead all accesses should return -ENOENT. No matter what
happens with its parent.

> My opinion here is that this is proc's problem.  When we free a
> task_struct it could be "cleaned up" of dangling ptrs, but this is a
> hack to cover a bug in proc.
> 
> This is not isolated to the parent task_struct, either.  The task_struct
> mm is also dereferenced.  It is pretty easy to validate a parent
> task_struct ptr (just hold tasklist_lock and run the list to check if it
> is still valid -- might not be the *right* task, but it will still be
> valid).  However, how do you validate the mm is ok?

exit_mm() cleans task->mm. _Before_ the process dies. And it should do
that, for a lot of reasons. General principle: if you are doing
garbage-collection upon removal of the last reference - _remove_
that reference. Before you call destructor. Anything else is simply
asking for races.

Besides, all the exit_foo() can be done by a very alive kernel threads.
Suppose that exit_mm() didn't clean ->mm.  Well, here comes losetup(8).
It binds loop device to a file and starts a thread for handling requests.
Said thread is created by kernel_thread(9). Which is a wrapper for clone(2).
So far, so good, but that thread gets a VM of parent. I.e. losteup.
That is _not_ good. For one thing, it means full-blown MMU switch whenever
we switch to loop_thread. And that will cost you. Since loop_thread has
no business using the userland part of MMU state it calls exit_mm(9) (it
calls daemonize(9). which, in turn, calls exit_mm(9)).

That picture is typical for kernel threads. knfsd, drivers' helper threads,
you name it. And unlike the relatively tame case of loop_thread (there
we have serialization between loop_thread and parent that will not
let parent to exit before loop_thread will do up(&lo->lo_sem) which is
after the daemonize() call) in general we can very well have parent
dead and gone by the time when child calls exit_mm().

See the problem? Child is very much alive, it's the sole owner of pointer
to mm_struct and it calls exit_mm(). Leaving the pointer around is _not_
a good idea.


