Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVHKNQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVHKNQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVHKNQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:16:50 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:53265 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1030301AbVHKNQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:16:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 11 Aug 2005 08:15:38 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB1@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][2.6.12.3] IRQ compression/sharing patch
Thread-Index: AcWeIp7Ju7QhZ0T4SmathJpMpN5t5QAUsjgg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <jamesclv@us.ibm.com>
Cc: "Andi Kleen" <ak@suse.de>, "Russ Weight" <rweight@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2005 13:15:38.0728 (UTC) FILETIME=[C456CE80:01C59E76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The only problem is here:
> >
> > +	if (i < NR_IRQS) {
> > +		gsi_2_irq[gsi] = i;
> > +		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ
> > %d\n",
> > +				gsi, vector, i);
> > +		return i;
> > +	}
> > +
> > +	i = next_irq++;
> >
> > That means for any IRQ < NR_IRQS you allow it to be 
> identity mapped, 
> > with all the gaps, and only for ones exceeding 224 you'll assign 
> > consecutive next_irqs++, whereas you can do it for all PCI 
> IRQs above 
> > 15. So, the alternative clause should probably come down to just:
> >                  irq = next_irq++;
> >                  gsi_2_irq[gsi] = irq; - which means just 
> removing the 
> > one above...
> > (although we better test that :)...I will definitely test vector 
> > sharing when manage to get on max configuration partition here.
> >
> > Regards,
> > --Natalie
> 
> Blast.  You're right, because i is the results of scanning 
> irq_vector (AKA IO_APIC_VECTOR()) for a previous use of the 
> vector.  If i < NR_IRQS then it has found a previous use and 
> would substitute the other IRQ number rather than allocate a new one.
> 
> Of course, one side effect of calling assign_irq_vector(gsi) 
> is that the vector number is stored at position gsi in 
> irq_vector.  So, for IRQs 0 to NR_IRQS - 1, it will always 
> find itself.
> 
> OK, how about not fighting that side effect and only 
> reassigning IRQs that are >= NR_IRQS?  Maybe something like this:

I am wondering where sharing_vectors gets set, it was not in the patch
originally.

> @@ -579,4 +589,57 @@ static inline int irq_trigger(int idx)
>  	return MPBIOS_trigger(idx);
>  }
>  
> +/*
> + * gsi_irq_sharing -- Name overload!  "irq" can be either a 
> legacy IRQ
> + * in the range 0-15, a linux IRQ in the range 0-223, or a GSI number
> + * from ACPI, which can easily reach 800.
> + *
> + * Compact the sparse GSI space into a available IRQs and reuse
> + * vectors if possible.
> + */
> +int gsi_irq_sharing(int gsi)
> +{
> +	int i, tries, vector;
> +
> +	BUG_ON(gsi >= NR_IRQ_VECTORS);
> +
> +	/*
> +	 * Don't share legacy IRQs.  Their trigger modes are 
> usually edge
> +	 * and PCI is level.  Mixed modes are trouble.  Only 
> big boxes are
> +	 * likely to overflow IRQs or to share vectors.
> +	 */
> +	if (likely(gsi < NR_IRQS && !sharing_vectors) || 
> platform_legacy_irq(gsi)) {
> +		gsi_2_irq[gsi] = gsi;
> +		return gsi;
> +	}
> +
> +	if (gsi_2_irq[gsi] != 0xFF)
> +		return gsi_2_irq[gsi];
> +	/*
> +	 * Ran out of vectors or IRQ >= NR_IRQS.  Sharing vectors
> +	 * means sharing IRQs, so scan irq_vectors for previous use
> +	 * of vector and return that IRQ.
> +	 */
> +	tries = NR_IRQS;
> +  try_again:
> +	vector = assign_irq_vector(gsi);
> +
> +	/* Find the first IRQ using vector. */
> +	for (i = 0; i < NR_IRQS; i++)
> +		if (IO_APIC_VECTOR(i) == vector)
> +			break;
> +
> +	if (i >= NR_IRQS || platform_legacy_irq(i)) {
> +		if (--tries >= 0) {
> +			IO_APIC_VECTOR(gsi) = 0;
> +			goto try_again;
> +		}
> +		panic("gsi_irq_sharing: didn't find an IRQ 
> using vector 0x%02X for GSI %d", vector, gsi);
> +	}
> +	printk("GSI %d assigned vector 0x%02X and IRQ %d\n", 
> gsi, vector, i);
> +	gsi_2_irq[gsi] = i;
> +	return i;
> +}
> +
>  static int pin_2_irq(int idx, int apic, int pin)  {
>  	int irq, i;
> 
> 
> --
> James Cleverdon
> IBM LTC (xSeries Linux Solutions)
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
> 
