Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWJRHkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWJRHkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWJRHkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:40:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23688 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932091AbWJRHkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:40:51 -0400
Date: Wed, 18 Oct 2006 09:32:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
       mgreer@mvista.com, sshtylyov@ru.mvista.com
Subject: Re: [PATCH -rt] powerpc update
Message-ID: <20061018073234.GA31118@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com> <20061018072858.GA29576@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018072858.GA29576@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> really, the ->eoi() op should only be called for true fasteoi cases. 
> What we want here is to turn the fasteoi handler into a handler that 
> does mask+ack and then unmask. Not 'mask+eoi ... unmask' as your patch 
> does.

i.e. like the much simpler patch below. That's what i've applied to the 
soon-to-be-rt6 tree, plus the other bits of your patch. Can you confirm 
this works well on PPC?

	Ingo

Index: linux-rt.q/kernel/irq/chip.c
===================================================================
--- linux-rt.q.orig/kernel/irq/chip.c
+++ linux-rt.q/kernel/irq/chip.c
@@ -386,13 +386,15 @@ handle_fasteoi_irq(unsigned int irq, str
 	}
 
 	desc->status |= IRQ_INPROGRESS;
+
 	/*
-	 * fasteoi should not be used for threaded IRQ handlers!
+	 * In the threaded case we fall back to a mask+ack sequence:
 	 */
 	if (redirect_hardirq(desc)) {
-		WARN_ON_ONCE(1);
+		mask_ack_irq(desc, irq);
 		goto out_unlock;
 	}
+
 	desc->status &= ~IRQ_PENDING;
 	spin_unlock(&desc->lock);
 
