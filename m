Return-Path: <linux-kernel-owner+w=401wt.eu-S1753120AbWLOSTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbWLOSTN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbWLOSTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:19:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45707 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbWLOSTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:19:12 -0500
Date: Fri, 15 Dec 2006 10:20:39 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>
Subject: [patch 25/24] x86-64: Mark rdtsc as sync only for netburst, not for core2
Message-ID: <20061215182039.GG10475@sequoia.sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215013337.823935000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.  
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
[chrisw: backported to 2.6.18]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Commit:     f3d73707a1e84f0687a05144b70b660441e999c7
Author:     Arjan van de Ven <arjan@linux.intel.com>
Date:       Thu Dec 7 02:14:12 2006 +0100

 arch/x86_64/kernel/setup.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.18.5.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.18.5/arch/x86_64/kernel/setup.c
@@ -1010,7 +1010,10 @@ static void __cpuinit init_intel(struct 
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 	    (c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
-	set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	if (c->x86 == 15)
+		set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	else
+		clear_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
  	c->x86_max_cores = intel_num_cpu_cores(c);
 
 	srat_detect_node();
