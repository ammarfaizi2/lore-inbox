Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135477AbRAGDeY>; Sat, 6 Jan 2001 22:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135684AbRAGDeE>; Sat, 6 Jan 2001 22:34:04 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18817 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135477AbRAGDdp>; Sat, 6 Jan 2001 22:33:45 -0500
Date: Sat, 6 Jan 2001 22:33:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: posix_types.h  error
Message-ID: <Pine.LNX.3.95.1010106222520.20496A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is an error at line 80 in linux-2.4.0/include/asm/posix_types.h
which prevents source-code from being compiled using the new C compiler
that I was forced to install in order to build the new kernel.

		gcc 2.95.3

Script started on Sat Jan  6 22:16:30 2001
# cat xxx.c


#include <stdio.h>
#include <stdlib.h>


main()
{
    fd_set x;

    FD_ZERO(&x);
}

# gcc -c -o xxx.o xxx.c
xxx.c: In function `main':
xxx.c:11: Invalid `asm' statement:
xxx.c:11: fixed or forbidden register 2 (cx) was spilled for class CREG.
# vi /usr/include/asm/posix_types.h
#ifndef __ARCH_I386_POSIX_TYPES_H
#define __ARCH_I386_POSIX_TYPES_H
[K
[K/*
[K * This file is generally used by user-level software, so you need to
[K * be a little careful about namespace pollution etc.  Also, we cannot
[K * assume GCC is being used.
[K */
[K
[Ktypedef unsigned short  __kernel_dev_t;
[Snipped...]

#define __FD_ZERO(fdsetp) \
[Kdo { \
[K        int __d0, __d1; \
[K        __asm__ __volatile__("cld ; rep ; stosl" \
[K                        :"=m" (*(__kernel_fd_set *) (fdsetp)), \
[K                          "=&c" (__d0), "=&D" (__d1) \
[K                        :"a" (0), "1" (__FDSET_LONGS), \
[K                        "2" ((__kernel_fd_set *) (fdsetp)) : "memory"); \
[K} while (0)
[K
[K#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
[K

exit
Script done on Sat Jan  6 22:19:03 2001

Since these inline asm statements no longer use register names, I
don't know how to fix them. One of life's little mystries is how
previously readable code got into this shape.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
