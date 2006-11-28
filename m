Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935814AbWK1K3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935814AbWK1K3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935815AbWK1K3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:29:09 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:27327 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S935814AbWK1K3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:29:08 -0500
Subject: [patch] Mark rdtsc as sync only for netburst, not for core2
From: Arjan van de Ven <arjan@linux.intel.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Nov 2006 11:28:28 +0100
Message-Id: <1164709708.3276.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On the Core2 cpus, the rdtsc instruction is not serializing (as defined
in the architecture reference since rdtsc exists) and due to the deep
speculation of these cores, it's possible that you can observe time go
backwards between cores due to this speculation. Since the kernel
already deals with this with the SYNC_RDTSC flag, the solution is
simple, only assume that the instruction is serializing on family 15...

The price one pays for this is a slightly slower gettimeofday (by a
dozen or two cycles), but that increase is quite small to pay for a
really-going-forward tsc counter.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

--- linux-2.6.18/arch/x86_64/kernel/setup.c.org	2006-11-28 11:22:08.000000000 +0100
+++ linux-2.6.18/arch/x86_64/kernel/setup.c	2006-11-28 11:22:50.000000000 +0100
@@ -854,7 +854,10 @@ static void __cpuinit init_intel(struct 
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
 	if (c->x86 == 6)
 		set_bit(X86_FEATURE_REP_GOOD, &c->x86_capability);
-	set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	if (c->x86 == 15)
+		set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	else
+		clear_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
  	c->x86_max_cores = intel_num_cpu_cores(c);
 
 	srat_detect_node();

