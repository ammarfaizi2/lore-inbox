Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUDVRGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUDVRGF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUDVRGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:06:05 -0400
Received: from fmr01.intel.com ([192.55.52.18]:8881 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264562AbUDVRF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:05:57 -0400
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z aka
	Newisys 2100
From: Len Brown <len.brown@intel.com>
To: Shantanu Goel <Shantanu.Goel@lehman.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082653547.16336.335.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 13:05:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 10:17, Shantanu Goel wrote:

> I think there might be a timer IRQ routing issue with 2.6 on this 
> particular hardware.  I have tried 2.6.6-rc1-bk4 and 2.6.6-rc2-mm1 and
> both hang after loading the RAM disk.  After the hang, the system 
> continues to respond to Ctrl-Alt-Del but does not come up in
> multi-user 
> mode.  However, Redhat AS3 kernel (2.4.21-9.0.1.ELsmp)  works
> perfectly 
> on this machine.
> I noticed a difference in timer detection between the two kernel.
> 
> 2.4 reports:
> 
> ..TIMER: vector=0x31 pin1=2 pin2=0
> 
> 2.6.6-rc1-bk4 reports:
> 
> ..TIMER: vector=0x31 pin1=2 pin2=-1

This should be okay, the -1 means that there was no ExtInt entry for the
timer in the mp_irqs[], which is what one would expect in ACPI mode.
The mystery to me is actually whey pin2=0 in ACPI mode on RHEL,
but since pin1 is valid, pin2 will not be used anyway.

> 2.6 is able to boot with acpi=off, though it only comes up in 
> uniprocessor mode.
> Thanks in advance for any help.  Attached is the complete dmesg output

Curious that acpi=off doesn't boot MP, the dmesg shows MPS present...
Anyway, try acpi=ht to get your cpus back.

More interesting would be if pci=noacpi works on 2.6.
you might also try a stock 2.6.5 kernel in case something recently broke
in 2.6.6.

Also, the console log would be more helpful if booted with "debug"
so we can see exactly how the IOAPIC is programmed.

> 2.4:

> Linux version 2.4.21-9.0.1.ELsmp (bhcompile@dolly.devel.redhat.com)
> (gcc 
> version 3.2.3 20030502 (Red Hat Linux 3.2.3-26)) #1 SMP Mon Feb 9 
> 22:11:50 EST 2004

> ACPI: RSDP (v002 PTLTD                      ) @ 0x00000000000f7d00
> ACPI: XSDT (v001 PTLTD       XSDT   01540.00000) @ 0x000000007ff7108b
> ACPI: FADT (v003 NWS    1U2P     01540.00000) @ 0x000000007ff72e46
> ACPI: MADT (v001 PTLTD       APIC   01540.00000) @ 0x000000007ff72f3a
> ACPI: SPCR (v001 PTLTD  $UCRTBL$ 01540.00000) @ 0x000000007ff72fb0
> ACPI: DSDT (v001    NWS   1U2P   01540.00000) @ 0x0000000000000000

Curious to see no HPET, most AMD x86_64 boxes seem to have them.

> time.c: Detected 1.193182 MHz PIT timer.
> time.c: Detected 1991.941 MHz TSC timer.

> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=0

I don't know why pin2=0 on RHEL x86_64 here,
but I've see it also on x86_64 systems which
run 2.6.5 properly.

> Using local APIC timer interrupts.
> Detected 12.449 MHz APIC timer.

> time.c: Using PIT/TSC based timekeeping.

> Red Hat Enterprise Linux AS release 3 (Taroon Update 1)
> Kernel 2.4.21-9.0.1.ELsmp on an x86_64


> 2.6:
> 
> Linux version 2.6.6-rc1-bk4-x86_64 (root@njlxlabstinger2) (gcc version
> 3.2.3 20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Tue Apr 20 13:25:44
> EDT 2004

> time.c: Using 1.193182 MHz PIT timer.
> time.c: Detected 1991.987 MHz processor.

> ENABLING IO-APIC IRQs
> Synchronizing Arb IDs.
> ..TIMER: vector=0x31 pin1=2 pin2=-1

> Using local APIC timer interrupts.
> Detected 12.449 MHz APIC timer.

> time.c: Using PIT/TSC based timekeeping.

The timer messages look normal to me.

cheers,
-Len


