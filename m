Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVG0RUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVG0RUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVG0RUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:20:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8951 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261329AbVG0RUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:20:09 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][2.6.13-rc3-mm1] IRQ compression/sharing patch
Date: Wed, 27 Jul 2005 10:20:03 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
References: <200507260012.41968.jamesclv@us.ibm.com> <20050726160319.GB5353@wotan.suse.de>
In-Reply-To: <20050726160319.GB5353@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507271020.03635.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 July 2005 09:03 am, Andi Kleen wrote:
> On Tue, Jul 26, 2005 at 12:12:41AM -0700, James Cleverdon wrote:
> > Here's a patch that builds on Natalie Protasevich's IRQ compression
> > patch and tries to work for MPS boots as well as ACPI.  It is meant
> > for a 4-node IBM x460 NUMA box, which was dying because it had
> > interrupt pins with GSI numbers > NR_IRQS and thus overflowed
> > irq_desc.
> >
> > The problem is that this system has 270 GSIs (which are 1:1 mapped
> > with I/O APIC RTEs) and an 8-node box would have 540.  This is much
> > bigger than NR_IRQS (224 for both i386 and x86_64).  Also, there
> > aren't enough vectors to go around.  There are about 190 usable
> > vectors, not counting the reserved ones and the unused vectors at
> > 0x20 to 0x2F.  So, my patch attempts to compress the GSI range and
> > share vectors by sharing IRQs.
> >
> > Important safety note:  While the SLES 9 version of this patch
> > works, I haven't been able to test the -rc3-mm1 patch enclosed.  I
> > keep getting errors from the adp94xx driver.  8-(
> >
> > (Sorry about doing an attachment, but KMail is steadfastly word
> > wrapping inserted files.  I need to upgrade....)
>
> The patch seems to have lots of unrelated stuff. Can you please
> split it out?

Of course.  I'll pull out the BUG_ON()s and some of the other cleanup 
stuff into a related patch.

> BTW I plan to implement per CPU IDT vectors similar to Zwane's i386
> patch for x86-64 soon, hopefully with that things will be easier too.

I hope so, too.  The problem has been making the most of limited 
interrupt resources (vectors and IRQ numbers), when previous coding has 
assumed that we could use them lavishly.

> Andrew: this is not 2.6.13 material.
>
> > @@ -276,13 +276,13 @@ config HAVE_DEC_LOCK
> >  	default y
> >
> >  config NR_CPUS
> > -	int "Maximum number of CPUs (2-256)"
> > -	range 2 256
> > +	int "Maximum number of CPUs (2-255)"
> > +	range 2 255
> >  	depends on SMP
> > -	default "8"
> > +	default "64"
>
> Please don't change that,

Which?  The maximum number of addressable CPUs is 255, because FF is 
reserved.  Or, would you rather the default be 8 or 16?  (Hmmm....  
Dual-core, hyperthreaded CPUs are out.  They'll turn a quad box into a 
16-way.)

> > +/*
> > + * Check the APIC IDs in MADT table header and choose the APIC
> > mode. + */
> > +void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> > +{
> > +	/* May need to check OEM strings in the future. */
> > +}
> > +
> > +/*
> > + * Check the IDs in MPS header and choose the APIC mode.
> > + */
> > +void mps_oem_check(struct mp_config_table *mpc, char *oem, char
> > *productid) +{
> > +	/* May need to check OEM strings in the future. */
> > +}
>
> Can you perhaps add it then later, not now?

Naturally.  It was a placeholder for those systems where we can't figure 
out what to do using heuristics on the ACPI/MPS table data.

> > +static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] =
> > 0xFF };
>
> With the per cpu IDTs we'll likely need more than 8 bits here.

OK, I'll make it u32.  Or would you rather have u16?

> > -	char str[16];
> > +	char oem[9], str[16];
> >  	int count=sizeof(*mpc);
> >  	unsigned char *mpt=((unsigned char *)mpc)+count;
> > +	extern void mps_oem_check(struct mp_config_table *mpc, char *oem,
> > char *productid);
>
> That would belong in some header if it was needed.
>
> But please just remove it for now.

Right.

> The rest looks ok.
>
> -Andi

Thanks Andi!

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
