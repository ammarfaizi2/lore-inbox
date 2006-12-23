Return-Path: <linux-kernel-owner+w=401wt.eu-S1753571AbWLWP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbWLWP6R (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 10:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbWLWP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 10:58:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56898 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbWLWP6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 10:58:16 -0500
Date: Sat, 23 Dec 2006 16:55:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Siddha@elte.hu,
       Suresh B <suresh.b.siddha@intel.com>,
       Clark Williams <williams@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch] suspend: fix suspend on single-CPU systems
Message-ID: <20061223155529.GA18924@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] suspend: fix suspend on single-CPU systems
From: Ingo Molnar <mingo@elte.hu>

Clark Williams reported that suspend doesnt work on his laptop on 
2.6.20-rc1-rt kernels. The bug was introduced by the following cleanup 
commit:

 commit 112cecb2cc0e7341db92281ba04b26c41bb8146d
 Author: Siddha, Suresh B <suresh.b.siddha@intel.com>
 Date:   Wed Dec 6 20:34:31 2006 -0800

    [PATCH] suspend: don't change cpus_allowed for task initiating the suspend

because with this change 'error' is not initialized to 0 anymore, if 
there are no other online CPUs. (i.e. if the system is single-CPU).

the fix is the initialize it to 0. The really weird thing is that my 
version of gcc does not warn about this non-initialized variable 
situation ...

(also fix the kernel printk in the error branch, it was missing a
 newline)

Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/cpu.c
===================================================================
--- linux.orig/kernel/cpu.c
+++ linux/kernel/cpu.c
@@ -258,7 +258,7 @@ static cpumask_t frozen_cpus;
 
 int disable_nonboot_cpus(void)
 {
-	int cpu, first_cpu, error;
+	int cpu, first_cpu, error = 0;
 
 	mutex_lock(&cpu_add_remove_lock);
 	first_cpu = first_cpu(cpu_present_map);
@@ -294,7 +294,7 @@ int disable_nonboot_cpus(void)
 		/* Make sure the CPUs won't be enabled by someone else */
 		cpu_hotplug_disabled = 1;
 	} else {
-		printk(KERN_ERR "Non-boot CPUs are not disabled");
+		printk(KERN_ERR "Non-boot CPUs are not disabled\n");
 	}
 out:
 	mutex_unlock(&cpu_add_remove_lock);
