Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbUKVQa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbUKVQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbUKVQ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:29:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57490 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262151AbUKVPu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:50:29 -0500
Message-ID: <41A20AF3.9030408@sgi.com>
Date: Mon, 22 Nov 2004 09:51:15 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
CC: holt@sgi.com, Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: scalability of signal delivery for Posix Threads
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've encountered a scalability problem with signal delivery.  Our application
is attempting to use ITIMER_PROF to deliver one signal per clock tick to each
thread of a ptrheaded (NPTL).  These threads are created with CLONE_SIGHAND,
so that there is a single sighand->siglock for the entire application.

On our Altix systems, everything works fine until we increase the number of
threads (and processors, with one thread bound to each processor) beyond
about 112 threads or so.  At that point lock contention can become severe
enough to make the system unresponsive.  The reason is that each thread has
to obtain the (global to the application, in this case) lock sighand->siglock.

(Obviously, one solution is to recode the application to send fewer signals
per thread as the number of threads increase.  However, we are concerned by
the fact that a user application, of any kind, can be constructed in a way
that causes system to become responsive and would like to find a solutiuon
that would let us correctly execute the program as described.)

Perusing the kernel sources shows that this global lock is used, in many 
cases, to protect data that is purely local to the current thread.  (For 
example, see block_all_signals(), where current->sighand->siglock is obtained
and then the current task's signal mask is manipulated.)

This lock is also aquired in the following routines, where most of the time
is being spent our application:

ia64_do_signal
set_signal_to_deliver
ia64_rt_sigreturn

In these cases, it appears that the global lock is being acquired to make sure
the signal handler definition doesn't change underneath us, as well as dealing
with the per thread signal data.

Since signals are sent much more often than sigaction() is called, it would
seem to make more sense to make sigaction() take a heavier weight lock of
some kind (to update the signal handler decription) and to have the signal
delivery mechanism take a lighter weight lock.  Making 
current->sighand->siglock a rwlock_t really doesn't improve the situation
much, since cache line contention is just a severe in that case (if not worse) 
than it is with the current definition.

It seems to me that scalability would be improved if we moved the siglock from
the sighand structure to the task_struct.  (keep reading, please...)  Code 
that manipulates the current task signal data only would just obtain that 
lock.  Code that needs to change the sighand structure (e. g. sigaction())
would obtain all of the siglock's of all tasks using the same sighand 
structure.  A list of those task_struct's would be added to the sighand
structure to enable finding these structurs without having to take the
task_list_lock and search for them.

Obviously, this change ricochet's throughout the entire signal handling code.
It also means that sigaction() can become quite expensive for a many threaded
POSIX application, but my guess is that this doesn't happen very often.
The change could also make do_exit(), thread group shutdown, etc slower and
perhaps somewhat more complex.

Anyway, we would be interested in the community's ideas about dealing with
this signal delivery scalability issue, and, comments on the solution above
or suggestions for alternative solutions are welcome.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
