Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWG2M1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWG2M1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWG2M1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:27:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:53228 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750784AbWG2M1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:27:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Date: Sat, 29 Jul 2006 14:18:32 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200607281015.30048.rjw@sisk.pl> <200607282115.45407.rjw@sisk.pl> <20060728224028.GK19076@localdomain>
In-Reply-To: <20060728224028.GK19076@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291418.32366.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 00:40, Nathan Lynch wrote:
> Rafael J. Wysocki wrote:
> > On Friday 28 July 2006 20:20, Nathan Lynch wrote:
> > > > +#ifdef CONFIG_SUSPEND_SMP
> > > > +static cpumask_t frozen_cpus;
> > > > +
> > > > +int disable_nonboot_cpus(void)
> > > > +{
> > > > +	int cpu, error = 0;
> > > > +
> > > > +	/* We take all of the non-boot CPUs down in one shot to avoid races
> > > > +	 * with the userspace trying to use the CPU hotplug at the same time
> > > > +	 */
> > > > +	mutex_lock(&cpu_add_remove_lock);
> > > > +	cpus_clear(frozen_cpus);
> > > > +	printk("Disabling non-boot CPUs ...\n");
> > > > +	for_each_online_cpu(cpu) {
> > > > +		if (cpu == 0)
> > > > +			continue;
> > > 
> > > Assuming cpu 0 is online is not okay in generic code.
> > 
> > Absolutely.  Thanks for pointing this out.
> > 
> > > This should be something like:
> > > 
> > > 	int cpu, first_cpu, error = 0;
> > > 
> > > 	/* We take all of the non-boot CPUs down in one shot to avoid races
> > > 	 * with the userspace trying to use the CPU hotplug at the same time
> > > 	 */
> > > 	mutex_lock(&cpu_add_remove_lock);
> > > 	cpus_clear(frozen_cpus);
> > > 	first_cpu = first_cpu(cpu_online_mask);
> > > 	printk("Disabling non-boot CPUs ...\n");
> > > 	for_each_online_cpu(cpu) {
> > > 		if (cpu == first_cpu)
> > > 			continue;
> >
> > 
> > I'm not quite sure if we can finish with CPU0 offline.  Perhaps it's
> > better to check if CPU0 is online and bring it up if not and then
> > continue or return an error if that fails?
> 
> You can't assume that cpu 0 is even present in generic code. :-)

Yes.  I should have said "the first present CPU" instead of "CPU0".

> But maybe I'm misunderstanding the motivation for using cpu 0 here.  I
> had assumed it was because on i386 (and others?) the BSP can't be
> offlined.  Is there some other reason?

Yes.

First, the arch-dependent suspend code assumes implicitly that it will be
running on the BSP, so some strange things may happen if it doesn't.

Second, we have to make sure that this function will always leaves the
same CPU online.  It's a bit difficult to explain, but I'll do my best.
Suppose that disable_nonboot_cpus() exits running on CPU1, assuming it's
possible.  Then the system memory state saved in the suspend image will
reflect this situation.  Now the resume code will almost certainly run on the
BSP (say it's CPU0), but when the system memory is restored from the suspend
image the kernel will think it's running on CPU1.

In the last patch I send yesterday I made disable_nonboot_cpus() check if the
first present CPU, first_cpu(cpu_present_map), is online, try to bring it up
if not and migrate itself to it before the loop over all online CPUs is run.

I think that's general enough.
