Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUAGGNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUAGGNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:13:34 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:5770 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266145AbUAGGNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:13:31 -0500
Date: Tue, 06 Jan 2004 22:13:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: shutdown panic in mm_release (really flush_tlb_others?)
Message-ID: <12800000.1073455988@[10.10.2.4]>
In-Reply-To: <20040106213036.5051129b.akpm@osdl.org>
References: <4500000.1073444277@[10.10.2.4]> <20040106213036.5051129b.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And the award for longest panic I've ever seen goes to ....
>>  <drumroll> ....
>> 
>>  (there were several of these in sequence).
>>  Looks like it was trying to printk an error on shutdown ...
>>  really maybe " [<c0115242>] flush_tlb_others+0x22/0xd0"
>> 
>>  Probably the same panic I sent out the other day in a slight
>>  disguise ... "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others
> 
> Cute.  Didn't you have a patch for this?  Or a proposed solution which
> you've been too lazy to type in?  ;)

I did have a rough guess as to the problem, but not the solution:

"I presume we've got a race between taking CPUs offline and the 
tlbflush code ... tlb_flush_mm reads the value from mm->cpu_vm_mask,
and then presumably some other cpu changes cpu_online_map before it
gets to calling flush_tlb_others ... does that sound about right?"

There doesn't seem to be anything locking cpu_online_map, AFAICS,
so presumably stop_this_cpu is futzing with it whilst we try to
shove tlb stuff out to other people. Looks like we're trying to stop 
sending IPIs to CPUs that aren't online (which is a Good Thing (tm)),
but we either end up calling send_IPI_mask_sequence (which already
checks it for us), or send_IPI_mask_bitmap. I suppose we could shift
the check into there ... it'll fix my problem for sure, but probably
just makes the race window smaller on mach_default:

diff -aurpN -X /home/fletch/.diff.exclude 2.6.1-rc2/arch/i386/kernel/smp.c 2.6.1-rc2-tlb_fix/arch/i386/kernel/smp.c
--- 2.6.1-rc2/arch/i386/kernel/smp.c	Tue Sep  2 09:55:42 2003
+++ 2.6.1-rc2-tlb_fix/arch/i386/kernel/smp.c	Tue Jan  6 22:10:44 2004
@@ -160,7 +160,7 @@ void send_IPI_self(int vector)
  */
 inline void send_IPI_mask_bitmask(cpumask_t cpumask, int vector)
 {
-	unsigned long mask = cpus_coerce(cpumask);
+	cpumask_t cpus_online;
 	unsigned long cfg;
 	unsigned long flags;
 
@@ -170,11 +170,12 @@ inline void send_IPI_mask_bitmask(cpumas
 	 * Wait for idle.
 	 */
 	apic_wait_icr_idle();
-		
+
 	/*
 	 * prepare target chip field
 	 */
-	cfg = __prepare_ICR2(mask);
+	cpus_and(cpus_online, cpumask, cpu_online_map);
+	cfg = __prepare_ICR2(cpus_coerce(cpus_online));
 	apic_write_around(APIC_ICR2, cfg);
 		
 	/*
@@ -356,7 +357,6 @@ static void flush_tlb_others(cpumask_t c
 	BUG_ON(cpus_empty(cpumask));
 
 	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 

(Note: not tested. I will if you want me to, but I'm not enamoured
with the patch ;-))

Perhaps there's some better solution in the up-and-coming CPU hotplug
stuff that we could steal?


M.       
