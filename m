Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVCJOdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVCJOdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVCJOdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 09:33:43 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:20682 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262646AbVCJOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 09:33:01 -0500
Date: Thu, 10 Mar 2005 07:33:50 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce cacheline bouncing in cpu_idle_wait
In-Reply-To: <m1mztbvq7p.fsf@muc.de>
Message-ID: <Pine.LNX.4.61.0503100731520.2903@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0503091839200.2903@montezuma.fsmlabs.com>
 <m1mztbvq7p.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Andi Kleen wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> 
> > Andi noted that during normal runtime cpu_idle_map is bounced around a 
> > lot, and occassionally at a higher frequency than the timer interrupt 
> > wakeup which we normally exit pm_idle from. So switch to a percpu 
> > variable. Andi i didn't move things to the slow path because it would 
> > involve adding scheduler code to wakeup the idle thread on the cpus we're 
> > waiting for.
> 
> Thanks. 
> >  
> > -
> >  void cpu_idle_wait(void)
> >  {
> > -        int cpu;
> > -        cpumask_t map;
> > +	unsigned int cpu, this_cpu = get_cpu();
> > +	cpumask_t map;
> > +
> > +	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
> > +	put_cpu();
> 
> You need a cpus_clear(map); here I think (probably same for the other
> archs) 

A bit subtle, the cpus_and will clear the offline processors after the 
first pass.
