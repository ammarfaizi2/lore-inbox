Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWIGBZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWIGBZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 21:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWIGBZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 21:25:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:52185 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965285AbWIGBZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 21:25:39 -0400
Date: Wed, 6 Sep 2006 20:25:37 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20060907012537.GA11138@sergelap.austin.ibm.com>
References: <20060906182719.GB24670@sergelap.austin.ibm.com> <20060906135113.00051e89.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906135113.00051e89.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> Serge wrote:
> > 	One remaining question is the note under task_setscheduler: are we
> > 	ok with CAP_SYS_NICE being sufficient to confine a process to a
> > 	cpuset?
> 
> So far as I know (which isn't very far ;), that's ok.
> 
> Can you explain to me how this will visibly affect users?

Short answer is that I don't think it should affect users at all.
They still cannot affect tasks belonging to other users (without
CAP_SYS_NICE).

The main change with file capabilities is that it becomes easy to
run with enhanced privilege, but with your non-root uid.  So for
instance /bin/passwd might now be run in your own name.  So permission
checks which until now have mainly checked for uid equivalence
no long suffice.  I could run /bin/passwd (as uid 500), then quickly
stick the process into a cpuset with insufficient memory or no cpus.
(Not sure whether that particular example makes sense or not :)

So after the regular a->uid==b->uid checks, we need to check whether
the victim process is actually running with raised privilege.

Details on changed behavior in for attach_task() below.

> Under what conditions, with what kernel configurations or options
> selected or not, and with what permissions settings, would they notice
> any difference, before and after this patch, in the behaviour of
> cpusets, such as when they do the operation of writing a pid to tasks
> file that invokes kernel/cpuset.c:attach_task()?

First, set_one_prio(), which calls security_task_nice(), checks
for the two tasks being the same uid before doing anything else.
So it remains the case that without having CAP_SYS_NICE you cannot
make a change for another user's tasks.

With SECURITY_CAPABILITIES=n, clearly this patch will have no effect.

With SECURITY_CAPABILITIES=y but (the new) SECURITY_FS_CAPABILITIES=n,
the new cap_task_setnice() function will be called.  The following
condition is checked:

	if (!cap_issubset(p->cap_permitted, current->cap_permitted) &&
		!__capable(current, CAP_SYS_NICE))

The only way, without SECURITY_FS_CAPABILITIES=y, that it can be the
case that p->cap_permitted is not a subset of current->cap_permitted,
and that current does have CAP_SYS_NICE, is for current to have
started setuid root and then dropped capabilities other than
CAP_SYS_NICE.  So a setuid root binary asked to retain CAP_SYS_NICE.

The other way for this function to grant permission is for
p->cap_permitted to be a subset of current->cap_permitted.  If you don't
have CAP_SYS_NICE, then these two facts combined mean that you are
doing attach_task() on behalf of a non-priviliged task owned by
yourself.

With SECURITY_FS_CAPABILITIES=y, what changes is that it is possible for
a binary to be marked as granting CAP_SYS_NICE to anyone running it.  If
you do that, your intent is clear.  If you don't grant CAP_SYS_NICE,
then the fact that p->cap_permitted is a subset of current->cap_permitted 
still means that you cannot affect a more privileged task than your own.
And again, set_one_prio() has already checked that the two processes are
owned by the same uid (or that the caller has CAP_SYS_NICE).

thanks,
-serge
