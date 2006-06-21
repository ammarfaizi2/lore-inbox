Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWFUVA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWFUVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWFUVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:00:28 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:52967 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030281AbWFUVAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:00:24 -0400
Date: Wed, 21 Jun 2006 23:00:23 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm 4/6] cpu_relax(): smpboot.c
Message-ID: <20060621210023.GD22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add cpu_relax() to various smpboot.c init loops.


Kept mb() since it's said to be required in some postings.

Tested on 2.6.17-mm1.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/arch/i386/kernel/smpboot.c linux-2.6.17-mm1.my/arch/i386/kernel/smpboot.c
--- linux-2.6.17-mm1.orig/arch/i386/kernel/smpboot.c	2006-06-21 14:28:15.000000000 +0200
+++ linux-2.6.17-mm1.my/arch/i386/kernel/smpboot.c	2006-06-21 14:43:24.000000000 +0200
@@ -251,8 +251,10 @@
 		/*
 		 * all APs synchronize but they loop on '== num_cpus'
 		 */
-		while (atomic_read(&tsc_count_start) != num_booting_cpus()-1)
+		while (atomic_read(&tsc_count_start) != num_booting_cpus()-1) {
+			cpu_relax();
 			mb();
+		}
 		atomic_set(&tsc_count_stop, 0);
 		wmb();
 		/*
@@ -270,8 +272,10 @@
 		/*
 		 * Wait for all APs to leave the synchronization point:
 		 */
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1)
+		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1) {
+			cpu_relax();
 			mb();
+		}
 		atomic_set(&tsc_count_start, 0);
 		wmb();
 		atomic_inc(&tsc_count_stop);
@@ -328,19 +332,27 @@
 	 * this gets called, so we first wait for the BP to
 	 * finish SMP initialization:
 	 */
-	while (!atomic_read(&tsc_start_flag)) mb();
+	while (!atomic_read(&tsc_start_flag)) {
+		cpu_relax();
+		mb();
+	}
 
 	for (i = 0; i < NR_LOOPS; i++) {
 		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != num_booting_cpus())
+		while (atomic_read(&tsc_count_start) != num_booting_cpus()) {
+			cpu_relax();
 			mb();
+		}
 
 		rdtscll(tsc_values[smp_processor_id()]);
 		if (i == NR_LOOPS-1)
 			write_tsc(0, 0);
 
 		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
+		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) {
+			cpu_relax();
+			mb();
+		}
 	}
 }
 #undef NR_LOOPS
@@ -1446,8 +1458,10 @@
 	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
-	while (!cpu_isset(cpu, cpu_online_map))
+	while (!cpu_isset(cpu, cpu_online_map)) {
+		cpu_relax();
 		mb();
+	}
 	return 0;
 }
 
