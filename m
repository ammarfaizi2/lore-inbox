Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSHFNkK>; Tue, 6 Aug 2002 09:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319084AbSHFNkK>; Tue, 6 Aug 2002 09:40:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:18960 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S318917AbSHFNkJ>;
	Tue, 6 Aug 2002 09:40:09 -0400
Date: Tue, 6 Aug 2002 15:43:28 +0200
From: Willy TARREAU <willy@w.ods.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] APM fix for 2.4.20pre1
Message-ID: <20020806134328.GA587@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I resend you this patch against 2.4.19-rc5 which prevents my SMP box from
randomly crashing at boot during APM initialization. It still applies to
2.4.20-pre1. Alan included it in 19-ac4 too. Basically, it forces bios
calls to be made only from CPU0.

Please include it in 2.4.20-pre2.

Thanks,
Willy

PS: people using O(1) scheduler should not use this patch, but Alan's.

--- linux-2.4.19-rc5/arch/i386/kernel/apm.c	Thu Aug  1 22:07:39 2002
+++ linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c	Fri Aug  2 01:52:55 2002
@@ -862,14 +862,6 @@
 		apm_do_busy();
 }
 
-#ifdef CONFIG_SMP
-static int apm_magic(void * unused)
-{
-	while (1)
-		schedule();
-}
-#endif
-
 /**
  *	apm_power_off	-	ask the BIOS to power off
  *
@@ -897,10 +889,11 @@
 	 */
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	while (cpu_number_map(smp_processor_id()) != 0) {
-		kernel_thread(apm_magic, NULL,
-			CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
+	if (cpu_number_map(smp_processor_id()) != 0) {
+		current->cpus_allowed = 1;
 		schedule();
+		if (unlikely(cpu_number_map(smp_processor_id()) != 0))
+			BUG();
 	}
 #endif
 	if (apm_info.realmode_power_off)
@@ -1661,6 +1654,21 @@
 	strcpy(current->comm, "kapmd");
 	sigfillset(&current->blocked);
 
+#ifdef CONFIG_SMP
+	/* 2002/08/01 - WT
+	 * This is to avoid random crashes at boot time during initialization
+	 * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
+	 * Some bioses don't like being called from CPU != 0.
+	 * Method suggested by Ingo Molnar.
+	 */
+	if (cpu_number_map(smp_processor_id()) != 0) {
+		current->cpus_allowed = 1;
+		schedule();
+		if (unlikely(cpu_number_map(smp_processor_id()) != 0))
+			BUG();
+	}
+#endif
+	
 	if (apm_info.connection_version == 0) {
 		apm_info.connection_version = apm_info.bios.version;
 		if (apm_info.connection_version > 0x100) {
@@ -1707,7 +1715,7 @@
 		}
 	}
 
-	if (debug && (smp_num_cpus == 1)) {
+	if (debug) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");

