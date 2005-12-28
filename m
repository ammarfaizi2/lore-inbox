Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVL1LXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVL1LXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVL1LXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:23:11 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:13272 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964790AbVL1LXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:23:09 -0500
Message-ID: <43B2874F.F41A9299@tv-sign.ru>
Date: Wed, 28 Dec 2005 15:38:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Ravikiran Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> 
> On Sat, 24 Dec 2005, Oleg Nesterov wrote:
> 
> > I can't understand this. 'p' can do clone(CLONE_THREAD) immediately
> > after 'if (!thread_group_empty(p))' check.
> 
> Only if p != current. As discussed later the lockless approach is
> intened to only be used if p == current.

Unless I missed something this function (getrusage_both) is called
from wait_noreap_copyout,

> +++ linux-2.6.15-rc6/kernel/exit.c	2005-12-23 10:42:16.000000000 -0800
> @@ -38,7 +38,7 @@
>  extern void sem_exit (void);
>  extern struct task_struct *child_reaper;
>  
> -int getrusage(struct task_struct *, int, struct rusage __user *);
> +int getrusage_both(struct task_struct *, struct rusage __user *);
>  
>  static void exit_mm(struct task_struct * tsk);
>  
> @@ -994,7 +994,7 @@
>  			       struct siginfo __user *infop,
>  			       struct rusage __user *rusagep)
>  {
> -	int retval = rusagep ? getrusage(p, RUSAGE_BOTH, rusagep) : 0;
> +	int retval = rusagep ? getrusage_both(p, rusagep) : 0;
>  	put_task_struct(p);

(the diff lacks '-p' parameter)

So p != current.

Oleg.
