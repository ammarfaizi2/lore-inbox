Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267842AbUHPS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267842AbUHPS3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUHPS3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:29:50 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:23636
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S267842AbUHPS3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:29:25 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: jjluza@yahoo.fr
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200408161452.44400.jjluza@yahoo.fr>
References: <200408161452.44400.jjluza@yahoo.fr>
Content-Type: multipart/mixed; boundary="=-1oK/drH1rU6r24OOff63"
Date: Mon, 16 Aug 2004 20:29:15 +0200
Message-Id: <1092680955.28374.0.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1oK/drH1rU6r24OOff63
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-08-16 at 14:52 +0200, jjluza wrote:
> It fails here at compile time with :
> 
> arch/i386/kernel/built-in.o(.text+0x2fc5): In function `do_nmi':
> : undefined reference to `__trace'
> arch/i386/kernel/built-in.o(.text+0x3723): In function `do_IRQ':
> : undefined reference to `__trace'
> arch/i386/mm/built-in.o(.text+0x7ba): In function `do_page_fault':
> : undefined reference to `__trace'
> make[1]: *** [vmlinux] Erreur 1
> make[1]: Leaving directory `/usr/src/linux-2.6.8'
> make: *** [stamp-build] Erreur 2
> 
> 
> I also got offset when applying the patch. (P1 hadn't this problem)
> 
> 
> Regards.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

--=-1oK/drH1rU6r24OOff63
Content-Disposition: attachment; filename=compile-fix-P2
Content-Type: text/plain; name=compile-fix-P2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- arch/i386/kernel/irq.c~	2004-08-16 20:01:58.835999719 +0200
+++ arch/i386/kernel/irq.c	2004-08-16 20:26:24.974943041 +0200
@@ -219,7 +219,9 @@
 	unsigned int status;
 
 	irq_enter();
+#ifdef CONFIG_LATENCY_TRACE
 	__trace((unsigned long)do_IRQ, regs.eip);
+#endif
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
--- arch/i386/kernel/traps.c~	2004-08-16 20:01:58.836999745 +0200
+++ arch/i386/kernel/traps.c	2004-08-16 20:26:48.156378051 +0200
@@ -537,7 +537,9 @@
 	int cpu;
 
 	nmi_enter();
+#ifdef CONFIG_LATENCY_TRACE
 	__trace((unsigned long)do_nmi, regs->eip);
+#endif
 
 	cpu = smp_processor_id();
 	++nmi_count(cpu);
--- arch/i386/mm/fault.c~	2004-08-16 20:01:58.837999771 +0200
+++ arch/i386/mm/fault.c	2004-08-16 20:27:08.181753770 +0200
@@ -223,7 +223,9 @@
 	int write;
 	siginfo_t info;
 
+#ifdef CONFIG_LATENCY_TRACE
 	__trace((unsigned long)do_page_fault, regs->eip);
+#endif
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));

--=-1oK/drH1rU6r24OOff63--

