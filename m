Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUG0Q3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUG0Q3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUG0Q2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:28:48 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:16846 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266453AbUG0QX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:23:56 -0400
Message-ID: <410681DC.7030706@colorfullife.com>
Date: Tue, 27 Jul 2004 18:25:00 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.6.8-rc1-mm1] perfctr inheritance locking issue
References: <200407201122.i6KBMbPR021614@harpo.it.uu.se> <20040726165754.1a4eda43.akpm@osdl.org>
In-Reply-To: <20040726165754.1a4eda43.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>  
>
>>Andrew,
>>
>>There is another locking problem with the per-process
>>performance counter inheritance changes I sent you.
>>
>>I currently use task_lock(tsk) to synchronise accesses
>>to tsk->thread.perfctr, when that pointer could change.
>>
>>The write_lock_irq(&tasklist_lock) in release_task() is
>>needed to prevent ->parent from changing while releasing the
>>child, but the parent's ->thread.perfctr must also be locked.
>>However, sched.h explicitly forbids holding task_lock()
>>simultaneously with write_lock_irq(&tasklist_lock). Ouch.
>>    
>>
>
>That's ghastly.
>
> * Nests both inside and outside of read_lock(&tasklist_lock).
> * It must not be nested with write_lock_irq(&tasklist_lock),
> * neither inside nor outside.
>
>Manfred, where did you discover the offending code?
>
>  
>
Think about interrupts: they are permitted to acquire the tasklist_lock 
for read.

Someone does
    read_lock(&tasklist_lock);
    task_lock(tsk);

One example is __do_SAK in tty_io.c, but I think there are further examples.

Now add a softirq that tries to deliver a signal: kill_something_info() 
contains a
    read_lock(&tasklist_lock);

This sequence doesn't deadlock - rw spinlocks starve writers.
But it means that both
    task_lock();
    write_lock_irq(&tasklist_lock);
and
    write_lock_irq(&tasklist_lock);
    task_lock();

can deadlock with the read_lock()/task_lock()/read_lock() sequence.

>Would be better to just sort out the locking, then take task_lock() inside
>tasklist_lock.  That was allegedly the rule in 2.4.
>  
>
It probably works by chance in 2.4.

--  
    Manfred
