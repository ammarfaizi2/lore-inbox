Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWACXus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWACXus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWACXur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:50:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36785 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965133AbWACXun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:50:43 -0500
Date: Tue, 3 Jan 2006 17:50:24 -0600
From: Mark Maule <maule@sgi.com>
To: Grant Grundler <iod00d@hp.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060103235024.GC16827@sgi.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222201657.2019.69251.48815@lnx-maule.americas.sgi.com> <20060103223918.GB13841@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103223918.GB13841@esmail.cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 02:39:18PM -0800, Grant Grundler wrote:
> On Thu, Dec 22, 2005 at 02:15:49PM -0600, Mark Maule wrote:
> > Abstract portions of the MSI core for platforms that do not use standard
> > APIC interrupt controllers.  This is implemented through a new arch-specific
> > msi setup routine, and a set of msi ops which can be set on a per platform
> > basis.
> 
> ...
> > +
> > +		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
> > +
> > +		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
> > +			address_hi);
> >  		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
> > -			address.lo_address.value);
> > +			address_lo);
> >  		set_native_irq_info(irq, cpu_mask);
> >  		break;
> >  	}
> ...
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ msi/drivers/pci/msi-apic.c	2005-12-22 11:09:37.022232088 -0600
> ...
> > +struct msi_ops msi_apic_ops = {
> > +	.setup = msi_setup_apic,
> > +	.teardown = msi_teardown_apic,
> > +#ifdef CONFIG_SMP
> > +	.target = msi_target_apic,
> > +#endif
> 
> Mark,
> msi_target_apic() initializes address_lo parameter.
> Even on a UP machine, we need inialize this value.

Not sure what you mean here.  target is used to retarget an existing MSI vector
to a different processor.  In the case of apic, this appears to be accomplished
by swizzling the cpu in the low 32 bits of the msi address.  Nothing needs to
change in the upper 32 bits.

> 
> If target is called unconditionally, wouldn't it be better
> for msi_target_apic() always be called?

target is called through the msi_ops->target vector.  SN does not use
msi_target_apic(), it uses sn_msi_target().  Other platforms can implement
target however they need to.

> 
> It would also be good for msi_target_apic to validate the 'dest_cpu' is online.
> Maybe a BUG_ON or something like that.

That wasn't a check in the original code flow ... the main protection appears
to be in the upper levels in irq_affinity_write_proc().

> 
> grant
> 
> ps. not done looking through this...and still curious to see where
>     other discussion about generic vector assignment leads.
