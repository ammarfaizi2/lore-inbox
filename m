Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVKVVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVKVVQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVKVVQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:16:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965202AbVKVVKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:15 -0500
Date: Tue, 22 Nov 2005 13:08:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Marcel Holtmann <marcel@holtmann.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       discuss@x86-64.org, Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Shaohua Li <shaohua.li@intel.com>, ak@suse.de
Subject: [patch 19/23] [PATCH] x86_64/i386: Compute correct MTRR mask on early Noconas
Message-ID: <20051122210838.GT28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="4GB-memory-intel-dual-core.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Force correct address space size for MTRR on some 64bit Intel Xeons

They report 40bit, but only have 36bits of physical address space.
This caused problems with setting up the correct masks for MTRR,
resulting in incorrect MTRRs.

CPUID workaround for steppings 0F33h(supporting x86) and 0F34h(supporting x86
and EM64T). Detail info can be found at:
http://download.intel.com/design/Xeon/specupdt/30240216.pdf
http://download.intel.com/design/Pentium4/specupdt/30235221.pdf

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/kernel/cpu/mtrr/main.c |    8 ++++++++
 arch/x86_64/kernel/setup.c       |    5 +++++
 2 files changed, 13 insertions(+)

--- linux-2.6.14.2.orig/arch/i386/kernel/cpu/mtrr/main.c
+++ linux-2.6.14.2/arch/i386/kernel/cpu/mtrr/main.c
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
--- linux-2.6.14.2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.14.2/arch/x86_64/kernel/setup.c
@@ -993,6 +993,11 @@ static void __cpuinit init_intel(struct 
 		unsigned eax = cpuid_eax(0x80000008);
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+		/* CPUID workaround for Intel 0F34 CPU */
+		if (c->x86_vendor == X86_VENDOR_INTEL &&
+		    c->x86 == 0xF && c->x86_model == 0x3 &&
+		    c->x86_mask == 0x4)
+			c->x86_phys_bits = 36;
 	}
 
 	if (c->x86 == 15)

--
