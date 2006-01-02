Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWABKhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWABKhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 05:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWABKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 05:37:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48362 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932101AbWABKhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 05:37:47 -0500
Date: Mon, 2 Jan 2006 11:37:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102103721.GA8701@elte.hu>
References: <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231150831.GL3811@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> My email was about things like Andi's example of the x86-64 vsyscall 
> code where we really need inlining, and due to your proposed inline 
> semantics change there might be breakages if an __always_inline is 
> forgotten at a place where it was required.

we can have two types of breakages:

 - stuff wont build if not always_inline. Really easy to find and fix.

 - stuff wont work at all (e.g. vsyscalls) because they have some
   unspecified reliance on gcc's code output. Such code Is Bad anyway,
   and the breakage is still clear: the vsyscalls wont work at all, it's
   quickly found, the appropriate always_inline is inserted, and the
   incident is forgotten.

talking about 'safer' or 'risky' in this context is misleading, these 
are very clear symptoms which are easy to fix.

[ If you didnt talk about this uninline patch in the "we have to wait 
  one year" comment then please clarify that - all that came through to 
  me was some vague "lets wait with this" message, and it wasnt clear 
  (to me) which patch it applied to and why. ]

> Your uninline patch might be simple, but the safe way would be Arjan's 
> approach to start removing all the buggy inline's from .c files.

sure, that's another thing to do, but it's also clear that there's no 
reason to force inlines in the -Os case.

There are 22,000+ inline functions in the kernel right now (inlined 
about a 100,000 times), and we'd have to change _thousands_ of them. 
They are causing an unjustified code bloat of somewhere around 20-30%. 
(some of them are very much justified, especially in core kernel code)

to say it loud and clear again: our current way of handling inlines is 
_FUNDAMENTALLY BROKEN_. To me this means that fundamental changes are 
needed for the _mechanics_ and meaning of inlines. We default to 'always 
inline' which has a current information to noise ratio of 1:10 perhaps.  
My patch changes the mechanics and meaning of inlines, and pretty much 
anything else but a change to the meaning of inlines will still result 
in the same scenario occuring over and over again.

	Ingo
