Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSKHRgB>; Fri, 8 Nov 2002 12:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSKHRgA>; Fri, 8 Nov 2002 12:36:00 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:54671 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266842AbSKHRf4>; Fri, 8 Nov 2002 12:35:56 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F4EB@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Linus Torvalds '" <torvalds@transmeta.com>,
       "'Jeremy Fitzhardinge '" <jeremy@goop.org>
Cc: "'William Lee Irwin III '" <wli@holomorphy.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "'linux-ia64@linuxia64.org '" <linux-ia64@linuxia64.org>,
       "'Linux Kernel List '" <linux-kernel@vger.kernel.org>,
       "'rusty@rustcorp.com.au '" <rusty@rustcorp.com.au>,
       "'dhowells@redhat.com '" <dhowells@redhat.com>,
       "'mingo@elte.hu '" <mingo@elte.hu>
Subject: RE: [Linux-ia64] reader-writer livelock problem
Date: Fri, 8 Nov 2002 11:41:57 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that was one of the options I suggested in the original post
to the IA64 list.  I'll bounce it to LKML for reference, now that
the discussion has moved there.

In my proposal, however, I proposed making (the current) reader
locks recursive spinlocks (to eliminate the starvation problem,
at the expense of eliminating reader parallelism), which would
have the added benefit of "encouraging" people to move to the
fair locks.  But your proposal is probably at least as good.

Of course, normal spinlocks do not scale either, since they
currently require N cache-cache transfers for a processor to
drop the lock, which results in N^2 cache transfers for each
processor to acquire/release the lock once.  So with 32 processors
contending for the lock, at 1us per cache-cache transfer (picked
for easy math, but that is reasonable for large systems), it
takes 1ms for each processor to acquire the spinlock and hold it
for 10 cpu cycles.

So I'd _also_ like to see an MCS lock implementation replace the current
spinlock code (IBM "NMCS" lock patch can be trivially used to replace
all spinlocks).

Kevin

-----Original Message-----
From: Linus Torvalds
To: Jeremy Fitzhardinge
Cc: William Lee Irwin III; Van Maren, Kevin; linux-ia64@linuxia64.org; Linux
Kernel List; rusty@rustcorp.com.au; dhowells@redhat.com; mingo@elte.hu
Sent: 11/8/02 12:28 PM
Subject: Re: [Linux-ia64] reader-writer livelock problem


On Fri, 8 Nov 2002, Linus Torvalds wrote:
> 
> NOTE! I'm not saying the existing practice is necessarily a good
tradeoff,
> and maybe we should just make sure to find all such cases and turn the
> read_lock() calls into read_lock_irqsave() and then make the rw-locks
> block readers on pending writers. But it's certainly more work and
cause
> for subtler problems than just naively changing the rw implementation.

Actually, giving this som emore thought, I really suspect that the
simplest solution is to alloc a separate "fair_read_lock()", and paths
that need to care about fairness (and know they don't have the irq
issue)  
can use that, slowly porting users over one by one...

  Linus
