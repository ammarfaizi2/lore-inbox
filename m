Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGaUsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGaUsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGaUsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:48:43 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9942 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262380AbUGaUsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:48:41 -0400
Date: Sat, 31 Jul 2004 16:52:18 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Subject: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following caused some fireworks whilst merging i386 cpu hotplug.

any_online_cpu(0x2) returns 32 on i386 if we're forced to continue past
the only set bit due to the additional find_first_bit in the
find_next_bit i386 implementation. Not wanting to change current
behaviour in the bitops primitives and since the NR_CPUS thing is a
cpumask issue, i've opted to fix next_cpu() and first_cpu() instead.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc2-mm1-lch/include/linux/cpumask.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/include/linux/cpumask.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpumask.h
--- linux-2.6.8-rc2-mm1-lch/include/linux/cpumask.h	28 Jul 2004 14:35:22 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/include/linux/cpumask.h	31 Jul 2004 17:57:12 -0000
@@ -207,13 +207,19 @@ static inline void __cpus_shift_left(cpu
 #define first_cpu(src) __first_cpu(&(src), NR_CPUS)
 static inline int __first_cpu(const cpumask_t *srcp, int nbits)
 {
-	return find_first_bit(srcp->bits, nbits);
+	int cpu = find_first_bit(srcp->bits, nbits);
+	if (cpu > NR_CPUS)
+		cpu = NR_CPUS;
+	return cpu;
 }

 #define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
 static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
 {
-	return find_next_bit(srcp->bits, nbits, n+1);
+	int cpu = find_next_bit(srcp->bits, nbits, n+1);
+	if (cpu > NR_CPUS)
+		cpu = NR_CPUS;
+	return cpu;
 }

 #define cpumask_of_cpu(cpu)						\
