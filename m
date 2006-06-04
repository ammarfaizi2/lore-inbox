Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932208AbWFDI7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWFDI7V (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWFDI7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:59:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23271 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932208AbWFDI7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:59:20 -0400
Date: Sun, 4 Jun 2006 10:58:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        "Barry K. Nathan" <barryn@pobox.com>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags bug
Message-ID: <20060604085836.GA8931@elte.hu>
References: <20060604083017.GA8241@elte.hu> <16537.1149411027@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16537.1149411027@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Keith Owens <kaos@ocs.com.au> wrote:

> Ingo Molnar (on Sun, 4 Jun 2006 10:30:17 +0200) wrote:
> >2) allowing the nesting of hardware interrupts only 'spreads out'
> >the handling of the current ISR, causing extra cachemisses that would
> >otherwise not happen. Furthermore, on architectures where ISRs share
> >the kernel stacks, enabling interrupts in ISRs introduces a much
> >higher kernel-stack-nesting and thus kernel-stack-overflow risk.
> 
> It is worse than you think.  A third party network driver enabled 
> interrupts in its irq handler.  For reasons that are still not clear, 
> that allowed recursive interrupts from the same device.  Unexpected I 
> know, because the card's ISR should still have been masked, but the 
> stack trace said otherwise.  When multiple packets arrived for the 
> same driver it drove multiple levels of kernel functions to handle 
> them and completely blew the kernel stack, even though it was using a 
> separate IRQ stack.

ouch!

They seem to be quite rare in practice (Barry's was the only one so 
far), but when they happen they can be very nasty. So the lock validator 
creates some gentle pressure to get these fixed ;-) For the really 
really rare cases where the irq enabling is justified (mostly old, very 
slow hardware) it can be easily annotated for lockdep.

	Ingo
