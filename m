Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263360AbUJ2Ovv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbUJ2Ovv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUJ2OtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:49:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:45275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263360AbUJ2OqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:46:10 -0400
Date: Fri, 29 Oct 2004 07:46:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, linux-os wrote:
> 
> Linus, please check this out.

Yes, I concur. However, I'd suggest changing the "addl $4,%esp" into a 
"popl %ecx", which is smaller and apparently faster on some CPU's (ecx 
obviously gets immediately overwritten by the next popl).

Btw, this is another case where we _really_ want "asmlinkage" to mean that
the compiler does not own the argument stack. Is there any chance of
getting a function attribute like that into future versions of gcc?  
Richard, Jan, Andi? Or does it already exist somewhere?

		Linus

--- saved for gcc people commentary ---
>
> asmlinkage void __up(struct semaphore *sem)
> {
>      wake_up(&sem->wait);
> }
> 
> This was from /usr/src/linux-2.6.9/arch/i386/kernel/semaphore.c
> It this case, the value of 'sem' is destroyed which means that
> certain assembly-language helper functions no longer work.
> 
> This was discovered by Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>.
> 
> This patch fixes it, but I think somebody may need to rework
> the semaphore code to eliminate the assembly because the newer
> compilers are not consistent in their handling of passed parameters
> so some assembly optimization may no longer be possible.
> 
> 
> --- linux-2.6.9/arch/i386/kernel/semaphore.c.orig	2004-08-14 01:36:56.000000000 -0400
> +++ linux-2.6.9/arch/i386/kernel/semaphore.c	2004-10-19 08:06:15.000000000 -0400
> @@ -198,9 +198,11 @@
>   #endif
>   	"pushl %eax\n\t"
>   	"pushl %edx\n\t"
> -	"pushl %ecx\n\t"
> +	"pushl %ecx\n\t"	// Register to save
> +	"pushl %ecx\n\t"	// Passed parameter
>   	"call __down\n\t"
> -	"popl %ecx\n\t"
> +	"addl $0x04, %esp\t\n"	// Bypass corrupted parameter
> +	"popl %ecx\n\t"		// Restore original
>   	"popl %edx\n\t"
>   	"popl %eax\n\t"
>   #if defined(CONFIG_FRAME_POINTER)
> @@ -220,9 +222,11 @@
>   	"movl  %esp,%ebp\n\t"
>   #endif
>   	"pushl %edx\n\t"
> -	"pushl %ecx\n\t"
> +	"pushl %ecx\n\t"	// Save register
> +	"pushl %ecx\n\t"	// Passed parameter
>   	"call __down_interruptible\n\t"
> -	"popl %ecx\n\t"
> +	"addl $0x04, %esp\n\t"	// Bypass corrupted parameter
> +	"popl %ecx\n\t"		// Restore register
>   	"popl %edx\n\t"
>   #if defined(CONFIG_FRAME_POINTER)
>   	"movl %ebp,%esp\n\t"
> @@ -241,9 +245,11 @@
>   	"movl  %esp,%ebp\n\t"
>   #endif
>   	"pushl %edx\n\t"
> -	"pushl %ecx\n\t"
> +	"pushl %ecx\n\t"		// Save register
> +	"pushl %ecx\n\t"		// Passed parameter
>   	"call __down_trylock\n\t"
> -	"popl %ecx\n\t"
> +	"addl $0x04, %esp\n\t"		// Bypass corrupted parameter
> +	"popl %ecx\n\t"			// Restore register
>   	"popl %edx\n\t"
>   #if defined(CONFIG_FRAME_POINTER)
>   	"movl %ebp,%esp\n\t"
> @@ -259,9 +265,11 @@
>   "__up_wakeup:\n\t"
>   	"pushl %eax\n\t"
>   	"pushl %edx\n\t"
> -	"pushl %ecx\n\t"
> +	"pushl %ecx\n\t"	// Save register
> +	"pushl %ecx\n\t"	// Passed parameter
>   	"call __up\n\t"
> -	"popl %ecx\n\t"
> +	"addl $0x04, %esp\n\t"	// Bypass corrupted parameter
> +	"popl %ecx\n\t"		// Restore register
>   	"popl %edx\n\t"
>   	"popl %eax\n\t"
>   	"ret"
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by John Ashcroft.
>                   98.36% of all statistics are fiction.
> 
