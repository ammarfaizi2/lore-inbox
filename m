Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVEQUSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVEQUSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVEQUSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:18:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21759 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261746AbVEQUSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:18:16 -0400
Date: Tue, 17 May 2005 21:18:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "Yu, Luming" <luming.yu@intel.com>, "Guo, Racing" <racing.guo@intel.com>,
       Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm] x86 port lockless MCE quirky bank0
Message-ID: <Pine.LNX.4.61.0505172107490.5585@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 17 May 2005 20:17:44.0504 (UTC) 
    FILETIME=[7C270B80:01C55B1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been avoiding -mm on the Dell Latitude with PIII Mobile for several
weeks now, since APM resume from RAM locks up.  Just stole time to bisect
and it's the x86-port-lockless-mce patches, which lack some of the wisdom
of ages handed down in the earlier MCE source.

The "Don't enable bank 0 on Intel P6 cores, it goes bang quickly" fix
from the old mcheck/p6.c solves my PIII problem; but looking further,
the old mcheck/k7.c says some Athlons also have a problem with bank 0.

So try to handle them both together: but this code is an amalgam of
what was done slightly differently in the two cases, diverging from each
- I don't want to add voodoo if it's unnecessary; and untested on AMD.

Worry: has more such wisdom got lost in the translation?

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.12-rc4-mm2/arch/i386/kernel/cpu/mcheck/mce.c	2005-05-16 12:18:35.000000000 +0100
+++ linux/arch/i386/kernel/cpu/mcheck/mce.c	2005-05-17 20:21:17.000000000 +0100
@@ -30,7 +30,7 @@ int __devinitdata mce_dont_init = 0;
 /* 0: always panic, 1: panic if deadlock possible, 2: try to avoid panic,
    3: never panic or exit (for testing only) */
 static unsigned long tolerant = 1;
-static int banks;
+static int banks, quirky_bank0;
 static unsigned long bank[NR_BANKS] = { [0 ... NR_BANKS-1] = ~0UL };
 static unsigned long console_logged;
 static int notify_user;
@@ -320,7 +320,8 @@ static void mce_init(void *dummy)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 
 	for (i = 0; i < banks; i++) {
-		wrmsrl(MSR_IA32_MC0_CTL+4*i, bank[i]);
+		if (i >= quirky_bank0)
+			wrmsrl(MSR_IA32_MC0_CTL+4*i, bank[i]);
 		wrmsrl(MSR_IA32_MC0_STATUS+4*i, 0);
 	}
 }
@@ -334,6 +335,14 @@ static void __devinit mce_cpu_quirks(str
 		   incorrectly with the IOMMU & 3ware & Cerberus. */
 		clear_bit(10, &bank[4]);
 	}
+	if ((c->x86_vendor == X86_VENDOR_AMD ||
+	     c->x86_vendor == X86_VENDOR_INTEL) && c->x86 == 6) {
+		/*
+		 * Intel P6 cores go bang quickly when bank0 is enabled.
+	 	 * Some Athlons cause spurious MCEs when bank0 is enabled.
+		 */
+		quirky_bank0 = 1;
+	}
 }
 
 static void __devinit mce_cpu_features(struct cpuinfo_x86 *c)
