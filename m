Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132936AbRDXJun>; Tue, 24 Apr 2001 05:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132939AbRDXJue>; Tue, 24 Apr 2001 05:50:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:47430 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132936AbRDXJuZ>; Tue, 24 Apr 2001 05:50:25 -0400
Date: Tue, 24 Apr 2001 11:49:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424114953.E7913@athlon.random>
In-Reply-To: <20010424065633.A16845@athlon.random> <5927.988102571@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5927.988102571@warthog.cambridge.redhat.com>; from dhowells@warthog.cambridge.redhat.com on Tue, Apr 24, 2001 at 09:56:11AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 09:56:11AM +0100, David Howells wrote:
> > Ok I finished now my asm optimized rwsemaphores and I improved a little my
> > spinlock based one but without touching the icache usage.
> 
> And I can break it. There's a very good reason the I changed __up_write() to
> use CMPXCHG instead of SUBL. I found a sequence of operations that locked up
> on this.

I'd love to hear this sequence. Certainly regression testing never generated
this sequence yet but yes that doesn't mean anything. Note that your slow path
is very different than mine.

My rule is really really simple:

-	the last one that moves from 1 to 0 the lower half of the word
	has to do 1 wakeup

I don't care who does that or where it does that.

That's all. No other real rules. Of course then both wakeup and down_failed
have to do their retire logic with the spinlock acquired to make sure to
serialize but that doesn't change the real rule. I don't feel the need
of any xchg to enforce additional serialization.

Anyways if you can provide a sequence that breaks my simple algorithm I will
love to know that, of course then it will be possible also to write a kernel
module to exploit it and reproduce the hang in real life. It is possible that I
missed something however right now the logic seems simple enough to be right (I
mean mine, yours plays with cmpxchg in a way that I still cannot understand).

> Unfortunately, I can't remember what it was. I do have it written down at
> home, I think, so I see about sending it to you later.

Ok thanks!

> > The main advantage of my rewrite are:
> >
> > -	my x86 version is visibly faster than yours in the write fast path and
> > 	it also saves icache because it's smaller
> 
> That's because your fast write path is wrong. You can get away without
> clobbering EDX and ECX, which I can't.
> 
> > (read fast path is reproducibly a bit faster too)
> 
> | +static inline void __down_read(struct rw_semaphore *sem)
> ...
> | +			     : "+m" (sem->count), "+a" (sem)
> 
> >From what I've been told, you're lucky here... you avoid a pipeline stall
> between whatever loads sem into EAX and the INCL that increments what it
> points to because the "+a" constraint says that EAX will be changed. This

Infact eax will be changed because it will be clobbered by the slow path, so I
have to. Infact you are not using the +a like I do there and you don't save EAX
explicitly on the stack I think that's "your" bug.

> means that the compiler saves EAX before entering the inline asm, thus
> delaying the INCL and thus avoiding the stall. However, you generally seem to
> gain this at the expense of clobbering another register, say EDX.

Again it's not a performance issue, the "+a" (sem) is a correctness issue
because the slow path will clobber it.

About the reason I'm faster than you in the down_write fast path is that I can
do the subl instead of the cmpxchg, you say this is my big fault, I think my
algorithm allows me to do that, but maybe I'm wrong.

> So, for a function that just calls down_read twice, I get:
>   20:   8b 44 24 04             mov    0x4(%esp,1),%eax
>   24:   f0 ff 00                lock incl (%eax)
>   27:   0f 88 22 00 00 00       js     4f <dr2+0x2f>
>   2d:   f0 ff 00                lock incl (%eax)
>   30:   0f 88 30 00 00 00       js     66 <dr2+0x46>
>   36:   c3                      ret
> 
> And you get:
>    0:   83 ec 08                sub    $0x8,%esp
>    3:   8b 54 24 0c             mov    0xc(%esp,1),%edx
>    7:   89 d0                   mov    %edx,%eax
>    9:   f0 ff 02                lock incl (%edx)
>    c:   0f 88 fc ff ff ff       js     e <dr+0xe>
>   12:   89 d0                   mov    %edx,%eax
>   14:   f0 ff 02                lock incl (%edx)
>   17:   0f 88 0f 00 00 00       js     2c <dr2+0xc>
>   1d:   58                      pop    %eax
>   1e:   5a                      pop    %edx
>   1f:   c3                      ret
> 
> Note also your asm constraints cause the compiler to eat an extra 8 bytes of
> stack and then to pop it into registers to get rid of it. This is a gcc bug,
> and will only hurt if the up_read and down_read are done in separate
> subroutines.
> 
> | +static inline void __up_read(struct rw_semaphore *sem)
> ...
> | +			     "jnz 1b\n\t"
> | +			     "pushl %%ecx\n\t"
> | +			     "call rwsem_wake\n\t"
> 
> Putting a PUSHL or two there hurt performance when I tried it, because, I'm
> told, it introduces a pipeline stall.

Unfortunatly I "have" to put the pushl there because I don't want to save %ecx
in the fast path (if I declare ecx clobbered it's even worse no?).

> > -	the common code automatically extends itself to support 2^32
> >	concurrent sleepers on 64bit archs
> 
> You shouldn't do this in the XADD case, since you are explicitly using 32-bit
> registers and instructions.

I said on 64bit archs. Of course on x86-64 there is xaddq and the rex
registers.

> Actually, both of our generic cases allow 2^31 sleepers on a 32-bit arch, and

Both my generic and asm code only allows 2^16 sleepers on 32bit archs, then I
don't know what happens, if it works it wasn't intentional ;).

> by changing mine to a long I can make it so we both support up to 2^63 on a
> 64-bit arch. However, I suspect that is overkill...
>
> > -	there is no code duplication at all in supporting xchgadd common code
> >       logic for other archs (and I prepared a skeleton to fill for the alpha)
> 
> Why not make it shareable? It doesn't have to be mandatory...

It isn't mandatory, if you don't want the xchgadd infrastructure then you don't
set even CONFIG_RWSEM_XCHGADD, no?

> I recommend against this at the moment (there's a bug in __up_write in his X86
> optimised code).

Certainly if there's a bug I agree ;). It will be really fun for me to get a
kernel module that deadlocks my algorithm. thanks for the auditing effort!

Andrea
