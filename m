Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWKPJ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWKPJ2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161980AbWKPJ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:28:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63704 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161975AbWKPJ2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:28:48 -0500
Date: Thu, 16 Nov 2006 10:28:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Message-ID: <20061116092801.GA14322@elte.hu>
References: <20061116084855.GA8848@elte.hu> <20061116005833.b6d6daa5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116005833.b6d6daa5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0007]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 16 Nov 2006 09:48:55 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > +static inline int
> > +smp_call_function_single(int cpuid, void (*func) (void *info), void *info,
> > +			 int retry, int wait)
> > +{
> > +	func(info);
> > +
> > +	return 0;
> > +}
> > +
> 
> Given that on SMP the function is called with local interrupts 
> disabled, I'd suggest that it should be called with local interrupts 
> disabled on UP as well.
> 
> on_each_cpu() does this and one caller (at least) relies upon it 
> (invalidate_bh_lrus(), iirc).

ok, fair enough. Then this is a (minor) bugfix as well.

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
 include/linux/smp.h      |   13 +++++++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

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
@@ -100,6 +100,19 @@ static inline void smp_send_reschedule(i
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
 
+static inline int
+smp_call_function_single(int cpuid, void (*func) (void *info), void *info,
+			 int retry, int wait)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	func(info);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
 #endif /* !SMP */
 
 /*
