Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbULJA0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbULJA0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbULJA0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:26:04 -0500
Received: from ozlabs.org ([203.10.76.45]:25737 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261571AbULJAZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:25:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16824.60713.130758.578122@cargo.ozlabs.ibm.com>
Date: Fri, 10 Dec 2004 11:26:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH] PPC64 Make UP kernel run on POWER4 logical partition
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I tried booting a UP kernel on a 1-processor logical
partition on a POWER4 system.  It failed because the CPU we happened
to be running on was CPU 2, but hard_smp_processor_id() is defined to
0 for !CONFIG_SMP.  (Note that this code runs quite early, as part of
init_IRQ, so hard_smp_processor_id() should be the physical ID of the
boot cpu.)

This patch does a minimal fix to make it work.  I think this patch
should go in 2.6.10.  Ultimately I think the hard_smp_processor_id()
definition should be removed from include/linux/smp.h, but that
carries a risk of breaking other architectures and probably shouldn't
be done pre 2.6.10.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/xics.c test/arch/ppc64/kernel/xics.c
--- linux-2.5/arch/ppc64/kernel/xics.c	2004-10-27 07:32:57.000000000 +1000
+++ test/arch/ppc64/kernel/xics.c	2004-12-10 11:08:18.532939288 +1100
@@ -504,7 +504,7 @@
 	     np;
 	     np = of_find_node_by_type(np, "cpu")) {
 		ireg = (uint *)get_property(np, "reg", &ilen);
-		if (ireg && ireg[0] == hard_smp_processor_id()) {
+		if (ireg && ireg[0] == boot_cpuid_phys) {
 			ireg = (uint *)get_property(np, "ibm,ppc-interrupt-gserver#s",
 						    &ilen);
 			i = ilen / sizeof(int);
