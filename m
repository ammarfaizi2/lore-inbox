Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTBYDrF>; Mon, 24 Feb 2003 22:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbTBYDrF>; Mon, 24 Feb 2003 22:47:05 -0500
Received: from fmr01.intel.com ([192.55.52.18]:59870 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267613AbTBYDrA>;
	Mon, 24 Feb 2003 22:47:00 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A8471380C1@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, jgarzik@redhat.com
Subject: smpenum rewrite, phase 2
Date: Mon, 24 Feb 2003 19:57:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phase 2 of the smpenum rewrite is available at:
ftp://ftp.kernel.org/pub/linux/kernel/people/grover/ .

smp-20030224-2.5.63.diff.gz - the patch
smp-20030224-2.5.63-broken-out.tar.gz - individual cset diffs

The goal of smpenum is to replace the current SMP enumeration code's
heavy use of MPS-specific data structures with smaller, generic
structures. Then, MPS and ACPI can be modularized into
"SMP-enumerators", which report found resources (CPUs, IOAPICs, etc.)
through clean interfaces.

This phase consolidates MPS and ACPI I/O APIC enumeration through a
common interface, like the previous phase consolidated CPU enumeration.
IOAPIC ID assignation for each now uses the same code path, and is more
conformant to the MPS specification. In addition, we can now cleanly
fall back to MPS, if the ACPI APIC table is bad.

It also fixes the previous patch's build issues with various x86 subarch
and other config options.

If you have an SMP box, especially one with multiple IOAPICs, test
reports would be appreciated. This patch should have no visible effects,
yet -- things should just keep working like they always have.

diffstat and changelogs below.

Regards -- Andy

 arch/i386/Kconfig                            |   14 
 arch/i386/kernel/Makefile                    |   16 
 arch/i386/kernel/acpi.c                      |   55 +
 arch/i386/kernel/acpi/boot.c                 |   12 
 arch/i386/kernel/apic.c                      |   29 
 arch/i386/kernel/io_apic.c                   |  259 +++-----
 arch/i386/kernel/mpparse.c                   |  462 +++++----------
 arch/i386/kernel/setup.c                     |   42 -
 arch/i386/kernel/smpboot.c                   |    8 
 arch/i386/kernel/smpenum.c                   |  209 +++++-
 arch/i386/kernel/time.c                      |    1 
 arch/i386/kernel/timers/timer_pit.c          |    2 
 arch/i386/mach-visws/mpparse.c               |   95 ---
 arch/i386/mm/discontig.c                     |    2 
 drivers/acpi/Kconfig                         |    1 
 drivers/acpi/bus.c                           |    1 
 drivers/acpi/pci_irq.c                       |    3 
 include/asm-i386/acpi.h                      |    9 
 include/asm-i386/io_apic.h                   |   10 
 include/asm-i386/mach-bigsmp/mach_apic.h     |   13 
 include/asm-i386/mach-default/mach_apic.h    |   15 
 include/asm-i386/mach-default/mach_mpparse.h |    8 
 include/asm-i386/mach-numaq/mach_apic.h      |   13 
 include/asm-i386/mach-numaq/mach_mpparse.h   |   12 
 include/asm-i386/mach-summit/mach_apic.h     |   14 
 include/asm-i386/mach-summit/mach_mpparse.h  |    8 
 include/asm-i386/mach-visws/mach_apic.h      |    8 
 include/asm-i386/mpspec.h                    |   43 -
 include/asm-i386/smp.h                       |    3 
 include/asm-i386/smpenum.h                   |  329 +++++++---
 30 files changed, 855 insertions(+), 841 deletions(-)

ChangeSets:

<agrover@groveronline.com> (03/02/24 1.990.9.6)
   [smpenum] fix a lot of compilation issues when compiling for the
various
   x86 subarches

<agrover@groveronline.com> (03/02/21 1.990.9.5)
   [snmpenum] Hmm, maybe we want a CONFIG_X86_MPPARSE after all

<agrover@groveronline.com> (03/02/20 1.990.9.4)
   [smpenum] fix for UP compile

<agrover@groveronline.com> (03/02/19 1.990.9.3)
   Cset exclude: agrover@groveronline.com|ChangeSet|20030125011210|06056

<agrover@groveronline.com> (03/02/19 1.990.9.2)

<agrover@groveronline.com> (03/01/25 1.914.65.12)
   [smpenum] Add some dprintks so we know when bad stuff happens

<agrover@groveronline.com> (03/01/24 1.914.65.11)
   [smpenum] change mpc_apic_id to take individual params instead of a
struct ptr

<agrover@groveronline.com> (03/01/24 1.914.65.10)
   [smpenum] This cset starts the modularization of SMP enumerators. MPS
and ACPI
   now use a registration function with smpenum (only 1 function ptr
passed so
   far) but the groundwork is there for better isolation of variables
and
   data structures.
   
   This also implements MPS fallback. If ACPI cannot parse any of the
tables,
   it resets any variables it might have set, and lets MPS be used.
   
   Finally, since smp_processor_register only takes 2 params, we just
pass them,
   instead of passing a struct with them as members.

<agrover@groveronline.com> (03/01/24 1.914.65.9)
   [smpenum] Previously, I changed all instances of smp_found_config to
   mps_found_config. Now, I have re-added smp_found_config. It means
   (acpi_found_config || mps_found_config).

<agrover@groveronline.com> (03/01/24 1.914.65.8)
   [smpenum] No reason for CONFIG_X86_MPPARSE option - remove it

<agrover@groveronline.com> (03/01/23 1.914.65.7)
   [smpenum] Get things compiling again for all variations of UP with or
without
   LAPIC and IOAPIC

<agrover@groveronline.com> (03/01/23 1.914.65.6)
   [smpenum] Unify IOAPIC code through added smp_ioapic_register
function
   
   This patch renames setup_io_apic_ids_from_mpc to setup_io_apic_ids.
It makes
   ACPI use this function, and also changes the apicid discovery
algorithm to
   precisely match what the MPS spec says (most notably, if the apicid
already
   has a value programmed, use that over what the BIOS says)
   
   We save space and make the code simpler by only having the fields we
need in
   the kernel data structures, instead of using the entire MPS-defined
one.

<agrover@groveronline.com> (03/01/22 1.914.65.5)
   [smpenum] Rename APIC_BROADCAST_ID to APIC_MAX_ID, since that's what
it
   really is.

<agrover@groveronline.com> (03/01/21 1.914.65.4)
   [smpenum] Make MP bus enumeration use a non-MPS interface called
   smp_bus_register.

<agrover@groveronline.com> (03/01/21 1.914.65.3)
   [smpenum] Add smpenum.c
   
   struct/variable/function renames (mainly mpc_record -> mps_record)
   Remove MP_processor_info, and change code to call
smp_processor_register
   instead.
   
   Move non-MPS variables to smpenum.c
   
   No real reason to call find_smp_config from setup_memory - move it
   to setup_arch, which is where the ACPI equivalent function is called
   from.

<agrover@groveronline.com> (03/01/21 1.914.65.2)
   [smpenum] struct mpc_config_processor no longer includes
mpc_cpufeature
   member, so remove printks that reference that.

<agrover@groveronline.com> (03/01/21 1.914.65.1)
   [smpenum] rename structs and variables


Regards -- Andy
