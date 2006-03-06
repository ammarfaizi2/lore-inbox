Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752431AbWCFVJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbWCFVJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbWCFVJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:09:45 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:27070 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1752431AbWCFVJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:09:44 -0500
Message-ID: <440CA459.6627024C@tv-sign.ru>
Date: Tue, 07 Mar 2006 00:06:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
		<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
		<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
		<44074479.15D306EB@tv-sign.ru> <m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have a really good idea.

Forget about task ref for a moment. I thinks we can greatly
simplify the pids management. We don't PIDTYPE_MAX hash tables,
we need only one.

The plan:

	kill PIDTYPE_TGID
	(copy_process/unhash_process need a simple fix)

	kill 'struct pid'

Now,

	struct task_struct
	{
		...
		struct list_head	pids[PIDTYPE_MAX];
		struct list_head	tgrp;
		...
	};

	static inline struct task_struct *next_thread(struct task_struct *p)
	{
		return list_entry(p->tgrp.next, struct task_struct, tgrp);
	}

	struct pid_head
	{
		pid_t			nr;
		struct hlist_node	chain;
		struct list_head	tasks[PIDTYPE_MAX];
	};

kernel/pid.c:

	static kmem_cache_t *pid_cachep;

	static struct hlist_head *pid_hash;
	#define	pid_bucket(nr)	(pid_hash + pid_hashfn(nr))

	// alloc_pidmap() becomes static,
	// do_fork() calls this instead
	struct pid_head *alloc_pid(void)
	{
		struct pid_head *pid;

		pid = kmem_cache_alloc(pid_cachep, GFP_KERNEL);

		if (likely(pid)) {
			enum pid_type type;

			for (type = 0; type < PIDTYPE_MAX; ++type)
				INIT_LIST_HEAD(pid->tasks + type);

			pid->nr = alloc_pidmap();
			hlist_add_head_rcu(&pid->chain, pid_bucket(pid->nr));
		}

		return pid;
	}

	void free_pid(struct pid_head *pid)
	{
		free_pidmap(pid->nr);
		kmem_cache_free(pid_cachep, pid);
	}

	static struct pid_head *find_pid(pid_t nr)
	{
		struct hlist_node *node;
		struct pid_head *pid;

		hlist_for_each_entry_rcu(pid, node, pid_bucket(nr), chain)
			if (pid->nr == nr)
				return pid;

		return NULL;
	}

	struct list_head *find_pid_list(enum pid_type type, pid_t nr)
	{
		struct pid_head *pid;

		pid = find_pid(nr);
		if (pid)
			return pid->tasks + type;

		return NULL;
	}

	void attach_pid(struct task_struct *task, enum pid_type type, pid_t nr)
	{
		struct list_head *list;

		list = find_pid_list(type, nr);
		BUG_ON(!list);
		list_add_tail_rcu(task->pids + type, list);
	}

	static inline struct list_head *__detach_pid(struct task_struct *task,
								enum pid_type type)
	{
		struct list_head *list;

		list = task->pids + type;
		list_del_rcu(list);	// it doesn't touch ->next
		return list->next;
	}

	void detach_pid(struct task_struct *task, enum pid_type type)
	{
		struct list_head *head;
		struct pid_head *pid;

		head = __detach_pid(task, type);
		if (!list_empty(head))
			return;

		pid = list_entry(head, struct pid_head, tasks[type]);

		for (type = 0; type < PIDTYPE_MAX; ++type)
			if (!list_empty(pid->tasks + type))
				return;

		free_pid(pid);
	}

We don't need ugly do_each_task_pid/while_each_task_pid anymore:

	#define	for_each_task_pid(head, pid, type, task)		\
		if ((head = find_pid_list(type, pid)))			\
			list_for_each_entry(task, head, pids[type])


And noe we can inplement pid_ref almost for free, just add ->count
to 'struct pid_head'.

What do you think?

Oleg.
