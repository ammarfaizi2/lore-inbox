Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWDTD6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWDTD6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 23:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWDTD6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 23:58:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:54958 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751197AbWDTD6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 23:58:03 -0400
Date: Thu, 20 Apr 2006 09:27:35 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: Re: [(resend)patch 7/7] Kprobes - Register for page fault notify on active probes
Message-ID: <20060420035735.GA3637@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060419221419.382297865@csdlinux-2.jf.intel.com> <20060419221948.714146860@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419221948.714146860@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 03:14:26PM -0700, Anil S Keshavamurthy wrote:
> With this patch Kprobes now registers for page fault notifications only
> when their is an active probe registered. Once all the active probes are
> unregistered their is no need to be notified of page faults and kprobes
> unregisters itself from the page fault notifications. Hence we
> will have ZERO side effects when no probes are active.

This patch isn't complete yet... comments below.
 
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> ---
>  kernel/kprobes.c |   25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
> +++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
> @@ -47,11 +47,17 @@
>  
>  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
>  static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
> +static atomic_t kprobe_count;
>  
>  DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
>  DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
>  
> +static struct notifier_block kprobe_page_fault_nb = {
> +	.notifier_call = kprobe_exceptions_notify,
> +	.priority = 0x7fffffff /* we need to notified first */
> +};
> +
>  #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
>  /*
>   * kprobe->ainsn.insn points to the copy of the instruction to be
> @@ -464,6 +470,8 @@ static int __kprobes __register_kprobe(s
>  	old_p = get_kprobe(p->addr);
>  	if (old_p) {
>  		ret = register_aggr_kprobe(old_p, p);
> +		if (!ret)
> +			atomic_inc(&kprobe_count);
>  		goto out;
>  	}
>  
> @@ -474,6 +482,9 @@ static int __kprobes __register_kprobe(s
>  	hlist_add_head_rcu(&p->hlist,
>  		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
>  
> +	if(atomic_add_return(1, &kprobe_count) == 2)
	^^^
	if (..) please, here and elsewhere

This will not work as desired for i386 (i386 no longer has a kprobe on the
trampoline) and sparc64 (no retprobe support).

> +		register_page_fault_notifier(&kprobe_page_fault_nb);
> +
>    	arch_arm_kprobe(p);
>  
>  out:
> @@ -523,9 +534,13 @@ valid_p:
>  		cleanup_p = 0;
>  	}
>  
> +	if(atomic_add_return(-1, &kprobe_count) == 1)
> +		unregister_page_fault_notifier(&kprobe_page_fault_nb);

Same here - i386 and sparc64 need different checks.

> +	else
> +		synchronize_rcu();

Why has this changed from synchronize_sched()? This *must* be
synchronize_sched() since, by definition it'll ensure that all
non-preemptive sections are completed. In contrast, synchronize_rcu()
will just enure rcu_read_lock() sections are complete.

As of now, synchronize_sched() is aliased to synchronize_rcu() but I am
told its scheduled to change in the future.

Please revert this back to synchronize_sched().

Thanks,
Ananth

> +
>  	mutex_unlock(&kprobe_mutex);
>  
> -	synchronize_sched();
>  	if (p->mod_refcounted &&
>  	    (mod = module_text_address((unsigned long)p->addr)))
>  		module_put(mod);
> @@ -544,10 +559,6 @@ static struct notifier_block kprobe_exce
>  	.priority = 0x7fffffff /* we need to notified first */
>  };
>  
> -static struct notifier_block kprobe_page_fault_nb = {
> -	.notifier_call = kprobe_exceptions_notify,
> -	.priority = 0x7fffffff /* we need to notified first */
> -};
>  
>  int __kprobes register_jprobe(struct jprobe *jp)
>  {
> @@ -654,14 +665,12 @@ static int __init init_kprobes(void)
>  		INIT_HLIST_HEAD(&kprobe_table[i]);
>  		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
>  	}
> +	atomic_set(&kprobe_count, 0);
>  
>  	err = arch_init_kprobes();
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
>  
> -	if (!err)
> -		err = register_page_fault_notifier(&kprobe_page_fault_nb);
> -
>  	return err;
>  }
>  
> 
> --
