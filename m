Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVC2PRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVC2PRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVC2PRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:17:10 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:63684 "EHLO
	sunsite.mff.cuni.cz") by vger.kernel.org with ESMTP id S262327AbVC2PNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:13:13 -0500
Date: Tue, 29 Mar 2005 17:13:05 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Message-ID: <20050329151305.GQ4961@sunsite.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200503291737.06356.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503291737.06356.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 05:37:06PM +0300, Denis Vlasenko wrote:
> typedef unsigned int size_t;
> 
> static inline void * __memcpy(void * to, const void * from, size_t n)
> {
> int d0, d1, d2;
> __asm__ __volatile__(
>         "rep ; movsl\n\t"
>         "testb $2,%b4\n\t"
>         "je 1f\n\t"
>         "movsw\n"
>         "1:\ttestb $1,%b4\n\t"
>         "je 2f\n\t"
>         "movsb\n"
>         "2:"
>         : "=&c" (d0), "=&D" (d1), "=&S" (d2)
>         :"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
>         : "memory");
> return (to);
> }
> 
> /*
>  * This looks horribly ugly, but the compiler can optimize it totally,
>  * as the count is constant.
>  */
> static inline void * __constant_memcpy(void * to, const void * from, size_t n)
> {
>         if (n <= 128)
>                 return __builtin_memcpy(to, from, n);
> 
> #define COMMON(x) \
> __asm__ __volatile__( \
>         "rep ; movsl" \
>         x \
>         : "=&c" (d0), "=&D" (d1), "=&S" (d2) \
>         : "0" (n/4),"1" ((long) to),"2" ((long) from) \
>         : "memory");
> {
>         int d0, d1, d2;
>         switch (n % 4) {
>                 case 0: COMMON(""); return to;
>                 case 1: COMMON("\n\tmovsb"); return to;
>                 case 2: COMMON("\n\tmovsw"); return to;
>                 default: COMMON("\n\tmovsw\n\tmovsb"); return to;
>         }
> }
> 
> #undef COMMON
> }
> 
> #define memcpy(t, f, n) \
> (__builtin_constant_p(n) ? \
>  __constant_memcpy((t),(f),(n)) : \
>  __memcpy((t),(f),(n)))
> 
> int f3(char *a, char *b) { memcpy(a,b,3); }

The problem is that in GCC < 4.0 there is no constant propagation
pass before expanding builtin functions, so the __builtin_memcpy
call above sees a variable rather than a constant.

Either use GCC 4.0+, where this works just fine, or move the
n <= 128 case into the macro:
#define memcpy(t, f, n) \
(__builtin_constant_p(n) ? \
 ((n) <= 128 ? __builtin_memcpy(t,f,n) : __constant_memcpy(t,f,n) : \
 __memcpy(t,f,n))

	Jakub
