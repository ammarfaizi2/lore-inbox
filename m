Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135602AbRDSJJT>; Thu, 19 Apr 2001 05:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135600AbRDSJJJ>; Thu, 19 Apr 2001 05:09:09 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:58810 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135599AbRDSJJA>; Thu, 19 Apr 2001 05:09:00 -0400
Date: Thu, 19 Apr 2001 11:08:51 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alon Ziv <alonz@nolaviz.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: light weight user level semaphores
Message-ID: <20010419110851.I682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com> <m33db680h8.fsf@otr.mynet.cygnus.com> <023c01c0c8a9$a4bb9940$910201c0@zapper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <023c01c0c8a9$a4bb9940$910201c0@zapper>; from alonz@nolaviz.org on Thu, Apr 19, 2001 at 10:20:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 10:20:48AM +0200, Alon Ziv wrote:
> My lightweight-semaphores were actually even simpler in userspace:
> * the userspace struct was just a signed count and a file handle.
> * Uncontended case is exactly like Linus' version (i.e., down() is decl +
> js, up() is incl()).
> * The contention syscall was (in my implementation) an ioctl on the FH; the
> FH was a special one, from a private syscall (although with the new VFS I'd
> have written it as just another specialized FS, or even referred into the
> SysVsem FS).

This is roughly the way I would prefer it. 

But I would dedicate a whole page to this struct, since this is
the granularity we can decide sharing on. This also has the
advantage, that we can include a lot of debugging info into this
page, too. Some people would like to know current contenders,
up/down ratio per second and contender etc.

Why? We have the infrastructure and all the semantics already in
place and it is well known to the programmers. We know how we
inherit this stuff, what will happen on process termination and
so on.

I thought about this myself a lot, but just didn't like the idea
to trust user space for up/down. I thought about abusing read() and
write() for down() and up(). Just doing it partially in user
space would be an significant speedup, once you got it right.

Maybe we can even combine both of it like this:

Then user space can do:

   /* open or create sema4 with normal open semantics */
   fd=open("/dev/sema4/myone");
   sema4=mmap(NULL,getpagesize(),,,fd,0);

   /* up */
   atomic_inc_and_test_for_zero(sema4) && ioctl(fd,WAKE_SLEEPERS,NULL);

   /* down */
   atomic_dec_and_test_negative(sema4) && ioctl(fd,SLEEP_NOW,NULL);

or 
   /* open or create sema4 with normal open semantics */
   fd=open("/dev/sema4/myone");

   /* up */
   write(fd, NULL,0); /* do the atomic stuff and wakeup in kernel */

   /* this might be stupid, but COULD be implemented */
   /* add 4 items to counter */
   write(fd, NULL, 4); 

   /* down */
   read(sama4, NULL, 0);

We could even do trylock() by default, if we open O_NONBLOCK. Or
we could do trylock sometimes using select() and poll(). This
also makes it easy to add it to existing select() loops like
Motif.

This differences could even be hidden by the libc. IIRC there are
some archs, which cannot do atomic operations without privileged
instructions, which is not acceptable in user space. Also there
are archs, which are not cache coherent (think NUMA) and where
flushing these caches to the other CPUs is privileged. Last but
not least there are clusters with process migration. 

My twofold approach would solve all these problems rather simply.

It would be a libc decision on what to use now. And the libc
knows enough about the application to handle all these cases.

The only thing we still need, is what we do if a contender or
waiter ist killed. Should we send SIGPIPE? Should we simply wake
all the waiters?

And we are not creating a new namespace again, but just use the
standard UN*X one: File name space.

Hopes this "fit into namespace" solution will be considered,
because I don't like to have a new linux-only API with completely
new semantics and things to care in wrappers, even if you don't
use this stuff. 

I also don't like the "kill me if I do a mistake"
that Linus proposed in the "bad_sem" label.

Comments? Flames? Overengineered?

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
