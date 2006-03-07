Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWCGWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWCGWnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWCGWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:43:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52957 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964830AbWCGWns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:43:48 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH rc5-mm] pids: kill PIDTYPE_TGID
References: <440DEADB.72C3A8A6@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 15:42:54 -0700
In-Reply-To: <440DEADB.72C3A8A6@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 07 Mar 2006 23:19:39 +0300")
Message-ID: <m11wxd27wx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> depends on
>
> 	pidhash-dont-count-idle-threads.patch
> 	pidhash-kill-switch_exec_pids.patch
>
> otherwise (I think) it is orthogonal to all tref/proc changes.

You also depend on your recent change to call __unhash_process
under the sighand lock.  Since the ->tgrp is protected by
the sighand lock.

> This patch kills PIDTYPE_TGID pid_type thus saving one hash table
> in kernel/pid.c and speeding up subthreads create/destroy a bit.
> It is also a preparation for the further tref/pids rework.
>
> This patch adds 'struct list_head tgrp' to 'struct task_struct'
> instead. Note that ->tgrp need not to be rcu safe.

Is there a reason for this?  I think at least proc could easily
take advantage of an rcu safe implementation.

Hmm.  At the moment proc is only taking the tasklist_lock during
traversal so we may have a problem with the list_add anyway.

Also could we name the member not ->tgrp but ->threads?
I keep half expecting tgrp to be a number, and have a hard
time not mispelling it tpgrp.

> We don't detach group leader from PIDTYPE_PID namespace until another
> thread inherits it's ->pid == ->tgid, so we are safe wrt premature
> free_pidmap(->tgid) call.

Agreed.

> Currently there are no users of find_task_by_pid_type(PIDTYPE_TGID).
> Should the need arise, we can use find_task_by_pid()->group_leader.
>
>  include/linux/pid.h   |    1 -
>  include/linux/sched.h |   10 +++++++---
>  kernel/exit.c         |   10 +---------
>  kernel/fork.c         |    4 +++-
>  4 files changed, 11 insertions(+), 14 deletions(-)

Eric
