Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWAKUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWAKUtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWAKUtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:49:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58589 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932350AbWAKUtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:49:45 -0500
Date: Wed, 11 Jan 2006 14:49:29 -0600
From: Mark Maule <maule@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060111204929.GA17946@sgi.com>
References: <20060111155251.12460.71269.12163@attica.americas.sgi.com> <20060111155256.12460.26048.32596@attica.americas.sgi.com> <20060111202123.GC4367@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111202123.GC4367@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static inline int msi_arch_init(void)
> > +{
> > +	extern struct msi_ops msi_apic_ops;
> > +	msi_register(&msi_apic_ops);
> > +	return 0;
> > +}
> 
> Don't have an extern in a function, it belongs in a .h file somewhere
> that describes it and everyone can see it.  Otherwise this gets stale
> and messy over time.

In this case, I have a public .h (asm-xxx/msi.h) which needs a data structure
decleared down in a driver-private file (drivers/pci/msi-apic.c).  Do you have
a suggestion for where I should put the msi_apic_ops declaration?  It should
be somewhere such that future msi ops (e.g. sn_msi_ops from patch3) would
be treated consistently.

linux/pci.h seems like one possiblity near where the ops struct is declared,
but that doesn't really seem right, because we'ld want to treat sn_msi_ops
(and future msi ops) the same way.

Maybe just move the extern out of the function and up further in the
asm-xxx/msi.h file?

> 
> > +/*
> > + * Generic callouts used on most archs/platforms.  Override with
> > + * msi_register_callouts()
> > + */
> 
> Care to use kerneldoc here and define exactly what is needed for these
> function pointers?  And you are still calling them "callouts" here :)
> 
> > +struct msi_ops msi_apic_ops = {
> > +	.setup = msi_setup_apic,
> > +	.teardown = msi_teardown_apic,
> > +#ifdef CONFIG_SMP
> > +	.target = msi_target_apic,
> > +#endif
> 
> Why the #ifdef?  Just drop it, it makes the code cleaner.
> 
> Care to redo this?

ok.  Will submit a new version once we have the placement of the msi_apic_ops
declaration sorted out.

Mark
