Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVHKDOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVHKDOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 23:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHKDOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 23:14:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49591 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932240AbVHKDOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 23:14:17 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Wed, 10 Aug 2005 20:14:13 -0700
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       Russ Weight <rweight@us.ibm.com>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB0@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB0@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508102014.14138.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 August 2005 05:21 pm, Protasevich, Natalie wrote:
> > > int gsi_irq_sharing(int gsi)
> > > {
> > >         int i, irq, vector;
> > >
> > >         BUG_ON(gsi >= NR_IRQ_VECTORS);
> > >
> > >         if (platform_legacy_irq(gsi)) {
> > >                 gsi_2_irq[gsi] = gsi;
> > >                 return gsi;
> > >         }
> > >
> > >         if (gsi_2_irq[gsi] != 0xFF)
> > >                 return (int)gsi_2_irq[gsi];
> > >
> > >         vector = assign_irq_vector(gsi); // this part
> > > here==========
> >
> > I thought I had this case covered earlier, given that in both i386
> > and x86_64:
> >
> > #define platform_legacy_irq(irq)      ((irq) < 16)
>
> Yes, you are absolutely correct, I don't need the (gsi<16) part, this
> takes care of PCI IRQs that happened to be <16.
>
> > In the deleted vector sharing code, I also check
> > platform_legacy_irq, to avoid inadvertently sharing vectors
> > already assigned to legacy IRQs.
> >
> > Am I missing your point here?
> >
> > >         if (gsi < 16) {
> > >                 irq = gsi;
> > >                 gsi_2_irq[gsi] = irq;
> > >         } else {
> > >                 irq = next_irq++;
> > >                 gsi_2_irq[gsi] = irq;
> > >         }
> > > //====================
> >
> > I can't explain the gaps in the numbers with the original
> > version.  I'll give your variant a try.
>
> The only problem is here:
>
> +	if (i < NR_IRQS) {
> +		gsi_2_irq[gsi] = i;
> +		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ
> %d\n",
> +				gsi, vector, i);
> +		return i;
> +	}
> +
> +	i = next_irq++;
>
> That means for any IRQ < NR_IRQS you allow it to be identity mapped,
> with all the gaps, and only for ones exceeding 224 you'll assign
> consecutive next_irqs++, whereas you can do it for all PCI IRQs above
> 15. So, the alternative clause should probably come down to just:
>                  irq = next_irq++;
>                  gsi_2_irq[gsi] = irq; - which means just removing
> the one above...
> (although we better test that :)...I will definitely test vector
> sharing when manage to get on max configuration partition here.
>
> Regards,
> --Natalie

Blast.  You're right, because i is the results of scanning irq_vector 
(AKA IO_APIC_VECTOR()) for a previous use of the vector.  If i < 
NR_IRQS then it has found a previous use and would substitute the other 
IRQ number rather than allocate a new one.

Of course, one side effect of calling assign_irq_vector(gsi) is that the 
vector number is stored at position gsi in irq_vector.  So, for IRQs 0 
to NR_IRQS - 1, it will always find itself.

OK, how about not fighting that side effect and only reassigning IRQs
that are >= NR_IRQS?  Maybe something like this:

@@ -579,4 +589,57 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
+/*
+ * gsi_irq_sharing -- Name overload!  "irq" can be either a legacy IRQ
+ * in the range 0-15, a linux IRQ in the range 0-223, or a GSI number
+ * from ACPI, which can easily reach 800.
+ *
+ * Compact the sparse GSI space into a available IRQs and reuse
+ * vectors if possible.
+ */
+int gsi_irq_sharing(int gsi)
+{
+	int i, tries, vector;
+
+	BUG_ON(gsi >= NR_IRQ_VECTORS);
+
+	/*
+	 * Don't share legacy IRQs.  Their trigger modes are usually edge
+	 * and PCI is level.  Mixed modes are trouble.  Only big boxes are
+	 * likely to overflow IRQs or to share vectors.
+	 */
+	if (likely(gsi < NR_IRQS && !sharing_vectors) || platform_legacy_irq(gsi)) {
+		gsi_2_irq[gsi] = gsi;
+		return gsi;
+	}
+
+	if (gsi_2_irq[gsi] != 0xFF)
+		return gsi_2_irq[gsi];
+	/*
+	 * Ran out of vectors or IRQ >= NR_IRQS.  Sharing vectors
+	 * means sharing IRQs, so scan irq_vectors for previous use
+	 * of vector and return that IRQ.
+	 */
+	tries = NR_IRQS;
+  try_again:
+	vector = assign_irq_vector(gsi);
+
+	/* Find the first IRQ using vector. */
+	for (i = 0; i < NR_IRQS; i++)
+		if (IO_APIC_VECTOR(i) == vector)
+			break;
+
+	if (i >= NR_IRQS || platform_legacy_irq(i)) {
+		if (--tries >= 0) {
+			IO_APIC_VECTOR(gsi) = 0;
+			goto try_again;
+		}
+		panic("gsi_irq_sharing: didn't find an IRQ using vector 0x%02X for GSI %d", vector, gsi);
+	}
+	printk("GSI %d assigned vector 0x%02X and IRQ %d\n", gsi, vector, i);
+	gsi_2_irq[gsi] = i;
+	return i;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
