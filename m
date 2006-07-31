Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWGaIEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWGaIEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGaIEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:04:37 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:59360 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964818AbWGaIEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:04:36 -0400
From: Christian Borntraeger <borntrae@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] bug in futex unqueue_me
Date: Mon, 31 Jul 2006 10:04:15 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>
References: <200607271841.56342.borntrae@de.ibm.com> <20060730063821.GA8748@elte.hu>
In-Reply-To: <20060730063821.GA8748@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607311004.15878.borntrae@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 08:38, Ingo Molnar wrote:
> interesting, how is this possible? We do a spin_lock(lock_ptr), and
> taking a spinlock is an implicit barrier(). So gcc must not delay
> evaluating lock_ptr to inside the critical section. And as far as i can
> see the s390 spinlock implementation goes through an 'asm volatile'
> piece of code, which is a barrier already. So how could this have
> happened?

spin_lock is a barrier, but isnt the barrierness too late here? The compiler 
reloads the value of lock_ptr after the "if(lock_ptr)" and *before* calling 
spin_lock(lock_ptr):
     3ee:       e3 c0 b0 28 00 04       lg      %r12,40(%r11)
				q->lockptr in r12
     3f4:       b9 02 00 cc             ltgr    %r12,%r12
				load and test r12
     3f8:       a7 84 00 4b             je      48e <unqueue_me+0xc6>
				if r12 == 0 jump away
     3fc:       e3 20 b0 28 00 04       lg      %r2,40(%r11)
				q->lockptr in r2
     402:       c0 e5 00 00 00 00       brasl   %r14,402 <unqueue_me+0x3a>
                        404: R_390_PC32DBL      _spin_lock+0x2
				call spinlock (r2 is first parameter)


I really dont know why the compiler reloads lock_ptr from memory at all, but I 
will talk to our compiler guys to find out. 


> I have nothing against adding a barrier(), but we should first 
> investigate why the spin_lock() didnt act as a barrier - there might be
> other, similar bugs hiding. (we rely on spin_lock()s barrier-ness in a
> fair number of places)
See above. I think the barrier must be before "if(lock_ptr)" and not 
afterwards. 

> yes, it is always a pointer to a valid spinlock, or NULL.
> futex_requeue() can change the spinlock from one to another, and
> wake_futex() can change it to NULL. The futex unqueue_me() fastpath is
> when a futex waiter was woken - in which case it's NULL. But it can
> still be non-NULL if we timed out or a signal happened, in which case we
> may race with a wakeup or a requeue. futex_requeue() changes the
> spinlock pointer if it holds both the old and the new spinlock. So it's
> race-free as far as i can see.
Ok, looks fine then. 

-- 
Mit freundlichen Grüßen / Best Regards

Christian Borntraeger
Linux Software Engineer zSeries Linux & Virtualization



