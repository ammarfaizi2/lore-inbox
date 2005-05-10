Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVEJXX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVEJXX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 19:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVEJXX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 19:23:27 -0400
Received: from fmr23.intel.com ([143.183.121.15]:26026 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261848AbVEJXXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:23:05 -0400
Date: Tue, 10 May 2005 16:22:21 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: x86_64 patches in -mm
Message-ID: <20050510162221.A29090@unix-os.sc.intel.com>
References: <20050505151522.72d6deec.akpm@osdl.org> <20050507225850.GA21873@muc.de> <20050509172731.A14676@unix-os.sc.intel.com> <20050510015125.GB97046@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050510015125.GB97046@muc.de>; from ak@muc.de on Tue, May 10, 2005 at 03:51:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:51:25AM +0200, Andi Kleen wrote:
> > 
> > Andrew, please don't drop this patch. There are Intel systems which are 
> > broken with out this patch.
> 
> Ok. Fine for now. Please submit it then Andrew.
> 
> BTW I think there is more code that assume BP == id 0, e.g. apic.c seems
> to have several instances too.
> 
> -Andi

Hi Andi

here is a slighly revised patch that Suresh submitted earlier. I did create one
that is similar to ia64 smp_build_cpu_map(), but it ended with about 50+  lines of code. 

I think this is much simpler. Even in ia64 we assume that the sapic id list is ordered, and
essentially smp_build_cpus() creates it this way. 

In addition the earlier code doesnt boot when bsp is not ordered and we use
maxcpus=1 option. 

If this appears to be ok for you (a prettier hack :-)).


-- 
Cheers,
Ashok Raj
- Open Source Technology Center


This patch removes the assumption that LAPIC entries contain the BSP as its
first entry. This is a slight improvement to the temporary fix submitted by
Suresh Siddha. 

- Removes assumption that LAPIC entries contain BSP first.
- Builds x86_acpiid_to_apicid[] and bios_cpu_apicid[] properly with
  BSP as first entry.
- Made maxcpus=1 boot on these systems. Since the parsing earlier in
  arch/x86_64/kernel/mpparse.c stopped after maxcpus entries, other entries 
  were not processed, this causes kernel not to boot on these systems.

TBD: x86_acpiid_to_apicid and bios_cpu_apicid[] seem to be exactly the same.
     This could be removed, but might need more work to cleanup.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-------
Index: linux-2.6.12-rc3-mm3/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/arch/x86_64/kernel/mpparse.c	2005-05-10 14:40:45.000000000 -0700
+++ linux-2.6.12-rc3-mm3/arch/x86_64/kernel/mpparse.c	2005-05-10 16:08:59.000000000 -0700
@@ -107,6 +107,7 @@
 static void __init MP_processor_info (struct mpc_config_processor *m)
 {
 	int ver;
+	static int found_bsp=0;
 
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
@@ -126,11 +127,6 @@
 			" Processor ignored.\n", NR_CPUS);
 		return;
 	}
-	if (num_processors >= maxcpus) {
-		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
-			" Processor ignored.\n", maxcpus);
-		return;
-	}
 
 	num_processors++;
 
@@ -151,18 +147,19 @@
 	}
 	apic_version[m->mpc_apicid] = ver;
 
-	if ((m->mpc_cpuflag & CPU_BOOTPROCESSOR) && num_processors > 1) {
-		/* for now smp boot code assumes that the first element
-		 * in bios_cpu_apicid array is of boot processor's.
-		 * And we will bring up the AP's in the order listed
-		 * by the bios tables.
+	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
+		/* 
+		 * bios_cpu_apicid is required to have processors listed
+		 * in same order as logical cpu numbers. Hence the first
+		 * entry is BSP, and so on.
 		 */
-		int j;
-		for (j = num_processors - 1; j >= 1; j--)
-			bios_cpu_apicid[j] = bios_cpu_apicid[j-1];
 		bios_cpu_apicid[0] = m->mpc_apicid;
-	} else
-		bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;
+		x86_cpu_to_apicid[0] = m->mpc_apicid;
+		found_bsp = 1;
+	} else {
+		bios_cpu_apicid[num_processors - found_bsp] = m->mpc_apicid;
+		x86_cpu_to_apicid[num_processors - found_bsp] = m->mpc_apicid;
+	}
 }
 
 static void __init MP_bus_info (struct mpc_config_bus *m)
Index: linux-2.6.12-rc3-mm3/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/arch/x86_64/kernel/smpboot.c	2005-05-10 14:40:46.000000000 -0700
+++ linux-2.6.12-rc3-mm3/arch/x86_64/kernel/smpboot.c	2005-05-10 16:09:00.000000000 -0700
@@ -531,7 +531,6 @@
 		printk("failed fork for CPU %d\n", cpu);
 		return PTR_ERR(idle);
 	}
-	x86_cpu_to_apicid[cpu] = apicid;
 
 	cpu_pda[cpu].pcurrent = idle;
 
@@ -842,7 +841,6 @@
 		      GET_APIC_ID(apic_read(APIC_ID)), boot_cpu_id);
 		/* Or can we switch back to PIC here? */
 	}
-	x86_cpu_to_apicid[0] = boot_cpu_id;
 
 	/*
 	 * Now start the IO-APICs
