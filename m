Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUIIMDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUIIMDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUIIMCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:02:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37108 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263448AbUIIMCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:02:22 -0400
Date: Thu, 9 Sep 2004 08:06:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       BlaisorBlade <blaisorblade_spam@yahoo.it>,
       acpi-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: [PATCH] Close race with preempt and modular pm_idle callbacks
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575168C7A@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.53.0409090743530.15087@montezuma.fsmlabs.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575168C7A@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch from Shaohua Li fixes a race with preempt enabled when 
a module containing a pm_idle callback is unloaded. Cached values in local 
variables need to be protected as RCU critical sections so that the 
synchronize_kernel() call in the unload path waits for all processors. 
There original bugzilla entry can be found at

Shaohua, i had to make a small change (variable declaration after 
code in code block) so that it compiles with geriatric compilers such as 
the ones Andrew is attached to ;)

http://bugzilla.kernel.org/show_bug.cgi?id=1716

 arch/i386/kernel/apm.c       |    9 ++++++++-
 arch/i386/kernel/process.c   |   10 +++++++++-
 arch/ia64/kernel/process.c   |   16 ++++++++++++----
 arch/x86_64/kernel/process.c |   17 +++++++++++++----
 drivers/acpi/processor.c     |    5 +++++
 5 files changed, 47 insertions(+), 10 deletions(-)

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.9-rc1-mm4/drivers/acpi/processor.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/drivers/acpi/processor.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.c
--- linux-2.6.9-rc1-mm4/drivers/acpi/processor.c	7 Sep 2004 11:52:02 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4/drivers/acpi/processor.c	9 Sep 2004 11:55:03 -0000
@@ -2424,6 +2424,11 @@ acpi_processor_remove (
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
 
Index: linux-2.6.9-rc1-mm4/arch/i386/kernel/apm.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/arch/i386/kernel/apm.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apm.c
--- linux-2.6.9-rc1-mm4/arch/i386/kernel/apm.c	7 Sep 2004 11:51:59 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4/arch/i386/kernel/apm.c	9 Sep 2004 11:55:03 -0000
@@ -2362,8 +2362,15 @@ static void __exit apm_exit(void)
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
Index: linux-2.6.9-rc1-mm4/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.9-rc1-mm4/arch/i386/kernel/process.c	7 Sep 2004 11:51:59 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4/arch/i386/kernel/process.c	9 Sep 2004 12:00:44 -0000
@@ -175,7 +175,14 @@ void cpu_idle (void)
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
@@ -184,6 +191,7 @@ void cpu_idle (void)
 				play_dead();
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
+			rcu_read_unlock();
 		}
 		schedule();
 	}
Index: linux-2.6.9-rc1-mm4/arch/ia64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/arch/ia64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.9-rc1-mm4/arch/ia64/kernel/process.c	7 Sep 2004 11:51:59 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4/arch/ia64/kernel/process.c	9 Sep 2004 11:58:21 -0000
@@ -228,18 +228,26 @@ cpu_idle (void *unused)
 
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
Index: linux-2.6.9-rc1-mm4/arch/x86_64/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/arch/x86_64/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.9-rc1-mm4/arch/x86_64/kernel/process.c	7 Sep 2004 11:52:00 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4/arch/x86_64/kernel/process.c	9 Sep 2004 11:55:03 -0000
@@ -131,11 +131,20 @@ void cpu_idle (void)
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
