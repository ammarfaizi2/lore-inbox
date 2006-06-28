Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWF1BHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWF1BHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 21:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWF1BHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:07:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932662AbWF1BHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:07:49 -0400
Date: Tue, 27 Jun 2006 18:07:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com, pavel@suse.cz,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
In-Reply-To: <20060627110954.GA23672@elte.hu>
Message-ID: <Pine.LNX.4.64.0606271801040.3927@g5.osdl.org>
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org>
 <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org> <20060626223526.GA18579@elte.hu>
 <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org> <20060627110954.GA23672@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Ingo Molnar wrote:
> 
> at copy_strings_kernel() time we dont yet know where in the target VM to 
> install the pages. A binformat might want to install all sorts of stuff 
> on the stack first, before it constructs the envp and copies the strings 
> themselves. So we dont know the precise alignment needed.
> 
> delaying the copying to setup_arg_pages() time does not seem to work 
> either, because that gets called after the old MM has been destroyed.

Well, I think we could just change the place the MM is destroyed. We 
shouldn't destroy it until we're done with it ;)

However, I don't think that actually matters. The only thing we _need_ to 
know is what the stack top is going to be, and we know that fairly early. 
The fact that we _also_ add various magic flags onto the stack is 
independent of copying the strings themselves, since the flags ordering is 
not actually something that matters for the _strings_, but for the actual 
setup of the pointers _to_ the strings.

And that's actually where we could potentially be better off without the 
current page[] array, because we could just do it using the user space 
image (and the hardware support for a TLB) itself rather than walk the 
array by hand.

I don't think it's a huge deal. In the end, we'll have to put a limit on 
the argument space _somewhere_. I don't like the current page[] array, and 
it's silly to make the limit so low, but on the other hand, in order to 
avoid excessive time in the kernel by badly behaved apps, and because any 
good application _needs_ to be able to handle the limited argument space 
anyway, I actually suspect it really doesn't matter in the end.

			Linus
