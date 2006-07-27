Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWG0F6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWG0F6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 01:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWG0F6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 01:58:35 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:16029 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751747AbWG0F6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 01:58:35 -0400
Date: Thu, 27 Jul 2006 01:53:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: + spinlock_debug-dont-recompute-jiffies_per_loop.patch
  added to -mm tree
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Message-ID: <200607270155_MC3-1-C637-8E28@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060725204306.GA22547@elte.hu>

On Tue, 25 Jul 2006 22:43:06 +0200, Ingo Molnar wrote:
> 
> * Dave Jones <davej@redhat.com> wrote:
> 
> >  > iteration limit, gets recomputed every time.  Caching it explicitly 
> >  > prevents that.
> > 
> > What is the purpose of those __delays being there at all ? Seems odd 
> > to be waiting that long when the spinlock could become available a lot 
> > sooner.  (These also make spinlock debug really painful on boxes with 
> > huge numbers of CPUs).
> 
> the debug code has to figure out when to trigger a deadlock warning 
> message. If we are looping in a deadlock with irqs disabled on all CPUs, 
> there's nothing that advances jiffies. The TSC is not reliable. The 
> thing that remains is to use __delay(1). We could calibrate the loop 
> separately perhaps?

Is there some reason this code:

                for (i = 0; i < loops_per_jiffy * HZ; i++) {
                        if (__raw_spin_trylock(&lock->raw_lock))
                                return;
                        __delay(1);
                }

needs to continuously try to update the spinlock?  Shouldn't it just
read it first, like this, to avoid the bus update traffic?

                        if (spin_can_lock(&lock->raw_lock) &&
                            __raw_spin_trylock(&lock->raw_lock))
                                return;


Also, looking at __delay(), I foresee problems on i386 with the HPET timer.
Every call to __delay() causes at least two HPET timer reads and it looks
like they're slow (using readl() on ioremapped memory, anyway.)

-- 
Chuck

