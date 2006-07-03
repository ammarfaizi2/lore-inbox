Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWGCFaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWGCFaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 01:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGCFaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 01:30:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13037 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750782AbWGCFaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 01:30:20 -0400
Date: Mon, 3 Jul 2006 07:25:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060703052538.GB13415@elte.hu>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060702164113.6dc1cd6c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Sun, 02 Jul 2006 16:27:55 -0700
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
> > Panic on NUMA-Q (mm4 was fine). Presumably some new scheduler patch
> > 
> > divide error: 0000 [#1]
> > 8K_STACKS SMP 
> > last sysfs file: 
> > Modules linked in:
> > CPU:    1
> > EIP:    0060:[<c0112b6e>]    Not tainted VLI
> > EFLAGS: 00010046   (2.6.17-mm5-autokern1 #1) 
> > EIP is at find_busiest_group+0x1a3/0x47c
> > eax: 00000000   ebx: 00000007   ecx: 00000000   edx: 00000000
> > esi: 00000000   edi: e75ff264   ebp: e7405ec8   esp: e7405e58
> > ds: 007b   es: 007b   ss: 0068
> > Process swapper (pid: 0, ti=e7404000 task=c13f8560 task.ti=e7404000)
> > Stack: e75ff264 00000010 c0119020 00000000 00000000 00000000 00000000 00000000 
> >        ffffffff 00000000 00000000 00000001 00000001 00000001 00000080 00000000 
> >        00000000 00000200 00000020 00000080 00000000 00000000 e75ff260 c1364960 
> > Call Trace:
> >  [<c0119020>] vprintk+0x5f/0x213
> >  [<c0112efb>] load_balance+0x54/0x1d6
> >  [<c011332d>] rebalance_tick+0xc5/0xe3
> >  [<c01137a3>] scheduler_tick+0x2cb/0x2d3
> >  [<c01215b4>] update_process_times+0x51/0x5d
> >  [<c010c224>] smp_apic_timer_interrupt+0x5a/0x61
> >  [<c0102d5b>] apic_timer_interrupt+0x1f/0x24
> >  [<c01006c0>] default_idle+0x0/0x59
> >  [<c01006f1>] default_idle+0x31/0x59
> >  [<c0100791>] cpu_idle+0x64/0x79
> > Code: 00 5b 83 f8 1f 89 c6 5f 0f 8e 63 ff ff ff 8b 45 e0 8b 55 e8 01 45 dc 8b 4a 08 89 c2 01 4d d4 c1 e2 07 89 d0 31 d2 89 ce c1 ee 07 <f7> f1 83 7d 9c 00 89 45 e0 74 17 89 45 d8 8b 55 e8 8b 4d a4 8b 
> > EIP: [<c0112b6e>] find_busiest_group+0x1a3/0x47c SS:ESP 0068:e7405e58
> 
> Yes, Andy's reporting that too.  I asked him to identify the 
> file-n-line and he ran away on me.

i checked the scheduler queue and nothing jumped out at me, except the 
cleanup bug fixed by the patch below. (which should be harmless in this 
particular case - nr_running should never be smaller than 0 or larger 
than ~4 billion. A fix is warranted nevertheless.)

	Ingo

-------------->
Subject: sched: fix macro -> inline function conversion bug
From: Ingo Molnar <mingo@elte.hu>

nr_running is long, not int.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -2480,7 +2480,7 @@ find_busiest_queue(struct sched_group *g
  */
 #define MAX_PINNED_INTERVAL	512
 
-static inline int minus_1_or_zero(int n)
+static inline unsigned long minus_1_or_zero(unsigned long n)
 {
 	return n > 0 ? n - 1 : 0;
 }
