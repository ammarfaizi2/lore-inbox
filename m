Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWF3K06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWF3K06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWF3K06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:26:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9109 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932271AbWF3K05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:26:57 -0400
Date: Fri, 30 Jun 2006 12:22:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm4
Message-ID: <20060630102210.GC16567@elte.hu>
References: <200606300609_MC3-1-C3D7-6B49@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606300609_MC3-1-C3D7-6B49@compuserve.com>
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


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20060629232739.GA28306@elte.hu>
> 
> On Fri, 30 Jun 2006 01:27:39 +0200, Ingo Molnar wrote:
> 
> > > +profile-likely-unlikely-macros.patch
> > 
> > CONFIG_PROFILE_LIKELY doesnt quite work:
> > 
> >  Low memory ends at vaddr f7e00000
> >  node 0 will remap to vaddr f7e00000 - f8000000
> >  High memory starts at vaddr f7e00000
> >  found SMP MP-table at 000f5680
> >  NX (Execute Disable) protection: active
> >  Unknown interrupt or fault at EIP 00000060 c1d9f264 00000002
> >  Unknown interrupt or fault at EIP 00000060 c0100295 0000f264
> >  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
> >  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
> >  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
> >  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
> > 
> > disabling it makes these go away.
> 
> Can you find out what source line belongs to c1d9f264?
> 
> arch/i386/kernel/head.S::ignore_int(), which produced those messages, 
> is horribly broken.  The first fault was likely a page fault 
> attempting to write to some unmapped area.  Since page fault pushes an 
> error code onto the stack and ignore_int() doesn't pop it because it 
> has no idea whether one is there, it attempts to return to cs:eip 
> f264:00000002 which causes segment-not-present for segment index f264 
> in the GDT. Same thing then happens when _that_ tries to return to 
> 0295:0000f264; now we are into infinite recursion. Eventually the 
> stack will overflow and more fun errors will occur...
> 
> Is this worth fixing?  We could get nice diagnostics for page fault 
> here by writing a handler for early init code.

yes, it's worth fixing if it doesnt complicate that code too much - i 
run across such early init faults every couple of weeks when hacking 
various code. (Maybe just some generic 'dump 64 bytes of the top of the 
stack' would be enough too. Early-bootup is fragile enough already.)

	Ingo
