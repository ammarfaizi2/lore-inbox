Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVLSFN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVLSFN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 00:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVLSFN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 00:13:26 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:32649 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030264AbVLSFN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 00:13:26 -0500
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
Date: Mon, 19 Dec 2005 00:12:46 -0500
Message-Id: <1134969166.13138.240.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:37 +0100, Ingo Molnar wrote:
> +static inline void __mutex_unlock_nonatomic(struct mutex *lock
> __IP_DECL__)
> +{
> +       struct thread_info *ti = current_thread_info();
> +       unsigned long flags;
> +
> +       debug_lock_irqsave(&debug_lock, flags, ti);
> +       spin_lock(&lock->wait_lock);
> +
> +#ifdef CONFIG_DEBUG_MUTEXESS
> +       DEBUG_WARN_ON(lock->magic != lock);
> +       DEBUG_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
> +       DEBUG_WARN_ON(lock->owner != ti);
> +       if (debug_on) {
> +               DEBUG_WARN_ON(list_empty(&lock->held_list));
> +               list_del_init(&lock->held_list);
> +       }
> +#endif
> +

The unlikely below is only for the non MUTEX_LOCKLESS_FASTPATH case.
Maybe have a define for the unlikely?

#ifdef MUTEX_LOCKLESS_FASTPATH
#  define UNLIKELY_SLOW(x) x
#else
#  define UNLIKELY_SLOW(x) unlikely(x)
#endif

-- Steve


> +       if (unlikely(!list_empty(&lock->wait_list)))
> +               __mutex_wakeup_waiter(lock __IP__);
> +#ifdef CONFIG_DEBUG_MUTEXESS
> +       lock->owner = NULL;
> +#endif

