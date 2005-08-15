Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVHOMSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVHOMSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVHOMSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:18:25 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:45699 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750730AbVHOMSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:18:24 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [-mm patch] make kcalloc() a static inline
Date: Mon, 15 Aug 2005 15:17:52 +0300
User-Agent: KMail/1.5.4
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050808223842.GM4006@stusta.de> <200508151233.46523.vda@ilport.com.ua> <1124098918.3228.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1124098918.3228.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151517.52171.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 August 2005 12:41, Arjan van de Ven wrote:
> On Mon, 2005-08-15 at 12:33 +0300, Denis Vlasenko wrote:
> 
> > gcc can optimize that away with non-const n?! I don't think so.
> 
> due to the wonders of "value range propagation" it actually can, if the
> check is done sufficiently before...
> 
> gcc keeps track of the range a variable can have at each point, so if
> the check is done before, the "possible range" will be such that the
> divide should be optimizable.
> 
> (Note: this is a relatively new feature in gcc though)

# gcc -v
Using built-in specs.
Target: i386-pc-linux-gnu
Configured with: ../gcc-4.0.0.src/configure --prefix=/usr/app/gcc-4.0.0 --exec-prefix=/usr/app/gcc-4.0.0 --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/app/gcc-4.0.0/libexec --datadir=/usr/app/gcc-4.0.0/share --sysconfdir=/etc --sharedstatedir=/usr/app/gcc-4.0.0/var/com --localstatedir=/usr/app/gcc-4.0.0/var --libdir=/usr/lib --includedir=/usr/include --infodir=/usr/info --mandir=/usr/man --with-slibdir=/usr/app/gcc-4.0.0/lib --with-local-prefix=/usr/local --with-gxx-include-dir=/usr/app/gcc-4.0.0/include/g++-v3 --enable-languages=c,c++ --with-system-zlib --disable-nls --enable-threads=posix i386-pc-linux-gnu
Thread model: posix
gcc version 4.0.0
# cat t.c
#include <stdlib.h>
#include <limits.h>

void *kzalloc(size_t size, unsigned int flags);

static inline void *kcalloc(size_t n, size_t size, unsigned int flags)
{
        if (n != 0 && size > INT_MAX / n)
                return NULL;
        return kzalloc(n * size, flags);
}

void* f(int n, int sz)
{
        if (sz<1000) return kcalloc(n, sz, 1);
        return NULL;
}
# gcc -O2 -S -mcpu=i386 t.c
`-mcpu=' is deprecated. Use `-mtune=' or '-march=' instead.
# cat t.s
        .file   "t.c"
        .text
        .p2align 2,,3
.globl f
        .type   f, @function
f:
        pushl   %ebp
        movl    %esp, %ebp
        pushl   %ebx
        movl    8(%ebp), %ebx
        movl    12(%ebp), %ecx
        cmpl    $999, %ecx
        jg      .L2
        testl   %ebx, %ebx
        jne     .L9
.L4:
        movl    $1, 12(%ebp)
        imull   %ebx, %ecx
        movl    %ecx, 8(%ebp)
        popl    %ebx
        leave
        jmp     kzalloc
        .p2align 2,,3
.L9:
        movl    $2147483647, %eax
        xorl    %edx, %edx
        divl    %ebx
        cmpl    %eax, %ecx
        jbe     .L4
        .p2align 2,,3
.L2:
        xorl    %eax, %eax
        popl    %ebx
        leave
        ret
        .size   f, .-f
        .ident  "GCC: (GNU) 4.0.0"
        .section        .note.GNU-stack,"",@progbits


Seems like that optimization is not helping.
Do you have better example?
--
vda

