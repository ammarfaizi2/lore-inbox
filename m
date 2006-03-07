Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWCGVFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWCGVFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWCGVFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:05:48 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:42426 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751526AbWCGVFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:05:47 -0500
Message-ID: <440DF4F8.1DC7F5A5@tv-sign.ru>
Date: Wed, 08 Mar 2006 00:02:48 +0300
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
		<44074479.15D306EB@tv-sign.ru>
		<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
		<440CA459.6627024C@tv-sign.ru> <m1fylu2ybx.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
>  struct pid
>  {
> +       atomic_t count;
>         /* Try to keep pid_chain in the same cacheline as nr for find_pid */
>         int nr;
>         struct hlist_node pid_chain;
>         /* list of pids with the same nr, only one of them is in the hash */
> -       struct list_head pid_list;
> -       /* Does a weak reference of this type exist to the task struct? */
> -       struct task_ref *tref;
> +       struct list_head tasks[PIDTYPE_MAX];
> +       struct rcu_head rcu;
>  };
>
> ...
>
> +static void rcu_put_pid(struct rcu_head *rhp)
> +{
> +       struct pid *pid = container_of(rhp, struct pid, rcu);
> +       put_pid(pid);
> +}

I hope we can do it without pid->rcu and rcu_put_pid(). Hopefuly
we can use SLAB_DESTROY_BY_RCU. To do so we need some changes in
find_task_by_pid_type().

I'll try to look closer at this patch tomorrow.

Oleg.
