Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVAJFpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVAJFpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVAJFnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:43:52 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:26372
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262103AbVAJFO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:29 -0500
Message-Id: <200501100735.j0A7ZsPW005815@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/28] UML - use for_each_cpu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_cpu rather than iterating over processors by hand.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/irq.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/irq.c	2005-01-09 22:38:17.000000000 -0500
@@ -45,9 +45,8 @@
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -60,9 +59,8 @@
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
Index: linux-2.6.10/arch/um/kernel/smp.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/smp.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/smp.c	2005-01-09 22:38:17.000000000 -0500
@@ -247,10 +247,8 @@
 	func = _func;
 	info = _info;
 
-	for (i=0;i<NR_CPUS;i++)
-		if((i != current_thread->cpu) &&
-		   cpu_isset(i, cpu_online_map))
-			os_write_file(cpu_data[i].ipi_pipe[1], "C", 1);
+	for_each_cpu(i)
+		os_write_file(cpu_data[i].ipi_pipe[1], "C", 1);
 
 	while (atomic_read(&scf_started) != cpus)
 		barrier();

