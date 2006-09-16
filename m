Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWIPTpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWIPTpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 15:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWIPTpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 15:45:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26771 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751465AbWIPTpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 15:45:51 -0400
Date: Sat, 16 Sep 2006 21:37:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916193745.GA29022@elte.hu>
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916191043.GA22558@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> and have measured the overhead of an unmodified, kprobes-probed and 
> djprobes-probed sys_getpid() system-call:
> 
>  sys_getpid() unmodified latency:    317 cycles   [ 0.146 usecs ]
>  sys_getpid() kprobes latency:       815 cycles   [ 0.377 usecs ]
>  sys_getpid() djprobes latency:      380 cycles   [ 0.176 usecs ]

i have taken a look at the kprobes fastpath, and there are a few things 
we can do to speed it up. The patch below shaves off 75 cycles from the 
kprobes overhead:

   sys_getpid() kprobes-speedup:       740 cycles   [ 0.342 usecs ]

that reduces the kprobes overhead to 423 cycles.

	Ingo

--------------->
Subject: [patch] kprobes: speed INT3 trap handling up on i386
From: Ingo Molnar <mingo@elte.hu>

speed up kprobes trap handling by special-casing kernel-space
INT3 traps (which do not occur otherwise) and doing a kprobes
handler check - instead of redirecting over the i386-die-notifier
chain.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/kprobes.c |    2 +-
 arch/i386/kernel/traps.c   |   19 ++++++++++++-------
 include/asm-i386/kprobes.h |    2 ++
 3 files changed, 15 insertions(+), 8 deletions(-)

Index: linux/arch/i386/kernel/kprobes.c
===================================================================
--- linux.orig/arch/i386/kernel/kprobes.c
+++ linux/arch/i386/kernel/kprobes.c
@@ -200,7 +200,7 @@ void __kprobes arch_prepare_kretprobe(st
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled thorough out this function.
  */
-static int __kprobes kprobe_handler(struct pt_regs *regs)
+int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -802,13 +802,18 @@ EXPORT_SYMBOL_GPL(unset_nmi_callback);
 #ifdef CONFIG_KPROBES
 fastcall void __kprobes do_int3(struct pt_regs *regs, long error_code)
 {
-	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
-			== NOTIFY_STOP)
-		return;
-	/* This is an interrupt gate, because kprobes wants interrupts
-	disabled.  Normal trap handlers don't. */
-	restore_interrupts(regs);
-	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+	/*
+	 * kernel-mode INT3s are likely kprobes:
+	 */
+        if (!user_mode(regs)) {
+                if (kprobe_handler(regs))
+			return;
+		/* This is an interrupt gate, because kprobes wants interrupts
+		disabled.  Normal trap handlers don't. */
+		restore_interrupts(regs);
+		do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+	}
+	notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP);
 }
 #endif
 
Index: linux/include/asm-i386/kprobes.h
===================================================================
--- linux.orig/include/asm-i386/kprobes.h
+++ linux/include/asm-i386/kprobes.h
@@ -88,4 +88,6 @@ static inline void restore_interrupts(st
 
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
+extern int kprobe_handler(struct pt_regs *regs);
+
 #endif				/* _ASM_KPROBES_H */
