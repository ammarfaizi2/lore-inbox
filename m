Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWFBHhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWFBHhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFBHhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:37:15 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43464
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751275AbWFBHhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:37:14 -0400
Message-Id: <448006F6.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 02 Jun 2006 09:37:58 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <jeff@garzik.org>, <htejun@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <reuben-lkml@reub.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <447EF7A8.76E4.0078.0@novell.com> <447FFCAC.76E4.0078.
In-Reply-To: <447FFCAC.76E4.0078.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>firstly, i'd suggest to use another magic value for 'bottom of call 
>stacks' - it is way too common to jump or call a NULL pointer. Something 
>like 0xfedcba9876543210 would be better.

That's contrary to common use (outside of the kernel). I'm opposed to this. Detecting an initial bad EIP isn't a
problem, and the old code can be used easily in that case.

>for the RIP/EIP to get corrupted is a common occurance. So is stack 
>corruption. So the fallback mechanism shouldnt be a 'short while' 
>side-thought, it must be part of the design.

RIP/EIP corruption, as said above, can be easily handled. RSP/ESP corruption, as I understand it, isn't being handled
in the old code, and so I can't see what improvements the new code could do here (given that instruction and stack
pointers serve as the anchors for kicking off an unwind).

>In all other cases (if we go outside of the stack page(s)) we _must_ 
>fall back to the dump 'scan the stack pages for interesting entries' 
>method, to get the information out! "Uh oh the unwind info somehow got 
>corrupted, sorry" is not enough to debug a kernel bug.

Again, you miss the point that the very last unwind operation must always be expected to move the stack pointer outside
the stack boundaries, which would mean triggering the fallback path in all cases. With this, we could as well leave out
the entire unwind code and keep everyone of us manually do the separation of good and bad entries in the trace shown.

Jan
