Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271750AbTG2Npa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271753AbTG2Npa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:45:30 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:60804
	"EHLO gaston") by vger.kernel.org with ESMTP id S271750AbTG2NpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:45:25 -0400
Subject: [PATCH] PPC32: Properly register CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059486309.8538.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 09:45:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This patch adds proper registration of CPUs on ppc32, without
this, accesses to cpufreq will oops.

Please apply,
Ben.

===== arch/ppc/kernel/setup.c 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/setup.c	Tue Jul 22 18:09:26 2003
+++ edited/arch/ppc/kernel/setup.c	Tue Jul 29 09:43:17 2003
@@ -572,11 +572,21 @@
 }
 #endif /* CONFIG_NVRAM */
 
+static struct cpu cpu_devices[NR_CPUS];
+
 int __init ppc_init(void)
 {
+	int i;
+	
 	/* clear the progress line */
 	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
-	
+
+	/* register CPU devices */
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			register_cpu(&cpu_devices[i], i, NULL);
+
+	/* call platform init */
 	if (ppc_md.init != NULL) {
 		ppc_md.init();
 	}


