Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbUKHSvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUKHSvd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUKHSvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:51:24 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:64774 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261166AbUKHSnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:43:18 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
Date: Mon, 8 Nov 2004 19:43:20 +0100
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411081943.21310.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of November 2004 19:31, you wrote:
> On Mon, Nov 08, 2004 at 07:04:13PM +0100, Pawe?? Sikora wrote:
> > On Monday 08 of November 2004 17:31, you wrote:
> > > On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
> > > > > Rethinking it, I don't even understand the sprintf example in your
> > > > > changelog entry - shouldn't an inclusion of kernel.h always get it
> > > > > right?
> > > >
> > > > Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str)
> > > > transparently.
> > >
> > > Which gcc is "Newer"?
> > >
> > > My gcc 3.4.2 didn't show this problem.
> >
> > #include <stdio.h>
> > #include <string.h>
> > char buf[128];
> > void test(char *str)
> > {
> >     sprintf(buf, "%s", str);
> > }
> >...
> >         jmp     strcpy
> >...
>
> This is the userspace example.
>
> The kernel example is:
>
> #include <linux/string.h>
> #include <linux/kernel.h>
>
> char buf[128];
> void test(char *str)
> {
>   sprintf(buf, "%s", str);
> }
>
>
> This results with gcc-3.4 (GCC) 3.4.2 (Debian 3.4.2-3) in:
>
>         .file   "test.c"
>         .section        .rodata.str1.1,"aMS",@progbits,1
> .LC0:
>         .string "%s"
>         .text
>         .p2align 4,,15
> .globl test
>         .type   test, @function
> test:
>         pushl   %eax
>         pushl   $.LC0
>         pushl   $buf
>         call    sprintf
>         addl    $12, %esp
>         ret
>         .size   test, .-test
> .globl buf
>         .bss
>         .align 32
>         .type   buf, @object
>         .size   buf, 128
> buf:
>         .zero   128
>         .section        .note.GNU-stack,"",@progbits
>         .ident  "GCC: (GNU) 3.4.2 (Debian 3.4.2-3)"

[~/rpm/BUILD] # cat sp.c

#include <linux/string.h>
#include <linux/kernel.h>

char buf[128];
void test(char *str)
{
    sprintf(buf, "%s", str);
}

[~/rpm/BUILD] # gcc -Wall sp.c -S -O2 -fomit-frame-pointer -mregparm=3
                    -nostdinc -isystem /usr/src/linux/include

sp.c: In function `test':
sp.c:7: warning: implicit declaration of function `sprintf'

[~/rpm/BUILD] # cat sp.s

        .file   "sp.c"
        .text
        .p2align 4,,15
.globl test
        .type   test, @function
test:
        movl    %eax, %edx
        movl    $buf, %eax
        jmp     strcpy
        .size   test, .-test
        .comm   buf,128,32
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.4.3 (PLD Linux)"


What now?

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
