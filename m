Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWIEKKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWIEKKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWIEKKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:10:52 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:706 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751352AbWIEKKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:10:51 -0400
Date: Tue, 5 Sep 2006 14:10:50 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       jdelvare@suse.de, Albert Cahalan <acahalan@gmail.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] proc: readdir race fix
Message-ID: <20060905101050.GA128@oleg>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com> <m1y7sz4455.fsf@ebiederm.dsl.xmission.com> <20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com> <m14pvn3tam.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14pvn3tam.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04, Eric W. Biederman wrote:
> 
> -static struct task_struct *next_tgid(struct task_struct *start)
> -{
> -	struct task_struct *pos;
> +	task = NULL;
>  	rcu_read_lock();
> -	pos = start;
> -	if (pid_alive(start))
> -		pos = next_task(start);
> -	if (pid_alive(pos) && (pos != &init_task)) {
> -		get_task_struct(pos);
> -		goto done;
> +retry:
> +	pid = find_next_pid(tgid);
> +	if (pid) {
> +		tgid = pid->nr + 1;
> +		task = pid_task(pid, PIDTYPE_PID);
> +		if (!task || !thread_group_leader(task))
                              ^^^^^^^^^^^^^^^^^^^
There is a window while de_thread() switches leadership, so next_tgid()
may skip a task doing exec. What do you think about

                             // needs a comment
		if (!task || task->pid != task->tgid)
			goto retry;

instead? Currently first_tgid() has the same (very minor) problem.

> +			goto retry;
> +		get_task_struct(task);
>  	}
> -	pos = NULL;
> -done:
>  	rcu_read_unlock();
> -	put_task_struct(start);
> -	return pos;
> +	return task;
> +
>  }

Emply line before '}'

> +struct pid *find_next_pid(int nr)
> +{
> +	struct pid *next;
> +
> +	next = find_pid(nr);
> +	while (!next) {
> +		nr = next_pidmap(nr);
> +		if (nr <= 0)
> +			break;
> +		next = find_pid(nr);
> +	}
> +	return next;
> +}

This is strange that we are doing find_pid() before and at the end of loop,
I'd suggest this code:

	struct pid *find_next_pid(int nr)
	{
		struct pid *pid;

		do {
			pid = find_pid(nr);
			if (pid != NULL)
				break;
			nr = next_pidmap(nr);
		} while (nr > 0);

		return pid;
	}

Imho, a bit easier to read.

Oleg.

