Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVEVLIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVEVLIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 07:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEVLIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 07:08:16 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:49001 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261784AbVEVLHt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 07:07:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ouCGfYb5/o+2aKigy6JV4HUDAuOF1KhBGXoVckizN40ytskZgNAC7L2wGNyq/hFRBYBSCva3RQEZ3XTRg2FH2ScyGdS0oO/UZAF6SceXN74J2iY5yR1sjrWrP3iPPUdwoWGkLtMClVlhe+KacS7pP16iMiHeK6hegd6ctTLcu1E=
Message-ID: <5a4c581d050522040778b3c519@mail.gmail.com>
Date: Sun, 22 May 2005 13:07:49 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Subject: Re: [PATCH] binutils-2.16.90.0.3: can't compile 2.4.30
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505212018.j4LKIMTG017159@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505212018.j4LKIMTG017159@wildsau.enemy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch

On 5/21/05, Herbert Rosmanith <kernel@wildsau.enemy.org> wrote:
> 
> 
> good evening,
> 
> updating to binutils 2.16.90.0.3 today resulting in being unable
> to compile 2.4.30. as it turns out, it's an assembly problem.

Hi Herbert,

  this seems to be documented in the binutils release notes, which
  will point you to this:

http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch

> please accept these two patches:
> 
> (1)
> 
> # diff -uN linux-2.4.30/arch/i386/kernel/process.c linux-2.4.30.rescue/arch/i386/kernel/process.c
> --- linux-2.4.30/arch/i386/kernel/process.c     Wed Nov 17 12:54:21 2004
> +++ linux-2.4.30.rescue/arch/i386/kernel/process.c      Sat May 21 22:11:58 2005
> @@ -5,6 +5,8 @@
>   *
>   *  Pentium III FXSR, SSE support
>   *     Gareth Hughes <gareth@valinux.com>, May 2000
> + * Sat May 21 22:11:22 MEST 2005 herp - Herbert Rosmanith
> + *      minor fixes for as from binutils-2.16
>   */
> 
>  /*
> @@ -544,7 +546,7 @@
>   * Save a segment.
>   */
>  #define savesegment(seg,value) \
> -       asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
> +       asm volatile("movw %%" #seg ",%0":"=m" (*(int *)&(value)))
> 
>  int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
>         unsigned long unused,
> @@ -661,8 +663,8 @@
>          * Save away %fs and %gs. No need to save %es and %ds, as
>          * those are always kernel segments while inside the kernel.
>          */
> -       asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
> -       asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
> +       asm volatile("movw %%fs,%0":"=m" (*(int *)&prev->fs));
> +       asm volatile("movw %%gs,%0":"=m" (*(int *)&prev->gs));
> 
>         /*
>          * Restore %fs and %gs.
> 
> 
> (2)
> 
> --- linux-2.4.30/include/asm-i386/system.h      Fri May 20 03:41:56 2005
> +++ linux-2.4.30.rescue/include/asm-i386/system.h       Sat May 21 22:07:10 2005
> @@ -84,7 +84,7 @@
>  #define loadsegment(seg,value)                 \
>         asm volatile("\n"                       \
>                 "1:\t"                          \
> -               "movl %0,%%" #seg "\n"          \
> +               "movw %0,%%" #seg "\n"          \
>                 "2:\n"                          \
>                 ".section .fixup,\"ax\"\n"      \
>                 "3:\t"                          \
> 
> 
> ---
> 
> long explanation follows.
> 
> 
> I just updated binutils to 2.16.90.0.3. when compiling 2.4.30, I get
> the following error:
> 
> gcc -D__KERNEL__ -I/data/root/linux-2.4.30.rescue/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=process  -c -o
> process.o process.c
> {standard input}: Assembler messages:
> {standard input}:738: Error: suffix or operands invalid for `mov'
> {standard input}:739: Error: suffix or operands invalid for `mov'
> {standard input}:832: Error: suffix or operands invalid for `mov'
> {standard input}:833: Error: suffix or operands invalid for `mov'
> {standard input}:884: Error: suffix or operands invalid for `mov'
> {standard input}:885: Error: suffix or operands invalid for `mov'
> {standard input}:887: Error: suffix or operands invalid for `mov'
> {standard input}:899: Error: suffix or operands invalid for `mov'
> make[1]: *** [process.o] Error 1
> 
> If we look at the assembly code:
> 
>    715  .globl copy_thread
>    716          .type    copy_thread,@function
>    717  copy_thread:
> ...
>    737  #APP
>    738          movl %fs,636(%ebx)
>    739          movl %gs,640(%ebx)
> 
> 
> then it is clear that a movl on a segreg should really be a movw.
> (same error in 832, 833 and so on: movl vs. movw)
> 
> *but* ... why is this code generated in the first place? is this
> a compiler problem? I'm using gss-2.95.3. copy_thread() doesn have
> any asm() statement, hm, but then ... *ponder*
> 
> ok, the two line are possibly generated by this one:
> 
>    549  int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
> 
>    564
>    565          savesegment(fs,p->thread.fs);
>    566          savesegment(gs,p->thread.gs);
> 
> 
> ok, I think this is the source of the error:
> 
>    546  #define savesegment(seg,value) \
>    547          asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
>    548
> 
> 
> this definitely should be a movw, right?
> 
> best regards,
> h.rosmanith


--alessandro

 "To love is to find your own soul
  Through the soul of the beloved one.
  When the beloved one withdraws itself from your soul
  Then you have lost your soul."

    (Edgar Lee Masters, Spoon River Anthology - "Mary McNeely")
