Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWJTKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWJTKZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWJTKZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 06:25:09 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:61479
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932143AbWJTKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 06:25:08 -0400
Message-Id: <4538C07F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 20 Oct 2006 11:26:39 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <ak@suse.de>, "Badari Pulavarty" <pbadari@us.ibm.com>
Cc: <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1 unwinder issues ?
References: <1161210966.18117.33.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1161210966.18117.33.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Badari Pulavarty <pbadari@us.ibm.com> 19.10.06 00:36 >>>
>Hi Andi,
>
>I am not getting stack traces properly on 2.6.19-rc2-mm1 again 
>(on my amd64 box).
>
>Wondering, if the unwinder code changed again ??
>
>Thanks,
>Badari

This patch:

>Annotate interrupt frame backlink in interrupt handlers
>
>Add correct CFI annotation to the backlink on top of the interrupt stack.
>
>Signed-off-by: Andi Kleen <ak@suse.de>
>
>---
> arch/x86_64/kernel/entry.S |    3 +++
> 1 files changed, 3 insertions(+)
>
>Index: linux/arch/x86_64/kernel/entry.S
>===================================================================
>--- linux.orig/arch/x86_64/kernel/entry.S
>+++ linux/arch/x86_64/kernel/entry.S
>@@ -535,6 +535,8 @@ END(stub_rt_sigreturn)
> 1:	incl	%gs:pda_irqcount
> 	cmoveq %gs:pda_irqstackptr,%rsp
> 	push    %rbp			# backlink for old unwinder
>+	CFI_ADJUST_CFA_OFFSET 8
>+	CFI_REL_OFFSET rbp,0
> 	/*
> 	 * We entered an interrupt context - irqs are off:
> 	 */
>@@ -1174,6 +1176,7 @@ ENTRY(call_softirq)
> 	incl %gs:pda_irqcount
> 	cmove %gs:pda_irqstackptr,%rsp
> 	push  %rbp			# backlink for old unwinder
>+	CFI_ADJUST_CFA_OFFSET    8
> 	call __do_softirq
> 	leaveq
> 	CFI_DEF_CFA_REGISTER	rsp

must be reverted for things to work again. Andi, what did you
want to cure with it? Clearly, when rSP isn't the CFA register
anymore, there must not (normally) be adjustments to the
CFA offset. Similarly, when a register was saved already and
it's not its spill location that changes, it must not be marked
as being saved a second time.

Jan
