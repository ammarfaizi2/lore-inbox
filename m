Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVG2JqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVG2JqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVG2JqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:46:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12490 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262542AbVG2JqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:46:09 -0400
Date: Fri, 29 Jul 2005 11:45:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729094519.GA12975@elte.hu>
References: <20050729070447.GA3032@elte.hu> <200507290722.j6T7Mig07477@unix-os.sc.intel.com> <20050729082826.GA6144@elte.hu> <20050729100257.A10345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729100257.A10345@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Jul 29, 2005 at 10:28:26AM +0200, Ingo Molnar wrote:
> > @@ -2872,10 +2878,10 @@ go_idle:
> >  	/*
> >  	 * Prefetch (at least) a cacheline below the current
> >  	 * kernel stack (in expectation of any new task touching
> > -	 * the stack at least minimally), and a cacheline above
> > -	 * the stack:
> > +	 * the stack at least minimally), and at least a cacheline
> > +	 * above the stack:
> >  	 */
> > -	prefetch_range(kernel_stack(next) - MIN_KERNEL_STACK_FOOTPRINT,
> > +	prefetch_range(kernel_stack(next) - L1_CACHE_BYTES,
> >  		       MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);
> 
> This needs to ensure that we don't prefetch outside the page of the 
> kernel stack - otherwise we risk weird problems on architectures which 
> support prefetching but not DMA cache coherency.

ok, agreed. Since kernel_stack(next) defaults to 'next', we go below 
that structure which has unknown coherency attributes. I guess the 
easiest solution would be to default kernel_stack(next) to '(void *)next 
+ L1_CACHE_BYTES'? That way the default prefetching would happen for the 
[next...next+2*L1_BYTES] range.

	Ingo
