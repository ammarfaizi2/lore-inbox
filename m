Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWAHKda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWAHKda (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWAHKda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:33:30 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:6609 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1161176AbWAHKd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:33:29 -0500
Message-ID: <43C0FC4B.567D18DC@tv-sign.ru>
Date: Sun, 08 Jan 2006 14:49:31 +0300
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
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay,

Ravikiran G Thirumalai wrote:
> 
>  static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
> @@ -1681,14 +1697,22 @@ static void k_getrusage(struct task_stru
>         struct task_struct *t;
>         unsigned long flags;
>         cputime_t utime, stime;
> +       int need_lock = 0;

Unneeded initialization

>         memset((char *) r, 0, sizeof *r);
> -
> -       if (unlikely(!p->signal))
> -               return;
> -
>         utime = stime = cputime_zero;
> 
> +       need_lock = !(p == current && thread_group_empty(p));
> +       if (need_lock) {
> +               read_lock(&tasklist_lock);
> +               if (unlikely(!p->signal)) {
> +                       read_unlock(&tasklist_lock);
> +                       return;
> +               }
> +       } else
> +               /* See locking comments above */
> +               smp_rmb();

This patch doesn't try to optimize ->sighand.siglock locking,
and I think this is right. But this also means we don't need
rmb() here. It was needed to protect against "another thread
just exited, cpu can read ->c* values before thread_group_empty()
without taking siglock" case, now it is not possible.

Oleg.
