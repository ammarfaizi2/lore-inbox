Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUEKFS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUEKFS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 01:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUEKFS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 01:18:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:5336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbUEKFR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 01:17:59 -0400
Date: Mon, 10 May 2004 22:17:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, rene.herman@keyaccess.nl,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040510221729.3b8e93da.akpm@osdl.org>
In-Reply-To: <20040510215626.6a5552f2.akpm@osdl.org>
References: <409F4944.4090501@keyaccess.nl>
	<200405102125.51947.bzolnier@elka.pw.edu.pl>
	<409FF068.30902@keyaccess.nl>
	<200405102352.24091.bzolnier@elka.pw.edu.pl>
	<20040510215626.6a5552f2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> It's a bit grubby, but we could easily add a fourth state to
>  `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and SYSTEM_HALT. 
>  That would be a quite simple change.

Like this.  I checked all the SYSTEM_FOO users and none of them seem to
care about the shutdown state at present.  Easy.



 25-akpm/include/linux/kernel.h |   11 +++++++----
 25-akpm/init/main.c            |    3 ++-
 25-akpm/kernel/sys.c           |    8 ++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff -puN include/linux/kernel.h~system-state-splitup include/linux/kernel.h
--- 25/include/linux/kernel.h~system-state-splitup	2004-05-10 22:05:15.127191856 -0700
+++ 25-akpm/include/linux/kernel.h	2004-05-10 22:05:15.133190944 -0700
@@ -109,14 +109,17 @@ static inline void console_verbose(void)
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
-extern int system_state;		/* See values below */
 extern int tainted;
 extern const char *print_tainted(void);
 
 /* Values used for system_state */
-#define SYSTEM_BOOTING 0
-#define SYSTEM_RUNNING 1
-#define SYSTEM_SHUTDOWN 2
+extern enum system_states {
+	SYSTEM_BOOTING,
+	SYSTEM_RUNNING,
+	SYSTEM_HALT,
+	SYSTEM_POWER_OFF,
+	SYSTEM_RESTART,
+} system_state;
 
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
diff -puN init/main.c~system-state-splitup init/main.c
--- 25/init/main.c~system-state-splitup	2004-05-10 22:05:15.128191704 -0700
+++ 25-akpm/init/main.c	2004-05-10 22:05:15.135190640 -0700
@@ -95,7 +95,8 @@ extern void prepare_namespace(void);
 extern void tc_init(void);
 #endif
 
-int system_state;	/* SYSTEM_BOOTING/RUNNING/SHUTDOWN */
+enum system_states system_state;
+EXPORT_SYMBOL(system_state);
 
 /*
  * Boot command-line arguments
diff -puN kernel/sys.c~system-state-splitup kernel/sys.c
--- 25/kernel/sys.c~system-state-splitup	2004-05-10 22:05:15.130191400 -0700
+++ 25-akpm/kernel/sys.c	2004-05-10 22:05:15.135190640 -0700
@@ -451,7 +451,7 @@ asmlinkage long sys_reboot(int magic1, i
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
@@ -467,7 +467,7 @@ asmlinkage long sys_reboot(int magic1, i
 
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_HALT;
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -477,7 +477,7 @@ asmlinkage long sys_reboot(int magic1, i
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_POWER_OFF;
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -493,7 +493,7 @@ asmlinkage long sys_reboot(int magic1, i
 		buffer[sizeof(buffer) - 1] = '\0';
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
-		system_state = SYSTEM_SHUTDOWN;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);

_

