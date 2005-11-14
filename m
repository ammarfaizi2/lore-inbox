Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVKNXg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVKNXg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVKNXg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:36:57 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:43687 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932177AbVKNXg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:36:56 -0500
Date: Mon, 14 Nov 2005 15:36:49 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051114153649.75e265e7.pj@sgi.com>
In-Reply-To: <20051114212341.724084000@sergelap>
References: <20051114212341.724084000@sergelap>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about adding the accessor routines in the first patch (still
referencing task->pid), then doing all the changes as you did, then
renaming task->pid to task->__pid and updating the accessor to that
change, in the last patch?  Then it would build all the way through.

Serge wrote:
> The resulting object code seems to be identical in most cases, and is
> actually shorter in cases where current->pid is used twice in a row,
> as it does not dereference task-> twice.

You lost me here.  Why does using these accessor routines avoid the
second reference?

Have you crosstool'd built this for most arch's?  I could imagine
some piece of code having a local or other struct variable named 'pid'
that would be broken by a mistake in this change.  This could be so
whether the change was done by a script, or by hand.  Probably need
to test 'allyesconfig' too.

> Note that this does not change the kernel's
> internal idea of pids, only what users see.

How can that be?  Doesn't it run all accesses to the task->pid
field through the accessor, regardless of whether it's something
the user will see, or something used within the kernel?

How about other fields holding a pid, such as (one I happen to know
about) kernel/cpuset.c marker_pid?  Grep for "pid_t" in include/linux
for other such possible fields.  What about other kerel-user interfaces
that deal with pids such as fcntl, msgctl, sched_setaffinity, semop,
shmctl, sigaction, ...

How do you propose to synchronize incoming pid's with these potentially
modified displayed pids?  There many invocations of find_task_by_pid()
in the kernel, typically converting a user provided pid into a task
struct.  If doing "kill(getpid(), 1)" in user code didn't sighup
myself, that would be uncool.

How do you intend to use these accessor routines in order to help solve
the problems with checkpoint/restart?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
