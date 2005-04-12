Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVDMD1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVDMD1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVDLTbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:31:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:12233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262192AbVDLKcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:15 -0400
Message-Id: <200504121032.j3CAW3hX005483@shell0.pdx.osdl.net>
Subject: [patch 089/198] x86_64: Use the extended RIP MSR for machine check reporting if available.
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       racing.guo@intel.com, venkatesh.pallipadi@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

They are rumoured to be much more reliable than the RIP in the stack frame on
P4s.

This is a borderline case because the code is very simple.  Please note there
are no plans to add support for all the MCE register MSRs.

Cc: <venkatesh.pallipadi@intel.com>
Cc: <racing.guo@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/mce.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff -puN arch/x86_64/kernel/mce.c~x86_64-use-the-extended-rip-msr-for-machine-check arch/x86_64/kernel/mce.c
--- 25/arch/x86_64/kernel/mce.c~x86_64-use-the-extended-rip-msr-for-machine-check	2005-04-12 03:21:24.452419568 -0700
+++ 25-akpm/arch/x86_64/kernel/mce.c	2005-04-12 03:21:24.455419112 -0700
@@ -33,6 +33,7 @@ static int banks;
 static unsigned long bank[NR_BANKS] = { [0 ... NR_BANKS-1] = ~0UL };
 static unsigned long console_logged;
 static int notify_user;
+static int rip_msr;
 
 /*
  * Lockless MCE logging infrastructure.
@@ -124,6 +125,23 @@ static int mce_available(struct cpuinfo_
 	       test_bit(X86_FEATURE_MCA, &c->x86_capability);
 }
 
+static inline void mce_get_rip(struct mce *m, struct pt_regs *regs)
+{
+	if (regs && (m->mcgstatus & MCG_STATUS_RIPV)) {
+		m->rip = regs->rip;
+		m->cs = regs->cs;
+	} else {
+		m->rip = 0;
+		m->cs = 0;
+	}
+	if (rip_msr) {
+		/* Assume the RIP in the MSR is exact. Is this true? */
+		m->mcgstatus |= MCG_STATUS_EIPV;
+		rdmsrl(rip_msr, m->rip);
+		m->cs = 0;
+	}
+}
+
 /* 
  * The actual machine check handler
  */
@@ -176,14 +194,7 @@ void do_machine_check(struct pt_regs * r
 		if (m.status & MCI_STATUS_ADDRV)
 			rdmsrl(MSR_IA32_MC0_ADDR + i*4, m.addr);
 
-		if (regs && (m.mcgstatus & MCG_STATUS_RIPV)) {
-			m.rip = regs->rip;
-			m.cs = regs->cs;
-		} else {
-			m.rip = 0;
-			m.cs = 0;
-		}
-
+		mce_get_rip(&m, regs);
 		if (error_code != -1)
 			rdtscll(m.tsc);
 		wrmsrl(MSR_IA32_MC0_STATUS + i*4, 0);
@@ -296,6 +307,9 @@ static void mce_init(void *dummy)
 		printk(KERN_INFO "MCE: warning: using only %d banks\n", banks);
 		banks = NR_BANKS; 
 	}
+	/* Use accurate RIP reporting if available. */
+	if ((cap & (1<<9)) && ((cap >> 16) & 0xff) >= 9)
+		rip_msr = MSR_IA32_MCG_EIP;
 
 	/* Log the machine checks left over from the previous reset.
 	   This also clears all registers */
_
