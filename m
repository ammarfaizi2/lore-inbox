Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWGHHCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWGHHCO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 03:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWGHHCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 03:02:13 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:32134 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964821AbWGHHCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 03:02:13 -0400
Date: Sat, 8 Jul 2006 00:02:12 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: trajce nedev <trajcenedev@hotmail.com>
cc: chase.venters@clientec.com, torvalds@osdl.org, acahalan@gmail.com,
       linux-kernel@vger.kernel.org, linux-os@analogic.com, khc@pm.waw.pl,
       mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
Message-ID: <Pine.LNX.4.58.0607072358190.25242@shell3.speakeasy.net>
References: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, trajce nedev wrote:

> On Sat, 8 Jul 2006, Chase Venters wrote:
> >
> >Perhaps you should have followed this thread closely before composing your
> >assault on Linus. We're not talking about "asm volatile". We're talking
> >about
> >the "volatile" keyword as applied to variables. 'volatile' as applied to
> >inline ASM is of course necessary in many cases -- no one is disputing
> >that.
> >
>
> Ok, let's port a spinlock macro that spins instead of context switches
> instead of using the pthread garbage on IA64 or AMD64:
>
> #if ((defined (_M_IA64) || defined (_M_AMD64)) && !defined(NT_INTEREX))
> #include <windows.h>
> #pragma intrinsic (_InterlockedExchange)
>
> typedef volatile LONG lock_t[1];
>
> #define LockInit(v)	((v)[0] = 0)
> #define LockFree(v)	((v)[0] = 0)
> #define Unlock(v)	((v)[0] = 0)
>
> __forceinline void Lock(volatile LONG *hPtr)
> {
> 	int iValue;
>
> 	for (;;) {
> 		iValue = _InterlockedExchange((LPLONG)hPtr, 1);
> 		if (iValue == 0)
> 			return;
> 		while (*hPtr);
> 	}
> }
>
> Please show me how I can write this to spinlock without using volatile.

See how Linux implements them. After Linus's patch, there will be no
volatile data qualifiers. In general, if you're concerned about the
compiler turning
	while (*hPtr);
into an infinite loop, then you should look at compiler barriers
(amongst other things). To find details, search for "barrier()".

> 		Trajce Nedev
> 		tnedev@mail.ru

-- Vadim Lobanov
