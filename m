Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUCHShY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 13:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUCHShY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 13:37:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:54974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262520AbUCHSgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 13:36:52 -0500
Date: Mon, 8 Mar 2004 10:35:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: hari@in.ibm.com
Cc: ebiederm@xmission.com, r3pek@r3pek.homelinux.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: kexec "problem" [and patch updates]
Message-Id: <20040308103509.0cf1ee98.rddunlap@osdl.org>
In-Reply-To: <20040304130310.GA7741@in.ibm.com>
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
	<20040226165446.16a5bb3b.rddunlap@osdl.org>
	<m1znb5c5q3.fsf@ebiederm.dsl.xmission.com>
	<20040227113224.72f6dcc5.rddunlap@osdl.org>
	<m1brnjcwpu.fsf@ebiederm.dsl.xmission.com>
	<20040304130310.GA7741@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004 18:33:10 +0530 Hariprasad Nellitheertha wrote:

| Hello,
| 
| I recreated this on a UNI system running an SMP kernel as well. 
| 
| The problem is because we now initialize cpu_vm_mask for init_mm with 
| CPU_MASK_ALL (from 2.6.3 onwards) which makes all bits in cpumask 1. 
| Hence BUG_ON(!cpus_equal(cpumask,tmp) fails. The change to set 
| cpu_vm_mask to CPU_MASK_ALL was done to remove tlb flush optimizations 
| for ppc64. On UNI kernels, CPU_MASK_ALL is 1 and hence the problem 
| does not occur.
| 
| I made a small patch which fixes this problem. The change is, essentially,
| to use "tmp" instead of "cpumask". This ensures that only the (other) online 
| cpus are sent the IPI. 
| 
| I have done some testing with this patch. Kexec loads fine and I haven't seen
| anything untoward. 

Yes, that does work well... Thanks for the patch.

Is this satisfactory for pushing into the mainline kernel, or
should kexec use another method to solve this problem?

--
~Randy


| Comments please.
| 
| Regards, Hari
| 
| 
| diff -Naur linux-2.6.3-before/arch/i386/kernel/smp.c linux-2.6.3/arch/i386/kernel/smp.c
| --- linux-2.6.3-before/arch/i386/kernel/smp.c	2004-02-18 09:27:15.000000000 +0530
| +++ linux-2.6.3/arch/i386/kernel/smp.c	2004-03-04 14:16:43.000000000 +0530
| @@ -356,7 +356,8 @@
|  	BUG_ON(cpus_empty(cpumask));
|  
|  	cpus_and(tmp, cpumask, cpu_online_map);
| -	BUG_ON(!cpus_equal(cpumask, tmp));
| +	if(cpus_empty(tmp))
| +		return;
|  	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
|  	BUG_ON(!mm);
|  
| @@ -371,12 +372,12 @@
|  	flush_mm = mm;
|  	flush_va = va;
|  #if NR_CPUS <= BITS_PER_LONG
| -	atomic_set_mask(cpumask, &flush_cpumask);
| +	atomic_set_mask(tmp, &flush_cpumask);
|  #else
|  	{
|  		int k;
|  		unsigned long *flush_mask = (unsigned long *)&flush_cpumask;
| -		unsigned long *cpu_mask = (unsigned long *)&cpumask;
| +		unsigned long *cpu_mask = (unsigned long *)&tmp;
|  		for (k = 0; k < BITS_TO_LONGS(NR_CPUS); ++k)
|  			atomic_set_mask(cpu_mask[k], &flush_mask[k]);
|  	}
| @@ -385,7 +386,7 @@
|  	 * We have to send the IPI only to
|  	 * CPUs affected.
|  	 */
| -	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
| +	send_IPI_mask(tmp, INVALIDATE_TLB_VECTOR);
|  
|  	while (!cpus_empty(flush_cpumask))
|  		/* nothing. lockup detection does not belong here */
| 
| 
| On Sat, Feb 28, 2004 at 03:41:33AM -0700, Eric W. Biederman wrote:
| > "Randy.Dunlap" <rddunlap@osdl.org> writes:
| > 
| > > On 27 Feb 2004 01:00:04 -0700 Eric W. Biederman wrote:
| > > 
| > > | > It works fine on 2.6.2.  It works for me on 2.6.3 if not SMP.
| > > | > If the kernel is built for SMP, when running kexec, I get a
| > > | > BUG in arch/i386/kernel/smp.c at line 359.
| > > | > I'm testing various workarounds for that BUG now.
| > > | 
| > > | I will eyeball it...
| > > | 
| > > | Is it the kernel that is shutting down, or the kernel that is being
| > > | brought up that has problems?
| > > 
| > > the kernel that is shutting down.
| > > 
| > > | The back trace from the BUG would be interesting.
| > > 
| > > see below.  my bad.  i should have included it.
| > > 
| > > | As I see it flush_tlb_others is being called when we have shutdown
| > > | cpus and the kernel still thinks we have the mm present on foreign
| > > | cpus.
| > > 
| > > Martin Bligh thinks that there is a tlb race here.
| > > I printed the 2 cpu masks on my dual-proc macine and saw
| > > 0 in one of them and 0xc in the other one.
| > 
| > Ouch we have both cpus running when this happens, and we have not
| > started any shutdown whatsoever.  This is the bit that sets up
| > the page tables for later use...
| > 
| > I think identity_map_pages will have problems with a kernel that does
| > the 4G/4G split, and it has known issues on some other architectures,
| > because they treat init_mm specially.  So the proper solution may be
| > to simply rewrite identity_map_pages. 
| > 
| > Before we do that in the short term we need to see if
| > identity_map_pages is actually doing anything bad.  You are
| > not using the 4G/4G split so that is not the cause.  So either
| > init_mm is now special in some way, or we have hit a generic kernel
| > bug.
| > 
| > So this may indeed be a tlb race.  But it is init_mm->cpu_vm_mask and
| > cpu_online map that are different.  With the implication being
| > that init_mm->cpu_vm_mask has cpus set that are not in cpu_online_map?
| > Very weird especially on SMP.
| > 
| > Without attribution I have a hard time making sense of which cpumask
| > is which so I can't draw any conclusions.  But I find it very
| > interesting that it is bits 2 and 3 that are set.  I wonder if
| > there is any mixup between logical cpu identities and apic ids.
| > 
| > Eric
| > _______________________________________________

| 
| -- 
| Hariprasad Nellitheertha
| Linux Technology Center
| India Software Labs
| IBM India, Bangalore
| -
