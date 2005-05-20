Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVETWj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVETWj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVETWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:39:57 -0400
Received: from fmr20.intel.com ([134.134.136.19]:17806 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261428AbVETWjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:39:51 -0400
Message-Id: <20050520223418.208677000@csdlinux-2.jf.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com>
Date: Fri, 20 May 2005 15:16:26 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: [patch 4/4] CPU hot-plug support for x86_64
Content-Disposition: inline; filename=remove_ipi_shortcut.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the usage of shortcut to send smp_call_function using ALL_BUT_SELF 
shortcut.  This is a problem for an upcomming CPU, and is still not ready to take
this interrupt. Since cpu_online_map is updated with the call_lock held, this 
mechanism should avoid sending IPI to cpu's not yet prepared to participate in this
party.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
----------------------------------------
 smp.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smp.c	2005-05-20 13:14:27.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smp.c	2005-05-20 13:14:38.000000000 -0700
@@ -315,8 +315,10 @@
 				int nonatomic, int wait)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	cpumask_t cpu_mask;
+	int cpus;
 
+	cpus = num_online_cpus() - 1;
 	if (!cpus)
 		return;
 
@@ -327,10 +329,14 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
+	cpu_mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), cpu_mask);
+
 	call_data = &data;
 	wmb();
+
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(cpu_mask, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)

--
