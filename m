Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWCPBLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCPBLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWCPBLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:11:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38787 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751375AbWCPBLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:11:48 -0500
Date: Wed, 15 Mar 2006 17:16:01 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Message-ID: <20060316011601.GF15997@sorel.sous-sol.org>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <20060313224902.GD12807@sorel.sous-sol.org> <4416078C.4030705@vmware.com> <20060314212742.GL12807@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314212742.GL12807@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> Yes, I completely agree.  Without specific performance numbers it's just
> hand waving.  To make it more concrete, I'll work on a compare/contrast
> of the interfaces so we have specifics to discuss.


Here's a comparison of API's.  In some cases there's trivial 1-to-1
mappings, and in other cases there's really no mapping.  The mapping is
(loosely) annotated below the interface as [ VMI_foo(*) ].  The trailing
asterisk is meant to note the API maps at high-level, but the details
may make the mapping difficult (details such as VA vs. MFN, for example).
Thanks to Christian for doing the bulk of this comparison.

PROCESSOR STATE CALLS

- shared_info->vcpu_info[]->evtchn_upcall_mask

Enable/Disable interrupts and query whether interrupts are enabled or
disabled.

[ VMI_DisableInterrupts, VMI_EnabledInterrupts, VMI_GetInterruptMask,
VMI_SetInterruptMask ]


- shared_info->vcpu_info[]->evtchn_upcall_pending

Query if an interrupt is pending

[ ]

- force_evtchn_callback = HYPERVISOR_xen_version(0, NULL)

Deliver pending interrupts.

[ VMI_DeliverInterrupts ]

(EVENT CHANNEL, virtual interrupts)
- HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound, ...)

Allocate a port in domain <dom> and mark as accepting interdomain
bindings from domain <remote_dom>. A fresh port is allocated in <dom>
and returned as <port>.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_bind_interdomain, ...)

Construct an interdomain event channel between the calling domain and
<remote_dom>. <remote_dom,remote_port> must identify a port that is
unbound and marked as accepting bindings from the calling domain. A fresh
port is allocated in the calling domain and returned as <local_port>.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq, ...)

Bind a local event channel to VIRQ <irq> on specified vcpu.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_bind_pirq, ...)

Bind a local event channel to PIRQ <irq>.

[ PIC programming* ]

- HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi, ...)

Bind a local event channel to receive events.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_close, ...)

Close a local event channel <port>. If the channel is interdomain then
the remote end is placed in the unbound state (EVTCHNSTAT_unbound),
awaiting a new connection.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_send, ...)

Send an event to the remote end of the channel whose local endpoint is <port>.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_status, ...)

Get the current status of the communication channel which has an endpoint
at <dom, port>.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, ...)

Specify which vcpu a channel should notify when an event is pending.

[ ]

- HYPERVISOR_event_channel_op(EVTCHNOP_unmask, ...)

Unmask the specified local event-channel port and deliver a notification
to the appropriate VCPU if an event is pending.

[ ]

- HYPERVISOR_sched_op(SCHEDOP_yield, ...)

Voluntarily yield the CPU.

[ VMI_Pause ]


- HYPERVISOR_sched_op(SCHEDOP_block, ...)

Block execution of this VCPU until an event is received for processing.
If called with event upcalls masked, this operation will atomically
reenable event delivery and check for pending events before blocking the
VCPU. This avoids a "wakeup waiting" race.

Periodic timer interrupts are not delivered when guest is blocked,
except for explicit timer events setup with HYPERVISOR_set_timer_op.

[ VMI_Halt ]


- HYPERVISOR_sched_op(SCHEDOP_shutdown, ...)

Halt execution of this domain (all VCPUs) and notify the system controller.

[ VMI_Shutdown, VMI_Reboot ]

- HYPERVISOR_sched_op(SCHEDOP_shutdown, SHUTDOWN_suspend, ...)

Clean up, save suspend info, kill

[ ]

- HYPERVISOR_sched_op_new(SCHEDOP_poll, ...)

Poll a set of event-channel ports. Return when one or more are pending. An
optional timeout may be specified.

[ ]


- HYPERVISOR_vcpu_op(VCPUOP_initialise, ...)

Initialise a VCPU. Each VCPU can be initialised only once. A 
newly-initialised VCPU will not run until it is brought up by VCPUOP_up.

[ VMI_SetInitialAPState ]


- HYPERVISOR_vcpu_op(VCPUOP_up, ...)

Bring up a VCPU. This makes the VCPU runnable. This operation will fail
if the VCPU has not been initialised (VCPUOP_initialise).

[ ]


- HYPERVISOR_vcpu_op(VCPUOP_down, ...)

Bring down a VCPU (i.e., make it non-runnable).
There are a few caveats that callers should observe:
 1. This operation may return, and VCPU_is_up may return false, before the
    VCPU stops running (i.e., the command is asynchronous). It is a good
    idea to ensure that the VCPU has entered a non-critical loop before
    bringing it down. Alternatively, this operation is guaranteed
    synchronous if invoked by the VCPU itself.
 2. After a VCPU is initialised, there is currently no way to drop all its
    references to domain memory. Even a VCPU that is down still holds
    memory references via its pagetable base pointer and GDT. It is good
    practise to move a VCPU onto an 'idle' or default page table, LDT and
    GDT before bringing it down.

[ ]

- HYPERVISOR_vcpu_op(VCPUOP_is_up, ...)

Returns 1 if the given VCPU is up.

[ ]

- HYPERVISOR_vcpu_op(VCPUOP_get_runstate_info, ...)

Return information about the state and running time of a VCPU.

[ ]

- HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area, ...)

Register a shared memory area from which the guest may obtain its own
runstate information without needing to execute a hypercall.
Notes:
 1. The registered address may be virtual or physical, depending on the
    platform. The virtual address should be registered on x86 systems.
 2. Only one shared area may be registered per VCPU. The shared area is
    updated by the hypervisor each time the VCPU is scheduled. Thus
    runstate.state will always be RUNSTATE_running and
    runstate.state_entry_time will indicate the system time at which the
    VCPU was last scheduled to run.

[ ]


DESCRIPTOR RELATED CALLS

- HYPERVISOR_set_gdt(unsigned long *frame_list, int entries)

Load the global descriptor table.

For non-shadow-translate mode guests, the frame_list is a list of
machine pages which contain the gdt.

[ VMI_SetGDT* ]


- HYPERVISOR_set_trap_table(struct trap_info *table)

Load the interrupt descriptor table.

The trap table is in a format which allows easier access from C code.
It's easier to build and easier to use in software trap despatch code.
It can easily be converted into a hardware interrupt descriptor table.

[ VMI_SetIDT, VMI_WriteIDTEntry ]


- HYPERVISOR_mmuext_op(MMUEXT_SET_LDT, ...)

Load local descriptor table.
linear_addr: Linear address of LDT base (NB. must be page-aligned).
nr_ents: Number of entries in LDT.

[ VMI_SetLDT* ]

- HYPERVISOR_update_descriptor(u64 pa, u64 desc)

Write a descriptor to a GDT or LDT.

For non-shadow-translate mode guests, the address is a machine address.

[ VMI_WriteGDTEntry*, VMI_WriteLDTEntry* ]



CPU CONTROL CALLS

- HYPERVISOR_mmuext_op(MMUEXT_NEW_BASEPTR, ...)

Write cr3 register.

[ VMI_SetCR3* ]

- shared_info->vcpu_info[]->arch->cr2

Read cr2 register.

[ VMI_GetCR2 ]

- HYPERVISOR_fpu_taskswitch(0)

Clear the taskswitch flag in control register 0.

[ VMI_CLTS ]

- HYPERVISOR_fpu_taskswitch(1)

Set the taskswitch flag in control register 0.

[ VMI_SetCR0* ]

- HYPERVISOR_set_debugreg(int reg, unsigned long value)

Write debug register.

[ VMI_SetDR ]

- HYPERVISOR_get_debugreg(int reg)

Read debug register.

[ VMI_GetDR ]



PROCESSOR INFORMATION CALLS



STACK / PRIVILEGE TRANSITION CALLS

- HYPERVISOR_stack_switch(unsigned long ss, unsigned long esp)

Set the ring1 stack pointer/segment to use when switching to ring1
from ring3.

[ VMI_UpdateKernelStack ]


- HYPERVISOR_iret

[ VMI_IRET ]


I/O CALLS

- HYPERVISOR_physdev_op(PHYSDEVOP_SET_IOPL, ...)

Set the IOPL mask.

[ VMI_SetIOPLMask ]

- HYPERVISOR_mmuext_op(MMUEXT_FLUSH_CACHE)

No additional arguments. Writes back and flushes cache contents.
(Can just trap and emulate here).

[ VMI_WBINVD ]

- HYPERVISOR_physdev_op(PHYSDEVOP_IRQ_UNMASK_NOTIFY, ...)

Advertise unmask of physical interrupt to hypervisor.

[ ]

- HYPERVISOR_physdev_op(PHYSDEVOP_IRQ_STATUS_QUERY,...)

Query if physical interrupt needs unmaks notify.

[ ]

- HYPERVISOR_physdev_op(PHYSDEVOP_SET_IOBITMAP, ...)

Set IO bitmap for guest.

[ ]

- HYPERVISOR_physdev_op(PHYSDEVOP_APIC_READ, ...)

Read IO-APIC register.

[ ]

- HYPERVISOR_physdev_op(PHYSDEVOP_APIC_WRITE, ...)

Write IO-APIC register.

[ ]

- HYPERVISOR_physdev_op(PHYSDEVOP_ASSIGN_VECTOR, ...)

Assign vector to interrupt.

[ ]


APIC CALLS



TIMER CALLS

- HYPERVISOR_set_timer_op(...)

Set timeout when to trigger timer interrupt even if guest is blocked.

MMU CALLS

- HYPERVISOR_mmuext_op(MMUEXT_(UN)PIN_*_TABLE

mfn: Machine frame number to be (un)pinned as a p.t. page.

[ RegisterPageType* ]

- HYPERVISOR_mmuext_op(MMUEXT_TLB_FLUSH_LOCAL)

No additional arguments. Flushes local TLB.

[ VMI_FlushTLB ]

- HYPERVISOR_mmuext_op(MMUEXT_INVLPG_LOCAL)

linear_addr: Linear address to be flushed from the local TLB.

[ VMI_InvalPage ]

- HYPERVISOR_mmuext_op(MMUEXT_TLB_FLUSH_MULTI)

vcpumask: Pointer to bitmap of VCPUs to be flushed.

- HYPERVISOR_mmuext_op(MMUEXT_INVLPG_MULTI)

linear_addr: Linear address to be flushed.
vcpumask: Pointer to bitmap of VCPUs to be flushed.

- HYPERVISOR_mmuext_op(MMUEXT_TLB_FLUSH_ALL)

No additional arguments. Flushes all VCPUs' TLBs.

- HYPERVISOR_mmuext_op(MMUEXT_INVLPG_ALL)

linear_addr: Linear address to be flushed from all VCPUs' TLBs.

- HYPERVISOR_update_va_mapping(...)

Update pagetable entry mapping a given virtual address.
Avoids having to map the pagetable page in the hypervisor by using
a linear pagetable mapping.  Also flush the TLB if requested.

[ ]

- HYPERVISOR_mmu_update(MMU_NORMAL_PT_UPDATE, ...)

Update an entry in a page table.

[ VMI_SetPte* ]

- HYPERVISOR_mmu_update(MMU_MACHPHYS_UPDATE, ...)

Update machine -> phys table entry.

[ no machine -> phys in VMI ]

MEMORY

- HYPERVISOR_memory_op(XENMEM_increase_reservation, ...)

Increase number of frames

[ ]

- HYPERVISOR_memory_op(XENMEM_decrease_reservation, ...)

Drop frames from reservation

[ ]

- HYPERVISOR_memory_op(XENMEM_populate_physmap, ...)

[ ]

- HYPERVISOR_memory_op(XENMEM_maximum_ram_page, ...)

Get maximum MFN of mapped RAM in domain

[ ]

- HYPERVISOR_memory_op(XENMEM_current_reservation, ...)

Get current memory reservation (in pags) of domain

[ ]

- HYPERVISOR_memory_op(XENMEM_maximum_reservation, ...)

Get maximum memory reservation (in pags) of domain

[ ]

MISC

- HYPERVISOR_console_io()

read/write to console (privileged)

- HYPERVISOR_xen_version(XENVER_version, NULL)

Return major:minor (16:16).

- HYPERVISOR_xen_version(XENVER_extraversion)

Return extra version (-unstable, .subminor)

- HYPERVISOR_xen_version(XENVER_compile_info)

Return hypervisor compile information.

- HYPERVISOR_xen_version(XENVER_capabilities)

Return list of supported guest interfaces.

- HYPERVISOR_xen_version(XENVER_platform_parameters)

Return information about the platform.

- HYPERVISOR_xen_version(XENVER_get_features)

Return feature maps.


- HYPERVISOR_set_callbacks

Set entry points for upcalls to the guest from the hypervisor.
Used for event delivery and fatal condition notification.


- HYPERVISOR_vm_assist(VMASST_TYPE_4gb_segments)

Enable emulation of wrap around segments.

- HYPERVISOR_vm_assist(VMASST_TYPE_4gb_segments_notify)

Enable notification on wrap around segment event.

- HYPERVISOR_vm_assist(VMASST_TYPE_writable_pagetables)

Enable writable pagetables.


- HYPERVISOR_nmi_op(XENNMI_register_callback)

Register NMI callback for this (calling) VCPU. Currently this only makes
sense for domain 0, vcpu 0. All other callers will be returned EINVAL.

- HYPERVISOR_nmi_op(XENNMI_unregister_callback)

Deregister NMI callback for this (calling) VCPU.


- HYPERVISOR_multicall

Execute batch of hypercalls.

[VMI_SetDeferredMode*, VMI_FlushDeferredCalls*]

There are some more management specific operations for dom0 and security
that are arguably beyond the scope of this comparison.
