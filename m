Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVCOEOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVCOEOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVCOEOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:14:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:5534 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262235AbVCOEOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:14:19 -0500
Subject: ppc32: Fix overflow in cpuinfo freq. display
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:12:34 +1100
Message-Id: <1110859955.29124.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The CPU frequency in /proc/cpuinfo would overflow because of a
signed/unsigned bug. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/setup.c	2005-03-15 13:55:31.000000000 +1100
+++ linux-work/arch/ppc/kernel/setup.c	2005-03-15 14:21:27.000000000 +1100
@@ -338,14 +338,15 @@
 of_show_percpuinfo(struct seq_file *m, int i)
 {
 	struct device_node *cpu_node;
-	int *fp, s;
+	u32 *fp;
+	int s;
 	
 	cpu_node = find_type_devices("cpu");
 	if (!cpu_node)
 		return 0;
 	for (s = 0; s < i && cpu_node->next; s++)
 		cpu_node = cpu_node->next;
-	fp = (int *) get_property(cpu_node, "clock-frequency", NULL);
+	fp = (u32 *)get_property(cpu_node, "clock-frequency", NULL);
 	if (fp)
 		seq_printf(m, "clock\t\t: %dMHz\n", *fp / 1000000);
 	return 0;


