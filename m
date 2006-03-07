Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWCGBkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWCGBkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCGBkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:40:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39377 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752064AbWCGBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:40:36 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
	<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
	<440CA459.6627024C@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Mar 2006 18:39:54 -0700
In-Reply-To: <440CA459.6627024C@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 07 Mar 2006 00:06:33 +0300")
Message-ID: <m1slpv58yd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> I think I have a really good idea.
>
> Forget about task ref for a moment. I thinks we can greatly
> simplify the pids management. We don't PIDTYPE_MAX hash tables,
> we need only one.
>
> The plan:
>
> 	kill PIDTYPE_TGID
> 	(copy_process/unhash_process need a simple fix)

Worth doing.  But I think it is an independent problem.
I almost wonder if it is possible to let the thread group leader
exit, at which point we really would need PIDTYPE_TGID.

Or do you need this to have the thread list embedded in the task_struct?

> 	kill 'struct pid'
>
> Now,
>
> 	struct task_struct
> 	{
> 		...
> 		struct list_head	pids[PIDTYPE_MAX];
> 		struct list_head	tgrp;
> 		...
> 	};
>
> 	static inline struct task_struct *next_thread(struct task_struct *p)
> 	{
> 		return list_entry(p->tgrp.next, struct task_struct, tgrp);
> 	}
>
> 	struct pid_head
> 	{
> 		pid_t			nr;
> 		struct hlist_node	chain;
> 		struct list_head	tasks[PIDTYPE_MAX];
> 	};

pid_head is decent but I am very tempted to call this struct pid.
Especially if we start getting a lot of pointers to them a simple
name that makes sense is useful.

> kernel/pid.c:
>
> 	static kmem_cache_t *pid_cachep;
>
> 	static struct hlist_head *pid_hash;
> 	#define	pid_bucket(nr)	(pid_hash + pid_hashfn(nr))
>
> 	// alloc_pidmap() becomes static,
> 	// do_fork() calls this instead
> 	struct pid_head *alloc_pid(void)
> 	{
> 		struct pid_head *pid;
>
> 		pid = kmem_cache_alloc(pid_cachep, GFP_KERNEL);
>
> 		if (likely(pid)) {
> 			enum pid_type type;
>
> 			for (type = 0; type < PIDTYPE_MAX; ++type)
> 				INIT_LIST_HEAD(pid->tasks + type);
>
> 			pid->nr = alloc_pidmap();
> 			hlist_add_head_rcu(&pid->chain, pid_bucket(pid->nr));
> 		}
>
> 		return pid;
> 	}

Hmm.  I guess that works.  I'm tempted to still return just a pid_t.
I guess I can't see how the struct pid_head, will be used.

There may be another problem here as well.  I don't think we have a lock
at this point that makes us safe to update the hash table.

> 	static struct pid_head *find_pid(pid_t nr)
> 	{
> 		struct hlist_node *node;
> 		struct pid_head *pid;
>
> 		hlist_for_each_entry_rcu(pid, node, pid_bucket(nr), chain)
> 			if (pid->nr == nr)
> 				return pid;
>
> 		return NULL;
> 	}

I'm pretty certain there are uses for find_pid, outside of pid.c

> And noe we can inplement pid_ref almost for free, just add ->count
> to 'struct pid_head'.

If we want to kill the tasklist_lock we also want to add a lock
to struct pid_head.  Otherwise I don't see how we can safely bump
the count, above zero.  But using the tasklist_lock for the first
version shouldn't be a problem.


Eric

