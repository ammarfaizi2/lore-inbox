Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVLVMX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLVMX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVLVMX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:23:26 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:41932 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932294AbVLVMX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:23:26 -0500
Message-ID: <43AAAC6F.17CC646@tv-sign.ru>
Date: Thu, 22 Dec 2005 16:38:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 5/9] mutex subsystem, core
References: <20051222114233.GF18878@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> +__mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter,
> +		    struct thread_info *ti,
> +		    unsigned long task_state __IP_DECL__)
> +{
> +	struct task_struct *task = ti->task;
> +	unsigned int old_val;
> +
> +	/*
> +	 * Lets try to take the lock again - this is needed even if
> +	 * we get here for the first time (shortly after failing to
> +	 * acquire the lock), to make sure that we get a wakeup once
> +	 * it's unlocked. Later on this is the operation that gives
> +	 * us the lock. If there are other waiters we need to xchg it
> +	 * to -1, so that when we release the lock, we properly wake
> +	 * up the other waiters:
> +	 */
> +	old_val = atomic_xchg(&lock->count, -1);
> +
> +	if (unlikely(old_val == 1)) {
> +		/*
> +		 * Got the lock - rejoice! But there's one small
> +		 * detail to fix up: above we have set the lock to -1,
> +		 * unconditionally. But what if there are no waiters?
> +		 * While it would work with -1 too, 0 is a better value
> +		 * in that case, because we wont hit the slowpath when
> +		 * we release the lock. We can simply use atomic_set()
> +		 * for this, because we are the owners of the lock now,
> +		 * and are still holding the wait_lock:
> +		 */
> +		if (likely(list_empty(&lock->wait_list)))
> +			atomic_set(&lock->count, 0);

This is a minor issue, but still I think it makes sense to optimize
for uncontended case:

	old_val = atomic_xchg(&lock->count, 0); // no sleepers

	if (old_val == 1) {
		// sleepers ?
		if (!list_empty(&lock->wait_list))
			// need to wakeup them
			atomic_set(&lock->count, -1);
		...
	}

Oleg.
