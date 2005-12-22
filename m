Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVLVMxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVLVMxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVLVMxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:53:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11729 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964839AbVLVMxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:53:38 -0500
Date: Thu, 22 Dec 2005 13:52:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 5/9] mutex subsystem, core
Message-ID: <20051222125255.GA21661@elte.hu>
References: <20051222114233.GF18878@elte.hu> <20051222115753.GB30964@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222115753.GB30964@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > +#include <linux/config.h>
> 
> we don't need config.h anymore, it's included implicitly now.

thanks, fixed.

> > +#include <asm/atomic.h>
> 
> Any chance we could include this after the <linux/*.h> headers ?

done.

> > +#include <linux/spinlock_types.h>
> 
> What do we need this one for?

for:

        spinlock_t              wait_lock;

> > +struct mutex {
> > +	// 1: unlocked, 0: locked, negative: locked, possible waiters
> 
> please use /* */ comments.

done.

> 
> > +	atomic_t		count;
> > +	spinlock_t		wait_lock;
> > +	struct list_head	wait_list;
> > +#ifdef CONFIG_DEBUG_MUTEXES
> > +	struct thread_info	*owner;
> > +	struct list_head	held_list;
> > +	unsigned long		acquire_ip;
> > +	const char 		*name;
> > +	void			*magic;
> > +#endif
> > +};
> 
> I know we generally don't like typedefs, but mutex is like spinlocks 
> one of those cases where the internals should be completely opaqueue, 
> so a mutex_t sounds like a good idea.

yeah, but we have DEFINE_MUTEX ...

> > +#include <linux/syscalls.h>
> 
> What do you we need this header for?

correct, fixed.

> > +static inline void __mutex_lock_atomic(struct mutex *lock)
> > +{
> > +#ifdef __ARCH_WANT_XCHG_BASED_ATOMICS
> > +	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
> > +		__mutex_lock_noinline(&lock->count);
> > +#else
> > +	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
> > +#endif
> > +}
> 
> this is the kind of thing I meant in the comment to the announcement.

i've solved that via the CONFIG_MUTEX_XCHG_ALGORITHM switch. It's more 
maintainable than 23 asm-*/mutex.h's.

> Just having this in arch code would kill all these ifdefs over mutex.c

it's exactly 3 #ifdefs.

	Ingo
