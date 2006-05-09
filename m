Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWEIOtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWEIOtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWEIOtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:49:50 -0400
Received: from dvhart.com ([64.146.134.43]:64738 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751757AbWEIOtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:49:49 -0400
Message-ID: <4460AC06.4000303@mbligh.org>
Date: Tue, 09 May 2006 07:49:42 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
References: <20060509084945.373541000@sous-sol.org> <20060509085154.095325000@sous-sol.org>
In-Reply-To: <20060509085154.095325000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * The use of 'barrier' in the following reflects their use as local-lock
> + * operations. Reentrancy must be prevented (e.g., __cli()) /before/ following
> + * critical operations are executed. All critical operations must complete
> + * /before/ reentrancy is permitted (e.g., __sti()). Alpha architecture also
> + * includes these barriers, for example.
> + */

Seems like an odd comment to have in an i386 header file.

> +#define __cli()								\
> +do {									\
> +	struct vcpu_info *_vcpu;					\
> +	preempt_disable();						\
> +	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> +	_vcpu->evtchn_upcall_mask = 1;					\
> +	preempt_enable_no_resched();					\
> +	barrier();							\
> +} while (0)

Should be a real function

> +#define __sti()								\
> +do {									\
> +	struct vcpu_info *_vcpu;					\
> +	barrier();							\
> +	preempt_disable();						\
> +	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> +	_vcpu->evtchn_upcall_mask = 0;					\
> +	barrier(); /* unmask then check (avoid races) */		\
> +	if (unlikely(_vcpu->evtchn_upcall_pending))			\
> +		force_evtchn_callback();				\
> +	preempt_enable();						\
> +} while (0)

Should be a real function

> +#define __save_flags(x)							\
> +do {									\
> +	struct vcpu_info *_vcpu;					\
> +	preempt_disable();						\
> +	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> +	(x) = _vcpu->evtchn_upcall_mask;				\
> +	preempt_enable();						\
> +} while (0)

Should be a real function

> +#define __restore_flags(x)						\
> +do {									\
> +	struct vcpu_info *_vcpu;					\
> +	barrier();							\
> +	preempt_disable();						\
> +	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> +	if ((_vcpu->evtchn_upcall_mask = (x)) == 0) {			\
> +		barrier(); /* unmask then check (avoid races) */	\
> +		if (unlikely(_vcpu->evtchn_upcall_pending))		\
> +			force_evtchn_callback();			\
> +		preempt_enable();					\
> +	} else								\
> +		preempt_enable_no_resched();				\
> +} while (0)

Should be a real function

> +#define safe_halt()		((void)0)
> +#define halt()			((void)0)
> +
> +#define __save_and_cli(x)						\
> +do {									\
> +	struct vcpu_info *_vcpu;					\
> +	preempt_disable();						\
> +	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> +	(x) = _vcpu->evtchn_upcall_mask;				\
> +	_vcpu->evtchn_upcall_mask = 1;					\
> +	preempt_enable_no_resched();					\
> +	barrier();							\
> +} while (0)

Should be a real function

> +#define local_irq_save(x)	__save_and_cli(x)
> +#define local_irq_restore(x)	__restore_flags(x)
> +#define local_save_flags(x)	__save_flags(x)
> +#define local_irq_disable()	__cli()
> +#define local_irq_enable()	__sti()
> +
> +/* Cannot use preempt_enable() here as we would recurse in preempt_sched(). */
> +#define irqs_disabled()							\
> +({	int ___x;							\
> +	struct vcpu_info *_vcpu;					\
> +	preempt_disable();						\
> +	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
> +	___x = (_vcpu->evtchn_upcall_mask != 0);			\
> +	preempt_enable_no_resched();					\
> +	___x; })
> +
> +#endif /* __KERNEL__ */

Should be a real function
