Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758405AbWK3HBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbWK3HBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758406AbWK3HBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:01:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758397AbWK3HBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:01:53 -0500
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
From: Ingo Molnar <mingo@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
In-Reply-To: <20061129174558.3dfd13df.akpm@osdl.org>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
	 <20061129174558.3dfd13df.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 08:00:00 +0100
Message-Id: <1164870000.11036.23.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 17:45 -0800, Andrew Morton wrote:
> No, I think this patch is right - the declaration of the CONFIG_SMP
> smp_call_function_single() is in linux/smp.h so the !CONFIG_SMP
> declaration
> or definition should be there too.
> 
> It's still buggy though.  It should disable local interrupts around
> the
> call to match the SMP version.  I'll fix that separately. 

hm, didnt i send an updated patch for that already? See the patch below,
from many days ago. I sent it after the tsc-sync-rewrite patch.

	Ingo

--------------->
Subject: x86_64: build fixes
From: Ingo Molnar <mingo@elte.hu>

x86_64 does not build cleanly on UP:

arch/x86_64/kernel/vsyscall.c: In function 'cpu_vsyscall_notifier':
arch/x86_64/kernel/vsyscall.c:282: warning: implicit declaration of
function 'smp_call_function_single'
arch/x86_64/kernel/vsyscall.c: At top level:
arch/x86_64/kernel/vsyscall.c:279: warning: 'cpu_vsyscall_notifier'
defined but not used

this patch fixes it by making smp_call_function_single() globally
available.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-x86_64/smp.h |   11 ++---------
 include/linux/smp.h      |   10 +++++++---
 kernel/sched.c           |   19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h
+++ linux/include/asm-x86_64/smp.h
@@ -115,16 +115,9 @@ static __inline int logical_smp_processo
 }
 
 #ifdef CONFIG_SMP
-#define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
+# define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
 #else
-#define cpu_physical_id(cpu)		boot_cpu_id
-static inline int smp_call_function_single(int cpuid, void (*func)
(void *info),
-				void *info, int retry, int wait)
-{
-	/* Disable interrupts here? */
-	func(info);
-	return 0;
-}
+# define cpu_physical_id(cpu)		boot_cpu_id
 #endif /* !CONFIG_SMP */
 #endif
 
Index: linux/include/linux/smp.h
===================================================================
--- linux.orig/include/linux/smp.h
+++ linux/include/linux/smp.h
@@ -53,9 +53,6 @@ extern void smp_cpus_done(unsigned int m
  */
 int smp_call_function(void(*func)(void *info), void *info, int retry,
int wait);
 
-int smp_call_function_single(int cpuid, void (*func) (void *info), void
*info,
-				int retry, int wait);
-
 /*
  * Call a function on all processors
  */
@@ -103,6 +100,13 @@ static inline void smp_send_reschedule(i
 #endif /* !SMP */
 
 /*
+ * Call a function on a specific CPU (on UP the function gets executed
+ * on the current CPU, immediately):
+ */
+int smp_call_function_single(int cpuid, void (*func) (void *info), void
*info,
+			     int retry, int wait);
+
+/*
  * smp_processor_id(): get the current CPU ID.
  *
  * if DEBUG_PREEMPT is enabled the we check whether it is
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1110,6 +1110,25 @@ repeat:
 	task_rq_unlock(rq, &flags);
 }
 
+#ifndef CONFIG_SMP
+/*
+ * Call a function on a specific CPU (on UP the function gets executed
+ * on the current CPU, immediately):
+ */
+int smp_call_function_single(int cpuid, void (*func) (void *info), void
*info,
+			     int retry, int wait)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	func(info);
+	local_irq_restore(flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(smp_call_function_single);
+#endif
+
 /***
  * kick_process - kick a running thread to enter/exit the kernel
  * @p: the to-be-kicked thread


