Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314087AbSDZQgI>; Fri, 26 Apr 2002 12:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSDZQgH>; Fri, 26 Apr 2002 12:36:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5625 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314087AbSDZQgG>;
	Fri, 26 Apr 2002 12:36:06 -0400
Message-ID: <3CC9816B.88C080A3@mvista.com>
Date: Fri, 26 Apr 2002 09:33:47 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: spinlocking between user context / tasklet / tophalf question
In-Reply-To: <7wwuuu4zam.fsf@avalon.france.sdesigns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Michon wrote:
> 
> Hi,
> 
> I read various documents about spinlocks, including Linux device
> drivers by A.Rubini 2nd edition, Unreliable guide to locking by P.R.Russel,
> and the source code of mainly network device drivers.
> 
> I'm trying to achieve correct SMP synchronization on the Sigma Designs
> EM84xx; this one involves an extra small hardware interrupt (let's call it tophalf),
> only one tasklet scheduled at end of tophalf, and usual kernel side code of
> ioctl() I call usercontext.
> 
> tophalf and tasklet are potentially writing the same data X
> 
> tasklet and usercontext are potentially writing the same data Y
> 
> So, my first guess was to use two spinlocks, X_lock and Y_lock,

Tasklets are run in interrupt context.  You need the irq versions of the
spinlock in kernel space.  In tasklet space a simple spinlock should be
enough as the tasklet can not be reentered.

-g
> 
> with
> 
> tophalf()
> {
>         spin_lock(&X_lock);
>         write X
>         spin_unlock(&X_lock);
> }
> 
> tasklet()
> {
>         unsigned long flags;
>         spin_lock_irqsave(&X_lock,flags);
>         write X
>         spin_lock(&Y_lock);
>         write X, write Y
>         spin_unlock(&Y_lock);
>         write X
>         spin_unlock_irqrestore(&X_lock,flags);
> }
> 
> ioctl()
> {
>         spin_lock_bh(&Y_lock);
>         write Y ... maybe copy_from_user/copy_to_user
>         spin_unlock_bh(&Y_lock);
> }
> 
> So far I get really hardcore freezes and I'm trying to handle this with kgdb
> 
> 1. Should I use spin_lock(&Y_lock); or spin_lock_bh(&Y_lock); in the tasklet body?
> 
> 2. What is the reality behind: ``things which sleep'', is it really a problem
> to use copy_from_user/copy_to_user holding a spinlock?
> 
> 3. Previous version used one semaphore to serialize usercontext access
> down_interruptible(&sem)/up(&sem)
> and handle tasklet concurrency with:
> down_trylock(&sem)/up(&sem)
> 
> That allowed to catch signals (^C) with the usual -ERESTARTSYS stuff. As
> far as I understand, spinlocks allow the serialization but no way to interrupt
> a dead system call --- should I keep the semaphore only for this purpose?
> 
> Sincerely yours,
> 
> --
> Emmanuel Michon
> Chef de projet
> REALmagic France SAS
> Mobile: 0614372733 GPGkeyID: D2997E42
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
