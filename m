Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVHUJnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVHUJnu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVHUJnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:43:49 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:15569
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750907AbVHUJnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:43:49 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43076138.C37ED380@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 21 Aug 2005 11:44:18 +0200
Message-Id: <1124617458.23647.643.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 20:58 +0400, Oleg Nesterov wrote:
> [PATCH] fix send_sigqueue() vs thread exit race
> 
> posix_timer_event() first checks that the thread (SIGEV_THREAD_ID
> case) does not have PF_EXITING flag, then it calls send_sigqueue()
> which locks task list. But if the thread exits in between the kernel
> will oops (->sighand == NULL after __exit_sighand).
> 
> This patch moves the PF_EXITING check into the send_sigqueue(), it
> must be done atomically under tasklist_lock. When send_sigqueue()
> detects exiting thread it returns -1. In that case posix_timer_event
> will send the signal to thread group.
> 
> Also, this patch fixes task_struct use-after-free in posix_timer_event.
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.13-rc6/kernel/signal.c~	2005-08-18 23:10:28.000000000 +0400
> +++ 2.6.13-rc6/kernel/signal.c	2005-08-20 23:05:21.000000000 +0400
> @@ -1366,16 +1366,16 @@ send_sigqueue(int sig, struct sigqueue *
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	/*
> -	 * We need the tasklist lock even for the specific
> -	 * thread case (when we don't need to follow the group
> -	 * lists) in order to avoid races with "p->sighand"
> -	 * going away or changing from under us.
> -	 */
>  	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> -	read_lock(&tasklist_lock);  
> +	read_lock(&tasklist_lock);
> +
> +	if (unlikely(p->flags & PF_EXITING)) {
> +		ret = -1;
> +		goto out_err;
> +	}
> +

It's still racy. tasklist_lock does not protect anything here. 

 arm timer
 exit
 timer event
	timr->it_process references a freed structure


tglx





