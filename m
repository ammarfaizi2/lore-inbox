Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUC3N3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbUC3N3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:29:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:62632 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263646AbUC3N3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:29:06 -0500
Date: Tue, 30 Mar 2004 18:58:32 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <20040330132832.GA5552@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <006701c415a4$01df0770$d100000a@sbs2003.local> <20040329162123.4c57734d.akpm@osdl.org> <20040329162555.4227bc88.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329162555.4227bc88.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

We faced this problem starting 2.6.3 while working on kexec. 

The problem is because we now initialize cpu_vm_mask for init_mm with 
CPU_MASK_ALL (from 2.6.3 onwards) which makes all bits in cpumask 1 (on SMP). 
Hence BUG_ON(!cpus_equal(cpumask,tmp) fails. The change to set
cpu_vm_mask to CPU_MASK_ALL was done to remove tlb flush optimizations 
for ppc64. 

I had posted a patch for this in the earlier thread. Reposting the same
here. This patch removes the assertion and uses "tmp" instead of cpumask. 
Otherwise, we will end up sending IPIs to offline CPUs as well.

Comments please.

Regards, Hari


diff -Naur linux-2.6.3-before/arch/i386/kernel/smp.c linux-2.6.3/arch/i386/kernel/smp.c
--- linux-2.6.3-before/arch/i386/kernel/smp.c	2004-02-18 09:27:15.000000000 +0530
+++ linux-2.6.3/arch/i386/kernel/smp.c	2004-03-04 14:16:43.000000000 +0530
@@ -356,7 +356,8 @@
 	BUG_ON(cpus_empty(cpumask));
 
 	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
+	if(cpus_empty(tmp))
+		return;
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
@@ -371,12 +372,12 @@
 	flush_mm = mm;
 	flush_va = va;
 #if NR_CPUS <= BITS_PER_LONG
-	atomic_set_mask(cpumask, &flush_cpumask);
+	atomic_set_mask(tmp, &flush_cpumask);
 #else
 	{
 		int k;
 		unsigned long *flush_mask = (unsigned long *)&flush_cpumask;
-		unsigned long *cpu_mask = (unsigned long *)&cpumask;
+		unsigned long *cpu_mask = (unsigned long *)&tmp;
 		for (k = 0; k < BITS_TO_LONGS(NR_CPUS); ++k)
 			atomic_set_mask(cpu_mask[k], &flush_mask[k]);
 	}
@@ -385,7 +386,7 @@
 	 * We have to send the IPI only to
 	 * CPUs affected.
 	 */
-	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
+	send_IPI_mask(tmp, INVALIDATE_TLB_VECTOR);
 
 	while (!cpus_empty(flush_cpumask))
 		/* nothing. lockup detection does not belong here */

On Mon, Mar 29, 2004 at 04:25:55PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> > >
> > > The bug is on "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others
> > > This was from 2.6.1-rc1-mjb1, and seems to be a race on shutdown
> > > (prints after "Power Down"), but I've no reason to believe it's specific
> > > to the patchset I have - it's not an area I'm touching, I think.
> > > 
> > > I presume we've got a race between taking CPUs offline and the 
> > > tlbflush code ... tlb_flush_mm reads the value from mm->cpu_vm_mask,
> > > and then presumably some other cpu changes cpu_online_map before it
> > > gets to calling flush_tlb_others ... does that sound about right?
> > 
> > Looks like it, yes.  I don't think there's a sane way of fixing that - we'd
> > need the flush_tlb_others() caller to hold some lock which keeps the cpu
> > add/remove code away.
> > 
> > I'd propose removing the assertion?
> 
> If the going-away CPU can still take IPIs we're OK, I think.  If it cannot,
> we have a problem.  Can you do a s/BUG_ON/WARN_ON/ and run with that for a
> while?  Check that the warnings come out and the machine doesn't go crump?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
