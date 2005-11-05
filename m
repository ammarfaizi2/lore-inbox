Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVKEPTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVKEPTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVKEPTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:19:05 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:54757 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932077AbVKEPTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:19:02 -0500
Message-ID: <436CDEAF.E236BC40@tv-sign.ru>
Date: Sat, 05 Nov 2005 19:32:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Additional/catchup RCU signal fixes for -mm
References: <20051105013650.GA17461@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
>
> @@ -1386,7 +1387,7 @@ send_sigqueue(int sig, struct sigqueue *
>  {
>  	unsigned long flags;
>  	int ret = 0;
> -	struct sighand_struct *sh = p->sighand;
> +	struct sighand_struct *sh;
>
>  	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
>
> @@ -1405,7 +1406,15 @@ send_sigqueue(int sig, struct sigqueue *
>  		goto out_err;
>  	}
>
> +retry:
> +	sh = rcu_dereference(p->sighand);
> +
>  	spin_lock_irqsave(&sh->siglock, flags);
> +	if (p->sighand != sh) {
> +		/* We raced with exec() in a multithreaded process... */
> +		spin_unlock_irqrestore(&sh->siglock, flags);
> +		goto retry;

p->sighand can't be changed, de_thread calls exit_itimers() before
changing ->sighand. But I still think it can be NULL, and send_sigqueue()
should return -1 in that case.

> @@ -1464,15 +1473,8 @@ send_group_sigqueue(int sig, struct sigq
>
>  	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
>
> -	while (!read_trylock(&tasklist_lock)) {
> -		if (!p->sighand)
> -			return -1;
> -		cpu_relax();
> -	}
> -	if (unlikely(!p->sighand)) {
> -		ret = -1;
> -		goto out_err;
> -	}
> +	read_lock(&tasklist_lock);
> +	/* Since it_lock is held, p->sighand cannot be NULL. */
>  	spin_lock_irqsave(&p->sighand->siglock, flags);

Again, I think the comment is wrong.

However, now I think we really have a race with exec, and this race was not
introduced by your patches!

If !thread_group_leader() does exec de_thread() calls release_task(->group_leader)
before calling exit_itimers(). This means that send_group_sigqueue() which
always has p == ->group_leader parameter can oops here.

Oleg.
