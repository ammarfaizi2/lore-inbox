Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbUKHWT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUKHWT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKHWT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:19:57 -0500
Received: from alog0167.analogic.com ([208.224.220.182]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261275AbUKHWTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:19:16 -0500
Date: Mon, 8 Nov 2004 17:15:14 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Adrian Bunk <bunk@stusta.de>
cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
In-Reply-To: <20041108212713.GH15077@stusta.de>
Message-ID: <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de>
 <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org>
 <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
 <20041108212713.GH15077@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Adrian Bunk wrote:

> On Mon, Nov 08, 2004 at 02:12:18PM -0500, linux-os wrote:
>>
>> On this compiler 3.3.3, -O2 will cause it to use strcpy().
>
> Not for me:
>
>        .file   "test.c"
>        .section        .rodata.str1.1,"aMS",@progbits,1
> .LC0:
>        .string "%s"
>        .text
>        .p2align 4,,15
> .globl test
>        .type   test, @function
> test:
>        pushl   %ebp
>        movl    %esp, %ebp
>        subl    $12, %esp
>        movl    %eax, 8(%esp)
>        movl    $.LC0, %eax
>        movl    %eax, 4(%esp)
>        movl    $buf, (%esp)
>        call    sprintf
>        movl    %ebp, %esp
>        popl    %ebp
>        ret
>        .size   test, .-test
> .globl buf
>        .bss
>        .align 32
>        .type   buf, @object
>        .size   buf, 128
> buf:
>        .zero   128
>        .section        .note.GNU-stack,"",@progbits
>        .ident  "GCC: (GNU) 3.3.5 (Debian 1:3.3.5-2)"
>
>
>
> Are you using exactly my example file?
> Are you using the complete gcc command line as shown by "make V=1"?
> Which gcc 3.3.3 are you using?
>

No, I am using (no headers):
-------------------
extern int sprintf(char *, const char *,...);
extern int puts(const char *);
static const char hello[]="Hello";
int xxx(void);
int xxx(){
    char buf[0x100];
    sprintf(buf, "%s", hello);
    puts(buf);
    return 0;
}
--------------------

Compiled as:

gcc -O2 -Wall -S -o xxx xxx.c

I get:

 	.file	"xxx.c"
 	.section	.rodata
 	.type	hello, @object
 	.size	hello, 6
hello:
 	.string	"Hello"
 	.text
 	.p2align 2,,3
.globl xxx
 	.type	xxx, @function
xxx:
 	pushl	%ebp
 	movl	%esp, %ebp
 	pushl	%ebx
 	subl	$268, %esp
 	pushl	$hello
 	leal	-264(%ebp), %ebx
 	pushl	%ebx
 	call	strcpy
 	movl	%ebx, (%esp)
 	call	puts
 	xorl	%eax, %eax
 	movl	-4(%ebp), %ebx
 	leave
 	ret
 	.size	xxx, .-xxx
 	.section	.note.GNU-stack,"",@progbits
 	.ident	"GCC: (GNU) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)"


If I don't use -O2, I get the sprintf() call. If I use
the constant string "Hello" instead of the allocated string,
it just bypasses everything and calls puts() directly.

If I use -fno-builtin, then it doesn't bypass sprintf().
However, there is no ISO C standard of "built-in" so
I don't think any compiler should default to something
that is undefined and decide to do whatever its current
whims are. Certainly, a compiler that has some capabilities,
not defined by a standard, should be able to use those
capabilities, but it certainly shouldn't decide to do
these things on its own.

Reviewing `man gcc` I see where I should be able to
find out what the built-in commands are:

 	gcc -dumpspecs

However, this man page is wrong because I don't get a
listing of any built-in functions, only the linking
and compiler defaults.

The compiler is a tool. It should be just like other
tools. Any killer options should be something that
take a special effort to turn ON. It shouldn't default
to firing the bullet out both ends of the barrel!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
