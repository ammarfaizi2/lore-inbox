Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbSKKSQS>; Mon, 11 Nov 2002 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbSKKSQS>; Mon, 11 Nov 2002 13:16:18 -0500
Received: from webmail.topspin.com ([12.162.17.3]:63709 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S266928AbSKKSQR>; Mon, 11 Nov 2002 13:16:17 -0500
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: programming for preemption (was: [PATCH] 2.5.46: access permission filesystem)
References: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk>
	<87k7jkg969.fsf@goat.bogus.local> <3DCF1593.CB9C7AA4@digeo.com>
	<87znsgov9e.fsf@goat.bogus.local>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Nov 2002 10:23:05 -0800
In-Reply-To: <87znsgov9e.fsf@goat.bogus.local>
Message-ID: <528z00neye.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Nov 2002 18:23:01.0890 (UTC) FILETIME=[5E94FE20:01C289AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Olaf" == Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

    Olaf> So this means kmalloc(GFP_KERNEL) inside spinlock is not
    Olaf> necessarily dangerous, but should be avoided if possible? Is
    Olaf> using a semaphore better than using spinlocks?

You should never kmalloc(GFP_KERNEL) while holding a spinlock, since
it is dangerous even without preempt.  kmalloc(GFP_KERNEL) may sleep,
which will lead to deadlock (the code holding the spinlock gets
scheduled out because of the kmalloc, then some other code tries to
take the lock -- deadlock).

A semaphore is safer, because if you fail to get the semaphore you
will go to sleep, which allows the process that holds the semaphore to
get scheduled again and release it.  However you cannot use semaphores
in interrupt handlers -- you must be in process context when you
down() the semaphore.  (Note that it is OK to up() a semaphore from an
interrupt handler)

Best,
  Roland
