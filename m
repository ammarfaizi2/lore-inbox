Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWJDJUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWJDJUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbWJDJUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:20:43 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:30080 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030548AbWJDJUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:20:43 -0400
Message-Id: <45239953.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 11:21:55 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Eric Rannaud" <eric.rannaud@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <nagar@watson.ibm.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
 <200609302230.24070.ak@suse.de>
 <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org>
 <20060930204900.GA576@elte.hu>
 <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Linus Torvalds <torvalds@osdl.org> 30.09.06 23:11 >>>
>It could - and _should_ dammit! - do some basic sanity tests like "is the 
>thing even in the same stack page"? But nooo... It seems _designed_ to be 
>fragile and broken.

Your opinion. Mine's different, as the unwind directives are specifically
meant to allow changing to a different stack page. Also, there shouldn't
be any potential for corrupt unwind data (once all annotations are
correct, the lack or incorrectness of which I'd rather attribute as bugs
of the old code or, in one case, the compiler) as long as it's being
properly write protected; corruption of the stack should be affecting
the quality of old and new style back traces in similar ways.

>Here's a simple test: if the next stack-slot isn't on the same page, the 
>unwind information is bogus unless you had the IRQ stack-switch signature 
>there. Does the code do that? No. It just assumes that unwind information 
>is complete and perfect.
>
>That's not the kind of code we write in the kernel. In the kernel, we 
>write code that _works_, regardless of the kind of horrible stuff people 
>feed it. That's _doubly_ true for something like a stack frame debugger, 
>which is invoced when there is trouble, and for all we know the stack 
>itself MIGHT BE CORRUPT.
>
>In short, I think the stack unwinder is just _broken_. It has made all the 
>wrong policy decisions - it only works when everything is perfect, yet 
>it's actually meant to be _used_ when somethign bad happened. Doesn't that 
>strike anybody else as a totally flawed design?

Again, a corrupt stack will not allow you getting reliable data out of the
old unwinder either. Even worse when you consider a stack overflow and
your request for range checks (or pointers into the stack) - you might not
get a stack trace then at all.

Jan
