Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVCISuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVCISuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCISqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:46:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262162AbVCISn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:43:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0503091019060.2530@ppc970.osdl.org> 
References: <Pine.LNX.4.58.0503091019060.2530@ppc970.osdl.org>  <28092.1110391155@redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Discard key spinlock and use RCU for key payload 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 09 Mar 2005 18:43:52 +0000
Message-ID: <28732.1110393832@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > The attached patch changes the key implementation in a number of ways:
> > 
> >  (1) It removes the spinlock from the key structure.
> > 
> >  (2) The key flags are now accessed using atomic bitops instead of
> >      write-locking the key spinlock and using C bitwise operators.
> 
> I'd suggest against using __set_bit() for the initialization. Either use
> the proper set_bit() (which is slow, but at least consistent), or just
> initialize it with (1ul << KEY_FLAG_IN_QUOTA). __set_bit is generally
> slower than setting a value (it's pretty guaranteed not to be faster, and
> at least on x86 is clearly slower), so using it as an "optimization" is
> misguided.

Yeah... fair enough.

> RCU seems to fit the key model pretty well, but I still wonder whether the 
> conceptual complexity is worth it. Was this done on a whim, or was there 
> some real reason for it?

There are two parts to the reason:

 (1) Keys are for the most part invariant. Whilst they can be modified if the
     type supports it, this should be uncommon. Except in the case of
     keyrings, that is, but they're a special case anyway.

 (2) Anything that accesses a key's payload (which includes the keyring search
     algorithm) must hold the key's spinlock whilst it is looking at it, for
     as long as it is looking at it.

     With RCU, this is no longer necessary. You just can't schedule until
     you've finished looking at it.

Given that for the most part keys don't change, it'd be very nice not to have
to get a read lock on them. For something like NFS or AFS, the key will
probably have to be accessed for every remote procedure call, for example; and
a process's keyrings will have to be searched on every open call, assuming
keys are associated with struct files or struct inodes.

The current locking model is quite complicated, and great care has to be taken
to avoid recursive deadlocks; so in some ways the RCU model is actually
simpler.

> I'd love for that to be documented while you're at it..

I need to update the key documentation to reflect the changes in locking, but
the base kernel doesn't have the previous sets of doc changes; something I'd
like to build on.

When you or Andrew have released such a kernel, I'll update the docs too.

David
