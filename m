Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTLLTVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTLLTVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:21:51 -0500
Received: from holomorphy.com ([199.26.172.102]:15337 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261827AbTLLTVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:21:21 -0500
Date: Fri, 12 Dec 2003 11:21:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: inaky.perez-gonzalez@intel.com
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Message-ID: <20031212192111.GO8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	inaky.perez-gonzalez@intel.com, linux-kernel@vger.kernel.org,
	robustmutexes@lists.osdl.org
References: <0312030051..akdxcwbwbHdYdmdSaFbbcycyc3a~bzd25502@intel.com> <0312030051.paLaLbTdPdUbed6dXcEbXdDajbVdUd6c25502@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0312030051.paLaLbTdPdUbed6dXcEbXdDajbVdUd6c25502@intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> +static inline void __debug_outb (unsigned val, int port) {
> +	__asm__ __volatile__ ("outb %b0,%w1" : : "a" (val), "Nd" (port));
> +}
> +static inline unsigned __debug_inb (int port) {
> +	unsigned value;
> +	__asm__ __volatile__ ("inb %w1,%b0" : "=a" (value) : "Nd" (port));
> +	return value;
> +}
> +static inline
> +void __debug_printstr (const char *str) {
> +	const int port = 0x03f8;  
> +	while (*str) {
> +		while (!(__debug_inb (port + UART_LSR) & UART_LSR_THRE));
> +		__debug_outb (*str++, port+UART_TX);
> +	}
> +	__debug_outb ('\r', port + UART_TX);
> +}
> +#endif

In general, this kind of debug code shouldn't go in "shipped" patches.


On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> +#define assert(c, a...)	 do { if ((DEBUG >= 0) && !(c)) BUG(); } while (0)

assert() is a no-no in Linux, for various reasons.


On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> + * FIXME: is it worth to have get/put? maybe they should be enforced
> + *        for every fuqueue, this way we don't have to query the ops
> + *        structure for the get/put method and if it is there, call
> + *        it. We'd have to move the get/put ops over to the vlocator,
> + *        but that's not much of a problem.
> + *        The decission factor is that an atomic operation needs to
> + *        lock the whole bus and is not as scalable as testing a ptr
> + *        for NULLness.
> + *        For simplicity, probably the idea of forcing the refcount in
> + *        the fuqueue makes sense.

Basically, if there aren't multiple implementations of ->get()/->put()
that need to be disambiguated, this should get left out.


On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> +#if DEBUG > 0
> +/* BUG_ON() firing? Temporary fix, do you have CONFIG_PREEMPT enabled?
> + * either that or disable DEBUG (force #define it to zero). */ 
> +#define CHECK_IRQs() do { BUG_ON (!in_atomic()); } while (0)
> +#else
> +#define CHECK_IRQs() do {} while (0)
> +#endif

This kind of thing isn't good to have in shipped patches either.


On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> +/* Priority-sorted list */
> +struct plist {
> +	unsigned prio;
> +	struct list_head node;
> +};

Maybe the expectation is for short lists, but it might be better to use
an rbtree or other sublinear insertion/removal structure for this. It
would be nice if we had a generic heap structure for this sort of affair.


On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> +void fuqueue_chprio (struct task_struct *task)
> +{
> +	struct fuqueue_ops *ops;
> +	struct fuqueue *fuqueue;
> +	struct fuqueue_waiter *w;
> +	int prio = task->prio;
> +	unsigned long flags;
> +
> +	__ftrace (1, "(%p [%d])\n", task, task->pid);
> +	CHECK_IRQs();
> +	
> +	local_irq_save (flags);
> +	preempt_disable();
> +	get_task_struct (task);
> +next:
> +	/* Who is the task waiting for? safely acquire and lock it */
> +	_raw_spin_lock (&task->fuqueue_wait_lock);
> +	fuqueue = task->fuqueue_wait;
> +	if (fuqueue == NULL)				/* Ok, not waiting */
> +		goto out_task_unlock;
> +	if (!_raw_spin_trylock (&fuqueue->lock)) {      /* Spin dance... */
> +		_raw_spin_unlock (&task->fuqueue_wait_lock);
> +		goto next;
> +	}
> +	ops = fuqueue->ops;
> +	if (ops->get)
> +		ops->get (fuqueue);
> +	
> +	w = task->fuqueue_waiter;
> +	_raw_spin_unlock (&task->fuqueue_wait_lock);
> +	put_task_struct (task);
> +	
> +	/* Ok, we need to propagate the prio change to the fuqueue */
> +	ops = fuqueue->ops;
> +	task = ops->chprio (task, fuqueue, w);
> +	if (task == NULL)
> +		goto out_fuqueue_unlock;
> +
> +	/* Do we need to propagate to the next task */
> +	get_task_struct (task);
> +	_raw_spin_unlock (&fuqueue->lock);
> +	if (ops->put)
> +		ops->put (fuqueue);
> +	ldebug (1, "__set_prio (%d, %d)\n", task->pid, prio);
> +	__set_prio (task, prio);
> +	goto next;
> +
> +out_fuqueue_unlock:
> +	_raw_spin_unlock (&fuqueue->lock);
> +	if (ops->put)
> +		ops->put (fuqueue);
> +	goto out;
> +	
> +out_task_unlock:
> +	_raw_spin_unlock (&task->fuqueue_wait_lock);
> +	put_task_struct (task);
> +out:
> +	local_irq_restore (flags);
> +	preempt_enable();
> +	return;

Heavy use of _raw_spin_lock() like this is a poor practice.


On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> +/** Fuqueue operations for usage within the kernel */
> +struct fuqueue_ops fuqueue_ops = {
> +	.get = NULL,
> +	.put = NULL,
> +	.wait_cancel = __fuqueue_wait_cancel,
> +	.chprio = __fuqueue_chprio
> +};

If this is all ->get() and ->put() are going to be, why bother?


-- wli
