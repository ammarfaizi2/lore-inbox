Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWDUIQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWDUIQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWDUIQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:16:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:8356 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932270AbWDUIQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:16:26 -0400
X-Authenticated: #14349625
Subject: Re: [RFC][PATCH 3/9] CPU controller - Adds timeslice scaling
From: Mike Galbraith <efault@gmx.de>
To: maeda.naoaki@jp.fujitsu.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 10:17:29 +0200
Message-Id: <1145607449.10016.47.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 11:27 +0900, maeda.naoaki@jp.fujitsu.com wrote:
> Index: linux-2.6.17-rc2/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-rc2.orig/kernel/sched.c
> +++ linux-2.6.17-rc2/kernel/sched.c
> @@ -173,10 +173,17 @@
>  
>  static unsigned int task_timeslice(task_t *p)
>  {
> +	unsigned int timeslice;
> +
>  	if (p->static_prio < NICE_TO_PRIO(0))
> -		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
> +		timeslice = SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
>  	else
> -		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
> +		timeslice = SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
> +
> +	if (!TASK_INTERACTIVE(p))
> +		timeslice = cpu_rc_scale_timeslice(p, timeslice);
> +
> +	return timeslice;
>  }

Why does timeslice scaling become undesirable if TASK_INTERACTIVE(p)?
With this barrier, you will completely disable scaling for many loads.

Is it possible you meant !rt_task(p)?

(The only place I can see scaling as having a large effect is on gobs of
non-sleeping tasks.  Slice width doesn't mean much otherwise.)

	-Mike

