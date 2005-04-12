Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVDLTZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVDLTZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDLTXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:23:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:19401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262199AbVDLKcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:21 -0400
Message-Id: <200504121032.j3CAW4cW005498@shell0.pdx.osdl.net>
Subject: [patch 091/198] x86_64: Always use CPUID 80000008 to figure out MTRR address space size
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, davej@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

It doesn't make sense to only do this only for AMD K8.

This would support future CPUs with extended address spaces properly.

For i386 and x86-64

Cc: <davej@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/cpu/mtrr/main.c |   49 +++++++++----------------------
 1 files changed, 15 insertions(+), 34 deletions(-)

diff -puN arch/i386/kernel/cpu/mtrr/main.c~x86_64-always-use-cpuid-80000008-to-figure-out-mtrr arch/i386/kernel/cpu/mtrr/main.c
--- 25/arch/i386/kernel/cpu/mtrr/main.c~x86_64-always-use-cpuid-80000008-to-figure-out-mtrr	2005-04-12 03:21:24.863357096 -0700
+++ 25-akpm/arch/i386/kernel/cpu/mtrr/main.c	2005-04-12 03:21:24.867356488 -0700
@@ -614,40 +614,21 @@ static int __init mtrr_init(void)
 		mtrr_if = &generic_mtrr_ops;
 		size_or_mask = 0xff000000;	/* 36 bits */
 		size_and_mask = 0x00f00000;
-			
-		switch (boot_cpu_data.x86_vendor) {
-		case X86_VENDOR_AMD:
-			/* The original Athlon docs said that
-			   total addressable memory is 44 bits wide.
-			   It was not really clear whether its MTRRs
-			   follow this or not. (Read: 44 or 36 bits).
-			   However, "x86-64_overview.pdf" explicitly
-			   states that "previous implementations support
-			   36 bit MTRRs" and also provides a way to
-			   query the width (in bits) of the physical
-			   addressable memory on the Hammer family.
-			 */
-			if (boot_cpu_data.x86 == 15
-			    && (cpuid_eax(0x80000000) >= 0x80000008)) {
-				u32 phys_addr;
-				phys_addr = cpuid_eax(0x80000008) & 0xff;
-				size_or_mask =
-				    ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
-				size_and_mask = ~size_or_mask & 0xfff00000;
-			}
-			/* Athlon MTRRs use an Intel-compatible interface for 
-			 * getting and setting */
-			break;
-		case X86_VENDOR_CENTAUR:
-			if (boot_cpu_data.x86 == 6) {
-				/* VIA Cyrix family have Intel style MTRRs, but don't support PAE */
-				size_or_mask = 0xfff00000;	/* 32 bits */
-				size_and_mask = 0;
-			}
-			break;
-		
-		default:
-			break;
+
+		/* This is an AMD specific MSR, but we assume(hope?) that
+		   Intel will implement it to when they extend the address
+		   bus of the Xeon. */
+		if (cpuid_eax(0x80000000) >= 0x80000008) {
+			u32 phys_addr;
+			phys_addr = cpuid_eax(0x80000008) & 0xff;
+			size_or_mask = ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
+			size_and_mask = ~size_or_mask & 0xfff00000;
+		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
+			   boot_cpu_data.x86 == 6) {
+			/* VIA C* family have Intel style MTRRs, but
+			   don't support PAE */
+			size_or_mask = 0xfff00000;	/* 32 bits */
+			size_and_mask = 0;
 		}
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
_
