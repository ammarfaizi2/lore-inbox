Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbUKDUCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUKDUCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUKDT7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:59:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40329 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262396AbUKDT41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:56:27 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jack Steiner <steiner@sgi.com>
Subject: Re: contention on profile_lock
Date: Thu, 4 Nov 2004 11:56:23 -0800
User-Agent: KMail/1.7
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, edwardsg@sgi.com
References: <200411021152.16038.jbarnes@engr.sgi.com> <20041102200222.GA5135@sgi.com> <200411021342.36918.jbarnes@engr.sgi.com>
In-Reply-To: <200411021342.36918.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nloiBWFFYFcRSzy"
Message-Id: <200411041156.23559.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_nloiBWFFYFcRSzy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, November 2, 2004 1:42 pm, Jesse Barnes wrote:
> Agreed.  Dipankar already suggested RCUifying the notifier list, but
> another option would be to simply check to see if oprofile timer based
> profiling is enabled since it seems to be the only user.  That would turn a
> lock into a read-mostly variable at least.

..but since I haven't heard from Dipankar, here's a patch that removes the 
profile_hook notifier list altogether in favor of a simple flag that controls 
whether or not to call the oprofile timer routine directly.  Does it look ok?

Thanks,
Jesse


--Boundary-00=_nloiBWFFYFcRSzy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="remove-profile-notifier-list-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove-profile-notifier-list-2.patch"

===== drivers/oprofile/timer_int.c 1.8 vs edited =====
--- 1.8/drivers/oprofile/timer_int.c	2004-09-03 16:55:27 -07:00
+++ edited/drivers/oprofile/timer_int.c	2004-11-04 11:53:42 -08:00
@@ -14,32 +14,29 @@
 #include <linux/profile.h>
 #include <linux/init.h>
 #include <asm/ptrace.h>
+
+int oprofile_timer;
  
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
+int oprofile_timer_notify(struct pt_regs *regs)
 {
-	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
 	unsigned long eip = profile_pc(regs);
  
 	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
 	return 0;
 }
- 
- 
-static struct notifier_block timer_notifier = {
-	.notifier_call	= timer_notify,
-};
- 
 
 static int timer_start(void)
 {
-	return register_profile_notifier(&timer_notifier);
+	oprofile_timer = 1;
+	return 0;
 }
 
 
 static void timer_stop(void)
 {
-	unregister_profile_notifier(&timer_notifier);
+	oprofile_timer = 0;
+	wmb();
 }
 
 
===== include/linux/oprofile.h 1.10 vs edited =====
--- 1.10/include/linux/oprofile.h	2004-06-24 01:56:02 -07:00
+++ edited/include/linux/oprofile.h	2004-11-04 11:06:29 -08:00
@@ -13,6 +13,7 @@
 #ifndef OPROFILE_H
 #define OPROFILE_H
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
@@ -105,5 +106,14 @@
 
 /** lock for read/write safety */
 extern spinlock_t oprofilefs_lock;
+
+#ifdef CONFIG_OPROFILE
+extern int oprofile_timer; /* bool for the oprofile timer */
+extern int oprofile_timer_notify(struct pt_regs *);
+#else
+#define oprofile_timer 0
+static inline int oprofile_timer_notify(struct pt_regs *) { return 0; }
+#endif
+
  
 #endif /* OPROFILE_H */
===== kernel/profile.c 1.14 vs edited =====
--- 1.14/kernel/profile.c	2004-10-19 02:40:31 -07:00
+++ edited/kernel/profile.c	2004-11-04 11:10:10 -08:00
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/profile.h>
+#include <linux/oprofile.h>
 #include <linux/highmem.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
@@ -168,38 +169,6 @@
 	return err;
 }
 
-static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
- 
-int register_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-int unregister_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-void profile_hook(struct pt_regs * regs)
-{
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
-}
-
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
 EXPORT_SYMBOL_GPL(task_handoff_register);
 EXPORT_SYMBOL_GPL(task_handoff_unregister);
 
@@ -394,8 +363,8 @@
 
 void profile_tick(int type, struct pt_regs *regs)
 {
-	if (type == CPU_PROFILING)
-		profile_hook(regs);
+	if (type == CPU_PROFILING && oprofile_timer)
+		oprofile_timer_notify(regs);
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }

--Boundary-00=_nloiBWFFYFcRSzy--
