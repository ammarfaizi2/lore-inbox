Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVHLBHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVHLBHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHLBHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:07:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55203 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932361AbVHLBHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:07:44 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 11 Aug 2005 18:07:37 -0700
User-Agent: KMail/1.7.1
Cc: "Andi Kleen" <ak@suse.de>, "Russ Weight" <rweight@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB4@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB4@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111807.38171.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 02:55 pm, Protasevich, Natalie wrote:
> > After sleeping on it, maybe the original code can be patched 
> > without having to hack assign_irq_vector(), etc.  How about:
> > 
> > --- io_apic.c	2005-08-11 10:14:33.564748923 -0700
> > +++ io_apic.c.new	2005-08-11 10:15:55.412331115 -0700
> > @@ -617,7 +617,7 @@ int gsi_irq_sharing(int gsi)
> >  	 * than PCI.
> >  	 */
> >  	for (i = 0; i < NR_IRQS; i++)
> > -		if (IO_APIC_VECTOR(i) == vector) {
> > +		if (IO_APIC_VECTOR(i) == vector && i != gsi) {
> >  			if (!platform_legacy_irq(i))
> >  				break;			/* got one */
> >  			IO_APIC_VECTOR(gsi) = 0;
> > 
> > 
> Yes that did it, on my small system it looked just right:
> 
> <7>IRQ to pin mappings:
> <7>IRQ0 -> 0:2
> <7>IRQ1 -> 0:1
> <7>IRQ3 -> 0:3
> <7>IRQ4 -> 0:4
> <7>IRQ5 -> 0:5
> <7>IRQ6 -> 0:6
> <7>IRQ7 -> 0:7
> <7>IRQ8 -> 0:8
> <7>IRQ9 -> 0:9
> <7>IRQ10 -> 0:10
> <7>IRQ11 -> 0:11
> <7>IRQ12 -> 0:12
> <7>IRQ14 -> 0:14
> <7>IRQ15 -> 0:15
> <7>IRQ16 -> 0:16
> <7>IRQ17 -> 0:17
> <7>IRQ18 -> 0:18
> <7>IRQ19 -> 0:19
> <7>IRQ20 -> 0:20
> <7>IRQ21 -> 0:23
> <7>IRQ22 -> 1:2
> <7>IRQ23 -> 1:3
> <7>IRQ24 -> 1:4
> <7>IRQ25 -> 1:5
> <7>IRQ26 -> 2:0
> <7>IRQ27 -> 2:1
> <7>IRQ28 -> 2:2
> <7>IRQ29 -> 2:3
> <7>IRQ30 -> 2:4
> <7>IRQ31 -> 2:5
> <7>IRQ32 -> 2:6
> <7>IRQ33 -> 2:7
> <7>IRQ34 -> 2:8
> :!cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:      12621      15007      12781      20921    IO-APIC-edge  timer
>   1:         72          0          2        175    IO-APIC-edge  i8042
>   2:          0          0          0          0          XT-PIC
> cascade
>   8:          0          0          0          1    IO-APIC-edge  rtc
>   9:          0          0          0          0    IO-APIC-edge  acpi
>  12:          4        272          0        110    IO-APIC-edge  i8042
>  15:          4          0          0         39    IO-APIC-edge  ide1
>  16:          0          0          0          0   IO-APIC-level
> uhci_hcd:usb1, uhci_hcd:usb4
>  17:          0          0          0          2   IO-APIC-level
> ohci1394
>  18:        730       2407        932       2083   IO-APIC-level
> libata, uhci_hcd:usb3
>  19:          0          0          0          0   IO-APIC-level
> uhci_hcd:usb2
>  21:          0          0          0          0   IO-APIC-level
> ehci_hcd:usb5
>  26:        416          0          0          4   IO-APIC-level  eth0
> NMI:        116         71         73         51
> LOC:      61280      61258      61236      61214
> ERR:          3
> MIS:          0
> 
> Looks good! I will try the patch also on the ES7000 hopefully big enough
> to exercise some vector sharing.
> 
> Regards,
> --Natalie


No, my quick fix still has some enumeration problems.  Suppose
gsi_irq_sharing has already handed out IRQ 16, then it is called with
GSI 16?  We'd call assign_irq_vector(16), which would clobber
irq_vector[16].  Not good.  We need to avoid assign_irq_vector's
habit of storing the vector in irq_vector until we commit to a
particular IRQ number.

Here's a quick and ugly kludge:

--- 2.6.12.3/arch/x86_64/kernel/io_apic.c	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/arch/x86_64/kernel/io_apic.c	2005-08-11 17:15:39.000000000 -0700
@@ -581,6 +586,69 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
+static int next_irq = 16;
+
+/*
+ * gsi_irq_sharing -- Name overload!  "irq" can be either a legacy IRQ
+ * in the range 0-15, a linux IRQ in the range 0-223, or a GSI number
+ * from ACPI, which can reach 800 in large boxen.
+ *
+ * Compact the sparse GSI space into a sequential IRQ series and reuse
+ * vectors if possible.
+ */
+int gsi_irq_sharing(int gsi)
+{
+	int i, tries, vector;
+	u8 saved_vector;
+
+	BUG_ON(gsi >= NR_IRQ_VECTORS);
+
+	if (platform_legacy_irq(gsi)) {
+		gsi_2_irq[gsi] = gsi;
+		return gsi;
+	}
+
+	if (gsi_2_irq[gsi] != 0xFF)
+		return (int)gsi_2_irq[gsi];
+
+	tries = NR_IRQS;
+  try_again:
+	saved_vector = IO_APIC_VECTOR(gsi);	/* Kludge:  Need to make assign_irq_vector not always store vector in irq_vector */
+	vector = assign_irq_vector(gsi);
+	IO_APIC_VECTOR(gsi) = saved_vector;	/* Rest of Kludge */
+
+	/*
+	 * Sharing vectors means sharing IRQs, so scan irq_vectors for previous
+	 * use of vector and if found, return that IRQ.  However, we never want
+	 * to share legacy IRQs, which usually have a different trigger mode
+	 * than PCI.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		if (IO_APIC_VECTOR(i) == vector)
+			break;
+	if (platform_legacy_irq(i)) {
+		if (--tries >= 0) {
+			IO_APIC_VECTOR(i) = 0;
+			goto try_again;
+		}
+		panic("gsi_irq_sharing: didn't find an IRQ using vector 0x%02X for GSI %d", vector, gsi);
+	}
+	if (i < NR_IRQS) {
+		gsi_2_irq[gsi] = i;
+		printk(/*KERN_INFO*/ KERN_ERR "GSI %d sharing vector 0x%02X and IRQ %d\n",
+				gsi, vector, i);
+		return i;
+	}
+
+	i = next_irq++;
+	BUG_ON(i >= NR_IRQS);
+	gsi_2_irq[gsi] = i;
+	IO_APIC_VECTOR(i) = vector;
+	printk(/*KERN_INFO*/ KERN_ERR "GSI %d assigned vector 0x%02X and IRQ %d\n",
+			gsi, vector, i);
+	return i;
+}
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;


I suppose the real solution might be an extra argument to
assign_irq_vector to tell it whether to save the vector or not.

What do you think?

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
