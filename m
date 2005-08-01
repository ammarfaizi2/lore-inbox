Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVHAVMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVHAVMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVHAUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:22 -0400
Received: from fmr19.intel.com ([134.134.136.18]:973 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261243AbVHAUdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:24 -0400
Message-Id: <20050801203011.746098000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:25 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 8/8] x86_64: Choose physflat for AMD systems only when >8 CPUS.
Content-Disposition: inline; filename=choose-physflat-onlyfor-gt8cpus-amd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not required to choose the physflat mode when CPU hotplug is enabled 
and CPUs <=8 case. Use of genapic_flat with the mask version is capable of 
doing the same, instead of doing the send_IPI_mask_sequence() where its a 
unicast.

This is another change that Andi introduced with the physflat mode. 

Andi: Do you think this is acceptable?

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---------------------------------------------------------------
 arch/x86_64/kernel/genapic.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic.c
@@ -69,15 +69,8 @@ void __init clustered_apic_check(void)
 	}
 
 	/* Don't use clustered mode on AMD platforms. */
- 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+ 	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (num_cpus > 8)) {
 		genapic = &apic_physflat;
-		/* In the CPU hotplug case we cannot use broadcast mode
-		   because that opens a race when a CPU is removed.
-		   Stay at physflat mode in this case. - AK */
-#ifdef CONFIG_HOTPLUG_CPU
-		if (num_cpus <= 8)
-			genapic = &apic_flat;
-#endif
  		goto print;
  	}
 

--

