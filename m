Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269085AbUIQWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269085AbUIQWmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUIQWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:41:00 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:176 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269085AbUIQWgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:36:07 -0400
Message-ID: <414B6583.5080809@sgi.com>
Date: Fri, 17 Sep 2004 15:30:27 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Tim Schmielau <tim@physik3.uni-rostock.de>
CC: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       CSA-ML <csa@oss.sgi.com>, Arthur Corliss <corliss@digitalmages.com>,
       Erik Jacobson <erikj@dbear.engr.sgi.com>, Limin Gu <limin@engr.sgi.com>,
       John Hesterberg <jh@sgi.com>
Subject: Re: [PATCH 2.6.8.1 3/4] CSA  csa_eop: accounting end-of-process hook
References: <4140A9D2.3010602@engr.sgi.com> <4140ABD2.90908@engr.sgi.com>
In-Reply-To: <4140ABD2.90908@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Tim,

I found i can eliminate this csa_eop patch.

Two ways to do this, depending on whether we want to view
linux/kernel/acct.c as a non-essential part of kernel and
another accounting package that CSA will replace.

If we decide we do not need to have acct.c in the kernel, it can be
controlled by a new config flag, say CONFIG_BSD_ACCT, and do this:
     do_eop_acct = acct_process;
at BSD acct initialization.

If we decide to always have BSD acct on, i can propose a new patch
to move do_eop_acct declaration into acct.c and at the beginning of
acct_process() routine, which is invoked at do_exit(), i will check
do_eop_acctL: if do_eop_acct is not NULL, do_eop_acct() would be
called and exits acct_process() upon return (ie, a competing accounting
package is running); otherwise, it continues do BSD acct processing.

What do you think? Which path i should walk down?

Thanks,
  - jay


Jay Lan wrote:
> Linux Comprehensive System Accounting (CSA) is a set of C programs and
> shell scripts that, like other accounting packages, provide methods for
> collecting per-process resource usage data, monitoring disk usage, and
> charging fees to specific login accounts.
> 
> The CSA patchset includes csa_io, csa_mm, csa_eop and csa_module.
> Patches csa_io, csa_mm, and csa_eop are responsible for system
> accounting data collection and are independent of each other.
> 
> csa_eop is a patch that provides a hook for end-of-process handling.
> 
> Please find CSA project at http://oss.sgi.com/projects/csa. This set of
> csa patches has been tested with the pagg and job kernel patches.
> The information of pagg and job project can be found at
> http://oss.sgi.com/projects/pagg/
> 
> 
> Signed-off-by: Jay Lan <jlan@sgi.com>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linux/kernel/exit.c
> ===================================================================
> --- linux.orig/kernel/exit.c	2004-09-03 17:17:03.000000000 -0700
> +++ linux/kernel/exit.c	2004-09-03 17:17:03.000000000 -0700
> @@ -33,6 +33,8 @@
>  
>  extern void sem_exit (void);
>  extern struct task_struct *child_reaper;
> +void (*do_eop_acct) (int, struct task_struct *) = NULL;
> +EXPORT_SYMBOL(do_eop_acct);
>  
>  int getrusage(struct task_struct *, int, struct rusage __user *);
>  
> @@ -826,6 +828,9 @@
>  	csa_update_integrals();
>  	update_mem_hiwater();
>  	acct_process(code);
> +	/* Handle end-of-process accounting */
> +	if (do_eop_acct != NULL)
> +		do_eop_acct(code, tsk);
>  	__exit_mm(tsk);
>  
>  	exit_sem(tsk);
> Index: linux/include/linux/acct.h
> ===================================================================
> --- linux.orig/include/linux/acct.h	2004-08-13 22:36:32.000000000 -0700
> +++ linux/include/linux/acct.h	2004-09-03 17:17:03.000000000 -0700
> @@ -185,6 +185,13 @@
>         return x;
>  }
>  
> +/*
> + * extern declaration that provides the hook needed for processing of
> + * end-of-process accounting record
> + *
> + */
> +extern void (*do_eop_acct) (int, struct task_struct *);
> +
>  #endif  /* __KERNEL */
>  
>  #endif	/* _LINUX_ACCT_H */

