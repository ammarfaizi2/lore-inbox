Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWBHIzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWBHIzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbWBHIzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:55:10 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:30599 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1030588AbWBHIzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:55:08 -0500
Date: Wed, 8 Feb 2006 11:55:06 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Richard Henderson <rth@twiddle.net>,
       Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       heiko.carstens@de.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Ingo Molnar <mingo@elte.hu>, axboe@suse.de, anton@samba.org,
       wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060208115506.A28309@jurassic.park.msu.ru>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com> <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org> <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org> <20060207183018.GA29056@in.ibm.com> <Pine.LNX.4.64.0602071036050.3854@g5.osdl.org> <20060207185355.GC5771@in.ibm.com> <Pine.LNX.4.64.0602071107200.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0602071107200.3854@g5.osdl.org>; from torvalds@osdl.org on Tue, Feb 07, 2006 at 11:11:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 11:11:56AM -0800, Linus Torvalds wrote:
> You're right, my bad.  I looked at setup_smp() and how it walked through 
> every CPU in the firmware, but it doesn't actually ever set the possible 
> map, it fills in just hwrpb_cpu_present_mask (which is then then only used 
> _later_ to set cpu_possible_map for some silly reason).
> 
> As far as I can tell, "hwrpb_cpu_present_mask" is just wrong, and the code 
> _should_ be using cpu_possible_map.

Yep, it seems that we can get rid of hwrpb_cpu_present_mask.
The appended patch is only minimally tested (works on UP with SMP kernel).

Ivan.

--- linux/arch/alpha/kernel/smp.c.orig	Wed Jan 18 02:09:27 2006
+++ linux/arch/alpha/kernel/smp.c	Wed Feb  8 02:38:46 2006
@@ -73,9 +73,6 @@ cpumask_t cpu_online_map;
 
 EXPORT_SYMBOL(cpu_online_map);
 
-/* cpus reported in the hwrpb */
-static unsigned long hwrpb_cpu_present_mask __initdata = 0;
-
 int smp_num_probed;		/* Internal processor count */
 int smp_num_cpus = 1;		/* Number that came online.  */
 
@@ -442,7 +439,7 @@ setup_smp(void)
 			if ((cpu->flags & 0x1cc) == 0x1cc) {
 				smp_num_probed++;
 				/* Assume here that "whami" == index */
-				hwrpb_cpu_present_mask |= (1UL << i);
+				cpu_set(i, cpu_possible_map);
 				cpu->pal_revision = boot_cpu_palrev;
 			}
 
@@ -453,12 +450,12 @@ setup_smp(void)
 		}
 	} else {
 		smp_num_probed = 1;
-		hwrpb_cpu_present_mask = (1UL << boot_cpuid);
+		cpu_set(boot_cpuid, cpu_possible_map);
 	}
 	cpu_present_mask = cpumask_of_cpu(boot_cpuid);
 
 	printk(KERN_INFO "SMP: %d CPUs probed -- cpu_present_mask = %lx\n",
-	       smp_num_probed, hwrpb_cpu_present_mask);
+	       smp_num_probed, cpu_possible_map.bits[0]);
 }
 
 /*
@@ -467,8 +464,6 @@ setup_smp(void)
 void __init
 smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu_count, i;
-
 	/* Take care of some initial bookkeeping.  */
 	memset(ipi_data, 0, sizeof(ipi_data));
 
@@ -486,19 +481,7 @@ smp_prepare_cpus(unsigned int max_cpus)
 
 	printk(KERN_INFO "SMP starting up secondaries.\n");
 
-	cpu_count = 1;
-	for (i = 0; (i < NR_CPUS) && (cpu_count < max_cpus); i++) {
-		if (i == boot_cpuid)
-			continue;
-
-		if (((hwrpb_cpu_present_mask >> i) & 1) == 0)
-			continue;
-
-		cpu_set(i, cpu_possible_map);
-		cpu_count++;
-	}
-
-	smp_num_cpus = cpu_count;
+	smp_num_cpus = smp_num_probed;
 }
 
 void __devinit
