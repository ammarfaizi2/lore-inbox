Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUBQF1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUBQF1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:27:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:39316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266001AbUBQF06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:26:58 -0500
Date: Mon, 16 Feb 2004 21:27:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dmorris@metavize.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
Message-Id: <20040216212758.437af444.akpm@osdl.org>
In-Reply-To: <20040217051911.6AC112C066@lists.samba.org>
References: <40311703.8070309@metavize.com>
	<20040217051911.6AC112C066@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> -	if (likely(!list_empty(&q.list)))
>  +	if (likely(!list_empty(&q.list))) {
>  +		current->flags |= PF_FUTEX_DEBUG;
>   		time = schedule_timeout(time);
>  +		current->flags &= ~PF_FUTEX_DEBUG;
>  +	}
>   	__set_current_state(TASK_RUNNING);
>   
>   	/*
>  diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/kernel/sched.c .6375-linux-2.6.3-rc3-bk1.updated/kernel/sched.c
>  --- .6375-linux-2.6.3-rc3-bk1/kernel/sched.c	2004-02-15 18:17:22.000000000 +1100
>  +++ .6375-linux-2.6.3-rc3-bk1.updated/kernel/sched.c	2004-02-17 12:02:24.000000000 +1100
>  @@ -658,6 +658,14 @@ static int try_to_wake_up(task_t * p, un
>   	long old_state;
>   	runqueue_t *rq;
>   
>  +	if ((p->flags & PF_FUTEX_DEBUG)
>  +	    && !(current->flags & PF_FUTEX_DEBUG)) {
>  +		printk("%s %i waking %s: %i %i\n",
>  +		       current->comm, (int)in_interrupt(),
>  +		       p->comm, p->tgid, p->pid);
>  +		WARN_ON(1);
>  +	}
>  +

If the schedule_timeout() expires then this wakeup will occur from within
the timer interrupt - current could point at any old thing.  We will get
bogus warnings.


