Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVC3LdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVC3LdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVC3LdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:33:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20373 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261870AbVC3LdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:33:07 -0500
Date: Wed, 30 Mar 2005 13:32:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: smp/swsusp done right
Message-ID: <20050330113254.GE572@elf.ucw.cz>
References: <20050323204019.GA11616@elf.ucw.cz> <200503301242.38280.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503301242.38280.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is against -mm kernel; it is smp swsusp done right, and it
> > actually works for me. Unlike previous hacks, it uses cpu hotplug
> > infrastructure. Disable CONFIG_MTRR before you try this...
> > 
> > Test this if you can, and report any problems. If not enough people
> > scream, this is going to -mm.
> > 								Pavel
> > 
> > --- clean-mm/drivers/pci/pci.c	2005-03-21 11:39:32.000000000 +0100
> > +++ linux-mm/drivers/pci/pci.c	2005-03-22 01:41:48.000000000 +0100
> > @@ -376,11 +376,13 @@
> >  	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> >  		return PCI_D0;
> >  
> > +#if 0
> >  	if (platform_pci_choose_state) {
> >  		ret = platform_pci_choose_state(dev, state);
> >  		if (ret >= 0)
> >  			state = ret;
> >  	}
> > +#endif
> >  	switch (state) {
> >  	case 0: return PCI_D0;
> >  	case 3: return PCI_D3hot;
> 
> You probably don't want the above change to go in the final patch?

No, not in final patch.

> > -	atomic_set(&cpu_counter, 0);
> > -	atomic_set(&freeze, 1);
> > -	smp_call_function(smp_pause, NULL, 0, 0);
> > -	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
> > -		cpu_relax();
> > -		barrier();
> > +	error = 0;
> > +	cpus_clear(frozen_cpus);
> > +	printk("Freezing cpus ...\n");
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu == 0)
> > +			continue;
> > +		error = cpu_down(cpu);
> > +		if (!error) {
> > +			cpu_set(cpu, frozen_cpus);
> > +			printk("CPU%d is down\n", cpu);
> > +			continue;
> > +		}
> > +		printk("Error taking cpu %d down: %d\n", cpu, error);
> >  	}
> > -	printk("ok\n");
> > +	BUG_ON(smp_processor_id() != 0);
> > +	if (error)
> > +		panic("cpus not sleeping");
> >  }
> 
> I'm not sure whether we should panic() here.  It may be better to make
> suspend fail and print a "please reboot immediately" message for the user.
> In that case, the user may be able to reboot without loosing data
> -	...

I guess I could just fail the suspend, but I want to see the messages
for now. (And I do not think it will ever trigger).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
