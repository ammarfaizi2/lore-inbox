Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWBUP5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWBUP5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWBUP5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:57:42 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:36043 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161225AbWBUP5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:57:42 -0500
Date: Tue, 21 Feb 2006 10:54:20 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 5/6] lightweight robust futexes: i386
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602211056_MC3-1-B8E9-59D2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060216094234.GF29716@elte.hu>

On Thu, 16 Feb 2006 at 10:42:34 +0100, Ingo Molnar wrote:

> --- linux-robust-list.q.orig/include/asm-i386/futex.h
> +++ linux-robust-list.q/include/asm-i386/futex.h
> @@ -107,7 +107,25 @@ futex_atomic_op_inuser (int encoded_op, 
>  static inline int
>  futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
>  {
> -     return -ENOSYS;
> +     __asm__ __volatile__(
> +             "1:     " LOCK_PREFIX "cmpxchgl %3, %1          \n"
> +
> +             "2:     .section .fixup, \"ax\"                 \n"
> +             "3:     mov     %2, %0                          \n"
> +             "       jmp     2b                              \n"
> +             "       .previous                               \n"
> +
> +             "       .section __ex_table, \"a\"              \n"
> +             "       .align  8                               \n"
> +             "       .long   1b,3b                           \n"
> +             "       .previous                               \n"
> +
> +             : "=a" (oldval), "=m" (*uaddr)
                                 ^^^^
   Should be "+m" because it's both read and written.

> +             : "i" (-EFAULT), "r" (newval), "0" (oldval)
> +             : "memory"
                  ^^^^^^^^
   Is this necessary? Every possible memory location that could be
affected has been listed in the operands if the above change is made.

> +     );
> +
> +     return oldval;
>  }
>  
>  #endif
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
