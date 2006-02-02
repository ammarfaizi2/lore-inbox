Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWBBTIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWBBTIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWBBTIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:08:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:45959 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750803AbWBBTIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:08:30 -0500
Message-ID: <43E26AB1.8509A175@tv-sign.ru>
Date: Thu, 02 Feb 2006 23:25:21 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH] pidhash:  Kill switch_exec_pids
References: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -699,7 +699,17 @@ static int de_thread(struct task_struct 
>  		remove_parent(current);
>  		remove_parent(leader);
>  
> -		switch_exec_pids(leader, current);
> +
> +		/* Become a process group leader with the old leader's pid.
> +		 * Note: The old leader also uses thispid until release_task
> +		 *       is called.  Odd but simple and correct.
> +		 */
> +		detach_pid(current, PIDTYPE_PID);
> +		current->pid = leader->pid;
> +		attach_pid(current, PIDTYPE_PID,  current->pid);

What happens after de_thread() unlocks tasklist_lock and before
it is taken again in release_task() ?

In that window find_task_by_pid() will return dead leader, not
the new leader of thread group. This means we can miss tkill()
or ptrace(), for example.

Oleg.
