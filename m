Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUKHTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUKHTPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUKHTOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:14:51 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:16903 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261183AbUKHTLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:11:46 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] kill IN_STRING_C
Date: Mon, 8 Nov 2004 20:11:46 +0100
User-Agent: KMail/1.7.1
References: <20041107142445.GH14308@stusta.de> <200411081942.38954.pluto@pld-linux.org> <20041108185222.GE15077@stusta.de>
In-Reply-To: <20041108185222.GE15077@stusta.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411082011.46775.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of November 2004 19:52, you wrote:
> On Mon, Nov 08, 2004 at 07:42:38PM +0100, Pawe?? Sikora wrote:
> >...
> > [~/rpm/BUILD] # gcc -Wall sp.c -S -O2 -fomit-frame-pointer -mregparm=3
> >                     -nostdinc -isystem /usr/src/linux/include
> >
> > sp.c: In function `test':
> > sp.c:7: warning: implicit declaration of function `sprintf'
> >
> > [~/rpm/BUILD] # cat sp.s
> >
> >         .file   "sp.c"
> >         .text
> >         .p2align 4,,15
> > .globl test
> >         .type   test, @function
> > test:
> >         movl    %eax, %edx
> >         movl    $buf, %eax
> >         jmp     strcpy
> >         .size   test, .-test
> >         .comm   buf,128,32
> >         .section        .note.GNU-stack,"",@progbits
> >         .ident  "GCC: (GNU) 3.4.3 (PLD Linux)"
> >
> >
> > What now?
>
> Do a "make V=1" and use the complete gcc call you see there.

[~/rpm/BUILD/linux-2.6.10-rc1] #

gcc -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2
-Wdeclaration-after-statement -pipe -msoft-float -mpreferred-stack-boundary=2
-fno-unit-at-a-time -march=pentium3 -Iinclude/asm-i386/mach-default -S sp.c

        .file   "sp.c"
        .text
        .p2align 4,,15
.globl test
        .type   test, @function
test:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $8, %esp
        movl    $buf, (%esp)
        movl    8(%ebp), %eax
        movl    %eax, 4(%esp)
        call    strcpy
        leave
        ret
        .size   test, .-test
        .p2align 4,,15
        .type   strcpy, @function
strcpy:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $12, %esp
        movl    %esi, -8(%ebp)
        movl    8(%ebp), %edx
        movl    12(%ebp), %esi
        movl    %edi, -4(%ebp)
        movl    %edx, %edi
#APP
        1:      lodsb
        stosb
        testb %al,%al
        jne 1b
#NO_APP
        movl    -8(%ebp), %esi
        movl    %edx, %eax
        movl    -4(%ebp), %edi
        movl    %ebp, %esp
        popl    %ebp
        ret
        .size   strcpy, .-strcpy
.globl buf
        .bss
        .align 32
        .type   buf, @object
        .size   buf, 128
buf:
        .zero   128
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.4.3 (PLD Linux)"

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
