Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbQKOVjc>; Wed, 15 Nov 2000 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQKOVjW>; Wed, 15 Nov 2000 16:39:22 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:24306 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129178AbQKOVjB>; Wed, 15 Nov 2000 16:39:01 -0500
Date: Wed, 15 Nov 2000 16:17:37 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
In-Reply-To: <3A12F852.E578E6CE@mvista.com>
Subject: Re: In line ASM magic? What is this?
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001115213912Z129178-521+471@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from George Anzinger <george@mvista.com> on Wed, 15 Nov
2000 12:55:46 -0800


> I am trying to understand what is going on in the following code.  The
> reference for %2, i.e. "m"(*__xg(ptr)) seems like magic (from
> .../include/i386/system.h).  At the same time, the code "m" (*mem) from
> the second __asm__ below (my code) seems to generate the required asm
> code.  Before I go with the simple version, could someone tell me why? 
> Inquiring minds want to know.
> 
> struct __xchg_dummy { unsigned long a[100]; };
> #define __xg(x) ((struct __xchg_dummy *)(x))
> 
> 		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %b1,%2"
> 				     : "=a"(prev)
> 				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
> 				     : "memory");
> 
> 
> 	__asm__ __volatile__(
>                              LOCK "cmpxchgl %1,%2\n\t"
>                              :"=a" (result)
>                              :"r" (new),
>                               "m" (*mem),
>                               "a0" (test)
>                              : "memory");

I've been a lot of gcc inline asm recently, and I still consider it a black
art.  There are times when I just throw in what I think makes sense, and then
look at the code the compiler generated.  If it's wrong, I try something else.

Both versions look correct to me.  The "m" simply tells the compiler that
__xg(ptr) is a memory location, and the contents of that memory location should
NOT be copied to a register.  The confusion occurs because its unintuitive that
the "*" is required.  Otherwise, it would have been "r", which basically tells
the compiler to copy the contents to a register first.



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
