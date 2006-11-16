Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031133AbWKPJEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031133AbWKPJEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031134AbWKPJEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:04:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11405 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031133AbWKPJEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:04:47 -0500
Date: Thu, 16 Nov 2006 10:03:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Message-ID: <20061116090330.GA11312@elte.hu>
References: <20061116084855.GA8848@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116084855.GA8848@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0239]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> x86_64 does not build cleanly on UP:

updated patch below - i left out the cpu.h bits because they caused 
problems elsewhere.

	Ingo

--------------->
Subject: x86_64: build fixes
From: Ingo Molnar <mingo@elte.hu>

x86_64 does not build cleanly on UP:

arch/x86_64/kernel/vsyscall.c: In function 'cpu_vsyscall_notifier':
arch/x86_64/kernel/vsyscall.c:282: warning: implicit declaration of function 'smp_call_function_single'
arch/x86_64/kernel/vsyscall.c: At top level:
arch/x86_64/kernel/vsyscall.c:279: warning: 'cpu_vsyscall_notifier' defined but not used

this patch fixes it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-x86_64/smp.h |   11 ++---------
 include/linux/smp.h      |    9 +++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h
+++ linux/include/asm-x86_64/smp.h
@@ -115,16 +115,9 @@ static __inline int logical_smp_processo
 }
 
 #ifdef CONFIG_SMP
-#define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
+# define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
 #else
-#define cpu_physical_id(cpu)		boot_cpu_id
-static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
-				void *info, int retry, int wait)
-{
-	/* Disable interrupts here? */
-	func(info);
-	return 0;
-}
+# define cpu_physical_id(cpu)		boot_cpu_id
 #endif /* !CONFIG_SMP */
 #endif
 
Index: linux/include/linux/smp.h
===================================================================
--- linux.orig/include/linux/smp.h
+++ linux/include/linux/smp.h
@@ -100,6 +100,15 @@ static inline void smp_send_reschedule(i
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
 
+static inline int
+smp_call_function_single(int cpuid, void (*func) (void *info), void *info,
+			 int retry, int wait)
+{
+	func(info);
+
+	return 0;
+}
+
 #endif /* !SMP */
 
 /*
