Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965555AbWKNMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965555AbWKNMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965556AbWKNMn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:43:26 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:5498 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S965555AbWKNMnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:43:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=jjqpnEwtLXydwJ91lxP9Kmv4xvdVvkmRcc29AlY6WCMnp7XC96UUbWITmXg4Ew68Ro4eyAIjkDEBGLo2R29+3w==  ;
Message-ID: <28113644.334031163508202925.komurojun-mbn@nifty.com>
Date: Tue, 14 Nov 2006 21:43:22 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: Ingo Molnar <mingo@redhat.com>
Subject: Re: [patch] irq: do not mask interrupts by default
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1163492040.28401.76.camel@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <1163492040.28401.76.camel@earth>
 <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	 <1162985578.8335.12.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <7813413.118221162987983254.komurojun-mbn@nifty.com>
	 <11940937.327381163162570124.komurojun-mbn@nifty.com>
	 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	 <m13b8ns24j.fsf@ebiederm.dsl.xmission.com> <1163450677.7473.86.camel@earth>
	 <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ingo

I tried your patch with 2.6.19-rc5.

The irq is generated properly.


Thanks!

Best Regards
Komuro


>>
>------------>
>Subject: irq: do not mask interrupts by default
>From: Ingo Molnar <mingo@elte.hu>
>
>never mask interrupts immediately upon request. Disabling
>interrupts in high-performance codepaths is rare, and on
>the other hand this change could recover lost edges (or
>even other types of lost interrupts) by conservatively
>only masking interrupts after they happen. (NOTE: with
>this change the highlevel irq-disable code still soft-disables
>this IRQ line - and if such an interrupt happens then the
>IRQ flow handler keeps the IRQ masked.)
>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>---
> kernel/irq/chip.c |   13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
>Index: linux/kernel/irq/chip.c
>===================================================================
>--- linux.orig/kernel/irq/chip.c
>+++ linux/kernel/irq/chip.c
>@@ -202,10 +202,6 @@ static void default_enable(unsigned int 
>  */
> static void default_disable(unsigned int irq)
> {
>-	struct irq_desc *desc = irq_desc + irq;
>-
>-	if (!(desc->status & IRQ_DELAYED_DISABLE))
>-		desc->chip->mask(irq);
> }
> 
> /*
>@@ -272,8 +268,11 @@ handle_simple_irq(unsigned int irq, stru
> 	kstat_cpu(cpu).irqs[irq]++;
> 
> 	action = desc->action;
>-	if (unlikely(!action || (desc->status & IRQ_DISABLED)))
>+	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
>+		if (desc->chip->mask)
>+			desc->chip->mask(irq);
> 		goto out_unlock;
>+	}
> 
> 	desc->status |= IRQ_INPROGRESS;
> 	spin_unlock(&desc->lock);
>@@ -366,11 +365,13 @@ handle_fasteoi_irq(unsigned int irq, str
> 
> 	/*
> 	 * If its disabled or no action available
>-	 * keep it masked and get out of here
>+	 * then mask it and get out of here:
> 	 */
> 	action = desc->action;
> 	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
> 		desc->status |= IRQ_PENDING;
>+		if (desc->chip->mask)
>+			desc->chip->mask(irq);
> 		goto out;
> 	}
> 
>
>

