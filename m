Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUIQOCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUIQOCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUIQOBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:01:45 -0400
Received: from sd291.sivit.org ([194.146.225.122]:59620 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268771AbUIQN7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:59:39 -0400
Date: Fri, 17 Sep 2004 16:00:21 +0200
From: Stelian Pop <stelian@popies.net>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917140021.GG3089@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Andrea Arcangeli <andrea@novell.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr> <20040917131523.GQ15426@dualathlon.random> <20040917133656.GF3089@crusoe.alcove-fr> <20040917134145.GT15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917134145.GT15426@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:41:45PM +0200, Andrea Arcangeli wrote:

> On Fri, Sep 17, 2004 at 03:36:58PM +0200, Stelian Pop wrote:
> > What about leaving kfifo_alloc as is (using kmalloc) and adding
> > 	struct kfifo *kfifo_init(unsigned char *buffer, spinlock_t *lock);
> > 	
> > which let's you specify the buffer and the spinlock you want to use.
> > Of course, one should not call kfifo_free() on such a struct kfifo...
> 
> I guess you need to pass down the size of the buffer too.

Of course... 

> > As a special case, the spinlock can be NULL and in this case it 
> > allocates it. But in this case we should also make a kfifo_delete()
> > to deallocate the lock...
> 
> that's fine with me, but allocating a lock dynamically? then probably
> you should force the caller to allocate it, and force it to pass it down
> either in the alloc or in the init function, the caller is going to have
> a bigger data structure where it will embed the kfifo structure, so it'd
> be normally zerocost for the caller to allocate a lock outside the
> kfifo, even if the API becomes a bit uglier, but I don't see the need of
> separate slab allocation for a single spinlock. 


Hmmm, allocating a single lock is ugly indeed, but I still want
the high level kfifo_get / kfifo_put to do the locking themselves...

We could do that by having a 'spinlock_t internal_lock' and a 
'spinlock_t * lock' fields, in struct kfifo: we always use 'lock' and
we initialize lock to either &internal_lock or to the user lock.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
