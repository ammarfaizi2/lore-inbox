Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbUDBB0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUDBB0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:26:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:51863 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263507AbUDBB0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:26:38 -0500
Date: Thu, 1 Apr 2004 19:26:14 -0600 (CST)
From: Olof Johansson <olof@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: manfred@colorfullife.com, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <anton@samba.org>
Subject: Re: Oops in get_boot_pages at reboot
In-Reply-To: <20040401105553.38468a64.akpm@osdl.org>
Message-ID: <Pine.A41.4.44.0404011847370.26954-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Andrew Morton wrote:

> Do we really need to clear system_running at reboot?  I'd always viewed it
> as "everything is initialised and usable", and that's generally true at
> reboot time.

Seems like it was added explicitly to avoid user mode helpers from being
invoked during early boot and shutdown/reboot:

http://linux.bkbits.net:8080/linux-2.5/cset@3d5c548dNM0Kqg9aP03NhtxXmntmKQ

Well, how about making system_running a state instead of a flag, and
defining states SYSTEM_BOOTING/RUNNING/SHUTDOWN?  See patch below.


-Olof


Olof Johansson                                        Office: 4F005/905
Linux on Power Development                            IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM


===== arch/ppc/platforms/pmac_nvram.c 1.12 vs edited =====
--- 1.12/arch/ppc/platforms/pmac_nvram.c	Wed Feb  4 23:20:40 2004
+++ edited/arch/ppc/platforms/pmac_nvram.c	Thu Apr  1 19:13:02 2004
@@ -154,11 +154,11 @@
 	struct adb_request req;
 	DECLARE_COMPLETION(req_complete);

-	req.arg = system_running ? &req_complete : NULL;
+	req.arg = system_running == SYSTEM_RUNNING ? &req_complete : NULL;
 	if (pmu_request(&req, pmu_nvram_complete, 3, PMU_READ_NVRAM,
 			(addr >> 8) & 0xff, addr & 0xff))
 		return 0xff;
-	if (system_running)
+	if (system_running == SYSTEM_RUNNING)
 		wait_for_completion(&req_complete);
 	while (!req.complete)
 		pmu_poll();
@@ -170,11 +170,11 @@
 	struct adb_request req;
 	DECLARE_COMPLETION(req_complete);

-	req.arg = system_running ? &req_complete : NULL;
+	req.arg = system_running == SYSTEM_RUNNING ? &req_complete : NULL;
 	if (pmu_request(&req, pmu_nvram_complete, 4, PMU_WRITE_NVRAM,
 			(addr >> 8) & 0xff, addr & 0xff, val))
 		return;
-	if (system_running)
+	if (system_running == SYSTEM_RUNNING)
 		wait_for_completion(&req_complete);
 	while (!req.complete)
 		pmu_poll();
===== include/linux/kernel.h 1.47 vs edited =====
--- 1.47/include/linux/kernel.h	Wed Mar 10 10:45:49 2004
+++ edited/include/linux/kernel.h	Thu Apr  1 19:11:16 2004
@@ -109,9 +109,15 @@
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
-extern int system_running;
+extern int system_running;		/* See values below */
 extern int tainted;
 extern const char *print_tainted(void);
+
+/* Values used for system_running */
+#define SYSTEM_BOOTING 0
+#define SYSTEM_RUNNING 1
+#define SYSTEM_SHUTDOWN 2
+
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
===== init/main.c 1.127 vs edited =====
--- 1.127/init/main.c	Tue Mar 16 04:10:35 2004
+++ edited/init/main.c	Thu Apr  1 19:11:17 2004
@@ -613,7 +613,7 @@
 	 */
 	free_initmem();
 	unlock_kernel();
-	system_running = 1;
+	system_running = SYSTEM_RUNNING;

 	if (sys_open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
===== kernel/kmod.c 1.36 vs edited =====
--- 1.36/kernel/kmod.c	Wed Feb 25 04:31:13 2004
+++ edited/kernel/kmod.c	Thu Apr  1 19:11:17 2004
@@ -249,7 +249,7 @@
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);

-	if (!system_running)
+	if (system_running != SYSTEM_RUNNING)
 		return -EBUSY;

 	if (path[0] == '\0')
===== kernel/printk.c 1.35 vs edited =====
--- 1.35/kernel/printk.c	Mon Mar  8 18:57:46 2004
+++ edited/kernel/printk.c	Thu Apr  1 19:11:17 2004
@@ -522,7 +522,8 @@
 			log_level_unknown = 1;
 	}

-	if (!cpu_online(smp_processor_id()) && !system_running) {
+	if (!cpu_online(smp_processor_id()) &&
+	    system_running != SYSTEM_RUNNING) {
 		/*
 		 * Some console drivers may assume that per-cpu resources have
 		 * been allocated.  So don't allow them to be called by this
===== kernel/sched.c 1.255 vs edited =====
--- 1.255/kernel/sched.c	Thu Mar 18 22:54:57 2004
+++ edited/kernel/sched.c	Thu Apr  1 19:11:17 2004
@@ -2982,7 +2982,8 @@
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */

-	if ((in_atomic() || irqs_disabled()) && system_running) {
+	if ((in_atomic() || irqs_disabled()) &&
+	    system_running == SYSTEM_RUNNING) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
===== kernel/sys.c 1.73 vs edited =====
--- 1.73/kernel/sys.c	Mon Feb 23 13:46:54 2004
+++ edited/kernel/sys.c	Thu Apr  1 19:11:17 2004
@@ -436,7 +436,7 @@
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_running = 0;
+		system_running = SYSTEM_SHUTDOWN;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
@@ -452,7 +452,7 @@

 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
-		system_running = 0;
+		system_running = SYSTEM_SHUTDOWN;
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -462,7 +462,7 @@

 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
-		system_running = 0;
+		system_running = SYSTEM_SHUTDOWN;
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -478,7 +478,7 @@
 		buffer[sizeof(buffer) - 1] = '\0';

 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
-		system_running = 0;
+		system_running = SYSTEM_SHUTDOWN;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
===== mm/page_alloc.c 1.197 vs edited =====
--- 1.197/mm/page_alloc.c	Tue Mar 16 20:10:10 2004
+++ edited/mm/page_alloc.c	Thu Apr  1 19:11:18 2004
@@ -734,7 +734,7 @@
 	struct page * page;

 #ifdef CONFIG_NUMA
-	if (unlikely(!system_running))
+	if (unlikely(system_running == SYSTEM_BOOTING))
 		return get_boot_pages(gfp_mask, order);
 #endif
 	page = alloc_pages(gfp_mask, order);

