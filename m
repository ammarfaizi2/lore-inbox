Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbTGIKg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbTGIKg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:36:59 -0400
Received: from ns.suse.de ([213.95.15.193]:47882 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265931AbTGIKej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:34:39 -0400
Date: Wed, 9 Jul 2003 12:49:15 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Readd BUG for SMP TLB IPI
Message-Id: <20030709124915.3d98054b.ak@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Readd the BUG for an spurious SMP TLB IPI.

Rationale: 

The condition is fatal and it's better to have a BUG than a hang.
The goto out code forgets to ack the IPI in the APIC. When the IPI would really arrive
at the wrong CPU it would immediately deadlock because the non-Acked IPI is retriggered.
Adding an ACK for this path is also no good, because then the SMP flusher would
need to detect this case and "retransmit" the IPI, otherwise it would hang too
in the loop waiting for other CPUs. But nobody has ever seen such a hang, so it's safe
to assume that all hardware guarantees it cannot happen.

-Andi

--- linux-2.5-amd64/arch/i386/kernel/smp.c~	2003-07-09 12:42:36.000000000 +0200
+++ linux-2.5-amd64/arch/i386/kernel/smp.c	2003-07-09 12:42:36.000000000 +0200
@@ -312,15 +312,7 @@
 	cpu = get_cpu();
 
 	if (!test_bit(cpu, &flush_cpumask))
-		goto out;
-		/* 
-		 * This was a BUG() but until someone can quote me the
-		 * line from the intel manual that guarantees an IPI to
-		 * multiple CPUs is retried _only_ on the erroring CPUs
-		 * its staying as a return
-		 *
-		 * BUG();
-		 */
+		BUG();
 		 
 	if (flush_mm == cpu_tlbstate[cpu].active_mm) {
 		if (cpu_tlbstate[cpu].state == TLBSTATE_OK) {
