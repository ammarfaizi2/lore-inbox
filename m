Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136361AbREDMex>; Fri, 4 May 2001 08:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136348AbREDMeo>; Fri, 4 May 2001 08:34:44 -0400
Received: from [32.97.182.101] ([32.97.182.101]:36032 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S136354AbREDMee>;
	Fri, 4 May 2001 08:34:34 -0400
Message-ID: <3AF2A1CC.C22A48E7@vnet.ibm.com>
Date: Fri, 04 May 2001 07:34:20 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <Pine.GSO.4.21.0105011236140.9771-100000@weyl.math.psu.edu> <3AF14555.8699881B@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've got this isolated.  Here's the sequence of events:

1.  Some process T (probably "top") opens /proc/N/stat.
2.  While holding tasklist_lock the proc code does a get_task_struct()
to add a ref count to the page.
3.  Process N exits.
4.  The parent of process N exits.
5.  Process T reads from the open file.  This calls proc_pid_stat()
which dereferences N's task_struct.  This is ok as Alexander points out
because a reference is held.
6.  Using N's task_struct process T attempt to dereference the *parent*
task struct.  It assumes this is ok because:
	A) it is holding tasklist_lock so N cannot be reparented in a race.
	B) every process *always* has a valid parent.

But this is where hell breaks loose.  Every process has a valid parent
-- unless it is dead and nobody cares.  Process N has already exited and
released from the tasklist while its parent was still alive.  There was
no reason to reparent it.  It just got released.  So N's task_struct has
a dangling ptr to its parent.  Nobody is holding the parent task_struct,
either.  When the parent died memory for its task_struct was released. 
This is ungood.


My opinion here is that this is proc's problem.  When we free a
task_struct it could be "cleaned up" of dangling ptrs, but this is a
hack to cover a bug in proc.

This is not isolated to the parent task_struct, either.  The task_struct
mm is also dereferenced.  It is pretty easy to validate a parent
task_struct ptr (just hold tasklist_lock and run the list to check if it
is still valid -- might not be the *right* task, but it will still be
valid).  However, how do you validate the mm is ok?

It would be nice if there were an easy way to detect when the process
gets into this state.  Certainly it is in this state if the page
reference count is 1.  But multiple processes *could* be reading the
same proc file holding additional artificial ref counts.

Hmm...perhaps if I scan the tasklist for my own task?  If I am not in
the list I either return an error or faked info.  I'll try this....

-- 
-todd

BTW, by adding code to validate the parent my test has now run for 18
hours on a 4-way without failure.  It otherwise would fail within the
first 5 minutes.
