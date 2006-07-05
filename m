Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWGEJ7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWGEJ7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWGEJ7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:59:01 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55998 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964781AbWGEJ7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:59:00 -0400
Date: Wed, 5 Jul 2006 11:54:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch] uninline init_waitqueue_*() functions, fix
Message-ID: <20060705095425.GA13874@elte.hu>
References: <20060705084914.GA8798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705084914.GA8798@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5011]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: uninline init_waitqueue_*() functions, fix
From: Ingo Molnar <mingo@elte.hu>

fix lockdep on-stack-completion initializer, now that waitqueue_lock_key 
is private to kernel/wait.c.

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
