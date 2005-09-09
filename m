Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVIIGlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVIIGlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVIIGlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:41:15 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:61895
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751395AbVIIGlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:41:14 -0400
Message-Id: <43214AE402000078000247AB@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 08:42:12 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com>  <20050909002045.GA19913@wotan.suse.de> <20050909004307.GA18347@wotan.suse.de>
In-Reply-To: <20050909004307.GA18347@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Index: linux/include/asm-x86_64/hw_irq.h
>===================================================================
>--- linux.orig/include/asm-x86_64/hw_irq.h
>+++ linux/include/asm-x86_64/hw_irq.h
>@@ -52,7 +52,7 @@ struct hw_interrupt_type;
> #define ERROR_APIC_VECTOR	0xfe
> #define RESCHEDULE_VECTOR	0xfd
> #define CALL_FUNCTION_VECTOR	0xfc
>-#define KDB_VECTOR		0xfb	/* reserved for KDB */
>+#define NMI_VECTOR		0xfb	/* IPI NMIs for debugging */
> #define THERMAL_APIC_VECTOR	0xfa
> /* 0xf9 free */
> #define INVALIDATE_TLB_VECTOR_END	0xf8

This doesn't seem too good an idea: the NMI vector really is 0x02
(architecturally), so defining it to something else seems at least odd.

>Index: linux/arch/x86_64/kernel/traps.c
>===================================================================
>--- linux.orig/arch/x86_64/kernel/traps.c
>+++ linux/arch/x86_64/kernel/traps.c
>@@ -931,7 +931,7 @@ void __init trap_init(void)
> 	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
> #endif
>        
>-	set_intr_gate(KDB_VECTOR, call_debug);
>+	set_intr_gate(NMI_VECTOR, call_debug);
>        
> 	/*
> 	 * Should be a barrier for any external CPU state.

I never understood what this does. If you deliver the IPI as an NMI,
it'll never arrive at this vector, and why would anyone want to put an
"int $NMI_VECTOR" anywhere?

Jan
