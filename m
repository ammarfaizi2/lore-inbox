Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWIPUiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWIPUiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWIPUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 16:38:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16315 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751501AbWIPUiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 16:38:07 -0400
Date: Sat, 16 Sep 2006 22:29:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [patch] kprobes: optimize branch placement
Message-ID: <20060916202939.GA4520@elte.hu>
References: <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916193745.GA29022@elte.hu>
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

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > and have measured the overhead of an unmodified, kprobes-probed and 
> > djprobes-probed sys_getpid() system-call:
> > 
> >  sys_getpid() unmodified latency:    317 cycles   [ 0.146 usecs ]
> >  sys_getpid() kprobes latency:       815 cycles   [ 0.377 usecs ]
> >  sys_getpid() djprobes latency:      380 cycles   [ 0.176 usecs ]
> 
> i have taken a look at the kprobes fastpath, and there are a few things 
> we can do to speed it up. The patch below shaves off 75 cycles from the 
> kprobes overhead:
> 
>    sys_getpid() kprobes-speedup:       740 cycles   [ 0.342 usecs ]
> 
> that reduces the kprobes overhead to 423 cycles.

the patch below  brings the overhead down to 420 cycles:

     sys_getpid() kprobes-speedup:       737 cycles   [ 0.341 usecs ]

	Ingo

---------->
Subject: [patch] kprobes: optimize branch placement
From: Ingo Molnar <mingo@elte.hu>

optimize gcc's code generation by hinting branch probabilities.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/kprobes.c |    2 +-
 arch/i386/kernel/traps.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/kprobes.c
===================================================================
--- linux.orig/arch/i386/kernel/kprobes.c
+++ linux/arch/i386/kernel/kprobes.c
@@ -220,7 +220,7 @@ int __kprobes kprobe_handler(struct pt_r
 	kcb = get_kprobe_ctlblk();
 
 	/* Check we're not actually recursing */
-	if (kprobe_running()) {
+	if (unlikely(kprobe_running())) {
 		p = get_kprobe(addr);
 		if (p) {
 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -806,7 +806,7 @@ fastcall void __kprobes do_int3(struct p
 	 * kernel-mode INT3s are likely kprobes:
 	 */
         if (!user_mode(regs)) {
-                if (kprobe_handler(regs))
+                if (likely(kprobe_handler(regs)))
 			return;
 		/* This is an interrupt gate, because kprobes wants interrupts
 		disabled.  Normal trap handlers don't. */
