Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWGFIWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWGFIWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWGFIWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:22:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64387 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964992AbWGFIWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:22:53 -0400
Date: Thu, 6 Jul 2006 10:18:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: [patch] lockdep: clean up completion initializer in smpboot.c
Message-ID: <20060706081818.GA24492@elte.hu>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lockdep: clean up completion initializer in smpboot.c
From: Ingo Molnar <mingo@elte.hu>

clean up lockdep on-stack-completion initializer. (This also removes
the dependency on waitqueue_lock_key.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/smpboot.c |    4 +---
 include/linux/completion.h   |    5 ++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -771,12 +771,10 @@ static int __cpuinit do_boot_cpu(int cpu
 	unsigned long start_rip;
 	struct create_idle c_idle = {
 		.cpu = cpu,
-		.done = COMPLETION_INITIALIZER(c_idle.done),
+		.done = COMPLETION_INITIALIZER_ONSTACK(c_idle.done),
 	};
 	DECLARE_WORK(work, do_fork_idle, &c_idle);
 
-	lockdep_set_class(&c_idle.done.wait.lock, &waitqueue_lock_key);
-
 	/* allocate memory for gdts of secondary cpus. Hotplug is considered */
 	if (!cpu_gdt_descr[cpu].address &&
 		!(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
Index: linux/include/linux/completion.h
===================================================================
--- linux.orig/include/linux/completion.h
+++ linux/include/linux/completion.h
@@ -18,6 +18,9 @@ struct completion {
 #define COMPLETION_INITIALIZER(work) \
 	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
+#define COMPLETION_INITIALIZER_ONSTACK(work) \
+	({ init_completion(&work); work; })
+
 #define DECLARE_COMPLETION(work) \
 	struct completion work = COMPLETION_INITIALIZER(work)
 
@@ -28,7 +31,7 @@ struct completion {
  */
 #ifdef CONFIG_LOCKDEP
 # define DECLARE_COMPLETION_ONSTACK(work) \
-	struct completion work = ({ init_completion(&work); work; })
+	struct completion work = COMPLETION_INITIALIZER_ONSTACK(work)
 #else
 # define DECLARE_COMPLETION_ONSTACK(work) DECLARE_COMPLETION(work)
 #endif
