Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWGEVth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWGEVth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWGEVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:49:37 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27349 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965059AbWGEVth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:49:37 -0400
Date: Wed, 5 Jul 2006 23:45:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705214502.GA27597@elte.hu>
References: <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu> <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 5 Jul 2006, Ingo Molnar wrote:
> > 
> > i had CONFIG_DEBUG_INFO (and UNWIND_INFO) disabled in all these build 
> > tests.
> 
> Good, because I just verified: those two together will on their own 
> increase "text size" by about 17% for me.
> 
> I still think Andrew is right: I don't see how an initializer that 
> should basically be three instructions can possibly be 35 bytes larger 
> than a function call that should be a minimum of two instructions 
> (argument setup in %eax and the actual call - and that's totally 
> ignoring the deleterious effects of a function call on register 
> liveness).
> 
> The fact that with allnoconfig the kernel is _smaller_ (but, quite 
> franlkly, within the noise) with the inlined version would seem to 
> back up Andrews position that it really shouldn't matter.

well, the allnoconfig thing is artificial (and the uninteresting) for a 
number of reasons:

- it has REGPARM disabled which penalizes function calls

- it's UP and hence the inlining cost of init_wait_queue_head() is 
  significantly smaller.

- allnoconfig has smaller average function size - increasing the cost of 
  uninlining

> So I'm left wondering why it matters for you, and what triggers it. 
> Maybe there is some secondary issue that could show us an even more 
> interesting optimization (or some compiler behaviour that we should 
> try to encourage).

yeah, i'd not want to skip over some interesting and still unexplained 
effect either, but 35 bytes isnt all that outlandish and from everything 
i've seen it's a real win. Here is an actual example:

 c0fb6137:       c7 44 24 08 00 00 00    movl   $0x0,0x8(%esp)
 c0fb613e:       00
 c0fb613f:       c7 44 24 08 01 00 00    movl   $0x1,0x8(%esp)
 c0fb6146:       00
 c0fb6147:       c7 43 60 00 00 00 00    movl   $0x0,0x60(%ebx)
 c0fb614e:       8b 44 24 08             mov    0x8(%esp),%eax
 c0fb6152:       89 43 5c                mov    %eax,0x5c(%ebx)
 c0fb6155:       8d 43 64                lea    0x64(%ebx),%eax
 c0fb6158:       89 40 04                mov    %eax,0x4(%eax)
 c0fb615b:       89 43 64                mov    %eax,0x64(%ebx)

versus:

 c0fb070e:       8d 43 5c                lea    0x5c(%ebx),%eax
 c0fb0711:       e8 94 98 18 ff          call   c0139faa <init_waitqueue_head>

so 39 bytes versus 8 bytes - 31 bytes saved. It's a similar win in other 
cases i checked too. (the only exception is for smaller functions that i 
mentioned before: where the parameters are not pre-calculated yet so 
there's no good integration for the function call. In that case it's 
break even, or in some cases a 3-4 bytes loss.)

	Ingo
