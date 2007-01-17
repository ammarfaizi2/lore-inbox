Return-Path: <linux-kernel-owner+w=401wt.eu-S1751252AbXAQGf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbXAQGf5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXAQGf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:35:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36141 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbXAQGf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:35:56 -0500
Date: Wed, 17 Jan 2007 07:34:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: On some configs, sparse spinlock balance checking is broken
Message-ID: <20070117063450.GC14027@elte.hu>
References: <adaejpumt41.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaejpumt41.fsf@cisco.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0098]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <rdreier@cisco.com> wrote:

> (Ingo -- you seem to be the last person to touch all this stuff, and I 
> can't untangle what you did, hence I'm sending this email to you)
> 
> On at least some of my configs on x86_64, when running sparse, I see 
> bogus 'warning: context imbalance in '<func>' - wrong count at exit'.
> 
> This seems to be because I have CONFIG_SMP=y, CONFIG_DEBUG_SPINLOCK=n
> and CONFIG_PREEMPT=n.  Therefore, <linux/spinlock.h> does
> 
> 	#define spin_lock(lock)			_spin_lock(lock)
> 
> which picks up
> 
> 	void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
> 
> from <linux/spinlock_api_smp.h>, but <linux/spinlock.h> also has:
> 
> 	#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
> 		!defined(CONFIG_SMP)
> 	//...
> 	#else
> 	# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)

this is the direct-inlining speedup some people insisted on.

> and <asm-x86_64/spinlock.h> has:
> 
> 	static inline void __raw_spin_unlock(raw_spinlock_t *lock)
> 	{
> 		asm volatile("movl $1,%0" :"=m" (lock->slock) :: "memory");
> 	}
> 
> so sparse doesn't see any __releases() to match the __acquires.
> 
> This all seems to go back to commit bda98685 ("x86: inline spin_unlock
> if !CONFIG_DEBUG_SPINLOCK and !CONFIG_PREEMPT") but I don't know what
> motivated that change.
> 
> Anyway, Ingo or anyone else, what's the best way to fix this?  Maybe 
> the right way to fix this is just to define away __acquires/__releases 
> unless CONFIG_DEBUG_SPINLOCK is set, but that seems suboptimal.

i think the right way to fix it might be to define a _spin_unlock() 
within those #ifdef branches, and then to define spin_lock as:

static inline void spin_lock(spinlock_t *lock) __acquires(lock)
{
	_spin_lock(lock);
}

?

	Ingo
