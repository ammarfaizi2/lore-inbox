Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbTHaB2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTHaB2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:28:05 -0400
Received: from aneto.able.es ([212.97.163.22]:34947 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261547AbTHaB2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:28:01 -0400
Date: Sun, 31 Aug 2003 03:27:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030831012759.GA3276@werewolf.able.es>
References: <20030828223511.GA23528@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.29, J.A. Magallon wrote:
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

How about something like this:

typedef unsigned long long	u64;
typedef unsigned long		u32;
typedef unsigned short		u16;
typedef unsigned char		u8;

union u64_split {
	u64	ll;
	u32 l[2];
	u16 w[4];
	u8  b[8];
};

void f()
{
	u64 a;

	int l = ((union u64_split)a).l[0];
	int h = ((union u64_split)a).l[1];
}

The clean way todo it without pointer arithmetic...

And with a modern gcc (anonymous structs):

union u64_split {
	u64	x;
	struct {
		u32 	l32,h32;
	};
	struct {
		u16 ll16,lh16,hl16,hh16;
	};
};

So you just write:

int l = ((union u64_split)a).l32;
u16 word = ((union u64_split)a).ll16;

I think it is better with structs, to take care of endianness if needed.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
