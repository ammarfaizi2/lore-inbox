Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWFBHJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWFBHJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFBHJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:09:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43212 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751130AbWFBHJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:09:51 -0400
Date: Fri, 2 Jun 2006 09:09:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, jeff@garzik.org, htejun@gmail.com,
       reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602070948.GB9721@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <447EF7A8.76E4.0078.0@novell.com> <447FFCAC.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447FFCAC.76E4.0078.0@novell.com>
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


* Jan Beulich <jbeulich@novell.com> wrote:

> >- Make the code robust and able to detect "unexpected" states at all
> >  points through the process.  If at the end of the process we see that we
> >  have encountered an unexpected state,
> 
> The problem is that the unwind is expected to end with an odd state 
> (i.e. fail), at least until all possible root points of execution 
> (i.e. bottoms of call stacks) have a proper annotation forcing their 
> parent program counter to zero (which I don't expect to happen soon, 
> if ever, because I think this is something difficult to prove). Thus 
> the only reasonable thing to do is to check whether the first level of 
> unwinding failed.

firstly, i'd suggest to use another magic value for 'bottom of call 
stacks' - it is way too common to jump or call a NULL pointer. Something 
like 0xfedcba9876543210 would be better.

> >  - emit a diagnostic so Jan can work out if there's a way to improve
> >    the unwinder in this situation
> 
> >  - do a traditional backtrace as well.
> 
> This might be a config or boot option (and might be forced on for a 
> short while), but I generally don't think this is helpful, given that 
> the entire point of the added logic is to remove (useless) information 
> (even more that if you have to rely on the screen alone, you have to 
> live with its limited size, and pushing out an old-style stack trace 
> after the unwound one would likely make part or all of it as well as 
> the register information disappear).

for the RIP/EIP to get corrupted is a common occurance. So is stack 
corruption. So the fallback mechanism shouldnt be a 'short while' 
side-thought, it must be part of the design.

If we use a much better magic value to delimit the stack then our 
confidence that the stacktrace is correct will be much higher.

In all other cases (if we go outside of the stack page(s)) we _must_ 
fall back to the dump 'scan the stack pages for interesting entries' 
method, to get the information out! "Uh oh the unwind info somehow got 
corrupted, sorry" is not enough to debug a kernel bug.

What we _can_ ignore are stack/register corruptions that accidentally 
cause a valid unwind call chain to be printed. That is impossible to 
detect and it's much less likely than say normal stack or register 
corruption. But we _must not_ ignore clear parsing errors. This is a 
really basic thing ...

	Ingo
