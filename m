Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbTLHKog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbTLHKog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:44:36 -0500
Received: from aun.it.uu.se ([130.238.12.36]:58286 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265377AbTLHKoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:44:30 -0500
Date: Mon, 8 Dec 2003 11:44:26 +0100 (MET)
Message-Id: <200312081044.hB8AiQHN009499@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, nemesis-lists@icequake.net
Subject: Re: APIC support on Slot-A Athlon, K6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 02:48:42 -0600, Ryan Underwood wrote:
>2.4.23 kernel on all machines, freshly compiled.
>
>In i386/kernel/apic.c:detect_init_APIC(), we have the following lines:
>switch (boot_cpu_data.x86_vendor) {
>case X86_VENDOR_AMD:
>	if (boot_cpu_data.x86 =3D=3D 6 && boot_cpu_data.x86_model > 1)
>		break;
>	goto no_apic;
>=2E..
>
>Unfortunately, this disables the APIC support (if it existed) on a
>Slot-A Athlon 600 MS-6167 (family 6, model 1, AMD-751/756), and a K6/3 400
>Tyan S1598 (family 5, model 9, MVP3/686A).
>
>What is the purpose of this check?  Why is the APIC availability dependent
>on the CPU, rather than just the southbridge?

This code checks for the ability to enable the local APIC,
which is integrated into the processor. The local APIC is
not implemented in K6 or K7 model 1, so the check is correct.

Furthermore, I/O-APIC usage requires (in hardware) that the
processor has a local APIC.

Ages ago MP 486 and early MP 586 boxes used a discrete (external)
local APIC, but that was changed when the local APIC and the
"APIC bus" were added to the Pentium. In theory you could have
I/O-APIC support with a K6 and a discrete local APIC, but I
doubt any such systems were ever built.

>  Also, there are only
>checks for Intel and AMD CPUs.  Is it not possible to use an APIC in
>conjunction with a Cyrix, et.al. ?

The other manufacturers haven't yet implemented local APIC
functionality in their processors.

>On to another topic, I would also like to know if anyone has used a
>Shuttle HOT-591P successfully in ACPI mode.  It passes the date check as
>the BIOS is (dmidecode):
>Vendor: Award Software International, Inc.
>Version: 4.51 PG
>Release Date: 03/27/01
>
>board:
>Manufacturer: Shuttle Inc.
>Product Name: VIA APOLLO MVP3 (HOT-597)
>Version: 2A5LEH2B
>(It is actually a 591P, regardless of the DMI string)
>
>However, the kernel does the following on bootup:
>
>ACPI: Subsystem revision 20031002
>PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3D1
>PCI: Using configuration type 1
> tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
>Parsing all Control Methods:...............................................=
>=2E.......
>Table [DSDT](id F004) - 227 Objects with 26 Devices 55 Methods 17 Regions
>ACPI Namespace successfully loaded at root c02dba3c
>ACPI: IRQ9 SCI: Level Trigger.
>evxfevnt-0089: *** Error: Could not transition to ACPI mode.
> utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
>ACPI: Unable to start the ACPI Interpreter
>evxfevnt-0127 [06] acpi_disable          : System is already in legacy (non=
>-ACPI) mode
> utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
>PCI: Probing PCI hardware
>PCI: ACPI tables contain no PCI IRQ routing entries
>=2E..
>
>At the "ACPI: IRQ9 SCI:" part, it pauses for a few seconds before continuin=
>g.

You need to bring that to the ACPI list.

>The APIC is also not enabled on this machine, but it is a 586B southbridge,=
> which
>I am not sure contains an APIC.

What processor? As I wrote above, I/O-APIC can't be used unless
the processor has a local APIC.
Some BIOSen have an option for enabling/disabling I/O-APIC mode.
Some BIOSen skip the "legacy" MP tables and only announce the
I/O-APIC config data via ACPI, so working ACPI may be required.
