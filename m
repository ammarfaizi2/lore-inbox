Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137132AbREKNPu>; Fri, 11 May 2001 09:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137133AbREKNPi>; Fri, 11 May 2001 09:15:38 -0400
Received: from smtp.mountain.net ([198.77.1.35]:39175 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S137132AbREKNP2>;
	Fri, 11 May 2001 09:15:28 -0400
Message-ID: <3AFBE57F.611A6051@mountain.net>
Date: Fri, 11 May 2001 09:13:35 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __up_read and gcc-3.0
In-Reply-To: <20010509190955.A1526@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> Hi Alan,
>   can you apply this patch to next 2.4.4-acX ? This fixes problem with
> gcc3.0 (20010426) unable to compile this under some conditions. As
> __up_write() uses same code ("i".... instead of tmp variable), I think
> that you should apply this. It can cause slower code, as gcc cannot
> move "movl -RWSEM_ACTIVE_READ_BIAS,%edx" away from "xadd" anymore,
> but as "lock xadd" is slow anyway, it should not matter.
> 
>   I looked at generated code in cases where it originally failed, and
> generated code looks OK to me.
>                                         Thanks,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
> 
> diff -urdN linux/include/asm-i386/rwsem.h linux/include/asm-i386/rwsem.h
> --- linux/include/asm-i386/rwsem.h      Fri Apr 27 22:48:24 2001
> +++ linux/include/asm-i386/rwsem.h      Wed May  9 16:31:57 2001
> @@ -148,9 +148,9 @@
>   */
>  static inline void __up_read(struct rw_semaphore *sem)
>  {
> -       __s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
>         __asm__ __volatile__(
>                 "# beginning __up_read\n\t"
> +               "  movl      %2,%%edx\n\t"
>  LOCK_PREFIX    "  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
>                 "  js        2f\n\t" /* jump if the lock is being waited upon */
>                 "1:\n\t"
> @@ -164,9 +164,9 @@
>                 "  jmp       1b\n"
>                 ".previous\n"
>                 "# ending __up_read\n"
> -               : "+m"(sem->count), "+d"(tmp)
> -               : "a"(sem)
> -               : "memory", "cc");
> +               : "+m"(sem->count)
> +               : "a"(sem), "i"(-RWSEM_ACTIVE_READ_BIAS)
> +               : "memory", "cc", "edx");
>  }
> 
>  /*

Hi Petr,

My solution to this was to relax +d(tmp) to +m(tmp). Posted a few days ago.
I have larger problems with 2.4.5-pre1 and have not gone back to check what
comes out. Being a product of pure reason (and not much of that), mine
deserves suspicion.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
