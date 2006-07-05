Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWGEVWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWGEVWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWGEVWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:22:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965022AbWGEVWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:22:01 -0400
Date: Wed, 5 Jul 2006 14:21:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
In-Reply-To: <20060705204727.GA16615@elte.hu>
Message-ID: <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
References: <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu>
 <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu>
 <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu>
 <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu>
 <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
 <20060705204727.GA16615@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Ingo Molnar wrote:
> 
> i had CONFIG_DEBUG_INFO (and UNWIND_INFO) disabled in all these build 
> tests.

Good, because I just verified: those two together will on their own 
increase "text size" by about 17% for me.

I still think Andrew is right: I don't see how an initializer that should 
basically be three instructions can possibly be 35 bytes larger than a 
function call that should be a minimum of two instructions (argument setup 
in %eax and the actual call - and that's totally ignoring the 
deleterious effects of a function call on register liveness). 

The fact that with allnoconfig the kernel is _smaller_ (but, quite 
franlkly, within the noise) with the inlined version would seem to back up 
Andrews position that it really shouldn't matter.

So I'm left wondering why it matters for you, and what triggers it. Maybe 
there is some secondary issue that could show us an even more interesting 
optimization (or some compiler behaviour that we should try to encourage).

It is, for example, entirely possible that the size reduction is REAL, but 
that it comes from some other interesting source like gcc deciding to not 
inline a function that isn't a leaf function - and that turning those 
init_waitqueue_*() functions into real function calls thus has a secondary 
effect that is the _real_ advantage.

In other words, I think the patch is fine per se, and I wouldn't mind 
applying it at all, but I think it would be good to understand _what_ 
exactly makes for the reduction in size.

In particular, if it is some secondary effect, maybe we'd be better off 
trying to aim for that secondary effect _directly_.

See?

			Linus
