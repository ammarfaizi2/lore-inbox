Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269174AbTGORvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269333AbTGORsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:48:30 -0400
Received: from fmr02.intel.com ([192.55.52.25]:4046 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S269255AbTGORrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:47:15 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470B981250@hdsmsx103.hd.intel.com>
From: "Brown, Len" <len.brown@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Cc: ACPI-Devel mailing list <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 11:07:29 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's the schedule for Len's rework to Marcelo?

I'm testing today and expect to push via Andy
(http://linux-acpi.bkbits.net/to-andy-2.4)  when when I'm satisifed I
haven't toasted anything -- probably Wednesday. 

Cheers,
-Len

Ps. Below is the current plan for ACPI build and boot knobs.  Except for the
config syntax -- 2.4 and 2.5 should end up the same.  Let me know if we
missed anything.

Audit of ACPI build and boot options
Scrubbed w/ Andy 7/10 -- see TODO for Lenb's plan


Build Options
-------------
Indentation shows dependency (from acpi/Kconfig, Makefile)

CONFIG_ACPI_HT_ONLY
	depends on X86 && ACPI && X86_LOCAL_APIC
	:= acpitable.o

	TODO: simplify acpitable.c to only to LAPIC enumeration for HT
		It probably shouldn't parse the non-LAPIC MADT entries

	TODO: make this independent of the ACPI option:

		ACPI && ACPI_HT_ONLY
			Expect OSD's to build this way
			acpitable.c runs only if boot with acpi=cpu
			This matches SL8.2 distribution

		!ACPI && ACPI_HT_ONLY
			Minimal kernel to enable HT -- no ACPI
			acpi=cpu is the default behaviour here
			if somebody wants to disable ht, they can use "noht"
			This matches RHL's 2.4 distribution

		ACPI && !ACPI_HT_ONLY
			Full ACPI w/o the acpi=cpu option
			Maybe OSD's will get here some day

		!ACPI && !ACPI_HT_ONLY
			no HT, no ACPI

	TODO: delete the !CONFIG_ACPI_HT_ONLY from the module dependencies
below.
		They depend on ACPI, and don't care about
CONFIG_ACPI_HT_ONLY

CONFIG_ACPI
	depends on !X86_VISWS (SGI visual workstation)

	TODO: change this to "depends on IA64 && !IA64_HP_SIM || X86 && ACPI
&& !ACPI_HT_ONLY"
		per CONFIG_ACPI_BOOT below

	+= drivers/acpi/

	CONFIG_ACPI_BOOT
		depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN) || X86 &&
ACPI && !ACPI_HT_ONLY

		TODO: This expression looks wrong IA64_SGI_SN should not be
necessary
		TODO: add parens, b/c it looks like '||' is higher
presidence than '&&'
		It doesn't make sense to have CONFIG_ACPI w/o
CONFIG_ACPI_BOOT
		TODO: delete this option and fold CONFIG_ACPI_BOOT into
CONFIG_ACPI

		:= boot.o
		+= tables.o blacklist.o

		CONFIG_X86_LOCAL_APIC
			acpi_lapic
		CONFIG_X86_IO_APIC
			acpi_ioapic

	CONFIG_ACPI_SLEEP
		depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
		+= main.o
		+= sleep.o wakeup.o

		CONFIG_ACPI_SLEEP_PROC_FS
			depends on ACPI_SLEEP && PROC_FS
			+= proc.o

	CONFIG_ACPI_AC
		depends on X86 && ACPI && !ACPI_HT_ONLY
		+= ac.o

	CONFIG_ACPI_BATTERY
		depends on X86 && ACPI && !ACPI_HT_ONLY
		+= battery.o

	CONFIG_ACPI_BUTTON
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= button.o

	CONFIG_ACPI_FAN
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= fan.o

	CONFIG_ACPI_PROCESSOR
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= processor.o

		CONFIG_ACPI_THERMAL
			depends on ACPI_PROCESSOR
			+= thermal.o

	CONFIG_ACPI_NUMA
		if NUMA && (IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY && !X86_64)
		+= numa.o

	CONFIG_ACPI_ASUS
		depends on X86 && ACPI && !ACPI_HT_ONLY
		+= asus_acpi.o

	CONFIG_ACPI_TOSHIBA
		depends on X86 && ACPI && !ACPI_HT_ONLY
		+= toshiba_acpi.o

	CONFIG_ACPI_DEBUG
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		enables -DACPI_DEBUG_OUTPUT
		+= debug.o

	CONFIG_ACPI_BUS
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= sleep/
			:= poweroff.o
		+= bus.o
		+= scan.o

	CONFIG_ACPI_INTERPRETER
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		osl.o utils.o \
                                   dispatcher/ events/ executer/ hardware/ \
                                   namespace/ parser/ resources/ tables/ \
                                   utilities/

		It doesn't make sense to have ACPI w/o the interpreter
		TODO: fold into CONFIG_ACPI

	CONFIG_ACPI_EC
		depends on X86 && ACPI && !ACPI_HT_ONLY
		+= ec.o

		TODO: possibly fold into CONFIG_ACPI
		? But what about IA64?

	CONFIG_ACPI_POWER
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= power.o

	CONFIG_ACPI_PCI
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= pci_root.o pci_link.o pci_irq.o pci_bind.o

		TODO: depend on CONFIG_PCI (like 2.4 does)

	CONFIG_ACPI_SYSTEM
		depends on IA64 && !IA64_HP_SIM || X86 && ACPI &&
!ACPI_HT_ONLY
		+= system.o event.o

	CONFIG_ACPI_EFI
		depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN)
		used within osl.c
		TODO: depend on CONFIG_ACPI

CONFIG_X86_LOCAL_APIC
	ACPI_HT_ONLY depends on this

CONFIG_X86_IO_APIC
	+= io_apic.o

Boot options:
------------

acpismp=force
	TODO: Delete.
	Used in 2.4 to force acpitable.c to configure HT.
	But it because a no-op when the code was changed
	to call acpitable.c whenever the cpu flags said HT was supported.

noht
	Keep
	TODO: fix
	Disable HT for benefit of systems which perform better with HT
disabled, but
	have a BIOS incapable of disabling HT.
	currently broken in 2.5

acpi=off
	Keep.
	Don't config with ACPI
	Don't load driver/interpreter, enter ACPI mode, or handle events

acpi=cpu
	TODO: port SuSE's "acpi=oldboot" with name change to "acpi=cpu"
	Minimal ACPI table support to allow cpu enumeration for benefit of
HT.

pci=noacpi
	Keep.

