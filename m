Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbTAPLzd>; Thu, 16 Jan 2003 06:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbTAPLzd>; Thu, 16 Jan 2003 06:55:33 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8323 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262373AbTAPLzc>;
	Thu, 16 Jan 2003 06:55:32 -0500
Date: Thu, 16 Jan 2003 17:47:32 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 3/4 -- x86_64 arch
Message-ID: <20030116121732.GE13013@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com> <20030113123602.GE2714@in.ibm.com> <20030113152110.GA19931@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113152110.GA19931@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 04:21:10PM +0100, Andi Kleen wrote:
> On Mon, Jan 13, 2003 at 06:06:02PM +0530, Ravikiran G Thirumalai wrote:
> > This one's for x86_64
> 
> Thanks, applied.
> 
> -Andi

Please apply this over the earlier patch.  As Andrew pointed out,
the above patch will cause crashes when per-cpu areas are modified to 
allocate for cpu_possible cpus only.

Reinit of prof_counter/prof_multiplier/prof_old_multiplier seems to be 
redundant (They are already statically inited).  Similar patch worked
for x86 for me.

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.58/arch/x86_64/kernel/smpboot.c prof_counter-2.5.58/arch/x86_64/kernel/smpboot.c
--- linux-2.5.58/arch/x86_64/kernel/smpboot.c	Thu Jan 16 17:01:18 2003
+++ prof_counter-2.5.58/arch/x86_64/kernel/smpboot.c	Thu Jan 16 16:59:58 2003
@@ -772,24 +772,16 @@
  * Cycle through the processors sending APIC IPIs to boot each.
  */
 
-extern int prof_multiplier[NR_CPUS];
-extern int prof_old_multiplier[NR_CPUS];
-DECLARE_PER_CPU(int, prof_counter);
-
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu;
 
 	/*
 	 * Initialize the logical to physical CPU number mapping
-	 * and the per-CPU profiling counter/multiplier
 	 */
 
 	for (apicid = 0; apicid < NR_CPUS; apicid++) {
 		x86_apicid_to_cpu[apicid] = -1;
-		per_cpu(prof_counter, apicid) = 1;
-		prof_old_multiplier[apicid] = 1;
-		prof_multiplier[apicid] = 1;
 	}
 
 	/*
