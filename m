Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUJAX3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUJAX3X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUJAX3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:29:23 -0400
Received: from fmr03.intel.com ([143.183.121.5]:61337 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266820AbUJAX3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:29:09 -0400
Date: Fri, 1 Oct 2004 16:29:00 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] display phys_proc_id only when it is initialized
Message-ID: <20041001162900.B10406@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


phys_proc_id gets initialized only when (smp_num_siblings > 1).
But gets printed even when (smp_num_siblings == 1). As a result we print 
incorrect physical processor id in /proc/cpuinfo, when HT is disabled.

This patch fixes it.

Signed-off-by:: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>

--- linux-2.6.9-rc2/arch/i386/kernel/cpu/proc.c.org	2004-08-29 22:59:21.334053528 -0700
+++ linux-2.6.9-rc2/arch/i386/kernel/cpu/proc.c	2004-08-29 22:57:55.882044208 -0700
@@ -88,7 +88,7 @@ static int show_cpuinfo(struct seq_file 
 	if (c->x86_cache_size >= 0)
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 #ifdef CONFIG_X86_HT
-	if (cpu_has_ht) {
+	if (smp_num_siblings > 1) {
 		extern int phys_proc_id[NR_CPUS];
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
 		seq_printf(m, "siblings\t: %d\n", smp_num_siblings);
--- linux-2.6.9-rc2/arch/x86_64/kernel/setup.c.org	2004-08-29 01:08:29.690920728 -0700
+++ linux-2.6.9-rc2/arch/x86_64/kernel/setup.c	2004-08-29 23:00:26.301177024 -0700
@@ -1132,7 +1132,7 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 	
 #ifdef CONFIG_X86_HT
-	if (cpu_has_ht) {
+	if (smp_num_siblings > 1) {
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[c - cpu_data]);
 		seq_printf(m, "siblings\t: %d\n", smp_num_siblings);
 	}
