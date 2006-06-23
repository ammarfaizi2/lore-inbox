Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932995AbWFWKXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995AbWFWKXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbWFWKXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:23:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44174 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932995AbWFWKXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:23:36 -0400
Date: Fri, 23 Jun 2006 12:18:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rmk@arm.linux.org.uk
Subject: Re: [patch 36/61] lock validator: special locking: serial
Message-ID: <20060623101840.GL4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212604.GJ3155@elte.hu> <20060529183533.75381871.akpm@osdl.org> <20060623094941.GE4889@elte.hu> <20060623030447.a8061690.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623030447.a8061690.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> btw, I was looking at this change:

> @@ -1003,6 +1003,7 @@ unsigned ata_exec_internal(struct ata_de
>  	unsigned int err_mask;
>  	int rc;
>  
> +	init_completion(&wait);
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	/* no internal command while frozen */
> 
> That local was already initialised with DEFINE_COMPLETION().  Am 
> surprised that an init_completion() also was needed?

That's a fundamental problem of DECLARE_COMPLETION() done on the kernel 
stack - it does build-time initialization with no opportunity to inject 
any runtime logic. (which lockdep would need. Maybe i missed some clever 
way to add a runtime callback into the initialization? [*])

Btw., there is no danger from missing the initialization of a wait 
structure: lockdep will detect "uninitialized" on-stack locks and will 
complain about it and turn itself off. [this happened a few times during 
development - that's how those init_completion() calls got added]

But at a minimum these initializations need to become lockdep-specific 
key-reinits - otherwise there will be impact to non-lockdep kernels too.

	Ingo

[*] the only solution i can see is to introduce 
DECLARE_COMPLETION_ONSTACK(), which could call a function with &wait 
passed in, where that function would return with a structure. The macro 
magic would resolve to something like:

  struct completion wait = lockdep_init_completion(&wait);

and thus the structure would be initialized. But this method cannot be 
used for static scope uses of DECLARE_COMPLETION, because it's not a 
constant initializer. So we'd definitely have to make a distinction in 
terms of _ONSTACK(). Is there really no compiler feature that could help 
us out here?
