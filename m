Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbTH2R5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTH2R4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:56:19 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:502
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S261566AbTH2R4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:56:14 -0400
Date: Fri, 29 Aug 2003 17:24:18 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030829152418.GB709@wind.cocodriloo.com>
References: <20030828223511.GA23528@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828223511.GA23528@werewolf.able.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 12:35:11AM +0200, J.A. Magallon wrote:
> Hi all...
> 
> gcc3 gives this warning when using the __set_64bit_var function:
> 
> /usr/src/linux/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
> 
> Is it a potential problem ?
> 
> This seems to cure it:
> 
> --- linux-2.4.22-jam1m/include/asm-i386/system.h.orig	2003-08-29 00:26:41.000000000 +0200
> +++ linux-2.4.22-jam1m/include/asm-i386/system.h	2003-08-29 00:26:55.000000000 +0200
> @@ -181,8 +181,8 @@
>  {
>  	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
>  }
> -#define ll_low(x)	*(((unsigned int*)&(x))+0)
> -#define ll_high(x)	*(((unsigned int*)&(x))+1)
> +#define ll_low(x)	*(((unsigned int*)(void*)&(x))+0)
> +#define ll_high(x)	*(((unsigned int*)(void*)&(x))+1)
>  
>  static inline void __set_64bit_var (unsigned long long *ptr,
>  			 unsigned long long value)
> 
> A collateral question: why is the reason for this function ?
> long long assignments are not atomic in gcc ?

On x86, long long int == 64 bits but the chip is 32 bits wide,
so it uses 2 separate memory accesses. There are 64bit-wide
instructions which do bus-locking so that the are atomic,
but gcc will not use them directly.

( info nasm and look up "cmpxchg8b" and related friends)
 
Greets, Antonio.

