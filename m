Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbVIOPNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVIOPNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVIOPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:13:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030491AbVIOPNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:13:36 -0400
Date: Thu, 15 Sep 2005 08:12:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
In-Reply-To: <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org>
References: <20050914212405.GD4966@opteron.random>
 <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Sep 2005, Hugh Dickins wrote:
> 
> Just like you and Nick, I'd be happy to revert maybe_mkwrite, and our
> recent patch to rescue it.  But I don't know the pressures which led
> to its introduction in the first place.  CC'ed Roland who introduced
> it in 2.6.4, and Linus who supported it in the recent discussions.

It is clear that ptrace() _has_ to change semantics when it writes to a 
shared page. That's fundamental. There's no way to avoid the COW, and yes, 
that COW will have strange behaviour because it's semantically illegal (ie 
the changed page will not be shared with anything else, including 
necessarily subsequent fork()'ed children depending on if/how we change 
that at some point).

So the question is whether we do the _minimal_ semantic changes (just COW) 
or whether we do even more semantic breakage.

Roland's patch tries to keep the semantic breakage to a minimum. The COW
is forced upon us and there's no way we can avoid it, but the permission 
change can be temporary and local to the ptrace, which is what we do now.

I personally think that it's a pretty ugly thing, but all the real
ugliness is in the COW part - which we can't avoid. Rolands change is less
so. In fact, in many ways I think Roland's change is quite nice: you can
have a PROT_READONLY/PROT_NONE area that is visible from the debugger, but
continues to cause SIGSEGV's if the user process itself tries to access
it. To me, that's good.

There would have to be some real advantage to _not_ doing what we're doing 
now. And I don't see an advantage.

The real complexity is not "maybe_mkwrite()", which is trivial. The real 
complexity is the fact that we COW, but that's not something we can avoid, 
and that's not something that has anything to do with maybe_mkwrite().

			Linus
