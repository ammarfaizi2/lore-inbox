Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWCVWEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCVWEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCVWEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:04:34 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:41988 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932073AbWCVWEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:04:33 -0500
Message-ID: <4421C9D4.3050806@vmware.com>
Date: Wed, 22 Mar 2006 14:04:04 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de>
In-Reply-To: <200603222105.58912.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 13 March 2006 18:59, Zachary Amsden wrote:
>
>   
>> +     The general mechanism for providing customized features and
>> +     capabilities is to provide notification of these feature through
>> +     the CPUID call, 
>>     
>
> How should that work since CPUID cannot be intercepted by 
> a Hypervisor (without VMX/SVM)?  
>   

It can be intercepted with a VMI call.  I actually think overloading 
this for VM features as well, although convenient, might turn out to be 
unwieldy.


>> + Watchdog NMIs are of limited use if the OS is
>> +     already correct and running on stable hardware;
>>     
>
> So how would your Hypervisor detect a kernel hung with interrupts
> off then?
>   

The hypervisor can detect it fine - we never disable hardware interrupts 
or NMIs except for very small windows in the fault handlers.  I'm 
arguing that philosophically, using NMIs to detect a software hang means 
you have broken software.  NMIs for detecting hardware induced hangs are 
common and reasonable things to do, but on virtual hardware, that 
shouldn't happen either.

>   
>>>       profiling NMIs are 
>>>       
>> +     similarly of less use, since this task is accomplished with more accuracy
>> +     in the VMM itself
>>     
>
> And how does oprofile know about this?
>   

It doesn't.  But consider that oprofile is a time based NMI sampler.  
That is less accurate in a VM when you have virtual time, and, somewhat 
skewed spacing between NMI delivery, and less than accurate performance 
counter information.  You can get a lot better results for benchmarks 
using the VMM to sample the guest instead.

>> ; and NMIs for machine check errors should be handled 
>> +     outside of the VM.  
>>     
>
> Right now yes, but if we ever implement intelligent memory ECC error handling it's questionable
> the hypervisor can do a better job. It has far less information about how memory
> is used than the kernel.
>   

Right.  I think I may have been too proactive in my defense of disabling 
NMIs.  I agree now, it is a bug, and it really should be supported.  But 
it was a convenient shortcut to getting things working - otherwise you 
have to have the NMI avoidance logic in entry.S, which is not properly 
virtualizable (checks raw segments without masking RPL).  But seeing as 
I already fixed that, I think we actually could re-enable NMIs now.

Though the usefulness of common cases may be compromised, having the VM 
do machine check handling on its own data pages (so it can figure out 
which processes to kill / recover) is an extremely useful case.

>> +   CORE INTERFACE CALLS
>>     
>
> Did I miss it or do you never describe how to find these entry points? 
>   

It should be described in the ROM probing section in more detail.  Our 
documentation is getting better with time ;)

>   
>> +    VMI_EnableInterrupts
>> +
>> +       VMICALL void VMI_EnableInterrupts(void);
>> +
>> +       Enable maskable interrupts on the processor.  Note that the
>> +       current implementation always will deliver any pending interrupts
>> +       on a call which enables interrupts, for compatibility with kernel
>> +       code which expects this behavior.  Whether this should be required
>> +       is open for debate.
>>     
>
> A subtle trap is also that it will do so on the next instruction, not the 
> followon to next like a real x86.  At some point there was code in Linux
> that dependend on this.
>   

There still is.  This is why you have the "sti; sysexit" pair, and why 
safe_halt() is "sti; hlt".  You really don't want interrupts in those 
windows.  The architectural oddity forced us to make these calls into 
the VMI interface.  A third one, used by some operating systems, is 
"sti; nop; cli" - i.e. deliver pending interrupts and disable again.  In 
most other cases, it doesn't matter.

>   
>> +       VMICALL VMI_UINT64 VMI_RDMSR(VMI_UINT64 dummy, VMI_UINT32 reg);
>> +
>> +       Read from a model specific register.  This functions identically to the
>> +       hardware RDMSR instruction.  Note that a hypervisor may not implement
>> +       the full set of MSRs supported by native hardware, since many of them
>> +       are not useful in the context of a virtual machine.
>>     
>
> So what happens when the kernel tries to access an unimplemented MSR?
>
> Also we have had occasionally workarounds in the past that required 
> MSR writes with magic "passwords". How would these be handled?
>   

I actually already implemented your suggestion on making MSR reads and 
writes use trap and emulate - so all of these issues go away.  Whether 
forcing trap and emulate is a good idea for a minimal open source 
hypervisor is another debate.

> +
>   
>> +    VMI_CPUID
>> +
>> +       /* Not expressible as a C function */
>> +
>> +       The CPUID instruction provides processor feature identification in a
>> +       vendor specific manner.  The instruction itself is non-virtualizable
>> +       without hardware support, requiring a hypervisor assisted CPUID call
>> +       that emulates the effect of the native instruction, while masking any
>> +       unsupported CPU feature bits.
>>     
>
> Doesn't seem to be very useful because everybody can just call CPUID directly.
>   

Which is why the kernel _must_ use the CPUID VMI call.  We're a little 
bit broken in this respect today, since the boot code in head.S does 
CPUID probing before the VMI init call.  It works for us because we use 
binary translation of the kernel up to this point.  In the end, this 
will disappear, and the CPUID probing will be done in the alternative 
entry point known as the "start of day" state, where the kernel is 
already pre-virtualized.

> Yes, but it will be wrong in a native kernel too so why do you want
> to be better than native? 
>
> Seems useless to me.
>   

Agree.  TSC is broken in so many ways, that it really should not be used 
for anything other than unreliable cycle counting.

>   
>> +    VMI_RDPMC
>> +
>> +       VMICALL VMI_UINT64 VMI_RDPMC(VMI_UINT64 dummy, VMI_UINT32 counter);
>> +
>> +       Similar to RDTSC, this call provides the functionality of reading
>> +       processor performance counters.  It also is selectively visible to
>> +       userspace, and maintaining accurate data for the performance counters
>> +       is an extremely difficult task due to the side effects introduced by
>> +       the hypervisor.
>>     
>
> Similar.
>
> Overall feeling is you have far too many calls. You seem to try to implement
> a full x86 replacement, but that makes it big and likely to be buggy. And 
> it's likely impossible to implement in any Hypervisor short of a full emulator
> like yours.
>
> I would try a diet and only implement facilities that are actually likely
> to be used by modern OS.
>   

The interface can't really go on too much of a diet - some kernel 
somewhere, maybe not Linux, under some hypervisor, maybe not VMware or 
Xen, may want to use these features.  What the interface can be is an a 
la carte menu.  By allowing specific instructions to fall back to trap 
and emulate, mainstream OSes don't need to be bothered with changing to 
match some rich interface.  Other OSes may have vastly different 
requirements, and might want to make use of these features heavily, if 
they are available.  And hypervisors don't need to implement anything 
special for these either.  Our RDPMC implementation in the ROM is quite 
simple:

/*
 * VMI_RDPMC - Binary RDPMC equivalent
 *             Must clobber no registers (other than %eax, %edx return)
 */
VMI_ENTRY(RDPMC)
   rdpmc
   vmireturn
VMI_CALL_END

Taken to the extreme, where the patch processing is done before the 
kernel runs, in the hypervisor itself, using the annotation table 
provided by the guest kernel, it is even easier.  If you see an 
annotation for a feature you don't care to implement, you don't do 
anything at all - you leave the native instructions as they are.  In 
this case, neither the kernel nor the hypervisor has any extra code at 
all to deal with cases they don't care about.  But the rich interface is 
still there, and if someone wants to bathe in butter, who are we to 
judge.  There certainly are uses for it.  For example, WRMSR is not on 
critical paths in i386 Linux today.  That does not mean we should remove 
it from the interface.  When a new processor core comes along, and all 
of a sudden, you really need that interface back, you want it ready for 
use.  And this case really did happen - FSBASE and GSBASE MSR writes 
moved onto the critical path in x86_64.

I think I carried the diet analogy a little far.

> There was one other point I wanted to make but I forgot it now @)
>   

Thanks again for your feedback,

Zach

