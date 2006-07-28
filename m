Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWG1TQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWG1TQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWG1TQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:16:26 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:12007 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030263AbWG1TQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:16:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Date: Fri, 28 Jul 2006 21:15:45 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200607281015.30048.rjw@sisk.pl> <20060728182041.GI19076@localdomain>
In-Reply-To: <20060728182041.GI19076@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282115.45407.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Friday 28 July 2006 20:20, Nathan Lynch wrote:
> Hi Rafael-
> 
> A couple of minor comments:
> 
> 
> > +int cpu_down(unsigned int cpu)
> > +{
> > +	int err = 0;
> > +
> > +	mutex_lock(&cpu_add_remove_lock);
> > +	if (cpu_hotplug_disabled)
> > +		err = -EPERM;
> > +	else
> > +		err = __cpu_down(cpu);
> > +
> >  	mutex_unlock(&cpu_add_remove_lock);
> >  	return err;
> >  }
> > @@ -191,6 +203,11 @@ int __devinit cpu_up(unsigned int cpu)
> >  	void *hcpu = (void *)(long)cpu;
> >  
> >  	mutex_lock(&cpu_add_remove_lock);
> > +	if (cpu_hotplug_disabled) {
> > +		ret = -EPERM;
> > +		goto out;
> > +	}
> 
> I think -EBUSY would be more appropriate than -EPERM, perhaps?

Sure, why not.
 
> > +#ifdef CONFIG_SUSPEND_SMP
> > +static cpumask_t frozen_cpus;
> > +
> > +int disable_nonboot_cpus(void)
> > +{
> > +	int cpu, error = 0;
> > +
> > +	/* We take all of the non-boot CPUs down in one shot to avoid races
> > +	 * with the userspace trying to use the CPU hotplug at the same time
> > +	 */
> > +	mutex_lock(&cpu_add_remove_lock);
> > +	cpus_clear(frozen_cpus);
> > +	printk("Disabling non-boot CPUs ...\n");
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu == 0)
> > +			continue;
> 
> Assuming cpu 0 is online is not okay in generic code.

Absolutely.  Thanks for pointing this out.

> This should be something like:
> 
> 	int cpu, first_cpu, error = 0;
> 
> 	/* We take all of the non-boot CPUs down in one shot to avoid races
> 	 * with the userspace trying to use the CPU hotplug at the same time
> 	 */
> 	mutex_lock(&cpu_add_remove_lock);
> 	cpus_clear(frozen_cpus);
> 	first_cpu = first_cpu(cpu_online_mask);
> 	printk("Disabling non-boot CPUs ...\n");
> 	for_each_online_cpu(cpu) {
> 		if (cpu == first_cpu)
> 			continue;

I'm not quite sure if we can finish with CPU0 offline.  Perhaps it's better to
check if CPU0 is online and bring it up if not and then continue or return
an error if that fails?

Rafael
