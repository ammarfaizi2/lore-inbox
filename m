Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSHGMIy>; Wed, 7 Aug 2002 08:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSHGMIy>; Wed, 7 Aug 2002 08:08:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316889AbSHGMIx>; Wed, 7 Aug 2002 08:08:53 -0400
Date: Wed, 7 Aug 2002 13:12:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: kernel thread exit race
Message-ID: <20020807131229.A7327@flint.arm.linux.org.uk>
References: <15696.59115.395706.489896@laputa.namesys.com> <1028719111.18156.227.camel@irongate.swansea.linux.org.uk> <15696.61666.452460.264138@laputa.namesys.com> <1028722283.18156.274.camel@irongate.swansea.linux.org.uk> <15697.1225.84051.277799@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15697.1225.84051.277799@laputa.namesys.com>; from Nikita@Namesys.COM on Wed, Aug 07, 2002 at 03:30:17PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 03:30:17PM +0400, Nikita Danilov wrote:
> So, complete() is not-arch dependent because spinlocks are "good" in all
> architectures? complete() ends with spin_unlock_irqrestore() so it
> cannot be any better than spinlocks, until there is some hidden magic.

It works like this:

	cpu1					cpu2
kill thread (on cpu2)
					complete_and_exit()
					- takes spinlock
wait_for_completion()
- spins on completion spinlock
					- increments x->done
					- wakes up anyone waiting on
					  the completion
					- releases spinlock
- checks x->done
- decrements x->done
- releases spinlock

OR:

	cpu1					cpu2
kill thread (on cpu2)
wait_for_completion()
- takes spinlock
					complete_and_exit()
					- spins on spinlock
- checks x->done
- adds to waitqueue
- releases spinlock
					- increments x->done
- sleeps
					- wakes up anyone waiting on
					  the completion
- wakes up
- spins on spinlock
					- releases spinlock
- decrements x->done
- releases spinlock

OR:

	cpu1					cpu2
kill thread (on cpu2)
wait_for_completion()
- takes spinlock
- checks x->done
- adds to waitqueue
- releases spinlock
- sleeps
					complete_and_exit()
					- takes spinlock
					- increments x->done
					- wakes up anyone waiting on
					  the completion
- wakes up
- spins on spinlock
					- releases spinlock
- decrements x->done
- releases spinlock

As you can see, wait_for_completion() will never return until complete()
has released the spinlock.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

