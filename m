Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSL3LdB>; Mon, 30 Dec 2002 06:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbSL3LdB>; Mon, 30 Dec 2002 06:33:01 -0500
Received: from c3po.skynet.be ([195.238.3.237]:22611 "EHLO c3po.skynet.be")
	by vger.kernel.org with ESMTP id <S266917AbSL3Lc5> convert rfc822-to-8bit;
	Mon, 30 Dec 2002 06:32:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans Lambrechts <hans.lambrechts@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre2: CPU0 handles all interrupts
Date: Mon, 30 Dec 2002 12:40:04 +0100
User-Agent: KMail/1.4.3
References: <200212281056.58419.hans.lambrechts@skynet.be> <200212281103.36973.rcooper@jamesconeyisland.com> <1041212142.1474.33.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1041212142.1474.33.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212301240.04998.hans.lambrechts@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 December 2002 02:35, you wrote:
> On Sat, 2002-12-28 at 17:03, Ron Cooper wrote:
> > Mine does this too.  2.4.20.  Iwill dp400 board running dual 2.4Ghz
> > Xeons with HT enabled.
> >
> > I have to boot by passing "noapic" to the kernel, otherwise
> > /cat/proc/interrupts will show the interrupt numbers wrong,
> > however. not doing this changes nothing.
>
> "noapic" will deliver all IRQ's to IRQ0. Note btw - IRQ numbers *do*
> change in APIC mode

Hi Alan,
maybe this snippet from patch-2.4.21-pre2.gz is the culprit:

diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.20/arch/i386/kernel/apic.c linux-2.4.21/arch/i386/kernel/apic.c
--- linux-2.4.20/arch/i386/kernel/apic.c        2002-12-18 18:27:05.000000000 +0000
+++ linux-2.4.21/arch/i386/kernel/apic.c        2002-12-18 18:58:08.000000000 +0000
@@ -261,6 +261,16 @@
        apic_write_around(APIC_LVT1, value);
 }

+static unsigned long calculate_ldr(unsigned long old)
+{
+       unsigned long id;
+       if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+               id = physical_to_logical_apicid(hard_smp_processor_id());
+       else
+               id = 1UL << smp_processor_id();
+       return (old & ~APIC_LDR_MASK)|SET_APIC_LOGICAL_ID(id);
+}
+
 void __init setup_local_APIC (void)
 {
        unsigned long value, ver, maxlvt;
@@ -298,15 +308,16 @@
                 * for us. Otherwise put the APIC into clustered or flat
                 * delivery mode. Must be "all ones" explicitly for 82489DX.
                 */
-               apic_write_around(APIC_DFR, APIC_DFR_FLAT);
+               if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+                       apic_write_around(APIC_DFR, APIC_DFR_CLUSTER);
+               else
+                       apic_write_around(APIC_DFR, APIC_DFR_FLAT);

                /*
                 * Set up the logical destination ID.
                 */
                value = apic_read(APIC_LDR);
-               value &= ~APIC_LDR_MASK;
-               value |= (1<<(smp_processor_id()+24));
-               apic_write_around(APIC_LDR, value);
+               apic_write_around(APIC_LDR, calculate_ldr(value));
        }

