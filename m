Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVAHQSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVAHQSv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVAHQSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:18:51 -0500
Received: from pD9F874CB.dip0.t-ipconnect.de ([217.248.116.203]:7040 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261202AbVAHQSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:18:41 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.4.x oops with X
Date: Sat, 08 Jan 2005 17:18:00 +0100
Organization: privat
Message-ID: <crp134$sg$1@pD9F874CB.dip0.t-ipconnect.de>
References: <fa.gv4g3v7.1ng0thr@ifi.uio.no> <fa.kmfmtrp.1a16aaf@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20041217
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.kmfmtrp.1a16aaf@ifi.uio.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann schrieb:
[...]
> But now, the question is:
> Why does X crash running kernel 2.4.x with glibc 2.3.4 and not with kernel
> 2.6.10? Why does X run fine using kernel 2.4 and 2.6 with glibc 2.3.3?
> 
> ----------------------------------------------
> 	|		glibc
> 	|	2.3.3		2.3.4
> ------|-------------------------------------
> kernel|
> 2.4	|	X ok		X segfaults
> 2.6	|	X ok		X ok


Meanwhile, I could find where X crashes using glibc 2.3.4 with kernel 2.4.
It's this piece of code in linux_vm86.c:267

static int
vm86_rep(struct vm86_struct *ptr)
{
    int __res;

#ifdef __PIC__
    /* When compiling with -fPIC, we can't use asm constraint "b" because
       %ebx is already taken by gcc. */
    __asm__ __volatile__("pushl %%ebx\n\t"
                         "movl %2,%%ebx\n\t"
                         "movl %1,%%eax\n\t"
                         "int $0x80\n\t"
                         "popl %%ebx"
                         :"=a" (__res)
                         :"n" ((int)113), "r" ((struct vm86_struct *)ptr));
#else
    __asm__ __volatile__("int $0x80\n\t"
                         :"=a" (__res):"a" ((int)113),
                         "b" ((struct vm86_struct *)ptr));
#endif

            if (__res < 0) {
                errno = -__res;
                __res = -1;
            }
            else errno = 0;
            return __res;
}


The function ExecX86int10 (vbe.c) calls do_vm86 (linux_vm86.c), which
calls vm86_rep (linux_vm86.c).


I don't understand, why this piece of assembler code works fine with glibc
2.3.3, but not with glibc 2.3.4, running kernel 2.4.x. It works fine again
with kernel 2.6.



Kind regards,
Andreas Hartmann
