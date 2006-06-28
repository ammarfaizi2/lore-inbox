Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWF1IfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWF1IfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWF1IfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:35:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46232 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161114AbWF1Ie6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:34:58 -0400
Date: Wed, 28 Jun 2006 10:30:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       "David S. Miller" <davem@davemloft.net>
Subject: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
Message-ID: <20060628083008.GA14056@elte.hu>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060627224038.GF13915@stusta.de> <1151478544.25491.485.camel@localhost.localdomain> <20060628001208.2b034afd.akpm@osdl.org> <1151479204.25491.491.camel@localhost.localdomain> <20060628081345.GA12647@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628081345.GA12647@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > > OK, so I moved the above lines inside #ifdef CONFIG_GENERIC_HARDIRQS (diff
> > > did a strange-looking thing with it):
> > 
> > Yeah, but its nevertheless correct. :)
> 
> lets hope it builds sparc64 & co too.
> 
> /me goes to try

ok, sparc64 needed the rename fix below, but otherwise it built fine on 
-mm3.

	Ingo

----------------
Subject: genirq: rename desc->handler to desc->chip, sparc64 fix
From: Ingo Molnar <mingo@elte.hu>

make sparc64 build.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/sparc64/kernel/irq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux/arch/sparc64/kernel/irq.c
===================================================================
--- linux.orig/arch/sparc64/kernel/irq.c
+++ linux/arch/sparc64/kernel/irq.c
@@ -151,7 +151,7 @@ int show_interrupts(struct seq_file *p, 
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
-		seq_printf(p, " %9s", irq_desc[i].handler->typename);
+		seq_printf(p, " %9s", irq_desc[i].chip->typename);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
@@ -414,8 +414,8 @@ void irq_install_pre_handler(int virt_ir
 	data->pre_handler_arg1 = arg1;
 	data->pre_handler_arg2 = arg2;
 
-	desc->handler = (desc->handler == &sun4u_irq ?
-			 &sun4u_irq_ack : &sun4v_irq_ack);
+	desc->chip = (desc->chip == &sun4u_irq ?
+		      &sun4u_irq_ack : &sun4v_irq_ack);
 }
 
 unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
@@ -431,7 +431,7 @@ unsigned int build_irq(int inofixup, uns
 	bucket = &ivector_table[ino];
 	if (!bucket->virt_irq) {
 		bucket->virt_irq = virt_irq_alloc(__irq(bucket));
-		irq_desc[bucket->virt_irq].handler = &sun4u_irq;
+		irq_desc[bucket->virt_irq].chip = &sun4u_irq;
 	}
 
 	desc = irq_desc + bucket->virt_irq;
@@ -465,7 +465,7 @@ unsigned int sun4v_build_irq(u32 devhand
 	bucket = &ivector_table[sysino];
 	if (!bucket->virt_irq) {
 		bucket->virt_irq = virt_irq_alloc(__irq(bucket));
-		irq_desc[bucket->virt_irq].handler = &sun4v_irq;
+		irq_desc[bucket->virt_irq].chip = &sun4v_irq;
 	}
 
 	desc = irq_desc + bucket->virt_irq;
