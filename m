Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUCaBCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbUCaBCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:02:37 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:12049 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263280AbUCaBCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:02:33 -0500
Date: Wed, 31 Mar 2004 02:01:45 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       hari@in.ibm.com
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <25020153.1080698505@[192.168.0.89]>
In-Reply-To: <187940000.1080692555@flay>
References: <006701c415a4$01df0770$d100000a@sbs2003.local>
 <20040329162123.4c57734d.akpm@osdl.org>
 <20040329162555.4227bc88.akpm@osdl.org><20040330132832.GA5552@in.ibm.com>
 <20040330151729.1bd0c5d0.rddunlap@osdl.org> <187940000.1080692555@flay>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 30 March 2004 16:22 -0800 "Martin J. Bligh" <mbligh@aracnet.com> wrote:

>>| We faced this problem starting 2.6.3 while working on kexec.
>>|
>>| The problem is because we now initialize cpu_vm_mask for init_mm with
>>| CPU_MASK_ALL (from 2.6.3 onwards) which makes all bits in cpumask 1 (on
>>| SMP).  Hence BUG_ON(!cpus_equal(cpumask,tmp) fails. The change to set
>>| cpu_vm_mask to CPU_MASK_ALL was done to remove tlb flush optimizations
>>| for ppc64.
>>|
>>| I had posted a patch for this in the earlier thread. Reposting the same
>>| here. This patch removes the assertion and uses "tmp" instead of
>>| cpumask.  Otherwise, we will end up sending IPIs to offline CPUs as
>>| well.
>>|
>>| Comments please.
>>
>> I'll just say that kexec fails without this patch and works with
>> it applied, so I'd like to see it merged.  If this patch isn't
>> acceptable, let's find out why and try to make one that is.
>>
>> Thanks for the patch, Hari.
>
>> From discussions with Andy, it seems this still has the same race as
>> before
> just smaller. I don't see how we can fix this properly without having some
> locking on cpu_online_map .... probably RCU as it's massively read-biased
> and we don't want to pay a spinlock cost to read it.

Realistically the patch does two things.  It removed the BUG_ON which 
causing issues and attempts to cover for the case where the BUG_ON would 
have triggered.  However, as there is no locking on cpu_online_map, there 
is nothing to prevent further cpus from leaving before we send the IPI's. 
If the CPU's are gone what would stop us from hanging here waiting for them 
to acknowledge the invalidate.  It would seem we want to get the cpu 
shutdown code to continue to handle IPI's until we are sure that all other 
cpus will have seen us missing from cpu_online_map?  ie that no other cpu 
is using a stale cpu_online_map for IPI's.

Poking around in the IPI code it does appear that all users of the IPI 
interface are locked, for i386 either under tlbstate_lock or call_lock.  If 
we add a restriction that you must sample cpu_online_map within the 
critical section then the cpu which is leaving must merely ensure that 
there are no callers in these critical sections to ensure there are no 
stale copies of cpu_online_map to worry about.

In this case we know smp_call_function is safe, we are using it to trigger 
the actions.  Therefore I think we only need to ensure we are not doing a 
tlb invalidate.   If we start to shutdown by removing ourselves from 
cpu_online_map, then acquire and release tlbstate_lock we can be sure that 
everyone has see us go.  Then we can shutdown and halt.

Something like this:

static void stop_this_cpu (void * dummy)
{
        /*
         * Remove this CPU:
         */
        cpu_clear(smp_processor_id(), cpu_online_map);
        spin_lock(&tlbstate_lock);
        spin_unlock(&tlbstate_lock);
        local_irq_disable();
        disable_local_APIC();
        if (cpu_data[smp_processor_id()].hlt_works_ok)
                for(;;) __asm__("hlt");
        for (;;);
}

No additional code in the IPI path?  What have I missed?

-apw
