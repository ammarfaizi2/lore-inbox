Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbULFHVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbULFHVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 02:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbULFHVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 02:21:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:20162 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261322AbULFHUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 02:20:40 -0500
Date: Sun, 5 Dec 2004 23:20:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
Message-Id: <20041205232007.7edc4a78.akpm@osdl.org>
In-Reply-To: <20041206111634.44d6d29c.sfr@canb.auug.org.au>
References: <20041205004557.GA2028@us.ibm.com>
	<20041206111634.44d6d29c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > OK, I believe I found the other end of this:
>  > 
>  > static void __exit apm_exit(void)
>  > {
>  > 	int	error;
>  > 
>  > 	if (set_pm_idle) {
>  > 		pm_idle = original_pm_idle;
>  > 		/*
>  > 		 * We are about to unload the current idle thread pm callback
>  > 		 * (pm_idle), Wait for all processors to update cached/local
>  > 		 * copies of pm_idle before proceeding.
>  > 		 */
>  > 		synchronize_kernel();
>  > 	}
>  > 
>  > Unfortunately, the idle loop is a quiescent state, so it is
>  > possible for synchronize_kernel() to return before the idle threads
>  > have returned.  So I don't believe RCU is useful here.  One other
>  > approach would be to keep a cpu mask, in which apm_exit() sets all
>  > bits, and pm_idle() clears its CPU's bit only if it is set.
>  > Then apm_exit() could wait for all CPU's bits to clear.
>  > 
>  > There is probably a better way to do this, but that is what comes
>  > to mind immediately.
>  > 
>  > Thoughts?
> 
>  None, sorry :-)
> 
>  I don't even remember that piece of code going in (I certainly didn't
>  write it), though I can see what it was trying to do.

It came in via the below patch.  I guess we need to find a different way to
fix this problem.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/17 12:09:12-07:00 zwane@linuxpower.ca 
#   [PATCH] Close race with preempt and modular pm_idle callbacks
#   
#   The following patch from Shaohua Li fixes a race with preempt enabled when
#   a module containing a pm_idle callback is unloaded.  Cached values in local
#   variables need to be protected as RCU critical sections so that the
#   synchronize_kernel() call in the unload path waits for all processors.
#   There original bugzilla entry can be found at
#   
#   Shaohua, i had to make a small change (variable declaration after code in
#   code block) so that it compiles with geriatric compilers such as the ones
#   Andrew is attached to ;)
#   
#   http://bugzilla.kernel.org/show_bug.cgi?id=1716
#   
#   Signed-off-by: Li Shaohua <shaohua.li@intel.com>
#   Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# drivers/acpi/processor.c
#   2004/09/17 00:07:02-07:00 zwane@linuxpower.ca +5 -0
#   Close race with preempt and modular pm_idle callbacks
# 
# arch/x86_64/kernel/process.c
#   2004/09/17 00:07:02-07:00 zwane@linuxpower.ca +13 -4
#   Close race with preempt and modular pm_idle callbacks
# 
# arch/ia64/kernel/process.c
#   2004/09/17 00:07:02-07:00 zwane@linuxpower.ca +12 -4
#   Close race with preempt and modular pm_idle callbacks
# 
# arch/i386/kernel/process.c
#   2004/09/17 00:07:02-07:00 zwane@linuxpower.ca +9 -1
#   Close race with preempt and modular pm_idle callbacks
# 
# arch/i386/kernel/apm.c
#   2004/09/17 00:07:02-07:00 zwane@linuxpower.ca +8 -1
#   Close race with preempt and modular pm_idle callbacks
# 
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2004-12-05 23:18:08 -08:00
+++ b/arch/i386/kernel/apm.c	2004-12-05 23:18:08 -08:00
@@ -2362,8 +2362,15 @@
 {
 	int	error;
 
-	if (set_pm_idle)
+	if (set_pm_idle) {
 		pm_idle = original_pm_idle;
+		/*
+		 * We are about to unload the current idle thread pm callback
+		 * (pm_idle), Wait for all processors to update cached/local
+		 * copies of pm_idle before proceeding.
+		 */
+		synchronize_kernel();
+	}
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-12-05 23:18:08 -08:00
+++ b/arch/i386/kernel/process.c	2004-12-05 23:18:08 -08:00
@@ -142,13 +142,21 @@
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
+			void (*idle)(void);
+			/*
+			 * Mark this as an RCU critical section so that
+			 * synchronize_kernel() in the unload path waits
+			 * for our completion.
+			 */
+			rcu_read_lock();
+			idle = pm_idle;
 
 			if (!idle)
 				idle = default_idle;
 
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
+			rcu_read_unlock();
 		}
 		schedule();
 	}
diff -Nru a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
--- a/arch/ia64/kernel/process.c	2004-12-05 23:18:08 -08:00
+++ b/arch/ia64/kernel/process.c	2004-12-05 23:18:08 -08:00
@@ -228,18 +228,26 @@
 
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
-		if (!idle)
-			idle = default_idle;
-
 #ifdef CONFIG_SMP
 		if (!need_resched())
 			min_xtp();
 #endif
 		while (!need_resched()) {
+			void (*idle)(void);
+
 			if (mark_idle)
 				(*mark_idle)(1);
+			/*
+			 * Mark this as an RCU critical section so that
+			 * synchronize_kernel() in the unload path waits
+			 * for our completion.
+			 */
+			rcu_read_lock();
+			idle = pm_idle;
+			if (!idle)
+				idle = default_idle;
 			(*idle)();
+			rcu_read_unlock();
 		}
 
 		if (mark_idle)
diff -Nru a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c	2004-12-05 23:18:08 -08:00
+++ b/arch/x86_64/kernel/process.c	2004-12-05 23:18:08 -08:00
@@ -130,11 +130,20 @@
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
-		if (!idle)
-			idle = default_idle;
-		while (!need_resched())
+		while (!need_resched()) {
+			void (*idle)(void);
+			/*
+			 * Mark this as an RCU critical section so that
+			 * synchronize_kernel() in the unload path waits
+			 * for our completion.
+			 */
+			rcu_read_lock();
+			idle = pm_idle;
+			if (!idle)
+				idle = default_idle;
 			idle();
+			rcu_read_unlock();
+		}
 		schedule();
 	}
 }
diff -Nru a/drivers/acpi/processor.c b/drivers/acpi/processor.c
--- a/drivers/acpi/processor.c	2004-12-05 23:18:08 -08:00
+++ b/drivers/acpi/processor.c	2004-12-05 23:18:08 -08:00
@@ -2419,6 +2419,11 @@
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id == 0) {
 		pm_idle = pm_idle_save;
+		/*
+		 * We are about to unload the current idle thread pm callback
+		 * (pm_idle), Wait for all processors to update cached/local
+		 * copies of pm_idle before proceeding.
+		 */
 		synchronize_kernel();
 	}
 

