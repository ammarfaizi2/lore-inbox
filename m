Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbWCVVA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbWCVVA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWCVU7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:6578 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932726AbWCVU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:02 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Date: Wed, 22 Mar 2006 21:05:56 +0100
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com>
In-Reply-To: <200603131759.k2DHxeep005627@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603222105.58912.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 18:59, Zachary Amsden wrote:

> +     The general mechanism for providing customized features and
> +     capabilities is to provide notification of these feature through
> +     the CPUID call, 

How should that work since CPUID cannot be intercepted by 
a Hypervisor (without VMX/SVM)?  

> + Watchdog NMIs are of limited use if the OS is
> +     already correct and running on stable hardware;

So how would your Hypervisor detect a kernel hung with interrupts
off then?

>>       profiling NMIs are 
> +     similarly of less use, since this task is accomplished with more accuracy
> +     in the VMM itself

And how does oprofile know about this?

> ; and NMIs for machine check errors should be handled 
> +     outside of the VM.  

Right now yes, but if we ever implement intelligent memory ECC error handling it's questionable
the hypervisor can do a better job. It has far less information about how memory
is used than the kernel.

> +   The net result of these choices is that most of the calls are very
> +   easy to make from C-code, and calls that are likely to be required in
> +   low level trap handling code are easy to call from assembler.   Most
> +   of these calls are also very easily implemented by the hypervisor
> +   vendor in C code, and only the performance critical calls from
> +   assembler paths require custom assembly implementations.
> +
> +   CORE INTERFACE CALLS

Did I miss it or do you never describe how to find these entry points? 

> +    VMI_EnableInterrupts
> +
> +       VMICALL void VMI_EnableInterrupts(void);
> +
> +       Enable maskable interrupts on the processor.  Note that the
> +       current implementation always will deliver any pending interrupts
> +       on a call which enables interrupts, for compatibility with kernel
> +       code which expects this behavior.  Whether this should be required
> +       is open for debate.

A subtle trap is also that it will do so on the next instruction, not the 
followon to next like a real x86.  At some point there was code in Linux
that dependend on this.


> +       VMICALL VMI_UINT64 VMI_RDMSR(VMI_UINT64 dummy, VMI_UINT32 reg);
> +
> +       Read from a model specific register.  This functions identically to the
> +       hardware RDMSR instruction.  Note that a hypervisor may not implement
> +       the full set of MSRs supported by native hardware, since many of them
> +       are not useful in the context of a virtual machine.

So what happens when the kernel tries to access an unimplemented MSR?

Also we have had occasionally workarounds in the past that required 
MSR writes with magic "passwords". How would these be handled?
+
> +    VMI_CPUID
> +
> +       /* Not expressible as a C function */
> +
> +       The CPUID instruction provides processor feature identification in a
> +       vendor specific manner.  The instruction itself is non-virtualizable
> +       without hardware support, requiring a hypervisor assisted CPUID call
> +       that emulates the effect of the native instruction, while masking any
> +       unsupported CPU feature bits.

Doesn't seem to be very useful because everybody can just call CPUID directly.

> +       The RDTSC instruction provides a cycles counter which may be made
> +       visible to userspace.  For better or worse, many applications have made
> +       use of this feature to implement userspace timers, database indices, or
> +       for micro-benchmarking of performance.  This instruction is extremely
> +       problematic for virtualization, because even though it is selectively 
> +       virtualizable using trap and emulate, it is much more expensive to
> +       virtualize it in this fashion.  On the other hand, if this instruction
> +       is allowed to execute without trapping, the cycle counter provided
> +       could be wrong in any number of circumstances due to hardware drift,
> +       migration, suspend/resume, CPU hotplug, and other unforeseen
> +       consequences of running inside of a virtual machine.  There is no
> +       standard specification for how this instruction operates when issued
> +       from userspace programs, but the VMI call here provides a proper
> +       interface for the kernel to read this cycle counter.

Yes, but it will be wrong in a native kernel too so why do you want
to be better than native? 

Seems useless to me.

> +    VMI_RDPMC
> +
> +       VMICALL VMI_UINT64 VMI_RDPMC(VMI_UINT64 dummy, VMI_UINT32 counter);
> +
> +       Similar to RDTSC, this call provides the functionality of reading
> +       processor performance counters.  It also is selectively visible to
> +       userspace, and maintaining accurate data for the performance counters
> +       is an extremely difficult task due to the side effects introduced by
> +       the hypervisor.

Similar.

Overall feeling is you have far too many calls. You seem to try to implement
a full x86 replacement, but that makes it big and likely to be buggy. And 
it's likely impossible to implement in any Hypervisor short of a full emulator
like yours.

I would try a diet and only implement facilities that are actually likely
to be used by modern OS.

There was one other point I wanted to make but I forgot it now @)

-Andi
