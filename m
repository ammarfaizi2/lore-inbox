Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVI2Azi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVI2Azi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVI2Azi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:55:38 -0400
Received: from fmr18.intel.com ([134.134.136.17]:33495 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751293AbVI2Azh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:55:37 -0400
Subject: [PATCH]CPUID workaround for intel CPU - Re: [PROBLEM] mtrr's not
	set, 2.6.13
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Jim McCloskey <mcclosk@ucsc.edu>, akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 09:02:31 +0800
Message-Id: <1127955751.4045.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
This is patch to fix the Jim McCloskey's MTRR issue.
CPUID workaround for steppings 0F33h(supporting x86) and 0F34h(supporting x86
and EM64T). Detail info can be found at:
http://download.intel.com/design/Xeon/specupdt/30240216.pdf
http://download.intel.com/design/Pentium4/specupdt/30235221.pdf

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.14-rc2-root/arch/i386/kernel/cpu/mtrr/main.c |    8 ++++++++
 linux-2.6.14-rc2-root/arch/x86_64/kernel/setup.c       |    6 ++++++
 2 files changed, 14 insertions(+)

diff -puN arch/i386/kernel/cpu/mtrr/main.c~cpuid_errta arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.14-rc2/arch/i386/kernel/cpu/mtrr/main.c~cpuid_errta	2005-09-29 08:35:34.000000000 +0800
+++ linux-2.6.14-rc2-root/arch/i386/kernel/cpu/mtrr/main.c	2005-09-29 08:37:16.000000000 +0800
@@ -626,6 +626,14 @@ void __init mtrr_bp_init(void)
 		if (cpuid_eax(0x80000000) >= 0x80000008) {
 			u32 phys_addr;
 			phys_addr = cpuid_eax(0x80000008) & 0xff;
+			/* CPUID workaround for Intel 0F33/0F34 CPU */
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			    boot_cpu_data.x86 == 0xF &&
+			    boot_cpu_data.x86_model == 0x3 &&
+			    (boot_cpu_data.x86_mask == 0x3 ||
+			     boot_cpu_data.x86_mask == 0x4))
+				phys_addr = 36;
+
 			size_or_mask = ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
 			size_and_mask = ~size_or_mask & 0xfff00000;
 		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
diff -puN arch/x86_64/kernel/setup.c~cpuid_errta arch/x86_64/kernel/setup.c
--- linux-2.6.14-rc2/arch/x86_64/kernel/setup.c~cpuid_errta	2005-09-29 08:35:34.000000000 +0800
+++ linux-2.6.14-rc2-root/arch/x86_64/kernel/setup.c	2005-09-29 08:37:48.000000000 +0800
@@ -992,6 +992,12 @@ static void __cpuinit init_intel(struct 
 		unsigned eax = cpuid_eax(0x80000008);
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+		/* CPUID workaround for Intel 0F34 CPU */
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+		    boot_cpu_data.x86 == 0xF &&
+		    boot_cpu_data.x86_model == 0x3 &&
+		    boot_cpu_data.x86_mask == 0x4)
+			c->x86_phys_bits = 36;
 	}
 
 	if (c->x86 == 15)
_


