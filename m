Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbRBSVw4>; Mon, 19 Feb 2001 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRBSVwq>; Mon, 19 Feb 2001 16:52:46 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:32525 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129150AbRBSVwg>;
	Mon, 19 Feb 2001 16:52:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: prumpf@mandrakesoft.com (Philipp Rumpf), linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: Your message of "Mon, 19 Feb 2001 16:04:07 -0000."
             <E14UsnJ-0003l9-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 08:52:29 +1100
Message-ID: <32669.982619549@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001 16:04:07 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>My spinlock based fix has almost no contention and doesnt require 64 processors
>grind to a halt on a big machine just to handle a module list change. Sorry
>I don't think it supports your argument

I am not proposing that the other cpus grind to a halt.  On the
contrary, they are allowed to continue running.  It is the current
process that is suspended until all other cpus have gone through at
least one schedule.

On Mon, 19 Feb 2001 16:23:09 +0100, 
Manfred Spraul <manfred@colorfullife.com> wrote:
>what about
>
>	spin_unlock_wait(&global_exception_lock);
>
>The actual exception table waker uses
>	spin_lock_irqsave(&global_exception_lock);
>
>	spin_unlock_irqsave(&global_exception_lock);
>
>Or a simple spinlock - the code shouldn't be performance critical.

All lock based fixes have the disadvantage that you penalise the entire
kernel all the time.  No matter how small the overhead of getting the
lock, it still exists - so we are slowing down the main kernel all the
time to handle the rare case of module unloading.

Also notice that we keep adding spinlocks.  One for the main module
list, another for the exception tables.  Then there is the architecture
specific module data, including unwind information for IA64; that also
needs to be locked.  Requiring more than one spinlock to handle module
unloading tells me that the design is wrong.

Using wait_for_at_least_one_schedule_on_every_cpu() has no penalty
except on the process running rmmod.  It does not require yet more
spinlocks and is architecture independent.  Since schedule() updates
sched_data->last_schedule, all the rmmod process has to do is wait
until the last_schedule value changes on all cpus, forcing a reschedule
if necessary.

Zero overhead in schedule, zero overhead in exception handling, zero
overhead in IA64 unwind code, architecture independent.  Sounds good to
me.

