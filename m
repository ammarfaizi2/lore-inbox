Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVDOWnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVDOWnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVDOWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 18:43:50 -0400
Received: from pat.uio.no ([129.240.130.16]:31927 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261994AbVDOWnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 18:43:43 -0400
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
In-Reply-To: <29082.1113581624@redhat.com>
References: <20050408223927.GA22217@kvack.org>
	 <1112224663.18019.39.camel@lade.trondhjem.org>
	 <1112309586.27458.19.camel@lade.trondhjem.org>
	 <20050331161350.0dc7d376.akpm@osdl.org>
	 <1112318537.11284.10.camel@lade.trondhjem.org>
	 <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com>
	 <20050404162216.GA18469@kvack.org>
	 <1112637395.10602.95.camel@lade.trondhjem.org>
	 <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org>
	 <29082.1113581624@redhat.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 15:42:54 -0700
Message-Id: <1113604974.27810.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.719, required 12,
	autolearn=disabled, AWL 0.28, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 15.04.2005 Klokka 17:13 (+0100) skreiv David Howells:
> Can I suggest you don't use a wait_queue_t in your mutex? The way you've
> implemented your mutex you appear to have to take spinlocks and disable
> interrupts a lot more than is necessary.

> You might want to look at how I've implemented semaphores for the frv arch:
> 
> 	include/asm-frv/semaphore.h
> 	arch/frv/kernel/semaphore.c
> 
> On FRV disabling interrupts is quite expensive, so I've made my own simple
> semaphores that don't need to take spinlocks and disable interrupts in the
> down() path once the sleeping task has been queued[*]. These work in exactly
> the same way as rwsems.

> The point being that since up() needs to take the semaphore's spinlock
> anyway
> so that it can access the list, up() does all the necessary dequeuing
> of tasks
> before waking them up.

I'm looking at the code, and I'm completely failing to see your point.
Exactly how is that scheme incompatible with use of wait_queue_t?

AFAICS You grab the wait_queue_t lock once in down()/__mutex_lock()
order to try to take the lock (or queue the waiter if that fails), then
once more in order to pass the mutex on to the next waiter on
up()/mutex_unlock(). That is more or less the exact same thing I was
doing with iosems using bog-standard waitqueues, and which Ben has
adapted to his mutexes. What am I missing?

One of the motivations for doing that as far as the iosems were
concerned, BTW, was to avoid adding to this ecology of functionally
identical structures that we have for semaphores, rwsems, and wait
queues.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

