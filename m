Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWDXJS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWDXJS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWDXJS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:18:57 -0400
Received: from mga06.intel.com ([134.134.136.21]:4679 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751192AbWDXJS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:18:56 -0400
X-IronPort-AV: i="4.04,151,1144047600"; 
   d="scan'208"; a="26846456:sNHT37884378"
X-IronPort-AV: i="4.04,151,1144047600"; 
   d="scan'208"; a="26846449:sNHT20670881"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,151,1144047600"; 
   d="scan'208"; a="27686047:sNHT18260746"
Message-ID: <444C9805.4060303@linux.intel.com>
Date: Mon, 24 Apr 2006 17:19:01 +0800
From: bibo mao <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
CC: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 7/7] Notify page fault call chain
References: <20060420232456.712271992@csdlinux-2.jf.intel.com> <20060420233912.570729645@csdlinux-2.jf.intel.com>
In-Reply-To: <20060420233912.570729645@csdlinux-2.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2006 09:18:53.0576 (UTC) FILETIME=[1B28A080:01C66780]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some questions about page fault call chain.
1) Can kprobe_exceptions_notify be divided into two sub-functions, one 
is for die call chain, which handles DIE_BREAK/DIE_FAULT trap, the other 
is specially for DIE_PAGE_FAULT trap.

2) page_fault_notifier is conditionally registered/unregistered in this 
patch, notify_page_fault(DIE_PAGE_FAULT...) is unconditionally called in 
  ia64_do_page_fault() function. I do not know whether it is possible to 
unconditionally register page_fault_notifier() call chain, but 
conditionally call notify_page_fault(DIE_PAGE_FAULT...) function.

3) I do know whether there are other conditions like kdb/kgdb which need
call page fault call chain when page fault happens. If only kprobe need 
handle page fault, then I think kprobe_exceptions_notify can be called 
directly in ia64_do_page_fault() function. Of course,  the call chain 
method is more convenient and easy to extend for other fault causes(like 
kdb/kgdb).

thanks
bibo,mao

Anil S Keshavamurthy wrote:
> With this patch Kprobes now registers for page fault notifications only
> when their is an active probe registered. Once all the active probes are
> unregistered their is no need to be notified of page faults and kprobes
> unregisters itself from the page fault notifications. Hence we
> will have ZERO side effects when no probes are active.
> 
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> ---
>  include/asm-i386/kprobes.h    |    1 +
>  include/asm-ia64/kprobes.h    |    1 +
>  include/asm-powerpc/kprobes.h |    2 ++
>  include/asm-sparc64/kprobes.h |    1 +
>  include/asm-x86_64/kprobes.h  |    1 +
>  kernel/kprobes.c              |   30 +++++++++++++++++++++++-------
>  6 files changed, 29 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.17-rc1-mm3/include/asm-i386/kprobes.h
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/include/asm-i386/kprobes.h
> +++ linux-2.6.17-rc1-mm3/include/asm-i386/kprobes.h
> @@ -44,6 +44,7 @@ typedef u8 kprobe_opcode_t;
>  
>  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
>  #define ARCH_SUPPORTS_KRETPROBES
> +#define  ARCH_INACTIVE_KPROBE_COUNT 0
>  
>  void arch_remove_kprobe(struct kprobe *p);
>  void kretprobe_trampoline(void);
> Index: linux-2.6.17-rc1-mm3/include/asm-ia64/kprobes.h
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/include/asm-ia64/kprobes.h
> +++ linux-2.6.17-rc1-mm3/include/asm-ia64/kprobes.h
> @@ -82,6 +82,7 @@ struct kprobe_ctlblk {
>  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
>  
>  #define ARCH_SUPPORTS_KRETPROBES
> +#define  ARCH_INACTIVE_KPROBE_COUNT 1
>  
>  #define SLOT0_OPCODE_SHIFT	(37)
>  #define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
> Index: linux-2.6.17-rc1-mm3/include/asm-powerpc/kprobes.h
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/include/asm-powerpc/kprobes.h
> +++ linux-2.6.17-rc1-mm3/include/asm-powerpc/kprobes.h
> @@ -50,6 +50,8 @@ typedef unsigned int kprobe_opcode_t;
>  			IS_TWI(instr) || IS_TDI(instr))
>  
>  #define ARCH_SUPPORTS_KRETPROBES
> +#define  ARCH_INACTIVE_KPROBE_COUNT 1
> +
>  void kretprobe_trampoline(void);
>  extern void arch_remove_kprobe(struct kprobe *p);
>  
> Index: linux-2.6.17-rc1-mm3/include/asm-sparc64/kprobes.h
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/include/asm-sparc64/kprobes.h
> +++ linux-2.6.17-rc1-mm3/include/asm-sparc64/kprobes.h
> @@ -13,6 +13,7 @@ typedef u32 kprobe_opcode_t;
>  
>  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
>  #define arch_remove_kprobe(p)	do {} while (0)
> +#define  ARCH_INACTIVE_KPROBE_COUNT 0
>  
>  /* Architecture specific copy of original instruction*/
>  struct arch_specific_insn {
> Index: linux-2.6.17-rc1-mm3/include/asm-x86_64/kprobes.h
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/include/asm-x86_64/kprobes.h
> +++ linux-2.6.17-rc1-mm3/include/asm-x86_64/kprobes.h
> @@ -43,6 +43,7 @@ typedef u8 kprobe_opcode_t;
>  
>  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
>  #define ARCH_SUPPORTS_KRETPROBES
> +#define  ARCH_INACTIVE_KPROBE_COUNT 1
>  
>  void kretprobe_trampoline(void);
>  extern void arch_remove_kprobe(struct kprobe *p);
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
> @@ -474,6 +482,10 @@ static int __kprobes __register_kprobe(s
>  	hlist_add_head_rcu(&p->hlist,
>  		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
>  
> +	if (atomic_add_return(1, &kprobe_count) == \
> +				(ARCH_INACTIVE_KPROBE_COUNT + 1))
> +		register_page_fault_notifier(&kprobe_page_fault_nb);
> +
>    	arch_arm_kprobe(p);
>  
>  out:
> @@ -537,6 +549,16 @@ valid_p:
>  		}
>  		arch_remove_kprobe(p);
>  	}
> +
> +	/* Call unregister_page_fault_notifier()
> +	 * if no probes are active
> +	 */
> +	mutex_lock(&kprobe_mutex);
> +	if (atomic_add_return(-1, &kprobe_count) == \
> +				ARCH_INACTIVE_KPROBE_COUNT)
> +		unregister_page_fault_notifier(&kprobe_page_fault_nb);
> +	mutex_unlock(&kprobe_mutex);
> +	return;
>  }
>  
>  static struct notifier_block kprobe_exceptions_nb = {
> @@ -544,10 +566,6 @@ static struct notifier_block kprobe_exce
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
> @@ -654,14 +672,12 @@ static int __init init_kprobes(void)
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
