Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWBGBP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWBGBP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWBGBP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:15:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932429AbWBGBP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:15:58 -0500
Date: Mon, 6 Feb 2006 17:15:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
In-Reply-To: <20060207112713.7cd0a61c.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0602061656560.3854@g5.osdl.org>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au>
 <20060206.160140.59716704.davem@davemloft.net> <20060207112713.7cd0a61c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Feb 2006, Stephen Rothwell wrote:
> 
> *If* we do get is_compat_task(), what would be you reaction to something
> like this:
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index faf61c3..83d6cd1 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1877,6 +1877,8 @@ asmlinkage long sys_mkdirat(int dfd, con
>  	int error = 0;
>  	char * tmp;
>  
> +	if (is_compat_task())
> +		dfd = compat_sign_extend(dfd);

Oh f*ck, why do people do ugly code like this?

That's just about the nastiest thing I've ever seen.

If you want to go this way, do it with

	asmlinkage long sys_mkdirat(long __dfd, ..
	{
		int dfd = __dfd;

which is at least unconditional.

The thing is unconditionally doing the "skip upper bits" is _faster_ then 
the conditional test to see if you even need it.

Conditionalizing code like this is EVIL and STUPID.

However, what I suspect David was actually suggesting was to just have 
some trivial for just the compat functions. You can generate them 
automatically based on 
 - function name
 - signedness/unsignedness of each argument
with some preprocessor hackery.

So each architecture could have the following #defines:

	#define SARG(x) "sext " x "," x	 // Whatever the architecture asm is for sign-extending a register
	#define UARG(x)	"zext " x "," x
	#define JMP(x)	"jmp " x

	#define ARG1 "%r3"
	#define ARG2 "%r4"
	#define ARG3 "%r5"
	...

and then there would be a generic helper header:

	#define compat_fn1(n, x1) 		\
		asm("compat_" ## n ":\n\t"	\
			x1(ARG1) "\n\t"		\
			JMP(##n))

	#define compat_fn2(n, x1, x2) 		\
		asm("compat_" ## n ":\n\t"	\
			x1(ARG1) "\n\t"		\
			x2(ARG2) "\n\t"		\
			JMP(##n))

	#define compat_fn3(n, x1, x2) 		\
		asm("compat_" ## n ":\n\t"	\
			x1(ARG1) "\n\t"		\
			x2(ARG2) "\n\t"		\
			x3(ARG3) "\n\t"		\
			JMP(##n))

	... fn4..fn6 ..

	compat_fn4(sys_semctl, SARG, SARG, SARG, UARG);
	compat_fn6(sys_waitif, SARG, UARG, UARG, SARG, UARG);
	..

you get the idea - automatically generated stub assembly functions that 
zero-extend or sign-extend the arguments properly. Each architecture would 
need just a minimal set of "helper defines" to create the per-architecture 
assembly language.

(And no, I didn't test the above at all).

		Linus
