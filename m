Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265063AbUFHMI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUFHMI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUFHMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:08:56 -0400
Received: from ozlabs.org ([203.10.76.45]:11172 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265063AbUFHMIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:08:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16581.43839.311371.292742@cargo.ozlabs.ibm.com>
Date: Tue, 8 Jun 2004 22:04:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH][PPC64] Make paca xCurrent field be a pointer
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The paca struct contains a pointer to the current task, which is used
for the `current' macro.  For some reason, this field is a u64, and
every time we use it we need a cast, because it is really a pointer.
This patch cleans things up a little by making it a pointer to struct
task_struct and removing the casts.  It also removes a now-incorrect
comment which said that r13 contains current (it now holds
&paca[smp_processor_id()]).

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN prom-cleanup/arch/ppc64/kernel/smp.c g5-preempt/arch/ppc64/kernel/smp.c
--- prom-cleanup/arch/ppc64/kernel/smp.c	2004-06-08 21:32:23.139000880 +1000
+++ g5-preempt/arch/ppc64/kernel/smp.c	2004-06-08 14:52:06.000000000 +1000
@@ -390,8 +390,7 @@
 	}
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	((struct task_struct *)paca[lcpu].xCurrent)->thread_info->preempt_count
-		= 0;
+	paca[lcpu].xCurrent->thread_info->preempt_count	= 0;
 	/* Fixup SLB round-robin so next segment (kernel) goes in segment 0 */
 	paca[lcpu].xStab_data.next_round_robin = 0;
 
@@ -817,7 +816,7 @@
 	init_idle(p, cpu);
 	unhash_process(p);
 
-	paca[cpu].xCurrent = (u64)p;
+	paca[cpu].xCurrent = p;
 	current_set[cpu] = p->thread_info;
 }
 
@@ -869,7 +868,7 @@
 	/* cpu_possible is set up in prom.c */
 	cpu_set(boot_cpuid, cpu_online_map);
 
-	paca[boot_cpuid].xCurrent = (u64)current;
+	paca[boot_cpuid].xCurrent = current;
 	current_set[boot_cpuid] = current->thread_info;
 }
 
diff -urN prom-cleanup/include/asm-ppc64/current.h g5-preempt/include/asm-ppc64/current.h
--- prom-cleanup/include/asm-ppc64/current.h	2002-07-23 19:45:10.000000000 +1000
+++ g5-preempt/include/asm-ppc64/current.h	2004-06-08 14:49:53.000000000 +1000
@@ -8,13 +8,11 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
- *
- * Use r13 for current since the ppc64 ABI reserves it - Anton
  */
 
 #include <asm/thread_info.h>
 
-#define get_current()   ((struct task_struct *)(get_paca()->xCurrent))
+#define get_current()   (get_paca()->xCurrent)
 #define current         get_current()
 
 #endif /* !(_PPC64_CURRENT_H) */
diff -urN prom-cleanup/include/asm-ppc64/paca.h g5-preempt/include/asm-ppc64/paca.h
--- prom-cleanup/include/asm-ppc64/paca.h	2004-06-08 21:31:30.508879952 +1000
+++ g5-preempt/include/asm-ppc64/paca.h	2004-06-08 14:49:03.000000000 +1000
@@ -37,6 +37,8 @@
 register struct paca_struct *local_paca asm("r13");
 #define get_paca()	local_paca
 
+struct task_struct;
+
 /*============================================================================
  * Name_______:	paca
  *
@@ -59,7 +61,7 @@
  */
 	struct ItLpPaca *xLpPacaPtr;	/* Pointer to LpPaca for PLIC		0x00 */
 	struct ItLpRegSave *xLpRegSavePtr; /* Pointer to LpRegSave for PLIC	0x08 */
-	u64 xCurrent;  		        /* Pointer to current			0x10 */
+	struct task_struct *xCurrent;	/* Pointer to current			0x10 */
 	/* Note: the spinlock functions in arch/ppc64/lib/locks.c load lock_token and
 	   xPacaIndex with a single lwz instruction, using the constant offset 24.
 	   If you move either field, fix the spinlocks and rwlocks. */
