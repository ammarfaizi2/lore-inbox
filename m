Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286193AbRLZKny>; Wed, 26 Dec 2001 05:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286194AbRLZKno>; Wed, 26 Dec 2001 05:43:44 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:63437 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S286193AbRLZKnZ>; Wed, 26 Dec 2001 05:43:25 -0500
Date: Wed, 26 Dec 2001 11:42:55 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weird __put_user_asm behavior
In-Reply-To: <01122416414400.02578@manta>
Message-ID: <Pine.LNX.4.33.0112261119310.18055-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > So here it goes: when I patch the macro in include/asm-i386/uaccess.h
> > named __put_user_asm using the patch below I cannot 'strace ls' anymore.
> > The ld.so runtime linker just stops when preparing the program displaying
> > a nice message; the same message as '/lib/ld-linux.so.2' generates when
> > ran without any parameters.
> > The kernel messages of __put_user_asm go to: 0xbffffb44; then the program
> > stops on the ld.so message.
> > But, 'strace'-ing of a static compiled program does the job as expected.
> > What am I doing wrong?
> 
> > --- linux-2.4.17/include/asm-i386/uaccess.h	Sat Dec 22 09:35:17 2001
> > +++ linux/include/asm-i386/uaccess.h	Mon Dec 24 12:43:22 2001
> > @@ -194,6 +194,10 @@
> >   * aliasing issues.
> >   */
> >  #define __put_user_asm(x, addr, err, itype, rtype, ltype)	\
> > +do {								\
> > +	if (current->ptrace & PT_PTRACED) {			\
> > +		printk(KERN_DEBUG "__put_user_asm: %#x\n", (unsigned long)(addr)); \
> > +	}							\
> >  	__asm__ __volatile__(					\
> 
> This must be clobbering some registers and some users of __put_user_asm
> might not expect that... did you try saving/restoring all regs around this 
> 'if'?

I tried to save/restore the eax register before/after the printk function 
call because this register is the only register on an i386 that a function 
may alter without preserving its previous contents (even when the 
function returns void).
What is weird is that an __asm__ __volatile__("nop") within the 
if-statement works so it's not the if-statement itself that is causing 
the problem, also works is a "push %eax\n\tpop %eax" so again it's not 
the stack that is causing the problem. 
But, when I try to access the (addr) parameter then execve shows the 
ld.so message again. This is very odd because all it does is (in most 
cases because GCC optimizes a lot) pushing a general register containing 
(addr) onto the stack then call the function (I also tried a void func) 
and after the call restore esp.
So, any more advice on this?

Thanks in advance,
Frank.

PS: Yes, I'm a thesis student and I really need this :).

