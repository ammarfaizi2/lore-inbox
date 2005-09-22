Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVIVUyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVIVUyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVIVUyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:54:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751186AbVIVUyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:54:52 -0400
Date: Thu, 22 Sep 2005 13:54:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
 atomic
In-Reply-To: <200509222137.41412.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0509221341230.2553@g5.osdl.org>
References: <200509211923.21861.blaisorblade@yahoo.it>
 <200509212222.50653.blaisorblade@yahoo.it> <20050921134724.52603016.akpm@osdl.org>
 <200509222137.41412.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Sep 2005, Blaisorblade wrote:
>
> Exactly - the point is: is it legal to call copy_from_user() while holding a 
> spinlock (which is my original question)? Or should copy_from_user try to 
> satisfy the fault, instead of seeing in_atomic() or something similar and 
> fail?

It is not legal to call copy_to/from_user() under a spinlock in general.

But what _is_ legal to do is something slightly more complex, ie

	spin_lock(...)
	inc_preempt_count();
	ret = __copy_from_user_inatomic(..)
	dec_preempt_count();
	spin_unlock();

but you have to realize that the copy-from-user will fail if the target is 
swapped out (so the code that does things like this has to look at the 
return value, and if the copy didn't copy anything it needs to release the 
locks and do it all over again without the atomic thing).

We don't do it very much, because it gets more complicated and it hasn't
historically been legal, but it could in theory be very useful if you hold
a lock and want to avoid releasing and re-taking it just to do a user
access.

Right now the only case where that happens is the futex code, and maybe 
that's a very special case. But maybe it isn't. 

			Linus
