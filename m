Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVIWXSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVIWXSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVIWXSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:18:23 -0400
Received: from fmr22.intel.com ([143.183.121.14]:6530 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751344AbVIWXSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:18:22 -0400
Date: Fri, 23 Sep 2005 16:17:57 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [x86] Bug fix in P6 Machine check initialization
Message-ID: <20050923161757.A15625@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Make P6 MCA initialization code complaint with guidelines in 
IA-32 SDM Vol3. Bank 0 control register should not be set by OS and clear status
registers on all banks on reset. 

This will preven false MCE alarms on the systems that has some non-MCE 
information left-over in MC0_STATUS on reboot.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.12/arch/i386/kernel/cpu/mcheck/p6.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/mcheck/p6.c	2005-08-30 11:10:46.000000000 -0700
+++ linux-2.6.12/arch/i386/kernel/cpu/mcheck/p6.c	2005-09-22 15:37:53.653669656 -0700
@@ -103,11 +103,16 @@
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	nr_mce_banks = l & 0xff;
 
-	/* Don't enable bank 0 on intel P6 cores, it goes bang quickly. */
-	for (i=1; i<nr_mce_banks; i++) {
+	/*
+	 * Following the example in IA-32 SDM Vol 3:
+	 * - MC0_CTL should not be written
+	 * - Status registers on all banks should be cleared on reset
+	 */
+	for (i=1; i<nr_mce_banks; i++)
 		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+
+	for (i=0; i<nr_mce_banks; i++)
 		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
-	}
 
 	set_in_cr4 (X86_CR4_MCE);
 	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
