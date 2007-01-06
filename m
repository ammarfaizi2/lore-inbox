Return-Path: <linux-kernel-owner+w=401wt.eu-S1751086AbXAFCZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbXAFCZr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXAFCZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:25:46 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47727 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbXAFCZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:25:42 -0500
Message-Id: <20070106022945.273419000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:27:58 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@linux.intel.com>,
       Andi Kleen <ak@suse.de>
Subject: [patch 05/50] x86-64: Mark rdtsc as sync only for netburst, not for core2
Content-Disposition: inline; filename=x86-64-mark-rdtsc-as-sync-only-for-netburst-not-for-core2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Arjan van de Ven <arjan@linux.intel.com>

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
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Commit:     f3d73707a1e84f0687a05144b70b660441e999c7
Author:     Arjan van de Ven <arjan@linux.intel.com>
AuthorDate: Thu Dec 7 02:14:12 2006 +0100

 arch/x86_64/kernel/setup.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.19.1.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.19.1/arch/x86_64/kernel/setup.c
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

--
