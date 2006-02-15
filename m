Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWBOXS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWBOXS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWBOXS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:18:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751349AbWBOXS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:18:28 -0500
Date: Wed, 15 Feb 2006 15:17:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: frankeh@watson.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: SMP BUG
Message-Id: <20060215151716.201da5de.akpm@osdl.org>
In-Reply-To: <20060215230701.GD1508@flint.arm.linux.org.uk>
References: <43F12207.9010507@watson.ibm.com>
	<20060215230701.GD1508@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Mon, Feb 13, 2006 at 07:19:19PM -0500, Hubertus Franke wrote:
> > Folks the change introduced in 2.6.16-rc2   over 2.6.15
> > wrt to the SMP initialization are wrong.
> > Please apply to unroll the change..
> > 
> > Here is the logic ...
> > sched_init is called from start_kernel before the
> > architecture specific function cpu_check_smp() is called
> > which is done as part of rest_init().
> > 
> > On s390 this actually sets the cpu_possible_map, which
> > is now used in sched_init through the for_each_cpu without
> > properly being initialized.
> > As a result bringing 2nd and subsequent cpu online
> > breaks.
> > 
> > This should be a quick fix, until this chicken and egg
> > problem is solved otherwise.
> > 
> > -- Hubertus
> > 
> > --- kernel/sched.c.orig 2006-02-13 19:08:28.000000000 -0500
> > +++ kernel/sched.c      2006-02-13 19:09:08.000000000 -0500
> > @@ -6111,7 +6111,7 @@ void __init sched_init(void)
> >         runqueue_t *rq;
> >         int i, j, k;
> > 
> > -       for_each_cpu(i) {
> > +       for (i = 0; i < NR_CPUS; i++ ) {
> >                 prio_array_t *array;
> > 
> >                 rq = cpu_rq(i);
> 
> (left most of the message intact because it seems to have been ignored.
> Copying Linus and akpm in the vague hope of a response.)

This has already been fixed in s390.

> Yes, I'm also seeing an oops caused by exactly this on ARM:
> 
> ...
>
> enqueue_task is being called with p = c03fe2e0, array = NULL, leading
> to a NULL pointer dereference because rq->array has not been initialised.

Is arm's setup_arch() populating cpu_possible_map?

If that's not possible, statically initialising it to CPU_MASK_ALL should
fix it, but that's a lame solution and might lead to wastage of per-cpu
memory on not-possible CPUs.

