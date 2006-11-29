Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935381AbWK2HNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935381AbWK2HNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935356AbWK2HNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:13:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2447 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935381AbWK2HNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:13:23 -0500
Date: Wed, 29 Nov 2006 08:10:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mm-commits@vger.kernel.org, ak@suse.de, ashok.raj@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] genapic: default to physical mode on hotplug CPU kernels
Message-ID: <20061129071023.GA651@elte.hu>
References: <200611140109.kAE19f5e014490@shell0.pdx.osdl.net> <20061127141849.A9978@unix-os.sc.intel.com> <20061128063345.GA19523@elte.hu> <20061128111414.A16460@unix-os.sc.intel.com> <20061128202322.GA29334@elte.hu> <20061128143145.B16460@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128143145.B16460@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> On Tue, Nov 28, 2006 at 09:23:22PM +0100, Ingo Molnar wrote:
> > 
> > * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > 
> > > On Tue, Nov 28, 2006 at 07:33:46AM +0100, Ingo Molnar wrote:
> > > > -	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster)
> > > > +	if (max_apic < 8)
> > > 
> > > Patch mostly looks good.  Instead of checking for max_apic, can we use
> > > 	cpus_weight(cpu_possible_map) <= 8
> > 
> > ok - but i think it's still possible the BIOS tells us APIC IDs that are 
> > larger than 7, even if there are fewer CPUs. So i think the patch below 
> > should cover it. Agreed?
> > 
> 
> I think it is ok to use flat mode even when APIC IDs are larger than 
> 7, as we rely on LDR's which are programmed using smp_processor_id().
> 
> IMO, cpus_weight check should be fine.

hm - indeed. Then we can indeed do the patch below. Nice simplification!

	Ingo

-------------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] genapic: default to physical mode on hotplug CPU kernels

default to physical mode on hotplug CPU kernels. Furher simplify and
clean up the APIC initialization code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/genapic.c |   20 +++-----------------
 arch/x86_64/kernel/mpparse.c |    2 +-
 include/asm-x86_64/apic.h    |    2 +-
 3 files changed, 5 insertions(+), 19 deletions(-)

Index: linux/arch/x86_64/kernel/genapic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic.c
+++ linux/arch/x86_64/kernel/genapic.c
@@ -33,25 +33,11 @@ u8 x86_cpu_to_log_apicid[NR_CPUS]	= { [0
 struct genapic __read_mostly *genapic = &apic_flat;
 
 /*
- * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
+ * Choose the APIC routing mode:
  */
-void __init clustered_apic_check(void)
+void __init setup_apic_routing(void)
 {
-	unsigned int i, max_apic = 0;
-	u8 id;
-
-	/*
-	 * Determine the maximum APIC ID in use:
-	 */
-	for (i = 0; i < NR_CPUS; i++) {
-		id = bios_cpu_apicid[i];
-		if (id == BAD_APICID)
-			continue;
-		if (id > max_apic)
-			max_apic = id;
-	}
-
-	if (max_apic < 8)
+	if (cpus_weight(cpu_possible_map) <= 8)
 		genapic = &apic_flat;
 	else
 		genapic = &apic_physflat;
Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -302,7 +302,7 @@ static int __init smp_read_mpc(struct mp
 			}
 		}
 	}
-	clustered_apic_check();
+	setup_apic_routing();
 	if (!num_processors)
 		printk(KERN_ERR "MPTABLE: no processors registered!\n");
 	return num_processors;
Index: linux/include/asm-x86_64/apic.h
===================================================================
--- linux.orig/include/asm-x86_64/apic.h
+++ linux/include/asm-x86_64/apic.h
@@ -82,7 +82,7 @@ extern void setup_secondary_APIC_clock (
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
-extern void clustered_apic_check(void);
+extern void setup_apic_routing(void);
 static inline void lapic_timer_idle_broadcast(int broadcast) { }
 
 extern void setup_APIC_extened_lvt(unsigned char lvt_off, unsigned char vector,
