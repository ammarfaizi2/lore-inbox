Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWDTEzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWDTEzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 00:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWDTEzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 00:55:38 -0400
Received: from mga05.intel.com ([192.55.52.89]:58383 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751274AbWDTEzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 00:55:37 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="26125377:sNHT4590475442"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="26125340:sNHT3767647912"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25317932:sNHT21172711"
Date: Wed, 19 Apr 2006 21:53:00 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: Re: [(resend)patch 7/7] Kprobes - Register for page fault notify on active probes
Message-ID: <20060419215300.C6150@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060419221419.382297865@csdlinux-2.jf.intel.com> <20060419221948.714146860@csdlinux-2.jf.intel.com> <20060420035735.GA3637@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060420035735.GA3637@in.ibm.com>; from ananth@in.ibm.com on Thu, Apr 20, 2006 at 09:27:35AM +0530
X-OriginalArrivalTime: 20 Apr 2006 04:55:25.0060 (UTC) FILETIME=[A2E58440:01C66436]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 09:27:35AM +0530, Ananth N Mavinakayanahalli wrote:
> On Wed, Apr 19, 2006 at 03:14:26PM -0700, Anil S Keshavamurthy wrote:
> > With this patch Kprobes now registers for page fault notifications only
> > when their is an active probe registered. Once all the active probes are
> > unregistered their is no need to be notified of page faults and kprobes
> > unregisters itself from the page fault notifications. Hence we
> > will have ZERO side effects when no probes are active.
> 
> This patch isn't complete yet... comments below.
>  
> > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > ---
> >  kernel/kprobes.c |   25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
> > ===================================================================
> > --- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
> > +++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
> > @@ -47,11 +47,17 @@
> >  
> >  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
> >  static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
> > +static atomic_t kprobe_count;
> >  
> >  DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
> >  DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
> >  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
> >  
> > +static struct notifier_block kprobe_page_fault_nb = {
> > +	.notifier_call = kprobe_exceptions_notify,
> > +	.priority = 0x7fffffff /* we need to notified first */
> > +};
> > +
> >  #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
> >  /*
> >   * kprobe->ainsn.insn points to the copy of the instruction to be
> > @@ -464,6 +470,8 @@ static int __kprobes __register_kprobe(s
> >  	old_p = get_kprobe(p->addr);
> >  	if (old_p) {
> >  		ret = register_aggr_kprobe(old_p, p);
> > +		if (!ret)
> > +			atomic_inc(&kprobe_count);
> >  		goto out;
> >  	}
> >  
> > @@ -474,6 +482,9 @@ static int __kprobes __register_kprobe(s
> >  	hlist_add_head_rcu(&p->hlist,
> >  		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
> >  
> > +	if(atomic_add_return(1, &kprobe_count) == 2)
> 	^^^
> 	if (..) please, here and elsewhere
> 
> This will not work as desired for i386 (i386 no longer has a kprobe on the
> trampoline) and sparc64 (no retprobe support).
Instead of hardcoding value 2, #define KPROBE_ARCH_INITIAL_COUNT x
should do the trick.
> 
> > +		register_page_fault_notifier(&kprobe_page_fault_nb);
> > +
> >    	arch_arm_kprobe(p);
> >  
> >  out:
> > @@ -523,9 +534,13 @@ valid_p:
> >  		cleanup_p = 0;
> >  	}
> >  
> > +	if(atomic_add_return(-1, &kprobe_count) == 1)
> > +		unregister_page_fault_notifier(&kprobe_page_fault_nb);
> 
> Same here - i386 and sparc64 need different checks.
Yup, will take care in my next version.

> 
> > +	else
> > +		synchronize_rcu();
> 
> As of now, synchronize_sched() is aliased to synchronize_rcu() but I am
> told its scheduled to change in the future.
> 
> Please revert this back to synchronize_sched().
> 
I will revert it back in my take2 :)

Thanks again for your valuable feedback.

-Anil Keshavamurthy
