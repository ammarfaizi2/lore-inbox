Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314089AbSDQOUz>; Wed, 17 Apr 2002 10:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314090AbSDQOUy>; Wed, 17 Apr 2002 10:20:54 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:51086 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S314089AbSDQOUw>;
	Wed, 17 Apr 2002 10:20:52 -0400
Message-ID: <044301c1e61b$00738240$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Andrey Ulanov" <drey@rt.mipt.ru>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020417140510.GB9930@gleam.rt.mipt.ru>
Subject: Re: FPU, i386
Date: Wed, 17 Apr 2002 10:20:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you use -O2 it works.

Assembly with -O2:
        .file   "t1.c"
        .version        "01.01"
gcc2_compiled.:
.section        .rodata
.LC2:
        .string "1/h == 5.0\n"
.LC3:
        .string "1/h < 5.0\n"
.LC4:
        .string "%llx %llx\n"
        .align 8
.LC1:
        .long 0x0,0x40140000
.text
        .align 4
.globl main
        .type    main,@function
main:
        pushl %ebp
        movl %esp,%ebp
        subl $8,%esp
        addl $-12,%esp
        pushl $.LC2
        call printf
        addl $16,%esp
        addl $-12,%esp
        pushl .LC1+4
        pushl .LC1
        pushl .LC1+4
        pushl .LC1
        pushl $.LC4
        call printf
        xorl %eax,%eax
        movl %ebp,%esp
        popl %ebp
        ret
.Lfe1:
        .size    main,.Lfe1-main
        .ident  "GCC: (GNU) 2.95.3 20010315 (release)"


Assembly with a plain compile:
 .file "t1.c"
 .version "01.01"
gcc2_compiled.:
.section .rodata
.LC2:
 .string "1/h == 5.0\n"
.LC3:
 .string "1/h < 5.0\n"
.LC4:
 .string "%llx %llx\n"
 .align 8
.LC0:
 .long 0x9999999a,0x3fc99999
 .align 8
.LC1:
 .long 0x0,0x40140000
.text
 .align 4
.globl main
 .type  main,@function
main:
 pushl %ebp
 movl %esp,%ebp
 subl $24,%esp
 fldl .LC0
 fstpl -8(%ebp)
 fld1
 fdivl -8(%ebp)
 fldl .LC1
 fucompp
 fnstsw %ax
 andb $68,%ah
 xorb $64,%ah
 jne .L3
 addl $-12,%esp
 pushl $.LC2
 call printf
 addl $16,%esp
.L3:
 fld1
 fdivl -8(%ebp)
 fldl .LC1
 fcompp
 fnstsw %ax
 andb $69,%ah
 jne .L4
 addl $-12,%esp
 pushl $.LC3
 call printf
 addl $16,%esp
.L4:
 addl $-12,%esp
 fldl .LC1
 subl $8,%esp
 fstpl (%esp)
 fld1
 fdivl -8(%ebp)
 subl $8,%esp
 fstpl (%esp)
 pushl $.LC4
 call printf
 addl $32,%esp
 xorl %eax,%eax
 jmp .L2
 .p2align 4,,7
.L2:
 movl %ebp,%esp
 popl %ebp
 ret
.Lfe1:
 .size  main,.Lfe1-main
 .ident "GCC: (GNU) 2.95.3 20010315 (release)"


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message ----- 
From: "Andrey Ulanov" <drey@rt.mipt.ru>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 17, 2002 10:05 AM
Subject: FPU, i386


Look at this:

$ cat test.c
#include <stdio.h>

main()
{
double h = 0.2;

if(1/h == 5.0)
    printf("1/h == 5.0\n");

if(1/h < 5.0)
    printf("1/h < 5.0\n");
return 0;
}
$ gcc test.c
$ ./a.out
1/h < 5.0
$ 

I also ran same a.out under FreeBSD. It says "1/h == 5.0".
It seems there is difference somewhere in FPU 
initialization code. And I think it should be fixed.

ps. cc to me
-- 
with best regards, Andrey Ulanov.
drey@rt.mipt.ru
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


