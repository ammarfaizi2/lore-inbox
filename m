Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTIHRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTIHRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:52:25 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43151 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263447AbTIHRwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:52:23 -0400
Date: Mon, 8 Sep 2003 18:51:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030908175140.GC27097@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain> <20030908102309.0AC4E2C013@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908102309.0AC4E2C013@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> +	u32 hash = jhash2((u32*)&key->both.word,

Have you checked the code size?

That does more work and has more code than is needed, especially on
32-bit archs.  On 32-bit, jhash_3words() is much better because it
reduces to a single call to __jhash_mix(), instead of the two done by
jhash2 (only one is required for good hashing afaict).

It is probably worth adding a jhash_3longs() to jhash.h, which does
one call to __hash_mix() on 32-bit, two calls on 64-bit, and avoids
the loop in both cases.

[ Aside: For hashing individual integers, I prefer to use Thomas Wang's:

	http://www.concentric.net/~Ttwang/tech/inthash.htm

  He mentions Jenkin's function, and derived an integer mixing function
  from correspondence with Jenkins.

  For hashing 3 words together, Jenkins' hash does seem a bit more
  compact - if you don't call __jhash_mix() multiple times that is! ]

> -	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
> -		return (vma->vm_flags & VM_IO) ? -EPERM : -EACCES;
> +	if (unlikely(vma->vm_flags & VM_IO))
> +		return -EPERM;
> +	if (unlikely(vma->vm_flags & (VM_READ|VM_WRITE)) != (VM_READ|VM_WRITE))
> +		return -EACCES;

Is there a good reason to disallow read-only waiters?
I agree with Hugh that it seems like a regression.

> +	/* A spurious wakeup.  Should never happen. */
> +	BUG();

:)

The rest of your changes seem fine.  I particularly appreciate your
grammatical improvements to my comment :)

-- Jamie
