Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWCMUHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWCMUHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWCMUHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:07:39 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17933 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751861AbWCMUHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:07:38 -0500
Message-ID: <4415D109.1010703@vmware.com>
Date: Mon, 13 Mar 2006 12:07:37 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VMI Interface Proposal Documentation for I386, Part 2.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2) Overview

   Initialization.

     Initialization is done with a bootstrap loader that creates
     the "start of day" state.  This is a known state, running 32-bit
     protected mode code with paging enabled.  The guest has all the
     standard structures in memory that are provided by a native ROM
     boot environment, including a memory map and ACPI tables.  For
     the native hardware, this bootstrap loader can be run before
     the kernel code proper, and this environment can be created
     readily from within the hypervisor for the virtual case.  At
     some point, the bootstrap loader or the kernel itself invokes
     the initialization call to enter paravirtualized mode.

   Privilege Model.

     The guest kernel must be modified to run at a dynamic privilege
     level, since if entry to paravirtual mode is successful, the kernel
     is no longer allowed to run at the highest hardware privilege level.
     On the IA-32 architecture, this means the kernel will be running at
     CPL 1-2, and with the hypervisor running at CPL0, and user code at
     CPL3.  The IOPL will be lowered as well to avoid giving the guest
     direct access to hardware ports and control of the interrupt flag.

     This change causes certain IA-32 instructions to become "sensitive",
     so additional support for clearing and setting the hardware
     interrupt flag are present.  Since the switch into paravirtual mode
     may happen dynamically, the guest OS must not rely on testing for a
     specific privilege level by checking the RPL field of segment
     selectors, but should check for privileged execution by performing
     an (RPL != 3 && !EFLAGS_VM) comparison.  This means the DPL of kernel
     ring descriptors in the GDT or LDT may be raised to match the CPL of
     the kernel.  This change is visible by inspecting the segments
     registers while running in privileged code, and by using the LAR
     instruction.

     The system also cannot be allowed to write directly to the hardware
     GDT, LDT, IDT, or TSS, so these data structures are maintained by the
     hypervisor, and may be shadowed or guest visible structures.  These
     structures are required to be page aligned to support non-shadowed
     operation.

     Currently, the system only provides for two guest security domains,
     kernel (which runs at the equivalent of virtual CPL-0), and user
     (which runs at the equivalent of virtual CPL-3, with no hardware
     access).  Typically, this is not a problem, but if a guest OS relies
     on using multiple hardware rings for privilege isolation, this
     interface would need to be expanded to support that.

   Memory Management.

     Since a virtual machine typically does not have access to all the
     physical memory on the machine, there is a need to redefine the
     physical address space layout for the virtual machine.  The
     spectrum of possibilities ranges from presenting the guest with
     a view of a physically contiguous memory of a boot-time determined
     size, exactly what the guest would see when running on hardware, to
     the opposite, which presents the guest with the actual machine pages
     which the hypervisor has allocated for it.  Using this approach
     requires the guest to obtain information about the pages it has
     from the hypervisor; this can be done by using the memory map which
     would normally be passed to the guest by the BIOS.

     The interface is designed to support either mode of operation.
     This allows the implementation to use either direct page tables
     or shadow page tables, or some combination of both.  All writes to
     page table entries are done through calls to the hypervisor
     interface layer.  The guest notifies the hypervisor about page
     tables updates, flushes, and invalidations through API calls.

     The guest OS is also responsible for notifying the hypervisor about
     which pages in its physical memory are going to be used to hold page
     tables or page directories.  Both PAE and non-PAE paging modes are
     supported.  When the guest is finished using pages as page tables, it
     should release them promptly to allow the hypervisor to free the
     page table shadows.  Using a page as both a page table and a page
     directory for linear page table access is possible, but currently
     not supported by our implementation.

     The hypervisor lives concurrently in the same address space as the
     guest operating system.  Although this is not strictly necessary on
     IA-32 hardware, performance would be severely degraded if that were
     not the case.  The hypervisor must therefore reserve some portion of
     linear address space for its own use. The implementation currently
     reserves the top 64 megabytes of linear space for the hypervisor.
     This requires the guest to relocate any data in high linear space
     down by 64 megabytes.  For non-paging mode guests, this means the
     high 64 megabytes of physical memory should be reserved.  Because
     page tables are not sensitive to CPL, only to user/supervisor level,
     the hypervisor must combine segment protection to ensure that the
     guest can not access this 64 megabyte region.

     An experimental patch is available to enable boot-time sizing of
     the hypervisor hole.

   Segmentation.

     The IA-32 architecture provides segmented virtual memory, which can
     be used as another form of privilege separation.  Each segment
     contains a base, limit, and properties.  The base is added to the
     virtual address to form a linear address.  The limit determines the
     length of linear space which is addressable through the segment.
     The properties determine read/write, code and data size of the
     region, as well as the direction in which segments grow.  Segments
     are loaded from descriptors in one of two system tables, the GDT or
     the LDT, and the values loaded are cached until the next load of the
     segment.  This property, known as segment caching, allows the
     machine to be put into a non-reversible state by writing over the
     descriptor table entry from which a segment was loaded.  There is no
     efficient way to extract the base field of the segment after it is
     loaded, as it is hidden by the processor.  In a hypervisor
     environment, the guest OS can be interrupted at any point in time by
     interrupts and NMIs which must be serviced by the hypervisor.  The
     hypervisor must be able to recreate the original guest state when it
     is done servicing the external event.

     To avoid creating non-reversible segments, the hypervisor will
     forcibly reload any live segment registers that are updated by
     writes to the descriptor tables.  *N.B - in the event that a segment
     is put into an invalid or not present state by an update to the
     descriptor table, the segment register must be forced to NULL so
     that reloading it will not cause a general protection fault (#GP)
     when restoring the guest state.  This may require the guest to save
     the segment register value before issuing a hypervisor API call
     which will update the descriptor table.*

     Because the hypervisor must protect its own memory space from
     privileged code running in the guest at CPL1-2, descriptors may not
     provide access to the 64 megabyte region of high linear space.  To
     achieve this, the hypervisor will truncate descriptors in the
     descriptor tables.  This means that attempts by the guest to access
     through negative offsets to the segment base will fault, so this is
     highly discouraged (some TLS implementations on Linux do this).
     In addition, this causes the truncated length of the segment to
     become visible to the guest through the LSL instruction.

