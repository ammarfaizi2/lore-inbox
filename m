Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbUJ1BzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUJ1BzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUJ1BzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:55:24 -0400
Received: from fmr10.intel.com ([192.55.52.30]:28315 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262683AbUJ1BzF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:55:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fixing MTRR smp breakage and suspending sysdevs.
Date: Wed, 27 Oct 2004 18:54:36 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600333AEF9@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing MTRR smp breakage and suspending sysdevs.
Thread-Index: AcS8EfsXY1o15QQ6TFu8j9E6cOb6HAAfbqQw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Li, Shaohua" <shaohua.li@intel.com>
Cc: <ncunningham@linuxmail.org>, "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Oct 2004 01:54:37.0946 (UTC) FILETIME=[14DC05A0:01C4BC91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Pavel Machek
>Sent: Wednesday, October 27, 2004 3:01 AM
>To: Li, Shaohua
>Cc: ncunningham@linuxmail.org; Patrick Mochel; Linux Kernel 
>Mailing List
>Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
>
>Hi!
>
>> >One thing I have noticed is that by adding the sysdev suspend/resume
>> >calls, I've gained a few seconds delay. I'll see if I can track down
>> the
>> >cause.
>> Is the problem MTRR resume must be with IRQ enabled, right? Could we
>> implement a method sysdev resume with IRQ enabled? MTRR driver isn't
>> the
>
>MTRR does not deserve to be sysdev. It is not essential for the
>system, it only makes it slow.
>
>> only case. The ACPI Link device is another case, it's a 
>sysdev (it must
>> resume before any PCI device resumed), but its resume (it 
>uses semaphore
>> and non-atomic kmalloc) can't invoked with IRQ enabled. I 
>guess cpufreq
>> driver is another case when suspend/resume SMP is supported.
>
>I do not see how enabling interrupts before setting up IRQs is good
>idea.
>
>What about this one, instead?
>
>* ACPI Link device should allocate with GFP_ATOMIC
>
>* during suspend, locks can't be taken. (We stop userland, etc). So it
>should be okay to down_trylock() and panic if that does not work.


Actually, I am trying another approach for Link Device.

- Temporarily enable interrupts during Link Device resume. Turn off all
the external interrupts at suspend time. They will remain suspended
until interrupt device resumes.

Something like the patch below. Only part I don't like is controlling
the resume order by Makefiles and the link order. Probably we can fix
that by sorting the sysdev list at the boottime, depending on our
ordering requirements. I think, the resume order we need to maintain is
something like this: irqrouter, pit/timer, i8259, lapic, ioapic, others

Thanks,
-Venki

--- linux-2.6.9-latest/arch/i386/kernel/i8259.c.org	2004-10-26
21:58:32.000000000 -0700
+++ linux-2.6.9-latest/arch/i386/kernel/i8259.c	2004-10-27
13:06:12.000000000 -0700
@@ -266,6 +266,10 @@ static int i8259A_resume(struct sys_devi
 static int i8259A_suspend(struct sys_device *dev, u32 state)
 {
 	save_ELCR(irq_trigger);
+	/* Stop all the interrupts from PIC until resume */
+	outb(0xff, PIC_MASTER_IMR);
+	outb(0xff, PIC_SLAVE_IMR);
+
 	return 0;
 }
 
--- linux-2.6.9-latest/arch/i386/kernel/io_apic.c.org	2004-10-26
22:05:58.000000000 -0700
+++ linux-2.6.9-latest/arch/i386/kernel/io_apic.c	2004-10-26
22:06:53.000000000 -0700
@@ -2302,6 +2302,7 @@ static int ioapic_suspend(struct sys_dev
 		*(((int *)entry) + 1) = io_apic_read(dev->id, 0x11 + 2 *
i);
 		*(((int *)entry) + 0) = io_apic_read(dev->id, 0x10 + 2 *
i);
 	}
+	clear_IO_APIC();
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
--- linux-2.6.9-latest/drivers/acpi/pci_link.c.org	2004-10-26
22:13:20.000000000 -0700
+++ linux-2.6.9-latest/drivers/acpi/pci_link.c	2004-10-27
13:31:43.000000000 -0700
@@ -714,9 +714,12 @@ irqrouter_resume(
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
+	unsigned long 		flags;
 
 	ACPI_FUNCTION_TRACE("irqrouter_resume");
 
+	local_save_flags(flags);
+	local_irq_enable();
 	list_for_each(node, &acpi_link.entries) {
 
 		link = list_entry(node, struct acpi_pci_link, node);
@@ -727,6 +730,7 @@ irqrouter_resume(
 
 		acpi_pci_link_resume(link);
 	}
+	local_irq_restore(flags);
 	return_VALUE(0);
 }
 
--- linux-2.6.9-latest/Makefile.org	2004-10-27 12:38:19.000000000
-0700
+++ linux-2.6.9-latest/Makefile	2004-10-27 13:06:10.000000000 -0700
@@ -571,7 +571,7 @@ libs-y		:= $(libs-y1) $(libs-y2)
 # System.map is generated to document addresses of all kernel symbols
 
 vmlinux-init := $(head-y) $(init-y)
-vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+vmlinux-main := $(drivers-y) $(core-y) $(libs-y) $(net-y)
 vmlinux-all  := $(vmlinux-init) $(vmlinux-main)
 vmlinux-lds  := arch/$(ARCH)/kernel/vmlinux.lds
 
