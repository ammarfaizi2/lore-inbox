Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSFTXmg>; Thu, 20 Jun 2002 19:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFTXmf>; Thu, 20 Jun 2002 19:42:35 -0400
Received: from host194.steeleye.com ([216.33.1.194]:53007 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315893AbSFTXme>; Thu, 20 Jun 2002 19:42:34 -0400
Message-Id: <200206202341.g5KNfqU07377@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Optimisation for smp_num_cpus loop in hotplug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Jun 2002 19:41:52 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug CPU patch introduces this to replace the loop over all active CPUs 
abstraction:

	for (i = 0; i < NR_CPUS; i++) {
		if (!cpu_online(i))
			continue;

Since the cpu online map is probably going to be quite sparse, could I suggest 
this alternative, which doesn't have to loop 32 times:

===== smp.h 1.11 vs edited =====
--- 1.11/include/asm-i386/smp.h Thu Jun 20 14:04:21 2002
+++ edited/smp.h        Thu Jun 20 12:39:33 2002
@@ -95,6 +95,11 @@
 
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
+#define for_each_cpu(cpu, mask) \
+       for(mask = cpu_online_map; \
+           cpu = __ffs(mask), mask != 0; \
+           mask &= ~(1<<cpu))
+
 extern inline unsigned int num_online_cpus(void)
 {
        return hweight32(cpu_online_map);

I've implemented this for my voyager system (8 cpus, but still a sparse online 
bitmap), mainly because (for historical reasons), I have to do this loop in 
time critical IPI code.

James 


