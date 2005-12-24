Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVLXQhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVLXQhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 11:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVLXQhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 11:37:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:60896 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751246AbVLXQhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 11:37:25 -0500
Message-ID: <43AD8AF6.387B357A@tv-sign.ru>
Date: Sat, 24 Dec 2005 20:52:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded 
 process at getrusage()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
>
> +int getrusage_both(struct task_struct *p, struct rusage __user *ru)
>  {
> +	unsigned long flags;
> +	int lockflag = 0;
> +	cputime_t utime, stime;
>  	struct rusage r;
> -	read_lock(&tasklist_lock);
> -	k_getrusage(p, who, &r);
> -	read_unlock(&tasklist_lock);
> +	struct task_struct *t;
> +	memset((char *) &r, 0, sizeof (r));
> +
> +	if (unlikely(!p->signal))
> +		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> +
> +	if (!thread_group_empty(p)) {
> +		read_lock(&tasklist_lock);
> +		lockflag = 1;
> +	}

I can't understand this. 'p' can do clone(CLONE_THREAD) immediately
after 'if (!thread_group_empty(p))' check.

> +	spin_lock_irqsave(&p->sighand->siglock, flags);

It is unsafe to do (unless p == current or tasklist held) even if
'p' is the only one process in the thread group.

p->sighand can be changed (and even freed) if 'p' does exec, see
de_thread().

p->sighand may be NULL , nothing prevents 'p' from release_task(p).
This patch checks p->signal, but this is meaningless unless it was
done under tasklist_lock.

Oleg.
