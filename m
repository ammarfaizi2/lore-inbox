Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUIQNhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUIQNhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUIQNhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:37:16 -0400
Received: from sd291.sivit.org ([194.146.225.122]:43235 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268752AbUIQNgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:36:17 -0400
Date: Fri, 17 Sep 2004 15:36:58 +0200
From: Stelian Pop <stelian@popies.net>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917133656.GF3089@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Andrea Arcangeli <andrea@novell.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr> <20040917131523.GQ15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917131523.GQ15426@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:15:23PM +0200, Andrea Arcangeli wrote:

> this is nice, I had to write a ring buffer myself last month for
> bootcache (you can find the patch on l-k searching for "bootcache"). It
> was fun so I don't mind but certainly it took me a few reboots to make
> it work ;)

Making the code separate helps also for testing it in usermode (minus
the lock), so I haven't had to reboot (yet) :)

> My main issue with this is that I don't like to use kmalloc, I expect
> most people will use a page anyways, I'm using alloc_page myself (and I
> may want to switch to vmalloc to get a larger buffer, that's fine for
> bootcache since the allocation is in a slow path). I wonder if it worth
> to generalize the allocator passing down a callback or something like
> that. I can still use kmalloc but it'd be just a waste of some memory
> and risk fragmentation for >PAGE_SIZE (OTOH the callback as well will
> waste some byte).

What about leaving kfifo_alloc as is (using kmalloc) and adding
	struct kfifo *kfifo_init(unsigned char *buffer, spinlock_t *lock);
	
which let's you specify the buffer and the spinlock you want to use.
Of course, one should not call kfifo_free() on such a struct kfifo...

As a special case, the spinlock can be NULL and in this case it 
allocates it. But in this case we should also make a kfifo_delete()
to deallocate the lock...

> The other issue with the locking is that I will not need locking since
> I've my own external locking used for other stuff too that serializes
> the fifo as well, so I wonder if the "spinlock_t *" could as well be
> passed down to kfifo_get so I won't need to allocate the spinlock
> structure as well inside the kfifo.  Otherwise I could start to use such
> a spinlock inside the kfifo for the external locking too (and then I
> could call only the __ functions), that means guys outside your
> kfifo.[ch] would use the kfifo->lock which doesn't sound that clean,
> kfifo using an external lock passed down by the caller as parameter
> looks more robust.

See above for the lock.

It is better to use an external lock if you want to use it for more
that just protecting the fifo. Unfortunately we cannot hide the
internal spinlock from the users, this is just C.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
