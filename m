Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWCTSIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWCTSIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWCTSIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:08:12 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:4796 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750742AbWCTSIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:08:10 -0500
Message-ID: <441EEEC8.D4D9C40A@tv-sign.ru>
Date: Mon, 20 Mar 2006 21:04:56 +0300
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
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com> <20060106194623.GA4078@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ravikiran,

Ravikiran G Thirumalai wrote:
> 
> Following patch avoids taking the global tasklist_lock when possible,
> if a process is single threaded during getrusage().  Any avoidance of
> tasklist_lock is good for NUMA boxes (and possibly for large SMPs).
>
> ...
>
>  static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
> @@ -1681,14 +1697,22 @@ static void k_getrusage(struct task_stru
>         struct task_struct *t;
>         unsigned long flags;
>         cputime_t utime, stime;
> +       int need_lock = 0;
> 
>         memset((char *) r, 0, sizeof *r);
> -
> -       if (unlikely(!p->signal))
> -               return;
> -
>         utime = stime = cputime_zero;
> 
> +       need_lock = (p != current || !thread_group_empty(p));
> +       if (need_lock) {
> +               read_lock(&tasklist_lock);
> +               if (unlikely(!p->signal)) {
> +                       read_unlock(&tasklist_lock);
> +                       return;
> +               }
> +       } else
> +               /* See locking comments above */
> +               smp_rmb();
> +

I think now it is possible to improve this patch.

Could you look at these patches?

	[PATCH] introduce lock_task_sighand() helper
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114028190927763

	[PATCH 0/3] make threads traversal ->siglock safe
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114064825626496

I think we can forget about tasklist_lock in k_getrusage() completely
and just use lock_task_sighand().

What do you think?

Oleg.
