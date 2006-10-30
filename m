Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWJ3NHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWJ3NHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWJ3NHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:07:14 -0500
Received: from mx.go2.pl ([193.17.41.41]:53413 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S964804AbWJ3NHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:07:12 -0500
Date: Mon, 30 Oct 2006 14:12:41 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Jiri Kosina <jikos@jikos.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: spin_lock_irqsave_nested()
Message-ID: <20061030131241.GA1657@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Jiri Kosina <jikos@jikos.cz>, Marcel Holtmann <marcel@holtmann.org>,
	David Woodhouse <dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162199005.24143.169.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some doubts...

Jarek P.

On 30-10-2006 10:03, Peter Zijlstra wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> Subject: spin_lock_irqsave_nested()
> 
> Introduce spin_lock_irqsave_nested(); implementation from:
>  http://lkml.org/lkml/2006/6/1/122
> Patch from:
>  http://lkml.org/lkml/2006/9/13/258
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  include/linux/spinlock.h         |    5 +++++
>  include/linux/spinlock_api_smp.h |    2 ++
>  include/linux/spinlock_api_up.h  |    1 +
>  kernel/spinlock.c                |   21 +++++++++++++++++++++
>  4 files changed, 29 insertions(+)
> 
> Index: linux-2.6/include/linux/spinlock_api_smp.h
> ===================================================================
> --- linux-2.6.orig/include/linux/spinlock_api_smp.h
> +++ linux-2.6/include/linux/spinlock_api_smp.h
> @@ -32,6 +32,8 @@ void __lockfunc _read_lock_irq(rwlock_t 
>  void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
>  unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
>  							__acquires(lock);
> +unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
> +							__acquires(spinlock_t);

According to neighbours rather:
 +							__acquires(lock);

>  unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
>  							__acquires(lock);
>  unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
> Index: linux-2.6/include/linux/spinlock_api_up.h
> ===================================================================
> --- linux-2.6.orig/include/linux/spinlock_api_up.h
> +++ linux-2.6/include/linux/spinlock_api_up.h
> @@ -59,6 +59,7 @@
>  #define _read_lock_irq(lock)			__LOCK_IRQ(lock)
>  #define _write_lock_irq(lock)			__LOCK_IRQ(lock)
>  #define _spin_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
> +#define _spin_lock_irqsave_nested(lock, flags, subclass) __LOCK_IRQSAVE(lock, flags, subclass)

Is __LOCK_IRQSAVE() with 3 args defined?

>  #define _read_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
>  #define _write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
>  #define _spin_trylock(lock)			({ __LOCK(lock); 1; })
> Index: linux-2.6/include/linux/spinlock.h
> ===================================================================
> --- linux-2.6.orig/include/linux/spinlock.h
> +++ linux-2.6/include/linux/spinlock.h
> @@ -186,6 +186,11 @@ do {								\
>  #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
>  #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
>  #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +#define spin_lock_irqsave_nested(lock, flags, subclass)	flags = _spin_lock_irqsave_nested(lock, subclass)
> +#else
> +#define spin_lock_irqsave_nested(lock, flags, subclass)	flags = _spin_lock_irqsave(lock)
> +#endif
>  #else

Plus for api_up:

+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define spin_lock_irqsave_nested(lock, flags, subclass)	_spin_lock_irqsave_nested(lock, flags, subclass)
+#else
+#define spin_lock_irqsave_nested(lock, flags, subclass)	_spin_lock_irqsave(lock, flags)
+#endif

>  #define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
>  #define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
> Index: linux-2.6/kernel/spinlock.c
> ===================================================================
> --- linux-2.6.orig/kernel/spinlock.c
> +++ linux-2.6/kernel/spinlock.c
> @@ -293,6 +293,27 @@ void __lockfunc _spin_lock_nested(spinlo
>  }
>  
>  EXPORT_SYMBOL(_spin_lock_nested);
> +unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	preempt_disable();
> +	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
> +	/*
> +	 * On lockdep we dont want the hand-coded irq-enable of
> +	 * _raw_spin_lock_flags() code, because lockdep assumes
> +	 * that interrupts are not re-enabled during lock-acquire:
> +	 */
> +#ifdef CONFIG_PROVE_SPIN_LOCKING
> +	_raw_spin_lock(lock);
> +#else
> +	_raw_spin_lock_flags(lock, &flags);
> +#endif
> +	return flags;
> +}
> +
> +EXPORT_SYMBOL(_spin_lock_irqsave_nested);
>  
>  #endif
>  
> 

Shouldn't this _nested locks be considered in: 
#else /* CONFIG_PREEMPT: */
part?
