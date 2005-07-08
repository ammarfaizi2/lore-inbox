Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVGHTAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVGHTAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVGHTAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:00:10 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:63684 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S262763AbVGHTAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:00:07 -0400
Message-ID: <42117.62.38.142.34.1120849517.squirrel@webmail.wired-net.gr>
Date: Fri, 8 Jul 2005 22:05:17 +0300 (EEST)
Subject: x86 Endiannes and libc printf
From: "Nanakos Chrysostomos" <nanakos@wired-net.gr>
To: linux-assembly@vger.kernel.org
Reply-To: nanakos@wired-net.gr
User-Agent: SquirrelMail/1.4.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i am searching for a few hours now the endianness in the x86
environment,and i have the following
snippets of code,which in some places i cant understand.Please help me!!!

endian.c
---------
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>


int main()
{
        char *filename= "endian.txt";
        unsigned long buf;
        char *k=(char *)&buf;
        int fd;

        fd = open("makis",O_RDONLY);

        read(fd,&buf,4);

        printf("%.4s\n",&buf);
        printf("%p\n",buf);
        printf("&buf: %p %#x %p\n",&buf,*k,k);
        return 0;
}

endian.txt
----------
DBCA


#./read
DCBA
0x41424344
&buf: 0xbffff8b0 0x44 0xbffff8b0
#


In the first printf everything is fine.In the second printf we see that
the 0x44,0x43,0x42,0x41 byte-data is printed in the revserse order,while
we can see
that in memory it is in the right order after the read system call.Why
this happens?Is it being internal in printf???


I tried to explain that with similar approaches like unions, but the same
happens.endian2.c
---------
#include <stdio.h>
#include <unistd.h>

int   main()
{

        union {
                long   s;
                char    c[sizeof(long)];
        } un;

        un.s = 0x41424344;
        if (sizeof(short) == 2) {
                if (un.c[0] == 0x41 && un.c[1] == 0x42)
                        printf("big-endian\n");
                else if (un.c[0] == 0x44 && un.c[1] == 0x43)
                        printf("little-endian\n");
                else
                        printf("unknown\n");
        } else
                printf("sizeof(short) = %d\n", sizeof(short));


        printf("%.4s\n",&(un.s));
        printf("%p\n",(un.s));
        _exit(0);

}



The same as above.Should i assume that an internal operation in printf is
doing this???


I also used the above assembly example,to see what
happens.Memory-to-memory movements (with push & pop) dont inherit the
little-endian way.Is this
happens only from memory-to-register and the opposite????

read.asm
--------
section .bss
buf     resd    1

section .data
        pathname db "makis",0
section .text

global _start

_start:

;open
mov eax,5
mov ebx,pathname
mov ecx,02
int 0x80


;read
mov ebx,eax
mov eax,3
mov ecx,buf
mov edx,4
int 0x80

;write
mov eax,4
mov ebx,1
mov ecx,buf
mov edx,4
int 0x80

;exit
mov eax,1
mov ebx,0
int 0x80


Everything works just fine.Can anynone knows how can i revserse the order
of the data,from 0x44434241 to 0x41424344 into the stack?? Without using
AND and OR.Can
this be done????


The last two examples is the output from gcc,one "fixed" from me to find
out what is in the stack and the other is the default output from the
first example.My example
has been changed only in the printf call from the library,after the read
call,which i suppose is the "black box" to the "problem" i cant
understand...........read.s
------
        .file   "read.c"
        .version        "01.01"
gcc2_compiled.:
                .section        .rodata
.LC0:
        .string "makis"
.LC1:
        .string "%#x\n"
.text
        .align 4
.globl main
        .type    main,@function
main:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $24, %esp
        movl    $.LC0, -4(%ebp)
        subl    $8, %esp
        pushl   $0
        pushl   $.LC0
        call    open

        addl    $16, %esp
        movl    %eax, %eax
        movl    %eax, -12(%ebp)
        subl    $4, %esp
        pushl   $4
        leal    -8(%ebp), %eax
        pushl   %eax
        pushl   -12(%ebp)
        call    read

---->Before it was the printf call which retrieves its arguments from the
stack.Which as we can see its different for every conversion specifier..

        movl    $4,%eax
        movl    $1,%ebx
        leal    -8(%ebp),%ecx
        movl    $4,%edx
        int     $0x80


        movl    $1, %eax
        movl    $0,%ebx
        int $0x80
.Lfe1:
        .size    main,.Lfe1-main
        .ident  "GCC: (GNU) 2.96 20000731 (Red Hat Linux 7.3 2.96-110)"



Can someone please help me with that???

Thanks in advance,Chris.

