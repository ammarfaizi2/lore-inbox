Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266112AbTLaEs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbTLaEs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:48:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:63955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266112AbTLaEsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:48:54 -0500
Date: Tue, 30 Dec 2003 20:49:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kthread_create
Message-Id: <20031230204910.0e767b50.akpm@osdl.org>
In-Reply-To: <20031231042016.958DC2C04B@lists.samba.org>
References: <20031231042016.958DC2C04B@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Hi all,
> 
> 	Ingo read through this before and liked it: this is the basis
> of the Hotplug CPU patch, and as such has been stressed fairly well.
> Tested stand-alone, and included here for wider review.

It would be nice to be able to see all the hotplug CPU patches in one
place, to get a feel for their shape and size.  That way, we can decide
whether we need to look at this patch ;)

> D: kthread_create(), kthread_start() and kthread_destroy().  These

A few things:

> +static struct kt_message ktm_receive(void)
> +{
> +	struct kt_message m;
> +
> +	for (;;) {
> +		spin_lock(&ktm_lock);
> +		if (ktm.to == current)
> +			break;
> +		current->state = TASK_INTERRUPTIBLE;
> +		spin_unlock(&ktm_lock);
> +		schedule();
> +	}

If the calling task has a signal pending, this could become a tight loop?

> +
> +static int kthread(void *data)
> +{
> +	/* Copy data: it's on keventd_init's stack */
> +	struct kthread k = *(struct kthread *)data;
> +	struct kt_message m;
> +	int ret = 0;
> +	sigset_t blocked;
> +
> +	strcpy(current->comm, k.name);
> +
> +	/* Block and flush all signals. */
> +	sigfillset(&blocked);
> +	sigprocmask(SIG_BLOCK, &blocked, NULL);
> +	flush_signals(current);
> +

deamonize() was not suitable here?

> +	/* Send to spawn_kthread, so it knows who we are. */
> +	ktm_send(ktm.info, current);
> +
> +	/* Receive from kthread_start or kthread_destroy */
> +	m = ktm_receive();
> +	if (!m.info)
> +		goto stop;
> +	if (k.initfn && (ret = k.initfn(k.data)) < 0)
> +		goto stop;
> +	ktm_send(m.from, current);
> +
> +	for (;;) {
> +		if (time_to_die(&m))
> +			break;
> +
> +		/* If it fails, just wait until kthread_destroy. */
> +		if (k.corefn && (ret = k.corefn(k.data)) < 0)
> +			k.corefn = NULL;
> +
> +		if (time_to_die(&m))
> +			break;
> +
> +		schedule();
> +	}

In what state is this schedule() called?  If it's TASK_RUNNING (or
TASK_INTERRUPTIBLE with signal_pending()) and this task has rt priority
higher than the thing it is waiting for we could have a problem?

> +
> +	current->state = TASK_RUNNING;
> +stop:
> +	ktm_send(m.from, ERR_PTR(ret));
> +	return ret;
> +}
> +
> +struct kthread_create
> +{
> +	struct task_struct *result;
> +	struct kthread k;
> +	struct completion done;
> +};
> +

`kthread_create' sounds like the name of a function to me, not a structure.

> +struct task_struct *kthread_create(int (*initfn)(void *data),

I was right! ;)

It would be nice to kerneldocify kthread_create(), kthread_start() and
kthread_destroy() sometime.

> +static void wait_for_death(struct task_struct *k)
> +{
> +	while (!(k->state & TASK_ZOMBIE) && !(k->state & TASK_DEAD))
> +		yield();
> +}
> +

If the calling task has higher rt priority than *k, could this not become a
busy loop?  It would be preferable to use a real sleep/wait primitive here.


