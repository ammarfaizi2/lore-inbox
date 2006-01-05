Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752182AbWAETo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbWAETo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWAETo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:44:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752182AbWAEToZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:44:25 -0500
Date: Thu, 5 Jan 2006 11:40:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
cc: Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
 <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Linus Torvalds wrote:
> 
> That way the "profile data" actually follows the source code, and is thus 
> actually relevant to an open-source project. Because we do _not_ start 
> having specially optimized binaries. That's against the whole point of 
> being open source and trying to get users to get more deeply involved with 
> the project.

Btw, having annotations obviously works, although it equally obviously 
will limit the scope of this kind of profile data. You won't get the same 
kind of granularity, and you'd only do the annotations for cases that end 
up being very clear-cut. But having an automated feedback cycle for adding 
(and removing!) annotations should make it pretty maintainable in the long 
run, although the initial annotations migh only end up being for really 
core code.

There's a few papers around that claim that programmers are often very 
wrong when they estimate probabilities for different code-paths, and that 
you absolutely need automation to get it right. I believe them. But the 
fact that you need automation doesn't automatically mean that you should 
feed the compiler a profile-data-blob.

You can definitely automate this on a source level too, the same way 
sparse annotations can help find user access problems. 

There's a nice secondary advantage to source code annotations that are 
actively checked: they focus the programmers themselves on the issue. One 
of the biggest advantages (in my opinion) of the "struct xyzzy __user *" 
annotations has actually been that it's much more immediately clear to the 
kernel programmer that it's a user pointer. Many of the bugs we had were 
just the stupid unnecessary ones because it wasn't always obvious.

The same is likely true of rare functions etc. A function that is marked 
"rare" as a hint to the compiler to put it into another segment (and 
perhaps optimize more aggressively for size etc rather than performance) 
is also a big hint to a programmer that he shouldn't care. On the other 
hand, if some branch is marked as "always()", that also tells the 
programmer something real.

So explicit source hints may be more work, but they have tons of 
advantages. Ranging from repeatability and distribution to just the 
programmer being aware of them.

In other projects, maybe people don't care as much about the programmer 
being aware of what's going on - garbage collection etc silent automation 
is all wonderful. In the kernel, I'd rather have people be aware of what 
happens.

		Linus
