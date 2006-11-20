Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966391AbWKTTMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966391AbWKTTMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966447AbWKTTMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:12:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16603 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966391AbWKTTMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:12:47 -0500
Date: Mon, 20 Nov 2006 20:11:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120191149.GA32537@elte.hu>
References: <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com> <20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com> <20061120172642.GA8683@elte.hu> <20061120175502.GA12733@elte.hu> <4561F43B.40000@ru.mvista.com> <20061120191013.GA30828@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120191013.GA30828@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0583]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> >    Hmm, that just won't do for PPC threaded fasteoi flows! What you'll 
> > get is a threaded IRQ with EOI *never ever* issued, unless my PPC 
> > patch is also in...
> 
> ok, how about the patch below in addition?

or rather, the one below. Untested.

	Ingo

Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -392,11 +394,12 @@ handle_fasteoi_irq(unsigned int irq, str
 	desc->status |= IRQ_INPROGRESS;
 
 	/*
-	 * In the threaded case we fall back to a mask+ack sequence:
+	 * In the threaded case we fall back to a mask+eoi sequence:
 	 */
 	if (redirect_hardirq(desc)) {
-		mask_ack_irq(desc, irq);
-		goto out_unlock;
+		if (desc->chip->mask)
+			desc->chip->mask(irq);
+		goto out;
 	}
 
 	desc->status &= ~IRQ_PENDING;
