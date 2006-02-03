Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWBCMJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWBCMJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWBCMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:09:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:46475 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750707AbWBCMJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:09:39 -0500
Message-ID: <43E35A13.B83AC4B8@tv-sign.ru>
Date: Fri, 03 Feb 2006 16:26:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH] pidhash:  Kill switch_exec_pids
References: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
		<43E26AB1.8509A175@tv-sign.ru> <m13bj1sevb.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > Eric W. Biederman wrote:
> >>
> >> +            detach_pid(current, PIDTYPE_PID);
> >> +            current->pid = leader->pid;
> >> +            attach_pid(current, PIDTYPE_PID,  current->pid);
> >
> > What happens after de_thread() unlocks tasklist_lock and before
> > it is taken again in release_task() ?
> >
> > In that window find_task_by_pid() will return dead leader, not
> > the new leader of thread group. This means we can miss tkill()
> > or ptrace(), for example.
> 
> All I have done is enlarged the window where this
> race is possible.  So for tkill I am not concerned,
> as it wants a particular thread.  Nor am I concerned
> about anything else that wants a particular thread.

Yes, you are right, sorry for noise. We have exactly same situation
before de_thread() locks tasklist after killing the leader.

> The fact that the group_leader does not point
> at the actual thread group leader might be a problem,
> as I have opened a window where that is now the case.
> 
> For signals that is not a problem as signals are still shared.
> This applies to most other resources as well.

Actually, now I think this patch fixes a small theoretical bug.
Currently we have a tiny window in switch_exec_pids() when it
detaches ->pid from PIDTYPE_PID namespace. RCU based kill_proc_info()
does not take tasklist, so we can miss a signal.

I have added Paul to the CC: list.

> So until we spot that case I'm ready to put this down
> of one of those cases in de_thread that looks wrong
> but happens to work.  Now if there is a way to make
> it work more cleanly that may be worth looking at.

I think you are right.

Andrew, please drop this one:

	dont-touch-current-tasks-in-de_thread.patch

Eric's patch includes this cleanup.

Oleg.
