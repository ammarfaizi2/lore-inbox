Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269950AbRHSDxQ>; Sat, 18 Aug 2001 23:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269960AbRHSDxG>; Sat, 18 Aug 2001 23:53:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:56688 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269950AbRHSDwx>; Sat, 18 Aug 2001 23:52:53 -0400
Date: Sun, 19 Aug 2001 05:53:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-mm@kvack.org,
        Chris Blizzard <blizzard@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: resend Re: [PATCH] final merging patch -- significant mozilla speedup.
Message-ID: <20010819055311.A8700@athlon.random>
In-Reply-To: <20010819012713.N1719@athlon.random> <Pine.LNX.4.33.0108182005590.3026-100000@touchme.toronto.redhat.com> <20010819023548.P1719@athlon.random> <20010819025314.R1719@athlon.random> <20010819032544.X1719@athlon.random> <20010819034050.Z1719@athlon.random> <20010819045906.E1719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010819045906.E1719@athlon.random>; from andrea@suse.de on Sun, Aug 19, 2001 at 04:59:06AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 04:59:06AM +0200, Andrea Arcangeli wrote:
> @@ -587,7 +591,21 @@
>  		return -ENOMEM;
>  	spin_lock(&vma->vm_mm->page_table_lock);
>  	vma->vm_start = address;
> +
> +	/*
> +	 * vm_pgoff locking is a bit subtle: everybody but expand_stack is
> +	 * playing with the vm_pgoff with the write semaphore acquired. The
> +	 * only one playing with vm_pgoff with only the read semaphore
> +	 * acquired is expand_stack and it serializes against itself with the
> +	 * spinlock.
> +	 *
> +	 * More in general this means that it is not enough to grab the mmap_sem
> +	 * in read mode to avoid vm_pgoff to change under you. You either
> +	 * need the write semaphore acquired, or the read semaphore plus
> +	 * the spinlock.
> +	 */
>  	vma->vm_pgoff -= grow;
> +
>  	vma->vm_mm->total_vm += grow;
>  	if (vma->vm_flags & VM_LOCKED)
>  		vma->vm_mm->locked_vm += grow;

unfortunately I was way too optimistic about this and I also misread
part of the code while writing the above. Looking more closely
expand_stack is a race condition in itself.

Nobody is allowed to change vm_pgoff or vm_start without holding _both_
the mm sem in _write_ mode _and_ the spinlock.

expand_stack holds the mm sem in _read_ mode and the spinlock so it is
totally broken.

All the readers thinks that only holding only the read semaphore is
enough to get coherent data but expand_stack is breaking this rule and
so all the readers can race.

To fix this problem we simply need to convert all the callers of
expand_stack to hold the write semaphore instead of the read semaphore
(this will have to be propagated to all architectures). I just checked
all the callers and they're all convertible without any real pain (we
just need to do a second lookup after upgrading the lock because we
don't have a primitive to upgrade the lock from "read" to "write"
atomically without having to release it for some time in the middle, but
expand_stack is a slow path so it's not a showstopper).

Andrea
