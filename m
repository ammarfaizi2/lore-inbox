Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVC3XNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVC3XNA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVC3XNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:13:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:61078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbVC3XMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:12:25 -0500
Date: Wed, 30 Mar 2005 15:12:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: coywolf@gmail.com
Cc: coywolf@sosdg.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] oom lca -- fork bombing killer
Message-Id: <20050330151226.6bfbd96e.akpm@osdl.org>
In-Reply-To: <20050328044217.GA6362@everest.sosdg.org>
References: <20050328044217.GA6362@everest.sosdg.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
>
> 
> 			Linux OOM LCA (Least Common Ancestor) Patch
> 
> ...
>
> --- 2.6.12-rc1-mm3/include/linux/sched.h	2005-03-26 13:21:11.000000000 +0800
> +++ 2.6.12-rc1-mm3-cy/include/linux/sched.h	2005-03-28 10:18:24.000000000 +0800
> @@ -656,11 +656,7 @@ struct task_struct {
>  	unsigned did_exec:1;
>  	pid_t pid;
>  	pid_t tgid;
> -	/* 
> -	 * pointers to (original) parent process, youngest child, younger sibling,
> -	 * older sibling, respectively.  (p->father can be replaced with 
> -	 * p->parent->pid)
> -	 */
> +
>  	struct task_struct *real_parent; /* real parent process (when being debugged) */
>  	struct task_struct *parent;	/* parent process */
>  	/*
> @@ -669,6 +665,9 @@ struct task_struct {
>  	 */
>  	struct list_head children;	/* list of my children */
>  	struct list_head sibling;	/* linkage in my parent's children list */
> +	struct task_struct *bio_parent;	
> +	struct list_head bio_children;
> +	struct list_head bio_sibling;
>  	struct task_struct *group_leader;	/* threadgroup leader */
>  
>  	/* PID/PID hash table linkage. */

Well that was a bit cruel - it would have been better to fix up the comment
rather than deleting it.  And to have documented the newly-added fields.

(The bio_* names remind me of fs/bio.c.  Maybe rename them to initial_*?)


> @@ -1068,7 +1067,6 @@ extern void exit_itimers(struct signal_s
>  
>  extern NORET_TYPE void do_group_exit(int);
>  
> -extern void reparent_to_init(void);

OK, but the reparent_to_init() cleanup should be a separate patch, please.

>  static inline void reparent_thread(task_t *p, task_t *father, int traced)
> @@ -590,6 +596,7 @@ static inline void reparent_thread(task_
>  static inline void forget_original_parent(struct task_struct * father,
>  					  struct list_head *to_release)
>  {
> +	extern struct task_struct *last_chosen_parent;

This declaration should be in a header file.

> +
> +	list_for_each_safe(_p, _n,  &father->bio_children) {
> +		p = list_entry(_p, struct task_struct, bio_sibling);
> +		list_del_init(&p->bio_sibling);
> +		p->bio_parent = father->bio_parent;
> +		list_add_tail(&p->bio_sibling, &(p->bio_parent)->bio_children);
> +	}

This big list walk on the exit path might be unpopular from a performance
and latency POV.

>  /*
> + * LCA: Least Common Ancestor
> + *
> + * Returns NULL if no LCA (LCA is init_task)
> + *
> + * I prefer to use task_t for function parameters, and
> + * struct task_struct elsewhere.  -- coywolf
> + */

Most other people prefer to not use the typedef...

> +static struct task_struct * find_lca(task_t *p1, task_t *p2)
> +{
> +	struct task_struct *tsk1, *tsk2;
> +
> +	for (tsk1 = p1; tsk1 != &init_task; tsk1 = tsk1->bio_parent) {
> +		for (tsk2 = p2; tsk2 != &init_task; tsk2 = tsk2->bio_parent)
> +			if (tsk1 == tsk2)
> +				return tsk1;
> +	}
> +
> +	return NULL;
> +}

eep.  That's an O(n^2) search?  What does it do with 50000 tasks?

> -	struct task_struct *c;
> -	struct list_head *tsk;
> +	if (list_empty(&p->bio_children)) {
> +		mmput(mm);
> +		__oom_kill_task(p);
> +		return 1;
> +	}
>  
> -	/* Try to kill a child first */
> -	list_for_each(tsk, &p->children) {
> -		c = list_entry(tsk, struct task_struct, sibling);
> -		if (c->mm == p->mm)
> -			continue;
> -		mm = oom_kill_task(c);
> -		if (mm)
> -			return mm;
> +	/* Kill all descendants */
> +	for_each_process(q) {
> +		if (q->pid > 1) {
> +			if (test_tsk_thread_flag(q, TIF_MEMDIE) ||
> +				(q->flags & PF_EXITING) || (q->flags & PF_DEAD))
> +				continue;
> +			if (is_ancestor(p, q))
> +				__oom_kill_task(q);
> +		}
>  	}

That's O(n^2) too.

