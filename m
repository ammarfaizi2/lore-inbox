Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUDSO4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUDSO4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:56:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:22464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264482AbUDSO4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:56:15 -0400
Date: Mon, 19 Apr 2004 07:56:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add 64-bit get_user and __get_user for i386
In-Reply-To: <20040419094408.GA13007@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0404190747110.2808@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com>
 <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org> <20040419004657.GD11064@mail.shareable.org>
 <Pine.LNX.4.58.0404182220470.2808@ppc970.osdl.org> <20040419094408.GA13007@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Apr 2004, Jamie Lokier wrote:
> 
> Subject: [PATCH] Add 64-bit get_user and __get_user for i386
> Patch: uaccess64-2.6.5
> 
> Add 64-bit get_user and __get_user for i386.
> Don't ask me how, but this shrinks the kernel too.

There must be some bug somewhere if the kernel shrinks from this. Although 
possibly the bug is in gcc ;)

Anyway, please don't do it like this (ie making one case be just a
memcpy). If we do this, let's do it right - ie 'd much rather see
something like

	#define get_user(x, ptr)					\
	({ __typeof__(*(ptr)) __val_gu;					\
	   int __ret_gu;						\
	   switch (sizeof(__val_gu)) {					\
	   case 1: __get_user_x(1,__ret_gu,__val_gu,ptr); break;	\
	   case 2: __get_user_x(2,__ret_gu,__val_gu,ptr); break;	\
	   case 4: __get_user_x(4,__ret_gu,__val_gu,ptr); break;	\
	   case 8: __get_user_8(__ret_gu,__val_gu,ptr); break;		\
	   default: __get_user_bad(); break;				\
	   }								\
	   (x) = __val_gu;						\
	   __ret_gu;							\
	})

and then you just make "__get_user_8()" look something like

	#define __get_user_8(ret,x,ptr)				\
		__asm__ __volatile__("call __get_user_8"	\
			:"=A" (ret), "=c" (x)			\
			:"1" (ptr))

Which is _different_ from the other "get_user" cases: it passes the 
address in %ecx, and it returns the error in %ecx too - the return value 
comes in %edx:%eax. Make the __get_user_8 in getuser.S match those 
different rules.

What do you think?

			Linus
