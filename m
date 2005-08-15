Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVHOEdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVHOEdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 00:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVHOEdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 00:33:40 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:61967 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1750819AbVHOEdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 00:33:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 
Date: Sun, 14 Aug 2005 23:32:12 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CBA@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcWhUk5FKqNq8cMcRhe/OAXTBBri9g==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <jamesclv@us.ibm.com>, "Andi Kleen" <ak@suse.de>
Cc: "Russ Weight" <rweight@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Aug 2005 04:32:12.0684 (UTC) FILETIME=[4E87CCC0:01C5A152]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 04 August 2005 02:22 am, Andi Kleen wrote:
> > On Thu, Aug 04, 2005 at 12:05:50AM -0700, James Cleverdon wrote:
> > > diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c
> > > n12.3/arch/i386/kernel/acpi/boot.c ---
> > > 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 
> 14:18:57.000000000
> > > -0700 +++ n12.3/arch/i386/kernel/acpi/boot.c	2005-08-04
> > > 00:01:10.199710211 -0700 @@ -42,6 +42,7 @@  static inline void  
> > > acpi_madt_oem_check(char *oem_id, char
> > > *oem_table_id) { } extern void __init 
> clustered_apic_check(void);  
> > > static inline int ioapic_setup_disabled(void) { return 0; }
> > > +extern int gsi_irq_sharing(int gsi);
> > >  #include <asm/proto.h>
> > >
> > >  #else	/* X86 */
> > > @@ -51,6 +52,9 @@ static inline int 
> ioapic_setup_disabled(  #include 
> > > <mach_mpparse.h>
> > >  #endif	/* CONFIG_X86_LOCAL_APIC */
> > >
> > > +static inline int gsi_irq_sharing(int gsi) { return gsi; }
> >
> > Why is this different for i386/x86-64? It shouldn't.
> 
> True.  Have added code for i386.  Unfortunately, I didn't see 
> one file that is shared by both architectures and which is 
> included when building with I/O APIC support.  So, I 
> duplicated the function into io_apic.c
> 
> > As a unrelated note we really need to get rid of this whole ifdef 
> > block.
> >
> > > +++ n12.3/arch/x86_64/Kconfig	2005-08-03 
> 21:31:07.487451167 -0700
> > > @@ -280,13 +280,13 @@ config HAVE_DEC_LOCK
> > >  	default y
> > >
> > >  config NR_CPUS
> > > -	int "Maximum number of CPUs (2-256)"
> > > -	range 2 256
> > > +	int "Maximum number of CPUs (2-255)"
> > > +	range 2 255
> > >  	depends on SMP
> > > -	default "8"
> > > +	default "16"
> >
> > Don't change the default please.
> >
> > > +static int next_irq = 16;
> >
> > Won't this need a lock for hotplug later?
> 
> That's what I thought originally, but maybe not.  We 
> initialize all RTEs and assign IRQs+vectors fairly early in 
> boot, plus store the results in arrays.  Thereafter the 
> functions just return the preallocated values.
> 
> Hmmm...  Since the I/O APIC init comes after the other CPUs 
> are brought online, and since I don't understand all that the 
> MSI driver is trying to accomplish, it might be safer to use 
> a spin lock anyway.
> 
> > > +
> > > + retry_vector:
> > > +	vector = assign_irq_vector(gsi);
> > > +
> > > +	/*
> > > +	 * Sharing vectors means sharing IRQs, so scan irq_vectors for
> > > previous +	 * use of vector and if found, return that IRQ. 
> > > However, we never want +	 * to share legacy IRQs, which usually
> > > have a different trigger mode +	 * than PCI.
> > > +	 */
> >
> > Can we perhaps force such sharing early temporarily even when the 
> > table is not filled up?  This way we would get better test 
> coverage of 
> > all of  this.
> >
> > That would be later disabled of course.
> 
> Suppose I added a static counter and pretended that every 
> third non-legacy IRQ needed to be shared?
> 
> > Rest looks ok to me.
> >
> > -Andi
> 
> Sigh.  Have to attach the file again.  Sorry about that.
> 
> Signed-off-by:  James Cleverdon <jamesclv@us.ibm.com>

I think you were going to change this line, which fixed the jumps in the
irq distribution:

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
But it's not in this version of the patch.
Thanks,
--Natalie
> --
> James Cleverdon
> IBM LTC (xSeries Linux Solutions)
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
> 
> 
