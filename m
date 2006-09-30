Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWI3Wyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWI3Wyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWI3Wyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:54:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751661AbWI3Wyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:54:38 -0400
Date: Sat, 30 Sep 2006 15:54:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <200609302357.06215.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609301548270.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <20060930204900.GA576@elte.hu> <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
 <200609302357.06215.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Andi Kleen wrote:
> 
> That wouldn't work with interrupt stacks.

Andi.

Please spend even just a few minutes looking at the old i386 code.

> The old unwinder code had a state machine to deal with them, but it was 
> distingustingly complicated (there are nasty corner cases where you can 
> be in multiple interrupt stacks nested). I'm not sure we would have 
> really wanted to retain that.

Here's what the old code did:

	frameptr = initialize frame code
	while (1) {
		struct thread_info *context;
		context = (struct thread_info *)
			((unsigned long)stack & (~(THREAD_SIZE - 1)));
		frameptr = print_context_stack(context, stack, frameptr, log_lvl);
		stack = (unsigned long*)context->previous_esp;
		if (!stack)
			break;
		printk(" =======================\n");
	}

it it really was that simple. The actual frame-following code was in 
"print_context_stack()", and it works entirely within a single stack page, 
and returns once it is outside that stack page. 

There is absolutely ZERO problem with new pages through interrupt stacks 
etc, because we don't even trust the stack contents for that, we just 
follow the stack context pointers that we _can_ trust.

		Linus
