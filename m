Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWCPDkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWCPDkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWCPDkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:40:25 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47373 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932602AbWCPDkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:40:24 -0500
Message-ID: <4418DE27.2060804@vmware.com>
Date: Wed, 15 Mar 2006 19:40:23 -0800
From: Eli Collins <ecollins@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Christopher Li <chrisl@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anne Holler <anne@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Jyothy Reddy <jreddy@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com>	<20060313224902.GD12807@sorel.sous-sol.org>	<4416078C.4030705@vmware.com>	<20060314212742.GL12807@sorel.sous-sol.org> <20060316011601.GF15997@sorel.sous-sol.org>
In-Reply-To: <20060316011601.GF15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Mar 2006 03:40:23.0193 (UTC) FILETIME=[5B1DE090:01C648AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Chris Wright (chrisw@sous-sol.org) wrote:

<snip>

> - HYPERVISOR_event_channel_op(EVTCHNOP_send, ...)
> 
> Send an event to the remote end of the channel whose local endpoint is <port>.
> 
> [ ]

VMI_APICWrite is used to send IPIs. In general all the event channel 
calls (modulo referencing other guests) are not needed when using a 
virtual APIC. Using calls rather than a struct shared between the 
hypervisor and the guest is a cleaner interface (no messy changes to 
entry.S) and easier to maintain and version. This is true of 
shared_info_t in general, not just the event channel.

> 
> - HYPERVISOR_vcpu_op(VCPUOP_get_runstate_info, ...)
> 
> Return information about the state and running time of a VCPU.
> 
> [ ]

See the VMI timer interface. Note that the runstate interface above was 
added recently after Dan Hecht pointed out the need for properly 
paravirtualizing time (reporting stolen time correctly), the Xen 3.0.0/1 
interfaces do not include runstate info.

http://lists.xensource.com/archives/html/xen-devel/2006-02/msg00836.html

It's too bad that Xen's vcpu_time_info_t presents the guest with the 
variables used to calculate time rather than time itself; requiring that 
the guest calculate time complicates the Linux patches and constrains 
future changes to time calculation in the hypervisor.

> - HYPERVISOR_set_trap_table(struct trap_info *table)
> 
> Load the interrupt descriptor table.
> 
> The trap table is in a format which allows easier access from C code.
> It's easier to build and easier to use in software trap despatch code.
> It can easily be converted into a hardware interrupt descriptor table.
> 
> [ VMI_SetIDT, VMI_WriteIDTEntry ]

Passing in trap_info structs (like much of the Xen interface) requires 
copying to/from the guest when it's not necessary. To handle VT/Pacifica 
Xen needs to understand the hardware table format anyway, so it's 
simpler to just use the hardware format.

> - HYPERVISOR_set_timer_op(...)
> 
> Set timeout when to trigger timer interrupt even if guest is blocked.

See VMI_SetAlarm and VMI_CancelAlarm.

> - HYPERVISOR_memory_op(XENMEM_increase_reservation, ...)
> 
> Increase number of frames
> 
> [ ]
> 
> - HYPERVISOR_memory_op(XENMEM_decrease_reservation, ...)
> 
> Drop frames from reservation
> 
> [ ]

Ballooning for VMI guests is currently handled by a driver which uses a 
special port in the virtual IO space.

The Xen increase reservation interface would be nicer if it took the 
pfns that the guest gave up as an argument (better for this logic to be 
in the balloon driver than the hypervisor). Relying on the hypervisor's 
allocator to get contiguous pages is also gross. From what I can tell 
extent_order is always 0 in XenLinux, an interface that just took a list 
of pages would be simpler.

> - HYPERVISOR_xen_version(XENVER_compile_info)
> 
> Return hypervisor compile information.

This kind of information seems gratuitous.

> - HYPERVISOR_set_callbacks
> 
> Set entry points for upcalls to the guest from the hypervisor.
> Used for event delivery and fatal condition notification.

In the VMI "events" are just interrupts, delivered via the virtual IDT.

> - HYPERVISOR_nmi_op(XENNMI_register_callback)
> 
> Register NMI callback for this (calling) VCPU. Currently this only makes
> sense for domain 0, vcpu 0. All other callers will be returned EINVAL.

Like the event callback, this could be integrated into the virtual IDT.
