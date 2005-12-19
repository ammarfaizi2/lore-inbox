Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVLSFBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVLSFBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 00:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLSFBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 00:01:09 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:1460 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030257AbVLSFBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 00:01:07 -0500
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013718.GA28038@elte.hu>
References: <20051219013718.GA28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 00:00:06 -0500
Message-Id: <1134968406.13138.235.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:37 +0100, Ingo Molnar wrote:
> +static inline int
> +__mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter,
> +                   struct thread_info *ti, struct task_struct *task,
> +                   unsigned long *flags, unsigned long task_state
> __IP_DECL__)
> +{
> +       unsigned int old_val;
> +
> +       debug_lock_irqsave(&debug_lock, *flags, ti);
> +       DEBUG_WARN_ON(lock->magic != lock);
> +

How expensive is the xchg?  Since __mutex_lock_common is called even
when it's going to wake up. Maybe it might be more efficient to add
something like:

          if (atomic_cmpxchg(&lock->count, 1, 0) {
              debug_set_owner(lock, ti __IP__);
              debug_unlock_irqrestore(&debug_lock, *flags, ti);
              return 1;
	  }

This way we save the overhead of grabbing another spinlock, adding the
task to the wait_list and changing it's state.


> +       spin_lock(&lock->wait_lock);
> +       __add_waiter(lock, waiter, ti, task __IP__);
> +       set_task_state(task, task_state);
> +
> +       /*
> +        * Lets try to take the lock again - this is needed even if
> +        * we get here for the first time (shortly after failing to
> +        * acquire the lock), to make sure that we get a wakeup once
> +        * it's unlocked. Later on this is the operation that gives
> +        * us the lock. We need to xchg it to -1, so that when we
> +        * release the lock, we properly wake up other waiters!
> +        */
> +       old_val = atomic_xchg(&lock->count, -1);
> +
> +       if (old_val == 1) {

-- Steve


