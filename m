Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRHaSZW>; Fri, 31 Aug 2001 14:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRHaSZN>; Fri, 31 Aug 2001 14:25:13 -0400
Received: from colorfullife.com ([216.156.138.34]:24324 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S268856AbRHaSY7>;
	Fri, 31 Aug 2001 14:24:59 -0400
Message-ID: <002d01c1324a$5d9d6790$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "\"Ulrich Weigand\"" <Ulrich.Weigand@de.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: NFS deadlock explained (on S/390)
Date: Fri, 31 Aug 2001 20:02:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Specifically, what happens is that the first CPU runs the QDIO
> bottom half (from ksoftirqd, but this is probably not important).
> That bottom half grabs the QDIO private spinlock, and then
> executes a bunch of code including a dev_kfree_skb_any().
>  As we are only in a softirq, not a hard irq, dev_kfree_skb_any()
> call kfree_skb() directly, which happens to invoke the
> udp_write_space() callback in xprt.c.  This routine then spins
> trying to acquire the xprt_sock_lock.

I think in_irq() and in_interrupt() should check the cpu interrupt flag
and return TRUE if the per-cpu interrupts are disabled.

The current behavious is just weird:
    spin_lock_bh();
    in_interrupt(); --> true
    spin_unlock_bh();
    spin_lock_irq();
    in_interrupt(); --> false
    spin_unlock_irq();

> Whether this same situation can explain the deadlocks seen on
> other platforms depends on whether the drivers used there exhibit
> similar locking behaviours as the QDIO driver, of course.

It should be possible to detect that automatically: if
dev_kfree_skb_any() is called outside irq context with disabled per-cpu
interrupts then it's probably due to a spin_lock_irq() and could
deadlock.

--
    Manfred

