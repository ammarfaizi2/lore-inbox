Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUCMElu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 23:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbUCMElu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 23:41:50 -0500
Received: from fmr06.intel.com ([134.134.136.7]:29665 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263041AbUCMEls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 23:41:48 -0500
Subject: Re: ALSA via82xx fails since 2.6.2
From: Len Brown <len.brown@intel.com>
To: =?ISO-8859-1?Q?J=FCrgen?= Repolusk <juerep@gmx.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200403130336.36845.juerep@gmx.at>
References: <A6974D8E5F98D511BB910002A50A6647615F4E8F@hdsmsx402.hd.intel.com>
	 <1079142765.2175.71.camel@dhcppc4>  <200403130336.36845.juerep@gmx.at>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1079152902.2175.88.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Mar 2004 23:41:43 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 21:36, Jürgen Repolusk wrote:

>            CPU0
>   0:   22589343          XT-PIC  timer
>   1:       3716          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   8:          2          XT-PIC  rtc
>   9:     100000          XT-PIC  acpi, uhci_hcd, uhci_hcd, yenta, eth1
>  10:     453565          XT-PIC  yenta, eth0
>  11:          0          XT-PIC  sonypi
>  12:     101345          XT-PIC  i8042
>  14:      42157          XT-PIC  ide0
>  15:         22          XT-PIC  ide1
> NMI:          0
> LOC:   22589934
> ERR:      42084
> MIS:          0
> 
> 

curious that an audio driver does not show up on irq 5 where the device
claims to be...

> > how about when you boot with acpi=off or pci=noacpi?
> actually i gave it a try but it doesn't change anything. still the same error.

Thanks for confirming that this isn't an ACPI bug;-)

I think what's happening is that one of the devices on IRQ9 is pulling
on that line.  ACPI is the 1st to register a handler on IRQ9, doesn't
know where the interrupts are coming from, and IRQ9 gets shut down
before the responsible device can register.

> > Are you sure you didn't see these messages before 2.6.2 -- was ACPI
> > enabled in the working release?
> 
> Yes I'm sure that before 2.6.2 I did not see this message at all - sound was 
> working real fine. with changin to 2.6.2 up to 2.6.4 now I've this problem.
> 
> 	greets, jürgen

There are a couple of things you can do to debug.

boot with "noirqdebug" to treat the symptom.  This will prevent IRQ9
from getting disabled.  If a device registers and claims those
interrupts, then the system will function.  If none does, then you'll
see IRQ9 in /proc/interrupts steadily climb and performance will be
poor.

remove your USB, yenta and eth1 hardware and see if one makes the issue
go away.

> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)

You can also use a feature in ACPI to distribute the interrupts and
perhaps isolate the offending device.  Boot with...

acpi_irq_balance acpi_irq_pci=3,4,5,7 acpi_irq_isa=9

This should tell the code to balance interrupts across IRQs where
possible, tending towards 3,4,5,7 and avoiding 9; it already tends
towards 10.

cheers,
-Len


