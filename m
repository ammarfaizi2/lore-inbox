Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWA3KfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWA3KfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWA3KfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:35:01 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:48299 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932204AbWA3KfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:35:01 -0500
Message-ID: <43DDFDE3.58C01234@tv-sign.ru>
Date: Mon, 30 Jan 2006 14:52:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Cleanup exec from a non thread group leader.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> And for good measure we set the thread group leaders
> exit_signal to -1 so it will self reap.  We are actually
> past the point where that matters but it can't hurt, and
> it might help someday.
> ...
>               leader->exit_state = EXIT_DEAD;
> +             leader->exit_signal = -1;

I disagree. The leader is already practically reaped, it is EXIT_DEAD.
I think this change will confuse the reader who will try to understand
why do we need this subtle assignment.

>  void switch_exec_pids(task_t *leader, task_t *thread)
>  {
> -	__detach_pid(leader, PIDTYPE_PID);
> -	__detach_pid(leader, PIDTYPE_TGID);
> -	__detach_pid(leader, PIDTYPE_PGID);
> -	__detach_pid(leader, PIDTYPE_SID);
> -
> -	__detach_pid(thread, PIDTYPE_PID);
> -	__detach_pid(thread, PIDTYPE_TGID);
> -
> -	leader->pid = leader->tgid = thread->pid;
> -	thread->pid = thread->tgid;
> -
> -	attach_pid(thread, PIDTYPE_PID, thread->pid);
> -	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
> +	detach_pid(thread, PIDTYPE_PID);
> +	thread->pid = leader->pid;
> +	attach_pid(thread, PIDTYPE_PID,  thread->pid);
>  	attach_pid(thread, PIDTYPE_PGID, thread->signal->pgrp);
> -	attach_pid(thread, PIDTYPE_SID, thread->signal->session);
> -	list_add_tail(&thread->tasks, &init_task.tasks);

The last deletion is wrong, I beleive.

> +	attach_pid(thread, PIDTYPE_SID,  thread->signal->session);
>  
> -	attach_pid(leader, PIDTYPE_PID, leader->pid);
> -	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
> -	attach_pid(leader, PIDTYPE_PGID, leader->signal->pgrp);
> -	attach_pid(leader, PIDTYPE_SID, leader->signal->session);
> +	detach_pid(leader, PIDTYPE_PID);
> +	detach_pid(leader, PIDTYPE_TGID);
> +	detach_pid(leader, PIDTYPE_PGID);
> +	detach_pid(leader, PIDTYPE_SID);
>  }

I think most of detach_pid()s could be replaced with __detach_pid(),
this will save unneccesary pid_hash scanning

Oleg.
