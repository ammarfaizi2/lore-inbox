Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTJPEG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbTJPEG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:06:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:33491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262675AbTJPEG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:06:27 -0400
Date: Wed, 15 Oct 2003 21:10:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
Message-Id: <20031015211012.5daac8fc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
>  cpu_has_foo and friends don't work at all with my gcc 3.2.2-5 and i'm 
>  branching off into all sorts of tests (which is another story...). i also 
>  took the liberty of removing the const volatile...

The volatile is rather important.


static inline int constant_test_bit(int nr, const unsigned long *addr)
{
        return ((1UL << (nr & 31)) & (((const unsigned long *) addr)[nr >> 5])) != 0;
}

foo(unsigned long *p)
{
        while (constant_test_bit(0, p))
                ;
}


        .file   "a.c"
        .text
        .align 2
        .p2align 2,,3
.globl foo
        .type   foo,@function
foo:
        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %eax
        testb   $1, (%eax)
        .p2align 2,,3
.L2:
        jne     .L2
        leave
        ret
.Lfe1:
        .size   foo,.Lfe1-foo
        .ident  "GCC: (GNU) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)"


See, the little busywait loop doesn't reevaluate the test each time around:
it locks up instead.

