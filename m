Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRGRJ60>; Wed, 18 Jul 2001 05:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbRGRJ6Q>; Wed, 18 Jul 2001 05:58:16 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:19211 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S267852AbRGRJ6F>;
	Wed, 18 Jul 2001 05:58:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Brent Baccala <baccala@freesoft.org>
Date: Wed, 18 Jul 2001 11:57:41 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Do kernel threads need their own stack?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <8F87F416D97@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 01 at 3:16, Brent Baccala wrote:

> The first thing I notice is that this function refers not only to the
> clone flags in ebx, but also to a "newsp" in ecx - and ecx went
> completely unmentioned in kernel_thread()!  A disassembly of
> 
> Anyway, I'm confused.  My analysis might be wrong, since I don't spend
> that much time in the Linux kernel, but bottom line - doesn't
> kernel_thread() need to allocate stack space for the child?  I mean,
> even if everything else is shared, doesn't the child at least need it's
> own stack?

ecx specifies where userspace stack lives, not kernel space one, and 
each process gets its own kernel stack automagically. As you must not
ever return to userspace from kernel_thread(), it is not a problem.
Because of exiting from kernel_thread() to userspace is not trivial
task, I do not think that is worth of effort.

If you are in doubts, you can trace code down to copy_thread. It copies
parent's registers as entered by int 0x80, and then uses ret_from_fork
for child's return path. So it returns to same place from where it
was invoked - in kernel_thread() case into kernel, with esp just being
on the top of kernel stack. And value passed for esp into clone() is lost
in that case, as it was stored in return stackframe esp field (oldesp
in entry.S) which was not used by processor because of it did not change 
its CPL to userspace (stack->cs & 3 was equal to %cs & 3, so stack pointer
was not fetched from stack).

Only problem I see is that we could give 8 more bytes to child by doing
add $8,%esp in child path in kernel_thread(), as currently we leave
these 8 bytes (oldesp, oldss) filled with garbage. But on other side,
if 8 bytes is everything what saves you from stack overflow, you are
in serious troubles anyway (in Linux, of course; 8 bytes is half of
your stack on i8048). And leaving it this way we ensure that child
has 16byte aligned stack on its enter, which can speed up code a bit
too.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
