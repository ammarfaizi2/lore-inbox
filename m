Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVAMO7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVAMO7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVAMO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:59:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261642AbVAMO61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:58:27 -0500
Date: Thu, 13 Jan 2005 09:30:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x oops with X
Message-ID: <20050113113041.GA5440@logos.cnet>
References: <fa.gv4g3v7.1ng0thr@ifi.uio.no> <fa.kmfmtrp.1a16aaf@ifi.uio.no> <crp134$sg$1@pD9F874CB.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <crp134$sg$1@pD9F874CB.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 05:18:00PM +0100, Andreas Hartmann wrote:
> Andreas Hartmann schrieb:
> [...]
> > But now, the question is:
> > Why does X crash running kernel 2.4.x with glibc 2.3.4 and not with kernel
> > 2.6.10? Why does X run fine using kernel 2.4 and 2.6 with glibc 2.3.3?
> > 
> > ----------------------------------------------
> > 	|		glibc
> > 	|	2.3.3		2.3.4
> > ------|-------------------------------------
> > kernel|
> > 2.4	|	X ok		X segfaults
> > 2.6	|	X ok		X ok
> 
> 
> Meanwhile, I could find where X crashes using glibc 2.3.4 with kernel 2.4.
> It's this piece of code in linux_vm86.c:267
> 
> static int
> vm86_rep(struct vm86_struct *ptr)
> {
>     int __res;
> 
> #ifdef __PIC__
>     /* When compiling with -fPIC, we can't use asm constraint "b" because
>        %ebx is already taken by gcc. */
>     __asm__ __volatile__("pushl %%ebx\n\t"
>                          "movl %2,%%ebx\n\t"
>                          "movl %1,%%eax\n\t"
>                          "int $0x80\n\t"
>                          "popl %%ebx"
>                          :"=a" (__res)
>                          :"n" ((int)113), "r" ((struct vm86_struct *)ptr));
> #else
>     __asm__ __volatile__("int $0x80\n\t"
>                          :"=a" (__res):"a" ((int)113),
>                          "b" ((struct vm86_struct *)ptr));
> #endif
> 
>             if (__res < 0) {
>                 errno = -__res;
>                 __res = -1;
>             }
>             else errno = 0;
>             return __res;
> }
> 
> 
> The function ExecX86int10 (vbe.c) calls do_vm86 (linux_vm86.c), which
> calls vm86_rep (linux_vm86.c).
> 
> 
> I don't understand, why this piece of assembler code works fine with glibc
> 2.3.3, but not with glibc 2.3.4, running kernel 2.4.x. It works fine again
> with kernel 2.6.

No idea either - the oops should be gone in -rc2 now that the get_user_pages() debugging
patch has been reverted.
