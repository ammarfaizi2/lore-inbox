Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSIZOb5>; Thu, 26 Sep 2002 10:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSIZOb5>; Thu, 26 Sep 2002 10:31:57 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:41356 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261300AbSIZOb4>; Thu, 26 Sep 2002 10:31:56 -0400
Date: Thu, 26 Sep 2002 09:36:37 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kksymoops-2.5.38-C9
In-Reply-To: <Pine.LNX.4.44.0209261536020.18328-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209260914170.6032-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Ingo Molnar wrote:

> in the attached kksymoops patch (against BK-curr) has the following fixes
> over yesterday's version:

I know this seems to be a never ending story to get exactly right, but 
anyway, more comments.

> kksymoops-disabled, modules-enabled output:
> 
> --------->
> kernel BUG at time.c:100!
> invalid operand: 0000
> 
> CPU:    1
> EIP:    0060:[<c011ddd4>]    Not tainted
> EFLAGS: 00010246
> eax: 0000004e   ebx: cf0fe000   ecx: 00000000   edx: 00000068
> esi: 00000000   edi: 00000000   ebp: bffffad8   esp: cf0fffa0
> ds: 0068   es: 0068   ss: 0068
> Process gettimeofday (pid: 569, threadinfo=cf0fe000 task=cf418060)
> Stack: 4001695c bffff414 40156154 00000004 c0112b50 cf0fe000 400168e4 bffffb44
>        c0107973 00000000 00000000 40156154 400168e4 bffffb44 bffffad8 0000004e
>        0000002b 0000002b 0000004e 400cecc1 00000023 00000246 bffffacc 0000002b
> Call Trace: [<c0112b50>] [<c0107973>]

Actually, in this case I would have expected to get the symbols resolved
using the exported symbols the kernel knows anyway. I can see two possible
explanations for that not happening: The addresses are lower than the
first exported symbol (look in /proc/ksyms to check), or (more likely)
there is still a bug in the address_to_exported_symbol() function.

I wondered initially, if it even makes any sense to use exported symbols 
only for resolving an address, but it actually is useful in the case of 
modules. For one reason, it actually names the module which the crash 
occured in, and given the module it also allows to actually find out where 
exactly the problem happened, which you normally cannot do, since you do 
not know which address the module was loaded at.

> @@ -137,15 +136,16 @@
>  	if (!stack)
>  		stack = (unsigned long*)&stack;
>  
> -	printk("Call Trace: ");
> +	printk("Call Trace:");
> +#if CONFIG_KALLSYMS

I think this should be || CONFIG_MODULES (see above)

> +	printk("\n");
> +#endif
>  	i = 1;
>  	while (((long) stack & (THREAD_SIZE-1)) != 0) {
>  		addr = *stack++;
>  		if (kernel_text_address(addr)) {
> -			if (i && ((i % 6) == 0))
> -				printk("\n   ");
> -			printk("[<%08lx>] ", addr);
> -			i++;
> +			printk(" [<%08lx>]", addr);
> +			print_symbol("%s\n", addr);
>  		}
>  	}
>  	printk("\n");

This will produce rather ugly output when the call trace is longer than
what fits in one line, since no one is adding "\n" then at all.

(This can be done with an ifdef, to avoid it I used the return value of
print_symbol() before, which is not really all that nice, either).
Maybe it's better to bite the bullet, use one #ifdef and get both cases 
separate, even if that's a slight duplication of code. (Oh, and I think 
most code uses #ifdef not #if, though of course both works the same)


> --- linux/include/linux/module.h.orig	Fri Sep 20 17:20:32 2002
> +++ linux/include/linux/module.h	Thu Sep 26 15:31:15 2002

> +extern void print_symbol(const char *fmt, unsigned long address);
> +
> +#else
> +
> +static inline int
> +print_symbol(const char *fmt, unsigned long address)
> +{
> +	return -ESRCH;
> +}
> +
>  #endif
>  
>  #endif /* _LINUX_MODULE_H */

You missed converting the return value of the inline variant.


--Kai




