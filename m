Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUB0Ars (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUB0Aqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:46:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:51619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261548AbUB0Ap0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:45:26 -0500
Date: Thu, 26 Feb 2004 16:45:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-mm@kvack.org, mbligh@aracnet.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au
Subject: Re: shutdown panic in mm_release (really flush_tlb_others?) (fwd)
Message-Id: <20040226164523.660a5496.rddunlap@osdl.org>
In-Reply-To: <12480000.1077754723@flay>
References: <12480000.1077754723@flay>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



| ---------- Forwarded Message ----------
| Date: Tuesday, January 06, 2004 22:13:10 -0800
| From: "Martin J. Bligh" <mbligh@aracnet.com>
| To: Andrew Morton <akpm@osdl.org>
| Subject: Re: shutdown panic in mm_release (really flush_tlb_others?)
| 
| >> And the award for longest panic I've ever seen goes to ....
| >>  <drumroll> ....
| >> 
| >>  (there were several of these in sequence).
| >>  Looks like it was trying to printk an error on shutdown ...
| >>  really maybe " [<c0115242>] flush_tlb_others+0x22/0xd0"
| >> 
| >>  Probably the same panic I sent out the other day in a slight
| >>  disguise ... "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others
| > 
| > Cute.  Didn't you have a patch for this?  Or a proposed solution which
| > you've been too lazy to type in?  ;)
| 
| I did have a rough guess as to the problem, but not the solution:
| 
| "I presume we've got a race between taking CPUs offline and the 
| tlbflush code ... tlb_flush_mm reads the value from mm->cpu_vm_mask,
| and then presumably some other cpu changes cpu_online_map before it
| gets to calling flush_tlb_others ... does that sound about right?"
| 
| There doesn't seem to be anything locking cpu_online_map, AFAICS,
| so presumably stop_this_cpu is futzing with it whilst we try to
| shove tlb stuff out to other people. Looks like we're trying to stop 
| sending IPIs to CPUs that aren't online (which is a Good Thing (tm)),
| but we either end up calling send_IPI_mask_sequence (which already
| checks it for us), or send_IPI_mask_bitmap. I suppose we could shift
| the check into there ... it'll fix my problem for sure, but probably
| just makes the race window smaller on mach_default:
| 
| diff -aurpN -X /home/fletch/.diff.exclude 2.6.1-rc2/arch/i386/kernel/smp.c 2.6.1-rc2-tlb_fix/arch/i386/kernel/smp.c
| --- 2.6.1-rc2/arch/i386/kernel/smp.c	Tue Sep  2 09:55:42 2003
| +++ 2.6.1-rc2-tlb_fix/arch/i386/kernel/smp.c	Tue Jan  6 22:10:44 2004
| @@ -160,7 +160,7 @@ void send_IPI_self(int vector)
|   */
|  inline void send_IPI_mask_bitmask(cpumask_t cpumask, int vector)
|  {
| -	unsigned long mask = cpus_coerce(cpumask);
| +	cpumask_t cpus_online;
|  	unsigned long cfg;
|  	unsigned long flags;
|  
| @@ -170,11 +170,12 @@ inline void send_IPI_mask_bitmask(cpumas
|  	 * Wait for idle.
|  	 */
|  	apic_wait_icr_idle();
| -		
| +
|  	/*
|  	 * prepare target chip field
|  	 */
| -	cfg = __prepare_ICR2(mask);
| +	cpus_and(cpus_online, cpumask, cpu_online_map);
| +	cfg = __prepare_ICR2(cpus_coerce(cpus_online));
|  	apic_write_around(APIC_ICR2, cfg);
|  		
|  	/*
| @@ -356,7 +357,6 @@ static void flush_tlb_others(cpumask_t c
|  	BUG_ON(cpus_empty(cpumask));
|  
|  	cpus_and(tmp, cpumask, cpu_online_map);
| -	BUG_ON(!cpus_equal(cpumask, tmp));
|  	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
|  	BUG_ON(!mm);
|  
| 
| (Note: not tested. I will if you want me to, but I'm not enamoured
| with the patch ;-))
| 
| Perhaps there's some better solution in the up-and-coming CPU hotplug
| stuff that we could steal?


I missed this thread somehow but Martin pointed it out to me.
I'm seeing the BUG in smp.c (line #359 in 2.6.3) when using kexec
on 2.6.3.  It succeeds on 2.6.2.  I don't have to try to shutdown
or reboot; just run /sbin/kexec (or wherever it lives) to call
the kexec syscall.

(kexec patch is at:
  http://developer.osdl.org/rddunlap/kexec/2.6.3/ )

Martin's patch didn't help me the first time that I tried it,
but I'll try it again.  Rusty, is the patch that you posted
complete (regarding arch/i386/kernel/smp.c), or are there other
patch components that I might need?  It's queued up for next...

Thanks,
--
~Randy
