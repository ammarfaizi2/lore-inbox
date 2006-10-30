Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWJ3Uej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWJ3Uej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWJ3Uej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:34:39 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:4238 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751993AbWJ3Uei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:34:38 -0500
Date: Mon, 30 Oct 2006 23:34:18 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Balbir Singh <balbir@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fill_tgid: fix task_struct leak and possible oops
Message-ID: <20061030203418.GA677@oleg>
References: <20061026232052.GA520@oleg> <45460302.4080904@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45460302.4080904@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Balbir Singh wrote:
>
> Oleg Nesterov wrote:
> 
> > 2. release_task(first) can happen after fill_tgid() drops tasklist_lock,
> >    it is unsafe to dereference first->signal.
> > 
> 
> But, we have a reference to first via get_task_struct(). release_task()
> would do just a put_task_struct(). Am I missing something?

No, release_task() will reap the task. tsk->usage protects only task_struct
itself (more precisely, it protects against __put_task_struct()). And please
note that release_task()->__exit_signal() sets tsk->signal = NULL.


QUESTION: taskstats_exit_alloc() does kfree(kmem_cache_alloc()), is it OK?
Yes, it works, but is it good? The comment says:

	* @objp: pointer returned by kmalloc.


Another question,

	do_exit()
		taskstats_exit_alloc()
		...
		taskstats_exit_send()
		taskstats_exit_free()

What is the point? Why can't we have taskstats_exit() which does alloc+send+free
itself? This looks like unnecessary complication to me.

>From taskstats_exit_alloc:

	/*
	 * This is the cpu on which the task is exiting currently and will
	 * be the one for which the exit event is sent, even if the cpu
	 * on which this function is running changes later.
	 */

Why do we record current cpu exactly here? This task probably changed its
CPU many times since it entered sys_exit(), so what is the problem if it
will change CPU again before taskstats_exit_send() ?

Oleg.

