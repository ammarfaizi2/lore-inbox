Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752112AbWAETNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbWAETNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWAETNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:13:10 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:14467 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1752112AbWAETNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:13:09 -0500
Message-ID: <43BD6FBA.6070805@engr.sgi.com>
Date: Thu, 05 Jan 2006 11:12:58 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove unused acct variables from task_struct
References: <17340.62497.275248.207740@jaguar.mkp.net>
In-Reply-To: <17340.62497.275248.207740@jaguar.mkp.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> This patch removes three acct related variables from struct
> task_struct which are no longer in use. Their values were calculated
> in acct_update_integrals, but never read back by anything.

Please don't. I will send in a patch to display those collected
acct data via proc fs soon. We need those information.

Thanks,
  - jay

> 
> Signed-off-by: Jes Sorensen <jes@sgi.com>
> 
> ----
> 
>  fs/compat.c           |    2 --
>  fs/exec.c             |    2 --
>  include/linux/sched.h |    5 -----
>  kernel/acct.c         |   31 -------------------------------
>  kernel/exit.c         |    1 -
>  kernel/fork.c         |    1 -
>  kernel/sched.c        |    3 ---
>  7 files changed, 45 deletions(-)
> 
> Index: linux-2.6.15/fs/compat.c
> ===================================================================
> --- linux-2.6.15.orig/fs/compat.c
> +++ linux-2.6.15/fs/compat.c
> @@ -44,7 +44,6 @@
>  #include <linux/nfsd/syscall.h>
>  #include <linux/personality.h>
>  #include <linux/rwsem.h>
> -#include <linux/acct.h>
>  #include <linux/mm.h>
>  
>  #include <net/sock.h>		/* siocdevprivate_ioctl */
> @@ -1482,7 +1481,6 @@
>  
>  		/* execve success */
>  		security_bprm_free(bprm);
> -		acct_update_integrals(current);
>  		kfree(bprm);
>  		return retval;
>  	}
> Index: linux-2.6.15/fs/exec.c
> ===================================================================
> --- linux-2.6.15.orig/fs/exec.c
> +++ linux-2.6.15/fs/exec.c
> @@ -47,7 +47,6 @@
>  #include <linux/security.h>
>  #include <linux/syscalls.h>
>  #include <linux/rmap.h>
> -#include <linux/acct.h>
>  #include <linux/cn_proc.h>
>  
>  #include <asm/uaccess.h>
> @@ -1198,7 +1197,6 @@
>  
>  		/* execve success */
>  		security_bprm_free(bprm);
> -		acct_update_integrals(current);
>  		kfree(bprm);
>  		return retval;
>  	}
> Index: linux-2.6.15/include/linux/sched.h
> ===================================================================
> --- linux-2.6.15.orig/include/linux/sched.h
> +++ linux-2.6.15/include/linux/sched.h
> @@ -842,11 +842,6 @@
>  	wait_queue_t *io_wait;
>  /* i/o counters(bytes read/written, #syscalls */
>  	u64 rchar, wchar, syscr, syscw;
> -#if defined(CONFIG_BSD_PROCESS_ACCT)
> -	u64 acct_rss_mem1;	/* accumulated rss usage */
> -	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
> -	clock_t acct_stimexpd;	/* clock_t-converted stime since last update */
> -#endif
>  #ifdef CONFIG_NUMA
>    	struct mempolicy *mempolicy;
>  	short il_next;
> Index: linux-2.6.15/kernel/acct.c
> ===================================================================
> --- linux-2.6.15.orig/kernel/acct.c
> +++ linux-2.6.15/kernel/acct.c
> @@ -571,34 +571,3 @@
>  	do_acct_process(exitcode, file);
>  	fput(file);
>  }
> -
> -
> -/**
> - * acct_update_integrals - update mm integral fields in task_struct
> - * @tsk: task_struct for accounting
> - */
> -void acct_update_integrals(struct task_struct *tsk)
> -{
> -	if (likely(tsk->mm)) {
> -		long delta = tsk->stime - tsk->acct_stimexpd;
> -
> -		if (delta == 0)
> -			return;
> -		tsk->acct_stimexpd = tsk->stime;
> -		tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm);
> -		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
> -	}
> -}
> -
> -/**
> - * acct_clear_integrals - clear the mm integral fields in task_struct
> - * @tsk: task_struct whose accounting fields are cleared
> - */
> -void acct_clear_integrals(struct task_struct *tsk)
> -{
> -	if (tsk) {
> -		tsk->acct_stimexpd = 0;
> -		tsk->acct_rss_mem1 = 0;
> -		tsk->acct_vm_mem1 = 0;
> -	}
> -}
> Index: linux-2.6.15/kernel/exit.c
> ===================================================================
> --- linux-2.6.15.orig/kernel/exit.c
> +++ linux-2.6.15/kernel/exit.c
> @@ -835,7 +835,6 @@
>  				current->comm, current->pid,
>  				preempt_count());
>  
> -	acct_update_integrals(tsk);
>  	if (tsk->mm) {
>  		update_hiwater_rss(tsk->mm);
>  		update_hiwater_vm(tsk->mm);
> Index: linux-2.6.15/kernel/fork.c
> ===================================================================
> --- linux-2.6.15.orig/kernel/fork.c
> +++ linux-2.6.15/kernel/fork.c
> @@ -949,7 +949,6 @@
>  	p->wchar = 0;		/* I/O counter: bytes written */
>  	p->syscr = 0;		/* I/O counter: read syscalls */
>  	p->syscw = 0;		/* I/O counter: write syscalls */
> -	acct_clear_integrals(p);
>  
>   	p->it_virt_expires = cputime_zero;
>  	p->it_prof_expires = cputime_zero;
> Index: linux-2.6.15/kernel/sched.c
> ===================================================================
> --- linux-2.6.15.orig/kernel/sched.c
> +++ linux-2.6.15/kernel/sched.c
> @@ -46,7 +46,6 @@
>  #include <linux/seq_file.h>
>  #include <linux/syscalls.h>
>  #include <linux/times.h>
> -#include <linux/acct.h>
>  #include <asm/tlb.h>
>  
>  #include <asm/unistd.h>
> @@ -2608,8 +2607,6 @@
>  		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
>  	else
>  		cpustat->idle = cputime64_add(cpustat->idle, tmp);
> -	/* Account for system time used */
> -	acct_update_integrals(p);
>  }
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

