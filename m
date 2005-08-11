Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVHKAWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVHKAWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVHKAWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:22:13 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:5133 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S964943AbVHKAWM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:22:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Wed, 10 Aug 2005 19:21:05 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB0@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][2.6.12.3] IRQ compression/sharing patch
Thread-Index: AcWeBvG9bKm5+6FTR8a+Ky/TbVMWFgAAOBzg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <jamesclv@us.ibm.com>
Cc: "Andi Kleen" <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       <zwane@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2005 00:21:05.0448 (UTC) FILETIME=[901B0A80:01C59E0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > int gsi_irq_sharing(int gsi)
> > {
> >         int i, irq, vector;
> >
> >         BUG_ON(gsi >= NR_IRQ_VECTORS);
> >
> >         if (platform_legacy_irq(gsi)) {
> >                 gsi_2_irq[gsi] = gsi;
> >                 return gsi;
> >         }
> >
> >         if (gsi_2_irq[gsi] != 0xFF)
> >                 return (int)gsi_2_irq[gsi];
> >
> >         vector = assign_irq_vector(gsi); // this part here==========
> 
> I thought I had this case covered earlier, given that in both i386 and
> x86_64:
> 
> #define platform_legacy_irq(irq)      ((irq) < 16)

Yes, you are absolutely correct, I don't need the (gsi<16) part, this
takes care of PCI IRQs that happened to be <16.

> In the deleted vector sharing code, I also check 
> platform_legacy_irq, to avoid inadvertently sharing vectors 
> already assigned to legacy IRQs.
> 
> Am I missing your point here?
> 
> >         if (gsi < 16) {
> >                 irq = gsi;
> >                 gsi_2_irq[gsi] = irq;
> >         } else {
> >                 irq = next_irq++;
> >                 gsi_2_irq[gsi] = irq;
> >         }
> > //====================
> 
> I can't explain the gaps in the numbers with the original 
> version.  I'll give your variant a try.

The only problem is here:

+	if (i < NR_IRQS) {
+		gsi_2_irq[gsi] = i;
+		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ
%d\n",
+				gsi, vector, i);
+		return i;
+	}
+
+	i = next_irq++;
 
That means for any IRQ < NR_IRQS you allow it to be identity mapped,
with all the gaps, and only for ones exceeding 224 you'll assign
consecutive next_irqs++, whereas you can do it for all PCI IRQs above
15. So, the alternative clause should probably come down to just:
                 irq = next_irq++;
                 gsi_2_irq[gsi] = irq; - which means just removing the
one above...
(although we better test that :)...I will definitely test vector sharing
when manage to get on max configuration partition here.

Regards,
--Natalie
 
