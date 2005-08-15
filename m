Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVHORoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVHORoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVHORoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:44:34 -0400
Received: from mail.suse.de ([195.135.220.2]:42696 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964861AbVHORod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:44:33 -0400
Date: Mon, 15 Aug 2005 19:44:32 +0200
From: Andi Kleen <ak@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Russ Weight <rweight@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Message-ID: <20050815174432.GC20749@wotan.suse.de>
References: <200507260012.41968.jamesclv@us.ibm.com> <200508040005.50817.jamesclv@us.ibm.com> <20050804092221.GL8266@wotan.suse.de> <200508141957.53396.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508141957.53396.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 07:57:53PM -0700, James Cleverdon wrote:
> On Thursday 04 August 2005 02:22 am, Andi Kleen wrote:
> > On Thu, Aug 04, 2005 at 12:05:50AM -0700, James Cleverdon wrote:
> > > diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c
> > > n12.3/arch/i386/kernel/acpi/boot.c ---
> > > 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000
> > > -0700 +++ n12.3/arch/i386/kernel/acpi/boot.c	2005-08-04
> > > 00:01:10.199710211 -0700 @@ -42,6 +42,7 @@
> > >  static inline void  acpi_madt_oem_check(char *oem_id, char
> > > *oem_table_id) { } extern void __init clustered_apic_check(void);
> > >  static inline int ioapic_setup_disabled(void) { return 0; }
> > > +extern int gsi_irq_sharing(int gsi);
> > >  #include <asm/proto.h>
> > >
> > >  #else	/* X86 */
> > > @@ -51,6 +52,9 @@ static inline int ioapic_setup_disabled(
> > >  #include <mach_mpparse.h>
> > >  #endif	/* CONFIG_X86_LOCAL_APIC */
> > >
> > > +static inline int gsi_irq_sharing(int gsi) { return gsi; }
> >
> > Why is this different for i386/x86-64? It shouldn't.
> 
> True.  Have added code for i386.  Unfortunately, I didn't see one file 
> that is shared by both architectures and which is included when 
> building with I/O APIC support.  So, I duplicated the function into 
> io_apic.c

That needs to be cleaned up before merge. This code is already ugly and I don't
want the cruft accumulating here.

> > As a unrelated note we really need to get rid of this whole ifdef
> > block.
> >
> > > +++ n12.3/arch/x86_64/Kconfig	2005-08-03 21:31:07.487451167 -0700
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
> That's what I thought originally, but maybe not.  We initialize all RTEs 
> and assign IRQs+vectors fairly early in boot, plus store the results in 
> arrays.  Thereafter the functions just return the preallocated values.

I was thinking of IO-APIC hotplug here. IIRC the ia64 folks
have it already and I'm sure someone will turn up with a patch
for i386/x86-64 soon. For devices it should be ok, you're right.

Ok I guess they can change it in that patch then. Perhaps
just add a comment.

> > > have a different trigger mode +	 * than PCI.
> > > +	 */
> >
> > Can we perhaps force such sharing early temporarily even when the
> > table is not filled up?  This way we would get better test coverage
> > of all of  this.
> >
> > That would be later disabled of course.
> 
> Suppose I added a static counter and pretended that every third 
> non-legacy IRQ needed to be shared?

Can you drop into the sharing path unconditionally?

-Andi
