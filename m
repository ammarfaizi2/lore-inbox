Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVAONqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVAONqE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVAONop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:44:45 -0500
Received: from aun.it.uu.se ([130.238.12.36]:34966 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262283AbVAONoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:44:11 -0500
Date: Sat, 15 Jan 2005 14:43:56 +0100 (MET)
Message-Id: <200501151343.j0FDhu9Z007668@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: 2.6.11-rc1: local_irq_disable() in main.c:rest_init() hangs ADB driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11-rc1 causes the powermac ADB driver, which controls
the keyboard and mouse on pre-USB powermacs, to hang during
bootup. The last kernel message seen is:

adb: starting probe task...

and then the machine hangs hard. 2.6.10 did not have this problem.

The problem appears to be caused by the local_irq_disable()
added to init/main.c:rest_init() in 2.6.10-bk12:

--- a/init/main.c	2005-01-11 20:02:35 -08:00
+++ b/init/main.c	2005-01-11 20:02:35 -08:00
@@ -445,6 +373,12 @@
 {
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
+	/*
+	 * Re-enable preemption but disable interrupts to make sure
+	 * we dont get preempted until we schedule() in cpu_idle().
+	 */
+	local_irq_disable();
+	preempt_enable_no_resched();
 	unlock_kernel();
  	cpu_idle();
 } 

Commenting out that local_irq_disable() makes the machine
boot Ok again.

The machine is a Beige G3, SMP=n, PREEMPT=n, ADB=y, ADB_CUDA=y.

/Mikael
