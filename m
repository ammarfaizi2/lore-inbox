Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSKKXNC>; Mon, 11 Nov 2002 18:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSKKXNC>; Mon, 11 Nov 2002 18:13:02 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:11241 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264653AbSKKXNB>; Mon, 11 Nov 2002 18:13:01 -0500
Cc: Ben Clifford <benc@hawaga.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk>
	<87k7jkg969.fsf@goat.bogus.local> <3DCF1593.CB9C7AA4@digeo.com>
	<87znsgov9e.fsf@goat.bogus.local> <3DCFF447.43EE55FE@digeo.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Andrew Morton <akpm@digeo.com>, Roland Dreier <roland@topspin.com>
Subject: Re: programming for preemption (was: [PATCH] 2.5.46:
 accesspermission  filesystem)
Date: Tue, 12 Nov 2002 00:19:34 +0100
Message-ID: <87u1inofsp.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Olaf Dietsche wrote:
>> 
>> Thanks for this hint. So this means kmalloc(GFP_KERNEL) inside
>> spinlock is not necessarily dangerous, but should be avoided if
>> possible?
>
> It can lock an SMP kernel up.  This CPU can switch to another task in the
> page allocator and then, within the context of the new task, come around
> and try to take the same lock.

Alright, this means kmalloc(GFP_KERNEL) inside spinlock is a bug.

>> Is using a semaphore better than using spinlocks?

Andrew Morton <akpm@digeo.com> writes:

> A semaphore won't have that problem.  If your CPU comes around again onto
> the already-held lock it will just switch to another task.

Roland Dreier <roland@topspin.com> writes:

> A semaphore is safer, because if you fail to get the semaphore you
> will go to sleep, which allows the process that holds the semaphore to
> get scheduled again and release it.  However you cannot use semaphores
> in interrupt handlers -- you must be in process context when you
> down() the semaphore.  (Note that it is OK to up() a semaphore from an
> interrupt handler)

So, as a rule of thumb, I would say use semaphores, if you need some
locking. And in interrupt context, use spinlocks. Do spinlocks have
other benefits, beside being interrupt safe?

Regards, Olaf.
