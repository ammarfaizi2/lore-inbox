Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUFSN5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUFSN5G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFSN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:56:37 -0400
Received: from fmr11.intel.com ([192.55.52.31]:40405 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265780AbUFSNza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:55:30 -0400
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
From: Len Brown <len.brown@intel.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, peter@cordes.ca, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200406191239.i5JCd6oX028139@harpo.it.uu.se>
References: <200406191239.i5JCd6oX028139@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1087653306.4489.244.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Jun 2004 09:55:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 08:39, Mikael Pettersson wrote:
> On Fri, 18 Jun 2004 04:41:32 -0300, Peter Cordes wrote:
> >On Thu, Jun 17, 2004 at 12:26:45PM +0200, Andi Kleen wrote:
> >> On Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
> >> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >>
> >> > On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
> >> > > I just noticed that on my Opteron cluster, the nodes that are running
> > 64bit
> >> > >kernels have their clocks ticking at double speed.  This happens with
> >> > >Linux 2.4.26, and 2.4.27-pre2
> >> >
> >> > I had the same problem: 2.4 x86-64 kernels ticking the clock
> >> > twice its normal speed, unless I booted with pci=noacpi.
> >> >
> >> > This got fixed very recently I believe, in a 2.4.27-pre kernel.
> >>
> Confirmed: pre2 has the bug, pre3 and later do not.
> 
> For reference, here's how pre2 and pre3 dmesg outputs
> differ on my K8 (MSI K8T Neo-FIS2R).

All the changes you highlight were made by me.
If it is really important to figure out why this system
failed in the past and works now, send me the complete dmesg
for each kernel, /proc/interrupts and output from dmidecode.


> --- dmesg-2.4.27-pre2	2004-06-19 13:56:57.000000000 +0200
> +++ dmesg-2.4.27-pre3	2004-06-19 13:59:14.000000000 +0200

> @@ -39,6 +38,9 @@
>  IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
>  ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> +ACPI: IRQ0 used by override.
> +ACPI: IRQ2 used by override.
> +ACPI: IRQ9 used by override.

believe it or not, these printks were added to work
around an x86_64 gcc bug.

>  Using ACPI (MADT) for SMP configuration information
>  Kernel command line: BOOT_IMAGE=bzimage apic

If this is a VIA system, IIR you should not longer need
the "apic" cmdline parameter.

>  Initializing CPU#0
> @@ -59,8 +61,8 @@
>  testing NMI watchdog ... OK.
>  ENABLING IO-APIC IRQs
>  init IO_APIC IRQs
> - IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
> -..TIMER: vector=0x31 pin1=0 pin2=-1
> + IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
> +..TIMER: vector=0x31 pin1=2 pin2=-1

Timer seems to be happy now on IRQ/pin2
Not immediately clear why it was on pin0+pin2 before.

>  Using local APIC timer interrupts.
>  Detected 12.500 MHz APIC timer.
>  cpu: 0, clocks: 2000140, slice: 1000070

> +number of MP IRQ sources: 15.
>  number of IO-APIC #2 registers: 24.
>  testing the IO APIC.......................
>  
> @@ -117,7 +111,7 @@
>  .......     : IO APIC version: 0003
>  .... IRQ redirection table:
>   NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
> - 00 001 01  0    0    0   0   0    1    1    31
> + 00 000 00  1    0    0   0   0    0    0    00
>   01 001 01  0    0    0   0   0    1    1    39
>   02 001 01  0    0    0   0   0    1    1    31

notice double mapping on vector 31 is now gone.

>   03 001 01  0    0    0   0   0    1    1    41
> @@ -142,7 +136,7 @@
>   16 001 01  1    1    0   1   0    1    1    C1
>   17 001 01  1    1    0   1   0    1    1    E1
>  IRQ to pin mappings:
> -IRQ0 -> 0:0-> 0:2

This one was broken.  Whenever you see a double IRQ mapping
like this in ACPI mode it indicates a bug.

> +IRQ0 -> 0:2
>  IRQ1 -> 0:1
>  IRQ3 -> 0:3
>  IRQ4 -> 0:4

anyway, if you see problems going forward, please let me know.

cheers,
-Len


