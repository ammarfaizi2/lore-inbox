Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWCMUz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWCMUz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWCMUz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:55:27 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:35602 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932452AbWCMUz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:55:26 -0500
Message-ID: <4415DC3D.4080807@vmware.com>
Date: Mon, 13 Mar 2006 12:55:25 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VMI Interface Proposal Documentation for I386, Part 2.2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, the word propasition (sp) is a banned word for LKML.  Very 
funny ;)  Anyways, here is the rest of the spec.

   Interrupt and I/O Subsystem.

     For security reasons, the guest operating system is not given
     control over the hardware interrupt flag.  We provide a virtual
     interrupt flag that is under guest control.  The virtual operating
     system always runs with hardware interrupts enabled, but hardware
     interrupts are transparent to the guest.  The API provides calls for
     all instructions which modify the interrupt flag.

     The paravirtualization environment provides a legacy programmable
     interrupt controller (PIC) to the virtual machine.  Future releases
     will provide a virtual interrupt controller (VIC) that provides
     more advanced features.

     In addition to a virtual interrupt flag, there is also a virtual
     IOPL field which the guest can use to enable access to port I/O
     from userspace for privileged applications.

     Generic PCI based device probing is available to detect virtual
     devices.  The use of PCI is pragmatic, since it allows a vendor
     ID, class ID, and device ID to identify the appropriate driver
     for each virtual device.

   IDT Management.

     The paravirtual operating environment provides the traditional x86
     interrupt descriptor table for handling external interrupts,
     software interrupts, and exceptions.  The interrupt descriptor table
     provides the destination code selector and EIP for interruptions.
     The current task state structure (TSS) provides the new stack
     address to use for interruptions that result in a privilege level
     change.  The guest OS is responsible for notifying the hypervisor
     when it updates the stack address in the TSS.

     Two types of indirect control flow are of critical importance to the
     performance of an operating system.  These are system calls and page
     faults.  The guest is also responsible for calling out to the
     hypervisor when it updates gates in the IDT.  Making IDT and TSS
     updates known to the hypervisor in this fashion allows efficient
     delivery through these performance critical gates.

   Transparent Paravirtualization.

     The guest operating system may provide an alternative implementation
     of the VMI option rom compiled in.  This implementation should
     provide implementations of the VMI calls that are suitable for
     running on native x86 hardware.  This code may be used by the guest
     operating system while it is being loaded, and may also be used if
     the operating system is loaded on hardware that does not support
     paravirtualization.

     When the guest detects that the VMI option rom is available, it
     replaces the compiled-in version of the rom with the rom provided by
     the platform.  This can be accomplished by copying the rom contents,
     or by remapping the virtual address containing the compiled-in rom
     to point to the platform's ROM.  When booting on a platform that
     does not provide a VMI rom, the operating system can continue to use
     the compiled-in version to run in a non-paravirtualized fashion.

   3rd Party Extensions.

     If desired, it should be possible for 3rd party virtual machine
     monitors to implement a paravirtualization environment that can run
     guests written to this specification.

     The general mechanism for providing customized features and
     capabilities is to provide notification of these feature through
     the CPUID call, and allowing configuration of CPU features
     through RDMSR / WRMSR instructions.  This allows a hypervisor vendor
     ID to be published, and the kernel may enable or disable specific
     features based on this id.  This has the advantage of following
     closely the boot time logic of many operating systems that enables
     certain performance enhancements or bugfixes based on processor
     revision, using exactly the same mechanism.

     An exact formal specification of the new CPUID functions and which
     functions are vendor specific is still needed.

   AP Startup.

     Application Processor startup in paravirtual SMP systems works a bit
     differently than in a traditional x86 system.

     APs will launch directly in paravirtual mode with initial state
     provided by the BSP.  Rather than the traditional init/startup
     IPI sequence, the BSP must issue the init IPI, a set application
     processor state hypercall, followed by the startup IPI.

     The initial state contains the AP's control registers, general
     purpose registers and segment registers, as well as the IDTR,
     GDTR, LDTR and EFER.  Any processor state not included in the initial
     AP state (including x87 FPRs, SSE register states, and MSRs other than
     EFER), are left in the poweron state.

     The BSP must construct the initial GDT used by each AP.  The segment
     register hidden state will be loaded from the GDT specified in the
     initial AP state.  The IDT and (if used) LDT may either be 
constructed by
     the BSP or by the AP.

     Similarly, the initial page tables used by each AP must also be
     constructed by the BSP.

     If an AP's initial state is invalid, or no initial state is provided
     before a start IPI is received by that AP, then the AP will fail to 
start.
     It is therefore advisable to have a timeout for waiting for AP's to 
start,
     as is recommended for traditional x86 systems.

     See VMI_SetInitialAPState in Appendix A for a description of the
     VMI_SetInitialAPState hypercall and the associated APState data 
structure.
 
   State Synchronization In SMP Systems.
     
     Some in-memory data structures that may require no special 
synchronization
     on a traditional x86 systems need special handling when run on a
     hypervisor.  Two of particular note are the descriptor tables and page
     tables.

     Each processor in an SMP system should have its own GDT and LDT.  
Changes
     to each processor's descriptor tables must be made on that processor
     via the appropriate VMI calls.  There is no VMI interface for updating
     another CPU's descriptor tables (aside from VMI_SetInitialAPState),
     and the result of memory writes to other processors' descriptor tables
     are undefined.
     
     Page tables have slightly different semantics than in a traditional x86
     system.  As in traditional x86 systems, page table writes may not be
     respected by the current CPU until a TLB flush or invlpg is issued.
     In a paravirtual system, the hypervisor implementation is free to
     provide either shared or private caches of the guest's page tables.
     Page table updates must therefore be propagated to the other CPUs
     before they are guaranteed to be noticed.
     
     In particular, when doing TLB shootdown, the initiating processor
     must ensure that all deferred page table updates are flushed to the
     hypervisor, to ensure that the receiving processor has the most 
up-to-date
     mapping when it performs its invlpg.

   Local APIC Support.

     A traditional x86 local APIC is provided by the hypervisor.  The local
     APIC is enabled and its address is set via the IA32_APIC_BASE MSR, as
     usual.  APIC registers may be read and written via ordinary memory
     operations.

     For performance reasons, higher performance APIC read and write 
interfaces
     are provided.  If possible, these interfaces should be used to access
     the local APIC.

     The IO-APIC is not included in this spec, as it is typically not
     performance critical, and used mainly for initial wiring of IRQ pins.
     Currently, we implement a fully functional IO-APIC with all the
     capabilities of real hardware.  This may seem like an unnecessary 
burden,
     but if the goal is transparent paravirtualization, the kernel must
     provide fallback support for an IO-APIC anyway.  In addition, the
     hypervisor must support an IO-APIC for SMP non-paravirtualized guests.
     The net result is less code on both sides, and an already well defined
     interface between the two.  This avoids the complexity burden of having
     to support two different interfaces to achieve the same task.

     One shortcut we have found most helpful is to simply disable NMI 
delivery
     to the paravirtualized kernel.  There is no reason NMIs can't be
     supported, but typical uses for them are not as productive in a
     virtualized environment.  Watchdog NMIs are of limited use if the OS is
     already correct and running on stable hardware; profiling NMIs are
     similarly of less use, since this task is accomplished with more 
accuracy
     in the VMM itself; and NMIs for machine check errors should be handled
     outside of the VM.  The addition of NMI support does create additional
     complexity for the trap handling code in the VM, and although the 
task is
     surmountable, the value proposal is debatable.  Here, again, feedback
     is desired.
