Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVADNRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVADNRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVADNPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:15:48 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:39922 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261609AbVADNLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:11:36 -0500
Date: Tue, 4 Jan 2005 14:11:01 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: rusty@rustcorp.com.au, paulus@au1.ibm.com, nathanl@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] mm_struct leak on cpu hotplug (s390/ppc64)
Message-ID: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is an mm_struct memory leak when using cpu hotplug. Appearently
start_secondary in smp.c initializes active_mm of the cpu's idle task
and increases init_mm's mm_count. But on cpu_die the idle task's
active_mm doesn't get dropped and therefore on the next cpu_up event
(->start_secondary) it gets overwritten and the result is a forgotten
reference count to whatever mm_struct was active when the cpu
was taken down previously.

The patch below should fix this for s390 (at least it works fine for
me), but I'm not sure if it's ok to call mmdrop from __cpu_die.

Also this very same leak exists for ppc64 as well.

Any opinions?

Thanks,
Heiko

diff -urN linux-2.6.10/arch/s390/kernel/smp.c linux-2.6.10-patched/arch/s390/kernel/smp.c
--- linux-2.6.10/arch/s390/kernel/smp.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-patched/arch/s390/kernel/smp.c	2005-01-04 13:42:14.000000000 +0100
@@ -728,9 +728,14 @@
 void
 __cpu_die(unsigned int cpu)
 {
+	struct task_struct *p;
+
 	/* Wait until target cpu is down */
 	while (!cpu_stopped(cpu));
 	printk("Processor %d spun down\n", cpu);
+	p = current_set[cpu];
+	mmdrop(p->active_mm);
+	p->active_mm = NULL;
 }
 
 void
