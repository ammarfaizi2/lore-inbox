Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWIYUPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWIYUPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWIYUPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:15:37 -0400
Received: from 17.sub-70-199-97.myvzw.com ([70.199.97.17]:54175 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751058AbWIYUPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:15:25 -0400
Message-Id: <20060925184639.059880975@goop.org>
References: <20060925184540.601971833@goop.org>
User-Agent: quilt/0.45-1
Date: Mon, 25 Sep 2006 11:45:45 -0700
From: jeremy@goop.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 5/6] Implement smp_processor_id() with the PDA.
Content-Disposition: inline; filename=pda/i386-pda-smp_processor_id.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the cpu_number in the PDA to implement raw_smp_processor_id.  This
is a little simpler than using thread_info, though the cpu field in
thread_info cannot be removed since it is used for things other than
getting the current CPU in common code.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    2 +-
 include/asm-i386/smp.h         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -r b1fc54fd576a arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Mon Sep 25 01:36:12 2006 -0700
+++ b/arch/i386/kernel/asm-offsets.c	Mon Sep 25 01:36:16 2006 -0700
@@ -52,7 +52,6 @@ void foo(void)
 	OFFSET(TI_exec_domain, thread_info, exec_domain);
 	OFFSET(TI_flags, thread_info, flags);
 	OFFSET(TI_status, thread_info, status);
-	OFFSET(TI_cpu, thread_info, cpu);
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
@@ -96,4 +95,5 @@ void foo(void)
 
 	BLANK();
 	OFFSET(PDA_pcurrent, i386_pda, pcurrent);
+	OFFSET(PDA_cpu, i386_pda, cpu_number);
 }
diff -r b1fc54fd576a include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Mon Sep 25 01:36:12 2006 -0700
+++ b/include/asm-i386/smp.h	Mon Sep 25 01:37:59 2006 -0700
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/pda.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -58,7 +59,7 @@ extern void cpu_uninit(void);
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (read_pda(cpu_number))
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
@@ -95,7 +96,6 @@ extern unsigned int num_processors;
 
 #define safe_smp_processor_id()		0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
-#define early_smp_processor_id()	0
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 

--

