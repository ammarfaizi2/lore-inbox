Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQKLCrt>; Sat, 11 Nov 2000 21:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQKLCrj>; Sat, 11 Nov 2000 21:47:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61199 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129453AbQKLCr0>; Sat, 11 Nov 2000 21:47:26 -0500
Date: Sat, 11 Nov 2000 18:47:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
In-Reply-To: <Pine.GSO.4.21.0011101618030.17943-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10011111844080.3611-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Nov 2000, Alexander Viro wrote:
> diff -urN rc11-2/include/asm-i386/processor.h rc11-2-show_task/include/asm-i386/processor.h
> --- rc11-2/include/asm-i386/processor.h	Fri Nov 10 09:14:04 2000
> +++ rc11-2-show_task/include/asm-i386/processor.h	Fri Nov 10 16:08:15 2000
> @@ -412,7 +412,7 @@
>   */
>  extern inline unsigned long thread_saved_pc(struct thread_struct *t)
>  {
> -	return ((unsigned long *)t->esp)[3];
> +	return ((unsigned long **)t->esp)[0][1];
>  }

The above needs to get verified: it should be something like

	unsigned long *ebp = *((unsigned long **)t->esp);

	if ((void *) ebp < (void *) t)
		return 0;
	if ((void *) ebp >= (void *) t + 2*PAGE_SIZE)
		return 0;
	if (3 & (unsigned long)ebp)
		return 0;
	return *ebp;

because otherwise I guarantee that we'll eventually have a bug with a
invalid pointer reference in the debugging code and that would be bad.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
