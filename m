Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132854AbRDXI4t>; Tue, 24 Apr 2001 04:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDXI4k>; Tue, 24 Apr 2001 04:56:40 -0400
Received: from t2.redhat.com ([199.183.24.243]:49143 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132854AbRDXI4c>; Tue, 24 Apr 2001 04:56:32 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
In-Reply-To: Your message of "Tue, 24 Apr 2001 06:56:33 +0200."
             <20010424065633.A16845@athlon.random>
Date: Tue, 24 Apr 2001 09:56:11 +0100
Message-ID: <5927.988102571@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok I finished now my asm optimized rwsemaphores and I improved a little my
> spinlock based one but without touching the icache usage.

And I can break it. There's a very good reason the I changed __up_write() to
use CMPXCHG instead of SUBL. I found a sequence of operations that locked up
on this.

Unfortunately, I can't remember what it was. I do have it written down at
home, I think, so I see about sending it to you later.

>
> The main advantage of my rewrite are:
>
> -	my x86 version is visibly faster than yours in the write fast path and
> 	it also saves icache because it's smaller

That's because your fast write path is wrong. You can get away without
clobbering EDX and ECX, which I can't.

> (read fast path is reproducibly a bit faster too)

| +static inline void __down_read(struct rw_semaphore *sem)
...
| +			     : "+m" (sem->count), "+a" (sem)

>From what I've been told, you're lucky here... you avoid a pipeline stall
between whatever loads sem into EAX and the INCL that increments what it
points to because the "+a" constraint says that EAX will be changed. This
means that the compiler saves EAX before entering the inline asm, thus
delaying the INCL and thus avoiding the stall. However, you generally seem to
gain this at the expense of clobbering another register, say EDX.

So, for a function that just calls down_read twice, I get:
  20:   8b 44 24 04             mov    0x4(%esp,1),%eax
  24:   f0 ff 00                lock incl (%eax)
  27:   0f 88 22 00 00 00       js     4f <dr2+0x2f>
  2d:   f0 ff 00                lock incl (%eax)
  30:   0f 88 30 00 00 00       js     66 <dr2+0x46>
  36:   c3                      ret

And you get:
   0:   83 ec 08                sub    $0x8,%esp
   3:   8b 54 24 0c             mov    0xc(%esp,1),%edx
   7:   89 d0                   mov    %edx,%eax
   9:   f0 ff 02                lock incl (%edx)
   c:   0f 88 fc ff ff ff       js     e <dr+0xe>
  12:   89 d0                   mov    %edx,%eax
  14:   f0 ff 02                lock incl (%edx)
  17:   0f 88 0f 00 00 00       js     2c <dr2+0xc>
  1d:   58                      pop    %eax
  1e:   5a                      pop    %edx
  1f:   c3                      ret

Note also your asm constraints cause the compiler to eat an extra 8 bytes of
stack and then to pop it into registers to get rid of it. This is a gcc bug,
and will only hurt if the up_read and down_read are done in separate
subroutines.

| +static inline void __up_read(struct rw_semaphore *sem)
...
| +			     "jnz 1b\n\t"
| +			     "pushl %%ecx\n\t"
| +			     "call rwsem_wake\n\t"

Putting a PUSHL or two there hurt performance when I tried it, because, I'm
told, it introduces a pipeline stall.

> -	the common code automatically extends itself to support 2^32
>	concurrent sleepers on 64bit archs

You shouldn't do this in the XADD case, since you are explicitly using 32-bit
registers and instructions.

Actually, both of our generic cases allow 2^31 sleepers on a 32-bit arch, and
by changing mine to a long I can make it so we both support up to 2^63 on a
64-bit arch. However, I suspect that is overkill...

> -	there is no code duplication at all in supporting xchgadd common code
>       logic for other archs (and I prepared a skeleton to fill for the alpha)

Why not make it shareable? It doesn't have to be mandatory...

> So I'd suggest Linus to apply one of my above -8 patches for pre7. (I hope I
> won't need any secondary try)

I recommend against this at the moment (there's a bug in __up_write in his X86
optimised code).

David
