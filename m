Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030721AbWI0Tq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030721AbWI0Tq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030722AbWI0Tq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:46:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030721AbWI0Tq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:46:56 -0400
Date: Wed, 27 Sep 2006 12:46:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git7 freezes solid on boot
Message-Id: <20060927124652.c670785e.akpm@osdl.org>
In-Reply-To: <5a4c581d0609270531p52d9452fie223dbd3152bcd38@mail.gmail.com>
References: <5a4c581d0609270531p52d9452fie223dbd3152bcd38@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 12:31:52 +0000
"Alessandro Suardi" <alessandro.suardi@gmail.com> wrote:

> Dell D610 running FC5, works fine with -git5, locks up
>  in less than a second after selecting the GRUB entry
>  for -git7, with NumLock on and nothing else working,
>  SysRq included, except for the power switch (no need
>  to keep it down for 10 secs though - it powers off
>  right away).
> 
> Since bzdiffing patch-2.6.18-git5 and -git7 shows there
>  are framebuffer changes, I'm wondering whether anyone
>  had already stumbled into similar issues.
> 
> Video card is an Intel i915GM.
> 

You probably want this..

From: Andi Kleen <ak@suse.de>

i386: Use early clobbers for semaphores now

The new code does clobber the result early, so make sure to tell
gcc to not put it into the same register as a input argument

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-i386/semaphore.h
===================================================================
--- linux.orig/include/asm-i386/semaphore.h
+++ linux/include/asm-i386/semaphore.h
@@ -126,7 +126,7 @@ static inline int down_interruptible(str
 		"lea %1,%%eax\n\t"
 		"call __down_failed_interruptible\n"
 		"2:"
-		:"=a" (result), "+m" (sem->count)
+		:"=&a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
@@ -148,7 +148,7 @@ static inline int down_trylock(struct se
 		"lea %1,%%eax\n\t"
 		"call __down_failed_trylock\n\t"
 		"2:\n"
-		:"=a" (result), "+m" (sem->count)
+		:"=&a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
