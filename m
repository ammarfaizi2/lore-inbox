Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSFQRVD>; Mon, 17 Jun 2002 13:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSFQRVC>; Mon, 17 Jun 2002 13:21:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45556 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316786AbSFQRVB>; Mon, 17 Jun 2002 13:21:01 -0400
Subject: Re: [patch] sti() preemption fix, 2.5.22
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206171003290.2580-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0206171003290.2580-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 10:20:53 -0700
Message-Id: <1024334453.3090.54.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-17 at 10:04, Linus Torvalds wrote:

> Ingo, please use "get_cpu()/put_cpu()" instead, which does exactly the
> preempt-disable etc, and is more readable.

Here is Ingo's patch using the get_cpu()/put_cpu() interface where
needed...

Ingo, good catch!

	Robert Love

diff -urN linux-2.5.22/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- linux-2.5.22/arch/i386/kernel/irq.c	Sun Jun 16 19:31:24 2002
+++ linux/arch/i386/kernel/irq.c	Mon Jun 17 10:19:18 2002
@@ -356,8 +356,9 @@
 
 	__save_flags(flags);
 	if (flags & (1 << EFLAGS_IF_SHIFT)) {
-		int cpu = smp_processor_id();
+		int cpu;
 		__cli();
+		cpu = smp_processor_id();
 		if (!local_irq_count(cpu))
 			get_irqlock(cpu);
 	}
@@ -365,11 +366,15 @@
 
 void __global_sti(void)
 {
-	int cpu = smp_processor_id();
+	int cpu;
+
+	cpu = get_cpu();
 
 	if (!local_irq_count(cpu))
 		release_irqlock(cpu);
 	__sti();
+
+	put_cpu();
 }
 
 /*

