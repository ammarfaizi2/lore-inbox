Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWIKD7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWIKD7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 23:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWIKD7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 23:59:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35292 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750817AbWIKD73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 23:59:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce get_task_pid() to fix unsafe get_pid()
References: <20060911022535.GA7095@oleg>
Date: Sun, 10 Sep 2006 21:58:25 -0600
In-Reply-To: <20060911022535.GA7095@oleg> (Oleg Nesterov's message of "Mon, 11
	Sep 2006 06:25:35 +0400")
Message-ID: <m1venvawbi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> (COMPILE TESTED, needs an ack from Eric)
>
> proc_pid_make_inode:
>
> 	ei->pid = get_pid(task_pid(task));
>
> I think this is not safe. get_pid() can be preempted after checking
> "pid != NULL". Then the task exits, does detach_pid(), and RCU frees
> the pid.

Ugh.  I had forgotten that the pid of a task gets freed even if you
hold a reference to the task struct.  So the preemption case looks possible.

Your technique to handle this problem looks fine.

As for the functions can we build them in all 4 varieties.
struct pid *get_task_pid(struct task *);
struct pid *get_task_tgid(struct task *);
struct pid *get_task_pgrp(struct task *);
struct pid *get_task_session(struct task *);

Functions without a flag are less error prone to use, and clearer to read.

Either that or we can just drop in some rcu_read_lock() rcu_read_unlock()
into the call sites.

Eric
