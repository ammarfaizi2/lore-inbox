Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWFXASn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWFXASn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbWFXASm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:18:42 -0400
Received: from mail.suse.de ([195.135.220.2]:64654 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751687AbWFXASm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:18:42 -0400
Date: Sat, 24 Jun 2006 02:18:40 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [4/82] i386/x86-64: Use new official CPUID to get 
 APICID/core split on AMD platforms
Message-ID: <449C84E0.mailCMY1N1S88@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Previously the apicid<->coreid split was computed based on the max 
number of cores. Now use a new CPUID AMD defined for that. On most
systems right now it should be 0 and the old method will be used.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/amd.c |   14 ++++++++------
 arch/x86_64/kernel/setup.c |   20 +++++++++++++-------
 2 files changed, 21 insertions(+), 13 deletions(-)

Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -968,10 +968,18 @@ static void __init amd_detect_cmp(struct
 	int node = 0;
 	unsigned apicid = hard_smp_processor_id();
 #endif
+	unsigned ecx = cpuid_ecx(0x80000008);
 
-	bits = 0;
-	while ((1 << bits) < c->x86_max_cores)
-		bits++;
+	c->x86_max_cores = (ecx & 0xff) + 1;
+
+	/* CPU telling us the core id bits shift? */
+	bits = (ecx >> 12) & 0xF;
+
+	/* Otherwise recompute */
+	if (bits == 0) {
+		while ((1 << bits) < c->x86_max_cores)
+			bits++;
+	}
 
 	/* Low order bits define the core id (index of core in socket) */
 	cpu_core_id[cpu] = phys_proc_id[cpu] & ((1 << bits)-1);
@@ -1059,11 +1067,9 @@ static int __init init_amd(struct cpuinf
 	if (c->x86_power & (1<<8))
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
 
-	if (c->extended_cpuid_level >= 0x80000008) {
-		c->x86_max_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
-
+	/* Multi core CPU? */
+	if (c->extended_cpuid_level >= 0x80000008)
 		amd_detect_cmp(c);
-	}
 
 	return r;
 }
Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -224,15 +224,17 @@ static void __init init_amd(struct cpuin
 
 #ifdef CONFIG_X86_HT
 	/*
-	 * On a AMD dual core setup the lower bits of the APIC id
-	 * distingush the cores.  Assumes number of cores is a power
-	 * of two.
+	 * On a AMD multi core setup the lower bits of the APIC id
+	 * distingush the cores.
 	 */
 	if (c->x86_max_cores > 1) {
 		int cpu = smp_processor_id();
-		unsigned bits = 0;
-		while ((1 << bits) < c->x86_max_cores)
-			bits++;
+		unsigned bits = (cpuid_ecx(0x80000008) >> 12) & 0xf;
+
+		if (bits == 0) {
+			while ((1 << bits) < c->x86_max_cores)
+				bits++;
+		}
 		cpu_core_id[cpu] = phys_proc_id[cpu] & ((1<<bits)-1);
 		phys_proc_id[cpu] >>= bits;
 		printk(KERN_INFO "CPU %d(%d) -> Core %d\n",
