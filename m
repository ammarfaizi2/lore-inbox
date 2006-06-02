Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWFBHvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWFBHvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWFBHvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:51:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61370 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751281AbWFBHvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:51:31 -0400
Date: Fri, 2 Jun 2006 09:51:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: jeff@garzik.org, htejun@gmail.com, Andrew Morton <akpm@osdl.org>,
       reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602075150.GA12212@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <447EF7A8.76E4.0078.0@novell.com> <448006F6.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448006F6.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5056]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <jbeulich@novell.com> wrote:

> >firstly, i'd suggest to use another magic value for 'bottom of call 
> >stacks' - it is way too common to jump or call a NULL pointer. Something 
> >like 0xfedcba9876543210 would be better.
> 
> That's contrary to common use (outside of the kernel). I'm opposed to 
> this. Detecting an initial bad EIP isn't a problem, and the old code 
> can be used easily in that case.

but 0 is pretty much the worst choice for something that needs to be 
reliable - it's the most common type of machine word in existence, 
amongst all the 18446744073709551616 possibilities. And we need not care 
about userspace's prior choices, this code and data is totally under the 
kernel's control.

> >for the RIP/EIP to get corrupted is a common occurance. So is stack 
> >corruption. So the fallback mechanism shouldnt be a 'short while' 
> >side-thought, it must be part of the design.
> 
> RIP/EIP corruption, as said above, can be easily handled. RSP/ESP 
> corruption, as I understand it, isn't being handled in the old code, 
> and so I can't see what improvements the new code could do here (given 
> that instruction and stack pointers serve as the anchors for kicking 
> off an unwind).

i'm not only talking about RSP/ESP corruption, but about stack 
corruption. I.e. some area of the stack is corrupted. With the scanning 
method we at least get some other entries out - while with the unwind 
method we only say 'sorry'.

anyway, i think that handling a bad initial RIP/EIP would be a good 
first step and it should solve the problem at hand. (it will also serve 
as a basis for whatever other heuristics we might want to apply later 
on)

> >In all other cases (if we go outside of the stack page(s)) we _must_ 
> >fall back to the dump 'scan the stack pages for interesting entries' 
> >method, to get the information out! "Uh oh the unwind info somehow got 
> >corrupted, sorry" is not enough to debug a kernel bug.
> 
> Again, you miss the point that the very last unwind operation must 
> always be expected to move the stack pointer outside the stack 
> boundaries, which would mean triggering the fallback path in all 
> cases. With this, we could as well leave out the entire unwind code 
> and keep everyone of us manually do the separation of good and bad 
> entries in the trace shown.

no, i dont miss that point at all. What _you_ are missing is the obvious 
solution: stacks on x86_64 are already linked to each other, via 
fixed-position pointers at the end of the stackpages. So the unwinder 
can easily check whether the 'next stack' as suggested by the link at 
the end of the page is indeed the same as the unwind jumpout does. If 
not => fallback.

same for i386 - there too the stacks are linked via non-unwind data. The 
unwinder can do a pretty good verification of the jumpout.

	Ingo
