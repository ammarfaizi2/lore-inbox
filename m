Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262273AbTCHWxO>; Sat, 8 Mar 2003 17:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbTCHWxN>; Sat, 8 Mar 2003 17:53:13 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:2275 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262273AbTCHWxJ>; Sat, 8 Mar 2003 17:53:09 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200303082303.AAA22598@faui11.informatik.uni-erlangen.de>
Subject: [NFS] Race in rpc_delete_timer causes crash
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Date: Sun, 9 Mar 2003 00:03:45 +0100 (MET)
Cc: uweigand@de.ibm.com, schwidefsky@de.ibm.com, bk@suse.de
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we're seeing a rare and hard to trigger crash on s390 where rpc_run_timer 
calls via an invalid callback pointer.

What appears to happen is that rpc_call_sync allocates a struct rpc_task 
(with its embedded tk_timer) on the stack, and the timer gets set up 
sometime during rpc_execute.  However, the timer actually triggers at
a point in time where the original call to rpc_call_sync has already 
returned, and the stack space overwritten by other data.  That data is 
now interpreted as an rpc_task struct holding a tk_timeout_fn pointer by
rpc_run_timer, which causes the Oops (actually, Aieee).

Now this is not supposed to happen because rpc_execute cleans up any 
potentially active timer before returning, by calling rpc_delete_timer.
However, this function is implemented as

  if (timer_pending(&task->tk_timer))
    del_timer_sync(&task->tk_timer)

and it is called without any locks held.  This would appear to open a 
race, because timer_pending returns false in a small window where the 
timer interrupt processing has already removed the timer from its queues, 
but not yet called the timer callback.

The flow of control the shows the race goes like this:

CPU A                                       CPU B

system call
 ...
  rpc_call_sync
   allocate task on stack
    rpc_execute (task)
     ...
      rpc_add_timer
       mod_timer (&task->tk_timer, ...)
        timer is now running,
        timer->data points to task
     ...
     rpc_release_task (task)
      rpc_disable_timer (task)
       sets tk_timeout_fn to NULL
      rpc_delete_timer (task)
                                             timer interrupt
                                              ...
                                               run_timer_list
                                                unchain timer from list
       timer_pending
        timer not in list -> false
       does not call del_timer_sync
     ...
   task goes out of scope
...
system call
 ...
  call chain overwrites stack space
  formerly occupied by task
  tk_timeout_fn now non-NULL
                                                call timer callback
                                                 rpc_run_timer
                                                  retrieve tk_timeout_fn
                                                  (gets random value)
                                                   -> Aieee.


This is a bit unlikely on most platforms, because CPU A has to execute a 
large number of instructions in the same time CPU B executes a comparatively 
small number of instructions.  However, on a virtualized platform like S/390
VM or LPAR, where the 'CPU' is actually scheduled in time slices by the 
hypervisor, this pattern is certainly possible (if rare).

In any case, I have post-mortem system dumps that are compatible with this 
scenario; I haven't found anything else that could explain the crash ...

The kernel where I've debugged the problem is quite old (2.4.7), but from 
reading more recent kernel sources, the very same race appears to be still 
present in current 2.4 and 2.5 kernels.

As fix I'd suggest to just go ahead and call del_timer_sync all the time; 
I don't quite see the point in checking for timer_pending in the first place.
The following patch implements this.


Index: net/sunrpc/sched.c
===================================================================
RCS file: /home/cvs/linux-2.3/net/sunrpc/sched.c,v
retrieving revision 1.13
diff -u -p -r1.13 sched.c
--- net/sunrpc/sched.c	3 May 2001 16:18:18 -0000	1.13
+++ net/sunrpc/sched.c	8 Mar 2003 22:46:11 -0000
@@ -168,10 +168,8 @@ void rpc_add_timer(struct rpc_task *task
 static inline void
 rpc_delete_timer(struct rpc_task *task)
 {
-	if (timer_pending(&task->tk_timer)) {
+	if (del_timer_sync(&task->tk_timer))
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
-		del_timer_sync(&task->tk_timer);
-	}
 }
 
 /*


Is is reasonable or am I overlooking something here?

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
