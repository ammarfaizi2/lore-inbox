Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbUKUWL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUKUWL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbUKUWL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:11:59 -0500
Received: from alog0112.analogic.com ([208.224.220.127]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261831AbUKUWLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:11:36 -0500
Date: Sun, 21 Nov 2004 17:10:59 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <20041120143755.E13550@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2004, Russell King wrote:

> Linus,
>
> Sparse appears to segfault when trying to check kernel/timer.c:
>
>  CC      kernel/ptrace.o
>  CHECK   /home/rmk/bk/linux-2.6-rmk/kernel/timer.c
> make[2]: *** [kernel/timer.o] Error 139
> make[1]: *** [kernel] Error 2
> make: *** [_all] Error 2
>
> It doesn't seem to matter which ARM machine I have my kernel configured
> for, the result is always the same.
>
> #0  0x08059222 in expand_conditional (expr=0xf6a88c4c) at expand.c:478
> 478                     *expr = *true;
> (gdb) where
> #0  0x08059222 in expand_conditional (expr=0xf6a88c4c) at expand.c:478
> #1  0x08059956 in expand_expression (expr=0xf6a88c4c) at expand.c:859
> #2  0x08059a32 in expand_symbol (sym=0x5) at expand.c:917
> #3  0x08048cc0 in clean_up_symbols (list=0x9464fb0) at check.c:100
> #4  0x08048eb5 in main (argc=40, argv=0xfef19dc4) at check.c:192
> (gdb) print expr
> $1 = (struct expression *) 0xf6a88c4c
> (gdb) print true
> $2 = (struct expression *) 0x0
> (gdb) print *expr
> $3 = {type = EXPR_CONDITIONAL, op = 63, pos = {type = 6, stream = 1,
>    newline = 0, whitespace = 1, pos = 22, line = 566, noexpand = 0},
>  ctype = 0x80764a0, {value = 4138241036, fvalue = <invalid float value>,
>    string = 0xf6a88c0c, unop = 0xf6a88c0c, statement = 0xf6a88c0c,
>    expr_list = 0xf6a88c0c}}
>
> Unfortunately, gdb won't show me the contents of expr->cond_true nor
> expr->cond_false without the following:
>
> (gdb) print *(&expr->string)
> $4 = (struct string *) 0xf6a88c0c
> (gdb) print *(&expr->string+1)
> $5 = (struct string *) 0x0
> (gdb) print *(&expr->string+2)
> $6 = (struct string *) 0xf6a88c6c
>
> Looks like expr->cond_true is NULL.  Line 566 of kernel/timer.c is:
>
> int tickadj = 500/HZ ? : 1;             /* microsecs */
>
> which makes it look like sparse doesn't understand such constructions.

I don't think any 'C' compiler should understand such constructions
either.
 	There is no result for the TRUE condition, and the standard
does not provide for a default. The compiler should have written
a diagnostic.


>
> -- 
> Russell King
> Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
> maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                 2.6 Serial core


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
