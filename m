Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271185AbUJVC3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271185AbUJVC3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271200AbUJVC3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:29:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:10910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271185AbUJVC1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:27:54 -0400
Date: Thu, 21 Oct 2004 19:25:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net
Subject: Re: [Lse-tech] [PATCH 2.6.9 2/2] enhanced accounting data
 collection
Message-Id: <20041021192551.2c2dfe18.akpm@osdl.org>
In-Reply-To: <417863D3.9060907@engr.sgi.com>
References: <41785FE3.806@engr.sgi.com>
	<417863D3.9060907@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't send multiple patches under the same Subject:.  It confuses me
and breaks my patch processing tools (I strip out the "1/2" numbering
because it becomes irrelevant).

Please choose a meaningful and distinct title for each patch.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Jay Lan <jlan@engr.sgi.com> wrote:
>
> 2/2: acct_mm
> 
> Enhanced MM accounting data collection.
> 

> Index: linux/include/linux/sched.h
> ===================================================================
> --- linux.orig/include/linux/sched.h	2004-10-01 17:16:35.105905373 -0700
> +++ linux/include/linux/sched.h	2004-10-14 12:15:33.450280955 -0700
> @@ -249,6 +249,8 @@
>  	struct kioctx		*ioctx_list;
>  
>  	struct kioctx		default_kioctx;
> +
> +	unsigned long hiwater_rss, hiwater_vm;
>  };

	unsigned long hiwater_rss;	/* comment goes here */
	unsigned long hiwater_vm;	/* and here */

>  
>  extern int mmlist_nr;
> @@ -593,6 +595,10 @@
>  
>  /* i/o counters(bytes read/written, #syscalls */
>  	unsigned long rchar, wchar, syscr, syscw;
> +#if defined(CONFIG_BSD_PROCESS_ACCT)
> +	u64 acct_rss_mem1, acct_vm_mem1;
> +	clock_t acct_stimexpd;
> +#endif

Please place the above three fields on separate lines and document them.

It's not clear to me what, semantically, these fields represent.  That's
something which is appropriate for the supporting changelog entry.

> +/* Update highwater values */
> +static inline void update_mem_hiwater(void)
> +{
> +	if (current->mm) {
> +		if (current->mm->hiwater_rss < current->mm->rss) {
> +			current->mm->hiwater_rss = current->mm->rss;
> +		}
> +		if (current->mm->hiwater_vm < current->mm->total_vm) {
> +			current->mm->hiwater_vm = current->mm->total_vm;
> +		}
> +	}
> +}

If this has more than one callsite then it it too big to inline.

If it has a single callsite then it's OK to inline it, but it can and
should be moved into the .c file.

> +
> +static inline void acct_update_integrals(void)
> +{
> +	long delta;
> +
> +	if (current->mm) {
> +		delta = current->stime - current->acct_stimexpd;
> +		current->acct_stimexpd = current->stime;
> +		current->acct_rss_mem1 += delta * current->mm->rss;
> +		current->acct_vm_mem1 += delta * current->mm->total_vm;
> +	}
> +}

Consider caching `current' in a local variable - sometimes gcc likes to
reevaluate it each time and it takes 14 bytes of code per pop.

This function is too big to inline.

> +static inline void acct_clear_integrals(struct task_struct *tsk)
> +{
> +	if (tsk) {
> +		tsk->acct_stimexpd = 0;
> +		tsk->acct_rss_mem1 = 0;
> +		tsk->acct_vm_mem1 = 0;
> +	}
> +}

Do any of the callers pass in a null `tsk'?

