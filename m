Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTFPO6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTFPO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:58:19 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:47551 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263944AbTFPO6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:58:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.56898.422086.822671@gargle.gargle.HOWL>
Date: Mon, 16 Jun 2003 17:12:02 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.71] fix x86-64 nmi.c oops on Simics
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

In 2.5, x86-64's nmi.c will semi-enable the local APIC NMI watchdog
on Simics, which leads to a kernel oops if disable_lapic_nmi_watchdog()
is called. The reason is:

1. setup_apic_nmi_watchdog() calls setup_k7_watchdog() for incorrect
   CPU models. Simics is model 8 while we should only allow models 6
   and 15 (well, 6 can't occur).
2. setup_k7_watchdog() initialises nmi_watchdog_msr [which tells others
   that we're enabled], and then tries to wrmsr() the MSRs. This fails
   in Simics with a #GP, you catch the failure and bail out.
3. on return to setup_apic_nmi_watchdog(), the failure goes unnoticed
   and nmi_active is set to 1.
4. Later someone calls disable_lapic_nmi_watchdog(), which, since
   nmi_active == 1, goes ahead and wrmsr()s EVNTSEL0. Bang!

The patch below forces setup_apic_nmi_watchdog() to bail out on unknown
models, so we never get into this half-initialised situation on Simics.
This also merges the code with what's in i386's nmi.c.

With this in place you could remove the error-checking wrmsr()s, but
I didn't bother with that at this time.

/Mikael

diff -ruN linux-2.5.71-andi/arch/x86_64/kernel/nmi.c linux-2.5.71-mikpe/arch/x86_64/kernel/nmi.c
--- linux-2.5.71-andi/arch/x86_64/kernel/nmi.c	2003-06-16 16:08:35.000000000 +0200
+++ linux-2.5.71-mikpe/arch/x86_64/kernel/nmi.c	2003-06-16 16:20:29.000000000 +0200
@@ -233,7 +236,7 @@
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 < 6)
+		if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
 			return;
 		setup_k7_watchdog();
 		break;
