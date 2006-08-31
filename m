Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWHaNz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWHaNz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWHaNz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:55:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12681 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750817AbWHaNz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:55:57 -0400
Date: Thu, 31 Aug 2006 15:55:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: cpu_init is called during resume
Message-ID: <20060831135545.GM3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cpu_init() is called during resume, at time when GFP_KERNEL is not
available. This silences warning, and adds few small cleanups.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 0c23b1939d38a6bbdf1fd22078bd4fd3ec932c68
tree 66e19bcca9940e3cab2df78aaef010e51260cb9f
parent de9ee8a9c1e2cf18adee5d1569daa19deedc7c87
author <pavel@amd.ucw.cz> Thu, 31 Aug 2006 15:55:00 +0200
committer <pavel@amd.ucw.cz> Thu, 31 Aug 2006 15:55:00 +0200

 arch/i386/kernel/cpu/common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
index 70c87de..d0565d3 100644
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -591,10 +591,10 @@ void __init early_cpu_init(void)
 void __cpuinit cpu_init(void)
 {
 	int cpu = smp_processor_id();
-	struct tss_struct * t = &per_cpu(init_tss, cpu);
+	struct tss_struct *t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt;
-	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
+	u32 stk16_off = (u32)&per_cpu(cpu_16bit_stack, cpu);
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
@@ -629,7 +629,7 @@ void __cpuinit cpu_init(void)
 		/* alloc_bootmem_pages panics on failure, so no check */
 		memset(gdt, 0, PAGE_SIZE);
 	} else {
-		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
+		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);
 		if (unlikely(!gdt)) {
 			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
 			for (;;)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
