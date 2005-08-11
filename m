Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVHKRYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVHKRYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHKRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:24:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42954 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751140AbVHKRYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:24:22 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 11 Aug 2005 10:24:18 -0700
User-Agent: KMail/1.7.1
Cc: "Andi Kleen" <ak@suse.de>, "Russ Weight" <rweight@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB1@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB1@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111024.18446.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 06:15 am, Protasevich, Natalie wrote:
> > > The only problem is here:
> > >
> > > +	if (i < NR_IRQS) {
> > > +		gsi_2_irq[gsi] = i;
> > > +		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ
> > > %d\n",
> > > +				gsi, vector, i);
> > > +		return i;
> > > +	}
> > > +
> > > +	i = next_irq++;
> > >
> > > That means for any IRQ < NR_IRQS you allow it to be 
> > identity mapped, 
> > > with all the gaps, and only for ones exceeding 224 you'll assign 
> > > consecutive next_irqs++, whereas you can do it for all PCI 
> > IRQs above 
> > > 15. So, the alternative clause should probably come down to just:
> > >                  irq = next_irq++;
> > >                  gsi_2_irq[gsi] = irq; - which means just 
> > removing the 
> > > one above...
> > > (although we better test that :)...I will definitely test vector 
> > > sharing when manage to get on max configuration partition here.
> > >
> > > Regards,
> > > --Natalie
> > 
> > Blast.  You're right, because i is the results of scanning 
> > irq_vector (AKA IO_APIC_VECTOR()) for a previous use of the 
> > vector.  If i < NR_IRQS then it has found a previous use and 
> > would substitute the other IRQ number rather than allocate a new one.
> > 
> > Of course, one side effect of calling assign_irq_vector(gsi) 
> > is that the vector number is stored at position gsi in 
> > irq_vector.  So, for IRQs 0 to NR_IRQS - 1, it will always 
> > find itself.
> > 
> > OK, how about not fighting that side effect and only 
> > reassigning IRQs that are >= NR_IRQS?  Maybe something like this:
> 
> I am wondering where sharing_vectors gets set, it was not in the patch
> originally.

Oh, that.  Sorry, I added it to indicate when the vectors are all used
up.  Here:

@@ -667,14 +736,14 @@ int __init assign_irq_vector(int irq)
 	if (current_vector == IA32_SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
-		offset++;
+	if (current_vector >= FIRST_SYSTEM_VECTOR) {
+		/* If we run out of vectors on large boxen, must share them. */
+		offset = (offset + 1) % 8;
+		if (offset == 0)
+			sharing_vectors = 1;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
-
 	IO_APIC_VECTOR(irq) = current_vector;
 	return current_vector;
 }


Since we run out of vectors before IRQs, we need to start checking for
vector reuse once assign_irq_vector wrapped.  I'm not especially happy
about putting in a global flag variable, but the alternative was to
scan irq_vectors for duplicates on every IRQ.  This seemed wasteful
when most boxes will never use up either vectors or IRQs.

After sleeping on it, maybe the original code can be patched without
having to hack assign_irq_vector(), etc.  How about:

--- io_apic.c	2005-08-11 10:14:33.564748923 -0700
+++ io_apic.c.new	2005-08-11 10:15:55.412331115 -0700
@@ -617,7 +617,7 @@ int gsi_irq_sharing(int gsi)
 	 * than PCI.
 	 */
 	for (i = 0; i < NR_IRQS; i++)
-		if (IO_APIC_VECTOR(i) == vector) {
+		if (IO_APIC_VECTOR(i) == vector && i != gsi) {
 			if (!platform_legacy_irq(i))
 				break;			/* got one */
 			IO_APIC_VECTOR(gsi) = 0;



> > @@ -579,4 +589,57 @@ static inline int irq_trigger(int idx)
> >  	return MPBIOS_trigger(idx);
> >  }
> >  
> > +/*
> > + * gsi_irq_sharing -- Name overload!  "irq" can be either a 
> > legacy IRQ
> > + * in the range 0-15, a linux IRQ in the range 0-223, or a GSI number
> > + * from ACPI, which can easily reach 800.
> > + *
> > + * Compact the sparse GSI space into a available IRQs and reuse
> > + * vectors if possible.
> > + */
> > +int gsi_irq_sharing(int gsi)
> > +{
> > +	int i, tries, vector;
> > +
> > +	BUG_ON(gsi >= NR_IRQ_VECTORS);
> > +
> > +	/*
> > +	 * Don't share legacy IRQs.  Their trigger modes are 
> > usually edge
> > +	 * and PCI is level.  Mixed modes are trouble.  Only 
> > big boxes are
> > +	 * likely to overflow IRQs or to share vectors.
> > +	 */
> > +	if (likely(gsi < NR_IRQS && !sharing_vectors) || 
> > platform_legacy_irq(gsi)) {
> > +		gsi_2_irq[gsi] = gsi;
> > +		return gsi;
> > +	}
> > +
> > +	if (gsi_2_irq[gsi] != 0xFF)
> > +		return gsi_2_irq[gsi];
> > +	/*
> > +	 * Ran out of vectors or IRQ >= NR_IRQS.  Sharing vectors
> > +	 * means sharing IRQs, so scan irq_vectors for previous use
> > +	 * of vector and return that IRQ.
> > +	 */
> > +	tries = NR_IRQS;
> > +  try_again:
> > +	vector = assign_irq_vector(gsi);
> > +
> > +	/* Find the first IRQ using vector. */
> > +	for (i = 0; i < NR_IRQS; i++)
> > +		if (IO_APIC_VECTOR(i) == vector)
> > +			break;
> > +
> > +	if (i >= NR_IRQS || platform_legacy_irq(i)) {
> > +		if (--tries >= 0) {
> > +			IO_APIC_VECTOR(gsi) = 0;
> > +			goto try_again;
> > +		}
> > +		panic("gsi_irq_sharing: didn't find an IRQ 
> > using vector 0x%02X for GSI %d", vector, gsi);
> > +	}
> > +	printk("GSI %d assigned vector 0x%02X and IRQ %d\n", 
> > gsi, vector, i);
> > +	gsi_2_irq[gsi] = i;
> > +	return i;
> > +}
> > +
> >  static int pin_2_irq(int idx, int apic, int pin)  {
> >  	int irq, i;
> > 
> > 
> > --
> > James Cleverdon
> > IBM LTC (xSeries Linux Solutions)
> > {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
> > 
> 
> 
> 

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
