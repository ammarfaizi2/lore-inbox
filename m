Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWF0LOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWF0LOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933398AbWF0LOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:14:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31170 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932153AbWF0LOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:14:47 -0400
Date: Tue, 27 Jun 2006 13:09:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com, pavel@suse.cz,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-ID: <20060627110954.GA23672@elte.hu>
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org> <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org> <20060626223526.GA18579@elte.hu> <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org>
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

> On Tue, 27 Jun 2006, Ingo Molnar wrote:
> >
> > i thought about your "map execve pages directly into target" (since the 
> > source gets destroyed anyway) suggestion back then, and unfortunately it 
> > gets quite complex.
> 
> No, you misunderstood.
> 
> I wasn't actually suggesting mapping pages directly from the source 
> into the destination.  That is indeed horribly horribly complicated.

ok, that's good news :-)

>  - And the whole reason for having a limited array basically goes away
>    (the swappable thing is part of it, but the fact that the page 
>    tables themselves are just a lot more extensible than the silly 
>    array is just fundamentally a part of it too)
> 
> So it's literally just the array I'd get rid of. Instead of insertign 
> the page into the array, just insert it directly into the page table 
> with "install_arg_page()".

ok, but there are a few logistical issues:

at copy_strings_kernel() time we dont yet know where in the target VM to 
install the pages. A binformat might want to install all sorts of stuff 
on the stack first, before it constructs the envp and copies the strings 
themselves. So we dont know the precise alignment needed.

delaying the copying to setup_arg_pages() time does not seem to work 
either, because that gets called after the old MM has been destroyed.

[ delaying the copying will also change behavior in error cases - 
  instead of returning with an error if the string pointers are bad 
  we'll have to kill the execve()ing process. ]

am i missing something?

	Ingo
