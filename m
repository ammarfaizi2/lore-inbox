Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSB0BkL>; Tue, 26 Feb 2002 20:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291291AbSB0BkC>; Tue, 26 Feb 2002 20:40:02 -0500
Received: from [202.135.142.194] ([202.135.142.194]:53266 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291306AbSB0Bjv>; Tue, 26 Feb 2002 20:39:51 -0500
Date: Wed, 27 Feb 2002 11:24:17 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-Id: <20020227112417.3a302d31.rusty@rustcorp.com.au>
In-Reply-To: <20020225100025.A1163@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
	<20020225100025.A1163@elinux01.watson.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002 10:00:25 -0500
Hubertus Franke <frankeh@watson.ibm.com> wrote:

> Rusty, since I supplied one of those packages available under lse.sourceforge.net
> let me make some comments.
> 
> (a) why do you need to pin. I simply use the user level address (vaddr)  
>     and hash with the <mm,vaddr> to obtain the internal object.
>     This also gives me full protection through the general vmm mechanisms.

I pin while sleeping for convenience, so I can get a kernel address.  It's
only one page (maybe 2).  I could look up the address every time, but then I
need to swap the page back in anyway to look at it.

> (b) I like the idea of mmap or shmat with special flags better than going 
>     through a device driver.

Me too, but I'd rather have people saying "make it a syscall" than "eww...
not another special purpose syscall!" 8)

> (c) creation can be done on demand, that's what I do. If you never have 
>     to synchronize through the kernel than you don't create the objects. 
>     There should be an option to force explicite creation if desired.

Absolutely, except there is no real "creation" event.  Adding a "here be
semaphores" syscall is sufficient and useful (and also makes it easy to
detect that there is no FUS support in the kernel).

> (d) The kernel should simply provide waiting and wakeup functionality and 
>     the bean counting should be done in user space. There is no need to 
>     pin or crossmap.

See above.

> (e) I really like to see multiple reader/single writer locks as well. I 
>     implemented these 

Hmmm... my current implementatino only allows down one and up one
operations, but off the top of my head I don't see a no reason this couldn't
be generalized.   Then:
1) Initialize at INT_MAX
2) down_read = down 1
3) down_write = down INT_MAX

Sufficient?

> (f) I also implemented convoy avoidance locks, spinning versions of 
>     user semaphores.  All over the same simple interface.
>     ulocks_wait(read_or_write) and ulocks_signal(read_or_write, num_to_wake_up).
>     Ofcourse to cut down on the interface a single system call is enough.

Interesting.  Something like this might be needed for backwards
compatibility anyway (spin & yield, at least).

> (g) I have an extensive test program and regression test <ulockflex>
>     that exercises the hell out of the userlevel approach. 

Excellent.   I shall grab it and take a look!

Thanks for the feedback,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
