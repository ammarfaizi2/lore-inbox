Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130592AbQL1TRj>; Thu, 28 Dec 2000 14:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQL1TR2>; Thu, 28 Dec 2000 14:17:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26377 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130592AbQL1TRS>; Thu, 28 Dec 2000 14:17:18 -0500
Date: Thu, 28 Dec 2000 10:46:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10012281031520.12260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2000, Andrew Morton wrote:
> 
> - Introduces a kernel-wide macro `SMP_KERNEL'.  This is designed to
>   be used as a `compiled ifdef' in place of `#ifdef CONFIG_SMP'.  There
>   are a few examples in __wake_up_common().

Please don't do this, it screws up the config option autodetection in
"make checkconfig", and also while gcc is reasonably good at deleting dead
code, gcc has absolutely no clue at all about deleting dead variables, and
will leave the stack slots around giving bigger stack usage and worse
cache behaviour.

(The gcc stack slot problem is a generic gcc problem - your approach just
tends to make it worse).

If you want to do this locally somewhere, that's ok, but keep it local.

> - SLEEP_ON_VAR, SLEEP_ON_HEAD and SLEEP_ON_TAIL have been changed.  I
>   see no valid reason why these functions were, effectively, doing
>   this:
> 
> 	spin_lock_irqsave(lock, flags);
> 	spin_unlock(lock);
> 	schedule();
> 	spin_lock(lock);
> 	spin_unlock_irqrestore(lock, flags);
> 
>   What's the point in saving the interrupt status in `flags'? If the
>   caller _wants_ interrupt status preserved then the caller is buggy,
>   because schedule() enables interrupts.  2.2 does the same thing.
> 
>   So this has been changed to:
> 
> 	spin_lock_irq(lock);
> 	spin_unlock(lock);
> 	schedule();
> 	spin_lock(lock);
> 	spin_unlock_irq(lock);
> 
>   Or did I miss something?

I'm a bit nervous about changing the old compatibility cruft, but the
above is probably ok.

Anyway, I'd like you to get rid of the global SMP_KERNEL thing (turning it
into a local one if you want to for this case), _and_ I'd like to see this
patch with the wait-queue spinlock _outside_ the __common_wakeup() path.

Why? Those semaphores will eventually want to re-use the wait-queue
spinlock as a per-semaphore spinlock, and they would need to call
__common_wakeup() with the spinlock held to do so. So let's get the
infrastructure in place.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
