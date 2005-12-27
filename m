Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVL0Lvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVL0Lvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 06:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVL0Lvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 06:51:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53639 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751102AbVL0Lvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 06:51:48 -0500
Date: Tue, 27 Dec 2005 12:51:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/3] mutex subsystem: trylock
Message-ID: <20051227115129.GB23587@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
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


* Nicolas Pitre <nico@cam.org> wrote:

> In the spirit of uniformity, this patch provides architecture specific 
> trylock implementations.  This allows for a pure xchg-based 
> implementation, as well as an optimized ARMv6 implementation.

hm, i dont really like the xchg variant:

> +static inline int
> +__mutex_trylock(atomic_t *count)
> +{
> +	int prev = atomic_xchg(count, 0);
> +
> +	if (unlikely(prev < 0)) {
> +		/*
> +		 * The lock was marked contended so we must restore that
> +		 * state. If while doing so we get back a prev value of 1
> +		 * then we just own it.
> +		 *
> +		 * IN all cases this has the potential to trigger the
> +		 * slowpath for the owner's unlock path - but this is not
> +		 * a big problem in practice.
> +		 */
> +		prev = atomic_xchg(count, -1);
> +		if (prev < 0)
> +			prev = 0;
> +	}

here we go to great trouble trying to avoid the 'slowpath', while we 
unconditionally force the next unlock into the slowpath! So we have not 
won anything. (on a cycle count basis it's probably even a net loss)

The same applies to atomic_dec_return() based trylock variant. Only the 
cmpxchg based one, and the optimized ARM variant should be used as a 
'fastpath'.

another thing is that this solution still leaves that ugly #ifdef in 
kernel/mutex.c.

so i took a different solution that solves both problems. The API 
towards architectures is now:

 static inline int
 __mutex_fastpath_trylock(atomic_t *count, int (*fn)(atomic_t *))

note the new 'fn' parameter: this enables mutex-null.h to do a simple:

 #define __mutex_fastpath_trylock(count, fn_name)        fn_name(count)

and the final ugly debugging related #ifdef is gone from kernel/mutex.c!  
Furthermore, both the mutex-xchg.h and the mutex-dec.h non-cmpxchg 
variant will fall back to the spinlock implementation.

	Ingo
