Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUKDWEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUKDWEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbUKDWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:02:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19653 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262446AbUKDVzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:55:43 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: contention on profile_lock
Date: Thu, 4 Nov 2004 13:55:27 -0800
User-Agent: KMail/1.7
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       edwardsg@sgi.com, dipankar@in.ibm.com, levon@movementarian.org
References: <200411021152.16038.jbarnes@engr.sgi.com> <20041104201257.GA14786@holomorphy.com> <200411041249.21718.jbarnes@engr.sgi.com>
In-Reply-To: <200411041249.21718.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PVqiBv6S+eG5gdA"
Message-Id: <200411041355.27228.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PVqiBv6S+eG5gdA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, November 4, 2004 12:49 pm, Jesse Barnes wrote:
> John pointed out that this breaks modules.  Would registering and
> unregistering a function pointer thus be module safe?  Dipankar, hopefully
> you have something better?
>
> static int timer_start(void)
> {
>  /* Setup the callback pointer */
>  oprofile_timer_notify = oprofile_timer;
>  return 0;
> }
>
>
> static void timer_stop(void)
> {
>  /* Tear down the callback pointer after sync_kernel */
>  synchronize_kernel();
>  oprofile_timer_notify = NULL;
> }

Ok, here's another one that uses this approach.  Hopefully it satisfies all 
parties?  (Compile tested only so far.)

Thanks,
Jesse

--Boundary-00=_PVqiBv6S+eG5gdA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="remove-profile-notifier-list-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove-profile-notifier-list-3.patch"

===== drivers/oprofile/timer_int.c 1.8 vs edited =====
--- 1.8/drivers/oprofile/timer_int.c	2004-09-03 16:55:27 -07:00
+++ edited/drivers/oprofile/timer_int.c	2004-11-04 13:54:13 -08:00
@@ -13,33 +13,31 @@
 #include <linux/oprofile.h>
 #include <linux/profile.h>
 #include <linux/init.h>
+#include <linux/rcupdate.h>
 #include <asm/ptrace.h>
  
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
+static int timer_notify(struct pt_regs *regs)
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
+	/* Setup the callback pointer */
+	oprofile_timer_notify = timer_notify;
+	return 0;
 }
 
 
 static void timer_stop(void)
 {
-	unregister_profile_notifier(&timer_notifier);
+	/* Tear down the callback pointer after sync_kernel */
+	synchronize_kernel();
+	oprofile_timer_notify = NULL;
 }
 
 
===== include/linux/oprofile.h 1.10 vs edited =====
--- 1.10/include/linux/oprofile.h	2004-06-24 01:56:02 -07:00
+++ edited/include/linux/oprofile.h	2004-11-04 13:54:04 -08:00
@@ -105,5 +105,8 @@
 
 /** lock for read/write safety */
 extern spinlock_t oprofilefs_lock;
+
+/* Timer based profiling hook */
+extern int (*oprofile_timer_notify)(struct pt_regs *);
  
 #endif /* OPROFILE_H */
===== kernel/profile.c 1.14 vs edited =====
--- 1.14/kernel/profile.c	2004-10-19 02:40:31 -07:00
+++ edited/kernel/profile.c	2004-11-04 13:50:36 -08:00
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/profile.h>
+#include <linux/oprofile.h>
 #include <linux/highmem.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
@@ -34,6 +35,9 @@
 #define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
+/* Oprofile timer tick hook */
+int (*oprofile_timer_notify)(struct pt_regs *);
+
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on;
@@ -168,38 +172,6 @@
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
 
@@ -394,8 +366,8 @@
 
 void profile_tick(int type, struct pt_regs *regs)
 {
-	if (type == CPU_PROFILING)
-		profile_hook(regs);
+	if (type == CPU_PROFILING && oprofile_timer_notify)
+		oprofile_timer_notify(regs);
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }

--Boundary-00=_PVqiBv6S+eG5gdA--
