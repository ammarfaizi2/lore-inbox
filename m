Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUIQNPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUIQNPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268698AbUIQNPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:15:35 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:57733 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268672AbUIQNPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:15:33 -0400
Date: Fri, 17 Sep 2004 15:15:23 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917131523.GQ15426@dualathlon.random>
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917122400.GD3089@crusoe.alcove-fr>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is nice, I had to write a ring buffer myself last month for
bootcache (you can find the patch on l-k searching for "bootcache"). It
was fun so I don't mind but certainly it took me a few reboots to make
it work ;)

My main issue with this is that I don't like to use kmalloc, I expect
most people will use a page anyways, I'm using alloc_page myself (and I
may want to switch to vmalloc to get a larger buffer, that's fine for
bootcache since the allocation is in a slow path). I wonder if it worth
to generalize the allocator passing down a callback or something like
that. I can still use kmalloc but it'd be just a waste of some memory
and risk fragmentation for >PAGE_SIZE (OTOH the callback as well will
waste some byte).

The other issue with the locking is that I will not need locking since
I've my own external locking used for other stuff too that serializes
the fifo as well, so I wonder if the "spinlock_t *" could as well be
passed down to kfifo_get so I won't need to allocate the spinlock
structure as well inside the kfifo.  Otherwise I could start to use such
a spinlock inside the kfifo for the external locking too (and then I
could call only the __ functions), that means guys outside your
kfifo.[ch] would use the kfifo->lock which doesn't sound that clean,
kfifo using an external lock passed down by the caller as parameter
looks more robust.
