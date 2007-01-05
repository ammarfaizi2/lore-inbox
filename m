Return-Path: <linux-kernel-owner+w=401wt.eu-S1750841AbXAEXCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbXAEXCg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbXAEXCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:02:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41809 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbXAEXCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:02:35 -0500
Message-ID: <459ED904.3080503@linux.vnet.ibm.com>
Date: Fri, 05 Jan 2007 17:02:28 -0600
From: Anthony Liguori <aliguori@linux.vnet.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [announce] [patch] KVM paravirtualization for Linux
References: <20070105215223.GA5361@elte.hu>
In-Reply-To: <20070105215223.GA5361@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pretty cool.  I've read the VT spec a number of times and never 
understood why they included the CR3 caching :-)  I suspect that you may 
even be faster than Xen for context switches because of the hardware 
assistance here.  Any chance you can run your benchmarks against Xen?

You may already know this, but there isn't a CR3 cache in SVM AFAIK so a 
fair bit of the code will probably have to be enabled conditionally.  
Otherwise, I don't think SVM support would be that hard.  The only other 
odd bit I noticed was:

> +	magic_val = KVM_API_MAGIC;
> +	para_state->guest_version = KVM_PARA_API_VERSION;
> +	para_state->host_version = -1;
> +	para_state->size = sizeof(*para_state);
> +
> +	asm volatile ("movl %0, %%cr3"
> +			: "=&r" (ret)
> +			: "a" (para_state),
> +			  "0" (magic_val)
> +	);

If I read this correctly, you're using a CR3 write as a hypercall (and 
relying on registers being set/returned that aren't part of the actual 
CR3 move)?  Any reason for not just using vmcall?  It seems a bit less 
awkward.  Even a PIO operation would be a bit cleaner IMHO.  PIO exits 
tend to be fast in VT/SVM so that's an added benefit.

Regards,

Anthony Liguori

Ingo Molnar wrote:
> i'm pleased to announce the first release of paravirtualized KVM (Linux
> under Linux), which includes support for the hardware cr3-cache feature
> of Intel-VMX CPUs. (which speeds up context switches and TLB flushes)
>
> the patch is against 2.6.20-rc3 + KVM trunk and can be found at:
>
>    http://redhat.com/~mingo/kvm-paravirt-patches/
>
> Some aspects of the code are still a bit ad-hoc and incomplete, but the
> code is stable enough in my testing and i'd like to have some feedback.
>
> Firstly, here are some numbers:
>
> 2-task context-switch performance (in microseconds, lower is better):
>
>  native:                       1.11
>  ----------------------------------
>  Qemu:                        61.18
>  KVM upstream:                53.01
>  KVM trunk:                    6.36
>  KVM trunk+paravirt/cr3:       1.60
>
> i.e. 2-task context-switch performance is faster by a factor of 4, and
> is now quite close to native speed!
>
> "hackbench 1" (utilizes 40 tasks, numbers in seconds, lower is better):
>
>  native:                       0.25
>  ----------------------------------
>  Qemu:                         7.8
>  KVM upstream:                 2.8
>  KVM trunk:                    0.55
>  KVM paravirt/cr3:             0.36
>
> almost twice as fast.
>
> "hackbench 5" (utilizes 200 tasks, numbers in seconds, lower is better):
>
>  native:                       0.9
>  ----------------------------------
>  Qemu:                        35.2
>  KVM upstream:                 9.4
>  KVM trunk:                    2.8
>  KVM paravirt/cr3:             2.2
>
> still a 30% improvement - which isnt too bad considering that 200 tasks
> are context-switching in this workload and the cr3 cache in current CPUs
> is only 4 entries.
>
> the patchset does the following:
>
> - it provides an ad-hoc paravirtualization hypercall API between a Linux
>   guest and a Linux host. (this will be replaced with a proper
>   hypercall later on.)
>
> - using the hypercall API it utilizes the "cr3 target cache" feature in
>   Intel VMX CPUs, and extends KVM to make use of that cache. This
>   feature allows the avoidance of expensive VM exits into hypervisor
>   context. (The guest needs to be 'aware' and the cache has to be
>   shared between the guest and the hypervisor. So fully emulated OSs
>   wont benefit from this feature.)
>
> - a few simpler paravirtualization changes are done for Linux guests: IO
>   port delays do not cause a VM exit anymore, the i8259A IRQ controller
>   code got simplified (this will be replaced with a proper, hypercall
>   based and host-maintained IRQ controller implementation) and TLB
>   flushes are more efficient, because no cr3 reads happen which would
>   otherwise cause a VM exit. These changes have a visible effect
>   already: they reduce qemu's CPU usage when a guest idles in HLT, by
>   about 25%. (from ~20% CPU usage to 14% CPU usage if an -rt guest has
>   HZ=1000)
>
> Paravirtualization is triggered via the kvm_paravirt=1 boot option (for
> now, this too is ad-hoc) - if that is passed then the KVM guest will
> probe for paravirtualization availability on the hypervisor side - and
> will use it if found. (If the guest does not find KVM-paravirt support
> on the hypervisor side then it will continue as a fully emulated guest.)
>
> Issues: i only tested this on 32-bit VMX. (64-bit should work with not
> too many changes, the paravirt.c bits can be carried over to 64-bit
> almost as-is. But i didnt want to spread the code too wide.)
>
> Comments, suggestions are welcome!
>
> 	Ingo
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>   

