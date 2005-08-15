Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVHONGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVHONGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 09:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVHONGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 09:06:32 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6637 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932182AbVHONGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 09:06:31 -0400
Date: Mon, 15 Aug 2005 16:06:22 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Arjan van de Ven <arjan@infradead.org>
cc: Denis Vlasenko <vda@ilport.com.ua>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] make kcalloc() a static inline
In-Reply-To: <1124108737.3228.35.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0508151601540.3068@sbz-30.cs.Helsinki.FI>
References: <20050808223842.GM4006@stusta.de>  <200508151233.46523.vda@ilport.com.ua>
  <1124098918.3228.25.camel@laptopd505.fenrus.org>  <200508151517.52171.vda@ilport.com.ua>
 <1124108737.3228.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 15:17 +0300, Denis Vlasenko wrote:
> > Seems like that optimization is not helping.
> > Do you have better example?

On Mon, 15 Aug 2005, Arjan van de Ven wrote:
> you need gcc 4.1 (eg CVS) for the value range propagation stuff.

For Denis' example, it does not seem to help. I must admit I did not know 
GCC 3.x does not have this optimization. I am also bit confused as Adrian 
and  I saw small reduction in kernel text with kcalloc() inlined. If GCC 
is, in fact, spreading the extra operations everywhere, shouldn't kernel 
text be bigger?

			Pekka

penberg@haji ~/tmp $ ~/bin/gcc-4.1-cvs/bin/gcc -v
Using built-in specs.
Target: i686-pc-linux-gnu
Configured with: ../gcc/configure --prefix=/home/penberg/bin/gcc-4.1-cvs 
--enable-languages=c
Thread model: posix
gcc version 4.1.0 20050815 (experimental)
penberg@haji ~/tmp $ ~/bin/gcc-4.1-cvs/bin/gcc -O -S -mcpu=i386 t.c
`-mcpu=' is deprecated. Use `-mtune=' or '-march=' instead.
penberg@haji ~/tmp $ cat t.s
        .file   "t.c"
        .text
.globl f
        .type   f, @function
f:
        pushl   %ebp
        movl    %esp, %ebp
        pushl   %ebx
        subl    $4, %esp
        movl    12(%ebp), %eax
        cmpl    $999, %eax
        jg      .L2
        movl    %eax, %ebx
        movl    8(%ebp), %ecx
        testl   %ecx, %ecx
        je      .L4
        movl    $2147483647, %eax
        movl    $0, %edx
        divl    %ecx
        cmpl    %eax, %ebx
        ja      .L2
.L4:
        subl    $8, %esp
        pushl   $1
        movl    %ebx, %eax
        imull   %ecx, %eax
        pushl   %eax
        call    kzalloc
        addl    $16, %esp
        jmp     .L6
.L2:
        movl    $0, %eax
.L6:
        movl    -4(%ebp), %ebx
        leave
        ret
        .size   f, .-f
        .ident  "GCC: (GNU) 4.1.0 20050815 (experimental)"
        .section        .note.GNU-stack,"",@progbits

