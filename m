Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWEGU4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWEGU4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEGU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 16:56:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:25510 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932224AbWEGU4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 16:56:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=frDA9WUArscunnqbkqeBmysKAYJU9RN2Yl6V8cB7LpTVRelcaByt86d/iAfrtUzFMXzVdQIIjGi7/xJ3qDiM/mSzoVwzR+GdJ4hnWyd5c6lFCVP6OO5x5ziVSzybg97wq4bawZhnGffaGhE6LJp92x44QRwd+zhkV5LwrM8kk60=
Message-ID: <9a8748490605071356t51c2b7b5wba62632bd9061e6@mail.gmail.com>
Date: Sun, 7 May 2006 22:56:20 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Chris Zankel" <zankel@tensilica.com>
Subject: Re: We also need to get rid of verify_area in entry.S
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508292144.11941.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508291954.27026.jesper.juhl@gmail.com>
	 <43135211.50109@tensilica.com>
	 <200508292144.11941.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Monday 29 August 2005 20:21, Chris Zankel wrote:
> > Jesper,
> >
> > Thanks for the patches. I'll take a look at the entry.S one and will
> > pass it along to Andres, and will incorporate the signal.c patch.
> >

Hi Chris,

Following up on an old mail...

verify_area() is still alive on xtensa in 2.6.17-rc3-git13 :-(
Do you have any plans to get rid of it? Are the original patches I
send still useful? Should I create new patches?
It would be nice to finally be rid of that function across the board.
Xtensa is the only user left and verify_area() comletely relaces it,
so let's get rid of the cruft - no?

/Jesper



> Thank you.
>
> I was originally planning to submit a single patch that removes
> verify_area across the board, but I guess it might be easier if I just
> hand you the bit of the patch that handles xtensa (instead of waiting for
> those bits to hit -mm) and then submit the rest along with a note that
> similar patches for xtensa will arrive later via you.
>
> So, here's the final bit that removes verify_area completely from xtensa :
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
> diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-xtensa/checksum.h linux-2.6.13/include/asm-xtensa/checksum.h
> --- linux-2.6.13-orig/include/asm-xtensa/checksum.h     2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.13/include/asm-xtensa/checksum.h  2005-08-29 03:46:34.000000000 +0200
> @@ -45,7 +45,7 @@ asmlinkage unsigned int csum_partial_cop
>   *     passed in an incorrect kernel address to one of these functions.
>   *
>   *     If you use these functions directly please don't forget the
> - *     verify_area().
> + *     access_ok().
>   */
>  extern __inline__
>  unsigned int csum_partial_copy_nocheck ( const char *src, char *dst,
> diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-xtensa/uaccess.h linux-2.6.13/include/asm-xtensa/uaccess.h
> --- linux-2.6.13-orig/include/asm-xtensa/uaccess.h      2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.13/include/asm-xtensa/uaccess.h   2005-08-29 03:47:18.000000000 +0200
> @@ -154,35 +154,6 @@
>  .Laccess_ok_\@:
>         .endm
>
> -/*
> - * verify_area determines whether a memory access is allowed.  It's
> - * mostly an unnecessary wrapper for access_ok, but we provide it as a
> - * duplicate of the verify_area() C inline function below.  See the
> - * equivalent C version below for clarity.
> - *
> - * On error, verify_area branches to a label indicated by parameter
> - * <error>.  This implies that the macro falls through to the next
> - * instruction on success.
> - *
> - * Note that we assume success is the common case, and we optimize the
> - * branch fall-through case on success.
> - *
> - * On Entry:
> - *     <aa>    register containing memory address
> - *     <as>    register containing memory size
> - *     <at>    temp register
> - *     <error> label to branch to on error; implies fall-through
> - *             macro on success
> - * On Exit:
> - *     <aa>    preserved
> - *     <as>    preserved
> - *     <at>    destroyed
> - */
> -       .macro  verify_area     aa, as, at, sp, error
> -       access_ok  \at, \aa, \as, \sp, \error
> -       .endm
> -
> -
>  #else /* __ASSEMBLY__ not defined */
>
>  #include <linux/sched.h>
> @@ -211,11 +182,6 @@
>  #define __access_ok(addr,size) (__kernel_ok || __user_ok((addr),(size)))
>  #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
>
> -extern inline int verify_area(int type, const void * addr, unsigned long size)
> -{
> -       return access_ok(type,addr,size) ? 0 : -EFAULT;
> -}
> -
>  /*
>   * These are the main single-value transfer routines.  They
>   * automatically use the right size if we just have the right pointer
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
