Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932772AbVITRay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbVITRay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbVITRay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:30:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932773AbVITRax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:30:53 -0400
Date: Tue, 20 Sep 2005 10:30:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Charles McCreary <mccreary@crmeng.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
In-Reply-To: <200509201212.55676.mccreary@crmeng.com>
Message-ID: <Pine.LNX.4.58.0509201028050.2553@g5.osdl.org>
References: <200509201212.55676.mccreary@crmeng.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Charles McCreary wrote:
>
> Another datapoint for this thread. The box spewing the bad pmds messages is a 
> dual opteron 246 on a TYAN S2885 Thunder K8W motherboard. Kernel is 
> 2.6.11.4-20a-smp.

This is quite possibly the result of an Opteron errata (tlb flush
filtering is broken on SMP) that we worked around as of 2.6.14-rc4.

So either just try 2.6.14-rc2, or try the appended patch (it has since 
been confirmed by many more people).

		Linus

---
diff-tree bc5e8fdfc622b03acf5ac974a1b8b26da6511c99 (from 61ffcafafb3d985e1ab8463be0187b421614775c)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Sat Sep 17 15:41:04 2005 -0700

    x86-64/smp: fix random SIGSEGV issues
    
    They seem to have been due to AMD errata 63/122; the fix is to disable
    TLB flush filtering in SMP configurations.
    
    Confirmed to fix the problem by Andrew Walrond <andrew@walrond.org>
    
    [ Let's see if we'll have a better fix eventually, this is the Q&D
      "let's get this fixed and out there" version ]
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -831,11 +831,26 @@ static void __init amd_detect_cmp(struct
 #endif
 }
 
+#define HWCR 0xc0010015
+
 static int __init init_amd(struct cpuinfo_x86 *c)
 {
 	int r;
 	int level;
 
+#ifdef CONFIG_SMP
+	unsigned long value;
+
+	// Disable TLB flush filter by setting HWCR.FFDIS:
+	// bit 6 of msr C001_0015
+	//
+	// Errata 63 for SH-B3 steppings
+	// Errata 122 for all(?) steppings
+	rdmsrl(HWCR, value);
+	value |= 1 << 6;
+	wrmsrl(HWCR, value);
+#endif
+
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
 	clear_bit(0*32+31, &c->x86_capability);
