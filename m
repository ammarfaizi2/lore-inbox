Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVCPUwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVCPUwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVCPUwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:52:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10423 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262793AbVCPUwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:52:16 -0500
Date: Wed, 16 Mar 2005 21:51:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Lynch <ntl@pobox.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, rusty@rustcorp.com.au
Subject: Re: CPU hotplug on i386
Message-ID: <20050316205158.GB2464@elf.ucw.cz>
References: <20050316132151.GA2227@elf.ucw.cz> <20050316184929.GA16469@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316184929.GA16469@otto>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wed, Mar 16, 2005 at 02:21:52PM +0100, Pavel Machek wrote:
> > +	int cpu, error;
> > +	cpus_clear(frozen_cpus);
> > +	printk("Freezing cpus...\n");
> > +	for_each_online_cpu(cpu) {
> > +		if (!cpu)
> > +			continue;
> > +		cpu_set(cpu, frozen_cpus);
> > +		error = cpu_down(cpu);
> > +		if (!error)
> > +			continue;
> > +		printk("Error taking cpu %d down: %d\n", cpu, error);
> > +		panic("Too many cpus");
> >  	}
> > -	printk("ok\n");
> > +	BUG_ON(smp_processor_id() != 0);
> >  }
> >  
> >  void enable_nonboot_cpus(void)
> >  {
> > -	printk("Restarting CPUs");
> > -	atomic_set(&freeze, 0);
> > -	while (atomic_read(&cpu_counter)) {
> > -		cpu_relax();
> > -		barrier();
> > +	int cpu, error;
> > +	printk("Thawing cpus...\n");
> > +	for_each_cpu_mask(cpu, frozen_cpus) {
> > +		if (!cpu)
> > +			continue;
> > +		error = cpu_up(cpu);
> > +		if (!error)
> > +			continue;
> > +		printk("Error taking cpu %d up: %d\n", cpu, error);
> > +		panic("Not enough cpus");
> >  	}
> 
> If you're going to depend on CONFIG_HOTPLUG_CPU for swsusp on smp, why
> not offline the non-boot cpus from userspace?  Same goes for onlining
> additional cpus during resume.

I'd like to stay in control. I may want to stop drivers first,
or something like that. Plus I need to do that during resume, too, when
userspace is not available, yet.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
