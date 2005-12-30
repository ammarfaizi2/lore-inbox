Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVL3QmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVL3QmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 11:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVL3QmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 11:42:02 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:31382 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964844AbVL3QmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 11:42:00 -0500
Message-ID: <43B57515.967F53E3@tv-sign.ru>
Date: Fri, 30 Dec 2005 20:57:41 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ravikiran G Thirumalai wrote:
>
> Following patch avoids taking the global tasklist_lock when possible,
> if a process is single threaded during getrusage().  Any avoidance of
> tasklist_lock is good for NUMA boxes (and possibly for large SMPs).

> --- arch/mips/kernel/irixsig.c.orig	2005-12-27 14:49:57.000000000 -0800
> +++ arch/mips/kernel/irixsig.c	2005-12-27 14:52:47.000000000 -0800
> @@ -540,7 +540,7 @@ out:
>  #define IRIX_P_PGID   2
>  #define IRIX_P_ALL    7
>
> -extern int getrusage(struct task_struct *, int, struct rusage __user *);
> +extern int getrusage_both(struct task_struct *, struct rusage __user *);

I think it's better sense to move this declaration to include/.

> -static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
> +int getrusage_children(struct rusage __user *ru)
>  {
> -	struct task_struct *t;
>  	unsigned long flags;
> +	int lockflag = 0;
>  	cputime_t utime, stime;
> +	struct task_struct *p = current;
> +	struct rusage r;
> +	memset((char *) &r, 0, sizeof (r));
>
> -	memset((char *) r, 0, sizeof *r);
> +	if (!thread_group_empty(p)) {
> +		read_lock(&tasklist_lock);
> +		if (unlikely(!p->signal)) {
> +			read_unlock(&tasklist_lock);
> +			goto ret;

Is this possible? 'current' always has valid signal/sighand.
Or better say, process can't call getrusage after exit_signal().

> +		}
> +		spin_lock_irqsave(&p->sighand->siglock, flags);
> +		lockflag = 1;
> +	}

What if another thread just exited? I think you need 'else smp_rmb()'.
here. Otherwise cpu can read signal->c* out of order.

> +int getrusage_self(struct rusage __user *ru)

Same comments.

> +int getrusage_both(struct task_struct *p, struct rusage __user *ru)
>  {
> +	unsigned long flags;
> +	cputime_t utime, stime;
>  	struct rusage r;
> +	struct task_struct *t;
> +	memset((char *) &r, 0, sizeof (r));
> +
>  	read_lock(&tasklist_lock);
> -	k_getrusage(p, who, &r);
> +	if (unlikely(!p->signal)) {
> +		read_unlock(&tasklist_lock);
> +		goto ret;
> +	}
> +
> +	spin_lock_irqsave(&p->sighand->siglock, flags);
> +	utime = p->signal->cutime;
> +	stime = p->signal->cstime;
> +	r.ru_nvcsw = p->signal->cnvcsw;
> +	r.ru_nivcsw = p->signal->cnivcsw;
> +	r.ru_minflt = p->signal->cmin_flt;
> +	r.ru_majflt = p->signal->cmaj_flt;
> +	spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +
> +	utime = cputime_add(utime, p->signal->utime);
> +	stime = cputime_add(stime, p->signal->stime);
> +	r.ru_nvcsw += p->signal->nvcsw;
> +	r.ru_nivcsw += p->signal->nivcsw;
> +	r.ru_minflt += p->signal->min_flt;
> +	r.ru_majflt += p->signal->maj_flt;
> +
> +	t = p;
> +	do {
> +		utime = cputime_add(utime, t->utime);
> +		stime = cputime_add(stime, t->stime);
> +		r.ru_nvcsw += t->nvcsw;
> +		r.ru_nivcsw += t->nivcsw;
> +		r.ru_minflt += t->min_flt;
> +		r.ru_majflt += t->maj_flt;
> +		t = next_thread(t);
> +	} while (t != p);
> +
>  	read_unlock(&tasklist_lock);
> +	cputime_to_timeval(utime, &r.ru_utime);
> +	cputime_to_timeval(stime, &r.ru_stime);
> +
> +ret:
>  	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
>  }

Looks we can factor out some code.

Actually I dont't understand why can't we move the locking into
k_getrusage,

k_getrusage()

	lock_flag = (p == current && thread_group_empty(p));
	if (lockflag) {
		read_lock(&tasklist_lock);
		spin_lock_irqsave(&p->sighand->siglock, flags);
	}

	and remove ->sighand locking under 'switch' statement.

Isn't this enough to solve perfomance problems?

Oleg.
