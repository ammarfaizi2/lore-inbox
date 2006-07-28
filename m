Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWG1WlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWG1WlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWG1WlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:41:05 -0400
Received: from rune.pobox.com ([208.210.124.79]:5323 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1161339AbWG1WlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:41:03 -0400
Date: Fri, 28 Jul 2006 17:40:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Message-ID: <20060728224028.GK19076@localdomain>
References: <200607281015.30048.rjw@sisk.pl> <20060728182041.GI19076@localdomain> <200607282115.45407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607282115.45407.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday 28 July 2006 20:20, Nathan Lynch wrote:
> > > +#ifdef CONFIG_SUSPEND_SMP
> > > +static cpumask_t frozen_cpus;
> > > +
> > > +int disable_nonboot_cpus(void)
> > > +{
> > > +	int cpu, error = 0;
> > > +
> > > +	/* We take all of the non-boot CPUs down in one shot to avoid races
> > > +	 * with the userspace trying to use the CPU hotplug at the same time
> > > +	 */
> > > +	mutex_lock(&cpu_add_remove_lock);
> > > +	cpus_clear(frozen_cpus);
> > > +	printk("Disabling non-boot CPUs ...\n");
> > > +	for_each_online_cpu(cpu) {
> > > +		if (cpu == 0)
> > > +			continue;
> > 
> > Assuming cpu 0 is online is not okay in generic code.
> 
> Absolutely.  Thanks for pointing this out.
> 
> > This should be something like:
> > 
> > 	int cpu, first_cpu, error = 0;
> > 
> > 	/* We take all of the non-boot CPUs down in one shot to avoid races
> > 	 * with the userspace trying to use the CPU hotplug at the same time
> > 	 */
> > 	mutex_lock(&cpu_add_remove_lock);
> > 	cpus_clear(frozen_cpus);
> > 	first_cpu = first_cpu(cpu_online_mask);
> > 	printk("Disabling non-boot CPUs ...\n");
> > 	for_each_online_cpu(cpu) {
> > 		if (cpu == first_cpu)
> > 			continue;
>
> 
> I'm not quite sure if we can finish with CPU0 offline.  Perhaps it's
> better to check if CPU0 is online and bring it up if not and then
> continue or return an error if that fails?

You can't assume that cpu 0 is even present in generic code. :-)

But maybe I'm misunderstanding the motivation for using cpu 0 here.  I
had assumed it was because on i386 (and others?) the BSP can't be
offlined.  Is there some other reason?

