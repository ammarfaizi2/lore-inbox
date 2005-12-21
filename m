Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVLUTRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVLUTRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVLUTRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:17:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37328 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751165AbVLUTRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:17:47 -0500
Date: Wed, 21 Dec 2005 13:17:41 -0600
From: Mark Maule <maule@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/4] msi vector targeting abstractions
Message-ID: <20051221191741.GI9920@sgi.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184348.5003.7540.53186@attica.americas.sgi.com> <20051221185637.GA13210@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221185637.GA13210@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 06:56:37PM +0000, Christoph Hellwig wrote:
> On Wed, Dec 21, 2005 at 12:42:41PM -0600, Mark Maule wrote:
> > Abstract portions of the MSI core for platforms that do not use standard
> > APIC interrupt controllers.  This is implemented through a set of callouts
> > which default to current behavior, but which can be overridden by calling
> > msi_register_callouts() in the platform msi init code.
> 
> we tend to calls these _ops or _operations instead of _callouts.
> Also I'd suggest to not keep the generic ones where they are but
> in a separate file and let the existing plattforms calls msi_register()
> with the ops table for those.  This keeps the interface symmetric instead
> of favouring the first implementation.

ok.

> 
> > @@ -89,10 +91,25 @@
> >  }
> >  
> >  #ifdef CONFIG_SMP
> > +static void msi_target_generic(unsigned int vector,
> > +			       unsigned int dest_cpu,
> > +			       uint32_t *address_hi,	/* in/out */
> > +			       uint32_t *address_lo)	/* in/out */
> 
> Please try to use u32 instead of uint32_t everywhere.  Dito for other
> sizes and signed types.

ok.

> 
> > +{
> > +	struct msg_address address;
> > +
> > +	address.lo_address.value = *address_lo;
> > +	address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
> > +	address.lo_address.value |=
> > +		(cpu_physical_id(dest_cpu) << MSI_TARGET_CPU_SHIFT);
> > +
> > +	*address_lo = address.lo_address.value;
> > +}
> 
> Why do we need the full struct msg_address here?  What about just:
> 
> static void msi_target_apic(unsigned int vector, unsigned int dest_cpu,
> 			    u32 *address_hi, u32 *address_lo)
> {
> 	u32 addr = *address_lo;
> 
> 	addr &= MSI_ADDRESS_DEST_ID_MASK;
> 	addr |= (cpu_physical_id(dest_cpu) << MSI_TARGET_CPU_SHIFT);
> 
> 	*address_lo = addr;
> }

Right.


> 
> > +	(*msi_callouts.msi_teardown)(vector);
> > +
> 
> just
> 	msi_ops.teardown(vector);
> 

ok.
