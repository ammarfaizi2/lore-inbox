Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263123AbVD3BpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbVD3BpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 21:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVD3BpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 21:45:14 -0400
Received: from ozlabs.org ([203.10.76.45]:37513 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263121AbVD3BpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 21:45:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17010.58144.95239.716600@cargo.ozlabs.ibm.com>
Date: Sat, 30 Apr 2005 11:45:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
In-Reply-To: <1114789320.10086.81.camel@lade.trondhjem.org>
References: <20050428182926.GC16545@kvack.org>
	<17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	<20050429141437.GA24617@kvack.org>
	<1114789320.10086.81.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:

> The PPC implementation would be hard to port to x86, since it relies on
> the load-linked/store-conditional stuff to provide a fast primitive for
> atomic_dec_if_positive().

The only fast path that needs atomic_dec_if_positive is down_trylock.
You can use atomic_dec for down_trylock instead; the only downside to
that is that if somebody was holding the semaphore but nobody was
waiting, the holder will take the slow path when it does the up.  Or
you can use cmpxchg for down_trylock.  I believe that down_trylock is
used much less than down and down_interruptible, so it shouldn't
matter if down_trylock is a few nanoseconds slower than down.

> The only way I found to implement that on x86 was to use cmpxchg. On my
> machine, therefore, a spinlock-based semaphore implementation turns out
> to be at least as fast for the "fast" path (and is naturally much more
> efficient for the slow path).

What is "your machine"?  Is a single cmpxchg really slower than
locking and unlocking a spinlock?  If so, by how much?

Paul.
