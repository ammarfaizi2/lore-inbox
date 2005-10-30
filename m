Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932794AbVJ3GuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbVJ3GuR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbVJ3GuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:50:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932794AbVJ3GuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:50:15 -0500
Date: Sun, 30 Oct 2005 01:49:38 -0500
From: Dave Jones <davej@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, Shaohua Li <shaohua.li@intel.com>,
       torvalds@osdl.org, stable@kernel.org, ak@suse.de
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051030064938.GA24429@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukas Hejtmanek <xhejtman@mail.muni.cz>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	Shaohua Li <shaohua.li@intel.com>, torvalds@osdl.org,
	stable@kernel.org, ak@suse.de
References: <20051028205833.GM2533@mail.muni.cz> <20051029033229.GA13257@redhat.com> <1130584524.5360.1.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130584524.5360.1.camel@blade>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 01:15:24PM +0200, Marcel Holtmann wrote:
 > Hi Dave,
 > 
 > >  > I have system with 2 Pentium 4 Xeon EM64T processors using 4GB of RAM.
 > >  > 
 > >  > Kernel is 2.6.13.4 compiled for x86_64 architecture.
 > >  > 
 > >  > Btw, /proc/cpuinfo reports, that only 36 bits are availalable for physical 
 > >  > memory. Not 40.
 > > 
 > > That should be fixed in 2.6.14
 > 
 > is this only true for the Xeon series or should it be 40 bits for every
 > EM64T capable CPU from Intel? I ask, because mine still shows 36 bits
 > with the latest vanilla from today.

Actually, I mixed this up a little. 36 bits is 'the norm' for EM64T 
(for right now at least).  However, there were two models that advertised
40 bits, but only actually have 36 bits.

The following patch Andi forwarded never actually made it into 2.6.14.
Definite 2.6.14.1 material IMO.

		Dave

From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] x86_64/i386: Compute correct MTRR mask on early Noconas
Date: Thu, 13 Oct 2005 02:28:26 +0200
Cc: discuss@x86-64.org, Shaohua Li <shaohua.li@intel.com>, davej@redhat.com


Force correct address space size for MTRR on some 64bit Intel Xeons

They report 40bit, but only have 36bits of physical address space.
This caused problems with setting up the correct masks for MTRR,
resulting in incorrect MTRRs.

CPUID workaround for steppings 0F33h(supporting x86) and 0F34h(supporting x86
and EM64T). Detail info can be found at:
http://download.intel.com/design/Xeon/specupdt/30240216.pdf
http://download.intel.com/design/Pentium4/specupdt/30235221.pdf

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mtrr/main.c
+++ linux/arch/i386/kernel/cpu/mtrr/main.c
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
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -990,6 +990,11 @@ static void __cpuinit init_intel(struct 
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

