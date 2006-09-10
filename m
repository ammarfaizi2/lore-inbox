Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWIJO3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWIJO3h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWIJO3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:29:37 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:26346 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932201AbWIJO3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:29:35 -0400
Date: Sun, 10 Sep 2006 18:29:42 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
Message-ID: <20060910142942.GA7384@oleg>
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Eric W. Biederman wrote:
> 
> This patch does several things.
> - The variables used are moved into a structure and declared in vt_kern.h
> - A spinlock is added so we don't have SMP races updating the values.
> - Instead of raw pid_t value a struct_pid is used to guard against
>   pid wrap around issues, if the daemon to spawn a new console dies.

I am not arguing against this patch, but it's a pity we can't use 'struct pid'
lockless. What dou you think about this:

	void delayed_free_pid(struct rcu_head *rhp)
	{
		struct pid *pid = container_of(rhp, struct pid, rcu);
		kmem_cache_free(pid_cachep, pid);
	}

	void put_pid_rcu(struct pid *pid)
	{
		if (atomic_dec_and_test(&pid->count))
			// this can happen only if delayed_put_pid()
			// was already fired, we can re-use pid->rcu
			call_rcu(&pid->rcu, delayed_free_pid);
	}

Now,

	update_pid()
	{
		// still needs some locking
		put_pid_rcu(pid);
		pid = get_pid(...);
	}

	use_pid()
	{
		rcu_read_lock();
		do_something(pid);
		rcu_read_unock();
	}

Thoughts?

Oleg.

