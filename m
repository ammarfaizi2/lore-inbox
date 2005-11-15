Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVKOAm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVKOAm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVKOAm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:42:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12987 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932223AbVKOAm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:42:58 -0500
Date: Mon, 14 Nov 2005 19:01:57 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115010155.GA3792@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114153649.75e265e7.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> How about adding the accessor routines in the first patch (still
> referencing task->pid), then doing all the changes as you did, then
> renaming task->pid to task->__pid and updating the accessor to that
> change, in the last patch?  Then it would build all the way through.

Ok, thanks - will send out a new patchset to do this.

> 
> Serge wrote:
> > The resulting object code seems to be identical in most cases, and is
> > actually shorter in cases where current->pid is used twice in a row,
> > as it does not dereference task-> twice.
> 
> You lost me here.  Why does using these accessor routines avoid the
> second reference?

Why, I don't know :)  I just looked at the resulting object code, and
the static inline causes task->pid to be dereferenced once and pushed
twice, whereas using task->pid causes it to be dereferenced twice.

> Have you crosstool'd built this for most arch's?  I could imagine

No - I've never used crosstool, but will it a shot.

> > Note that this does not change the kernel's
> > internal idea of pids, only what users see.
> 
> How can that be?  Doesn't it run all accesses to the task->pid
> field through the accessor, regardless of whether it's something
> the user will see, or something used within the kernel?

Ok...  our intent is to not change the kernel pid concept  :)  Of
course the accessor functions could be coded so as to change it, but
as far as I know we will not do so.

> How about other fields holding a pid, such as (one I happen to know
> about) kernel/cpuset.c marker_pid?  Grep for "pid_t" in include/linux
> for other such possible fields.  What about other kerel-user interfaces
> that deal with pids such as fcntl, msgctl, sched_setaffinity, semop,
> shmctl, sigaction, ...

Yes, our next patchset will introduce the actual pid to vpid translations
and place those functions in the right place.  What I meant to say was
that the kernel pids will still be pids just as they are now.  The barrier
between virtual pids and pids does not yet exist in this patchset.  This
patchset is to lay the groundwork to make those translations simpler.  We
switch task_pid() to task_vpid() in the right places, and use
task_pid_to_vpid() at the barriers between pids and vpids.

> How do you propose to synchronize incoming pid's with these potentially
> modified displayed pids?  There many invocations of find_task_by_pid()
> in the kernel, typically converting a user provided pid into a task

These are replaced with find_task_by_vpid(), which looks for a the given
vpid in the pid-space of the calling process.

> struct.  If doing "kill(getpid(), 1)" in user code didn't sighup
> myself, that would be uncool.
> 
> How do you intend to use these accessor routines in order to help solve
> the problems with checkpoint/restart?

Let's say we want to start a process group.  Start the first process in
a new pidspace.  (Hubertus or Dave can tell use exactly how this will be
done in the first prototype, but I would expect something like
	echo 5 > /proc/$$/childpidspace
	start_my_program   # This forks, and its children remain in pidspace 5
)
Now the processes in pidspace 5 are checkpointed and killed.  When they
are restarted, they will create a new pidspace for the group again, and
ask for their checkpointed pids within that pidspace.  Their kernelpids
will still be the same pid it would have been.  But when one of the
processes looks for process 10, task_vpid_to_pid(current, 10) will return
the real pid for the vpid 10 in current's pidspace.

thanks,
-serge

