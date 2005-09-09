Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVIIGz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVIIGz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVIIGz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:55:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:63979 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751416AbVIIGz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:55:57 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
Date: Fri, 9 Sep 2005 08:55:52 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com> <20050909004307.GA18347@wotan.suse.de> <43214AE402000078000247AB@emea1-mh.id2.novell.com>
In-Reply-To: <43214AE402000078000247AB@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509090855.52752.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 08:42, Jan Beulich wrote:
> >Index: linux/include/asm-x86_64/hw_irq.h
> >===================================================================
> >--- linux.orig/include/asm-x86_64/hw_irq.h
> >+++ linux/include/asm-x86_64/hw_irq.h
> >@@ -52,7 +52,7 @@ struct hw_interrupt_type;
> > #define ERROR_APIC_VECTOR	0xfe
> > #define RESCHEDULE_VECTOR	0xfd
> > #define CALL_FUNCTION_VECTOR	0xfc
> >-#define KDB_VECTOR		0xfb	/* reserved for KDB */
> >+#define NMI_VECTOR		0xfb	/* IPI NMIs for debugging */
> > #define THERMAL_APIC_VECTOR	0xfa
> > /* 0xf9 free */
> > #define INVALIDATE_TLB_VECTOR_END	0xf8
>
> This doesn't seem too good an idea: the NMI vector really is 0x02
> (architecturally), so defining it to something else seems at least odd.

Good point. Actually the consensus (or the patch from T.Rini) was 
to name it DEBUG_VECTOR, but I messed that up. Will fix.

>
> >Index: linux/arch/x86_64/kernel/traps.c
> >===================================================================
> >--- linux.orig/arch/x86_64/kernel/traps.c
> >+++ linux/arch/x86_64/kernel/traps.c
> >@@ -931,7 +931,7 @@ void __init trap_init(void)
> > 	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
> > #endif
> >
> >-	set_intr_gate(KDB_VECTOR, call_debug);
> >+	set_intr_gate(NMI_VECTOR, call_debug);
> >
> > 	/*
> > 	 * Should be a barrier for any external CPU state.
>
> I never understood what this does. If you deliver the IPI as an NMI,
> it'll never arrive at this vector, and why would anyone want to put an
> "int $NMI_VECTOR" anywhere?

You can force an NMI when sending an IPI by setting the right bits
in ICR. That is what it is used for.

-Andi
