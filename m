Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVK3EYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVK3EYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVK3EYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:24:39 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27624 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750940AbVK3EYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:24:35 -0500
Date: Tue, 29 Nov 2005 23:21:48 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] x86-64 fix smp boot failure with thread_info change
Message-ID: <20051130042148.GF19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that stack_smp_processor_id() gets set for all CPUs regardless of 
which path we take in do_boot_cpu(), as well as in upcoming case where 
tsk->thread_info != task_thread_info(tsk).

Add a memory barrier to ensure this change is flushed before the other
CPU comes up.  My P4/HT machine was occasionally randomly failing to boot
without this barrier.

---

 arch/x86_64/kernel/smpboot.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

applies-to: ff25c960b7af25819aba4fbecbd94bd3500a3a4a
932262b117ba1c3a77078b64674e1a1823c169df
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index 50d018a..10b951b 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -780,6 +780,9 @@ do_rest:
 
 	cpu_pda[cpu].pcurrent = c_idle.idle;
 
+	/* set the CPU for stack_smp_processor_id() */
+	c_idle.idle->thread_info->cpu = cpu;
+
 	start_rip = setup_trampoline();
 
 	init_rsp = c_idle.idle->thread.rsp;
@@ -796,6 +799,7 @@ do_rest:
 	 * the targeted processor.
 	 */
 
+	mb();
 	atomic_set(&init_deasserted, 0);
 
 	Dprintk("Setting warm reset code and vector.\n");
---
0.99.9.GIT
