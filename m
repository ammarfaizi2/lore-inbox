Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUIQVaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUIQVaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269181AbUIQVaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 17:30:23 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:13962 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269031AbUIQVaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 17:30:13 -0400
Date: Fri, 17 Sep 2004 23:28:47 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917212847.GC15426@dualathlon.random>
References: <20040917154834.GA3180@crusoe.alcove-fr> <Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain> <20040917205011.GA3049@crusoe.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917205011.GA3049@crusoe.dsnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 10:50:12PM +0200, Stelian Pop wrote:
> +	spinlock_t *lock;	/* protects concurrent modifications */

if we've to spend 4 bytes into a pointer, then we could as well have a
spinlock_t. The idea was to pass the pointer through the stack every
time we call a method of the class so no locking-memory would be
allocated at all in the kfifo struct.

Anyways if you like the above I don't mind 4 more bytes per struct
(especially in my usage that is entirely in a slow path and dynamically
allocated). we reached a state where the patch looks good enough, so we
can merge it and later over time can do further modifications
incrementally.

> +	/* 
> +	 * round up to the next power of 2, since our 'let the indices
> +	 * wrap' tachnique works only in this case.
> +	 */
> +	if (size > 0x80000000)
> +		return ERR_PTR(-EINVAL);
> +	newsize = 1;
> +	while (newsize < size)
> +		newsize <<= 1;

this could be:

	newsize = size;
	if (size & (size-1)) {
		BUG_ON(size > 0x80000000);
		newsize = 1;
		while (newsize < size)
			newsize <<= 1;
	}

so we get the fast path when people asks for PAGE_SIZE multiples.

I also wonder if a O(1) algorithm exists to roundup to the next power of
two (doesn't come to mind by memory, hmm maybe it's not that easy
problem).

Thanks Stelian. Now if you like to keep working in this area and you
would like to also change do_syslog to use your new object, more power
to you and good luck! 8)
