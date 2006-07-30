Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWG3Gos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWG3Gos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWG3Gos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:44:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24513 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751173AbWG3Gor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:44:47 -0400
Date: Sun, 30 Jul 2006 08:38:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christian Borntraeger <borntrae@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bug in futex unqueue_me
Message-ID: <20060730063821.GA8748@elte.hu>
References: <200607271841.56342.borntrae@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607271841.56342.borntrae@de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Borntraeger <borntrae@de.ibm.com> wrote:

> From: Christian Borntraeger <borntrae@de.ibm.com>
> 
> This patch adds a barrier() in futex unqueue_me to avoid aliasing of 
> two pointers.
>
> On my s390x system I saw the following oops:

> So the code becomes more or less:
> if (q->lock_ptr != 0) spin_lock(q->lock_ptr)
> instead of
> if (lock_ptr != 0) spin_lock(lock_ptr)
>
> Which caused the oops from above.

interesting, how is this possible? We do a spin_lock(lock_ptr), and 
taking a spinlock is an implicit barrier(). So gcc must not delay 
evaluating lock_ptr to inside the critical section. And as far as i can 
see the s390 spinlock implementation goes through an 'asm volatile' 
piece of code, which is a barrier already. So how could this have 
happened? I have nothing against adding a barrier(), but we should first 
investigate why the spin_lock() didnt act as a barrier - there might be 
other, similar bugs hiding. (we rely on spin_lock()s barrier-ness in a 
fair number of places)

> As a general note, this code of unqueue_me seems a bit fishy. The 
> retry logic of unqueue_me only works if we can guarantee, that the 
> original value of q->lock_ptr is always a spinlock (Otherwise we 
> overwrite kernel memory). We know that q->lock_ptr can change. I dont 
> know what happens with the original spinlock, as I am not an expert 
> with the futex code.

yes, it is always a pointer to a valid spinlock, or NULL. 
futex_requeue() can change the spinlock from one to another, and 
wake_futex() can change it to NULL. The futex unqueue_me() fastpath is 
when a futex waiter was woken - in which case it's NULL. But it can 
still be non-NULL if we timed out or a signal happened, in which case we 
may race with a wakeup or a requeue. futex_requeue() changes the 
spinlock pointer if it holds both the old and the new spinlock. So it's 
race-free as far as i can see.

	Ingo
