Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWG3Xxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWG3Xxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWG3Xxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:53:43 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42933 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964794AbWG3Xxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:53:42 -0400
Subject: Re: [PATCH] bug in futex unqueue_me
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christian Borntraeger <borntrae@de.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>,
       Thomas Gleixner <tglx@timesys.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060730063821.GA8748@elte.hu>
References: <200607271841.56342.borntrae@de.ibm.com>
	 <20060730063821.GA8748@elte.hu>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 19:53:21 -0400
Message-Id: <1154303601.10074.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 08:38 +0200, Ingo Molnar wrote:
> * Christian Borntraeger <borntrae@de.ibm.com> wrote:
> 
> > From: Christian Borntraeger <borntrae@de.ibm.com>
> > 
> > This patch adds a barrier() in futex unqueue_me to avoid aliasing of 
> > two pointers.
> >
> > On my s390x system I saw the following oops:
> 
> > So the code becomes more or less:
> > if (q->lock_ptr != 0) spin_lock(q->lock_ptr)
> > instead of
> > if (lock_ptr != 0) spin_lock(lock_ptr)
> >
> > Which caused the oops from above.
> 
> interesting, how is this possible? We do a spin_lock(lock_ptr), and 
> taking a spinlock is an implicit barrier(). So gcc must not delay 
> evaluating lock_ptr to inside the critical section. And as far as i can 
> see the s390 spinlock implementation goes through an 'asm volatile' 
> piece of code, which is a barrier already. So how could this have 
> happened? I have nothing against adding a barrier(), but we should first 
> investigate why the spin_lock() didnt act as a barrier - there might be 
> other, similar bugs hiding. (we rely on spin_lock()s barrier-ness in a 
> fair number of places)

Ingo,  this spinlock is probably still a barrier, but is it still a
barrier on itself?  That is, the problem here is that we have the
compiler optimizing the lock_ptr temp variable that is used inside the
spin_lock.  So does a spin_lock protect itself, or just the stuff inside
it?

Here we need a barrier to keep gcc from optimizing the use of the lock
and not what the lock is protecting.

I don't know about other areas in the kernel that has a dynamic spin
lock like this that needs protection.

-- Steve


