Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVG3EIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVG3EIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVG3EG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:06:58 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:47373 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262870AbVG3EGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:06:45 -0400
Date: Fri, 29 Jul 2005 21:04:16 -0700
From: zach@vmware.com
Message-Id: <200507300404.j6U44Gkb005933@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 5/6 i386 non-reversible-fs-gs
X-OriginalArrivalTime: 30 Jul 2005 04:05:16.0421 (UTC) FILETIME=[E48DA350:01C594BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subtle fix:  load_TLS has been moved after saving %fs and %gs segments to
avoid creating non-reversible segments.  This could conceivably cause a bug
if the kernel ever needed to save and restore fs/gs from the NMI handler.
It currently does not, but this is the safest approach to avoiding fs/gs
corruption.  SMIs are safe, since SMI saves the descriptor hidden state.

Diffs against: patch-2.6.13-rc4 + cpu-inline-cleanup + dt-inline-cleanup

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-07-29 11:17:02.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-07-29 11:50:19.000000000 -0700
@@ -678,21 +678,26 @@
 	__unlazy_fpu(prev_p);
 
 	/*
-	 * Reload esp0, LDT and the page table pointer:
+	 * Reload esp0.
 	 */
 	load_esp0(tss, next);
 
 	/*
-	 * Load the per-thread Thread-Local Storage descriptor.
+	 * Save away %fs and %gs. No need to save %es and %ds, as
+	 * those are always kernel segments while inside the kernel.
+	 * Doing this before setting the new TLS descriptors avoids
+	 * the situation where we temporarily have non-reloadable
+	 * segments in %fs and %gs.  This could be an issue if the
+	 * NMI handler ever used %fs or %gs (it does not today), or
+	 * if the kernel is running inside of a hypervisor layer.
 	 */
-	load_TLS(next, cpu);
+	savesegment(fs, prev->fs);
+	savesegment(gs, prev->gs);
 
 	/*
-	 * Save away %fs and %gs. No need to save %es and %ds, as
-	 * those are always kernel segments while inside the kernel.
+	 * Load the per-thread Thread-Local Storage descriptor.
 	 */
-	asm volatile("mov %%fs,%0":"=m" (prev->fs));
-	asm volatile("mov %%gs,%0":"=m" (prev->gs));
+	load_TLS(next, cpu);
 
 	/*
 	 * Restore %fs and %gs if needed.
