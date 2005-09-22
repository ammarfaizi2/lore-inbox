Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVIVT65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVIVT65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVIVT64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:58:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030290AbVIVT64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:58:56 -0400
Date: Thu, 22 Sep 2005 12:58:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, torvalds@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
 atomic
Message-Id: <20050922125801.1b7894d2.akpm@osdl.org>
In-Reply-To: <200509222137.41412.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<200509212222.50653.blaisorblade@yahoo.it>
	<20050921134724.52603016.akpm@osdl.org>
	<200509222137.41412.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Wednesday 21 September 2005 22:47, Andrew Morton wrote:
> > Blaisorblade <blaisorblade@yahoo.it> wrote:
> > > On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> > > > "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > > > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> > > > It has accidental side-effects,
> > > > such as making copy_to_user() fail if inside spinlocks when
> > > > CONFIG_PREEMPT=y.
> 
> > > Sorry, but should it ever succeed inside spinlocks? I mean, should it
> > > ever call down() inside spinlocks? (We never do down_trylock, and ever if
> > > we did the x86 trick, that wouldn't make the whole thing safe at all -
> > > they still take the spinlock and potentially sleep. And it's legal only
> > > if no spinlock is held).
> 
> > Not sure what you're asking here.
> 
> > copy_to/from_user() will fail inside spinlock if CONFIG_PREMPT=y and if the
> > copy happens to cause a fault.
> 
> > Otherwise it will succeed inside spinlock, 
> > and it won't spew a sleeping-while-atomic warning, because that uses
> > in_atomic() too.
> 
> > It might deadlock if we schedule away and try to retake 
> > the same lock.
> Exactly - the point is: is it legal to call copy_from_user() while holding a 
> spinlock (which is my original question)? Or should copy_from_user try to 
> satisfy the fault, instead of seeing in_atomic() or something similar and 
> fail?

No, it is not legal to call copy_*_user() while holding a spinlock.

If CONFIG_PREEMPT=n, do_page_fault() has no way of knowing that the caller
holds a spinlock.

