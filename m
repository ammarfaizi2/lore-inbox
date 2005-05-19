Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVESCWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVESCWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 22:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVESCWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 22:22:41 -0400
Received: from smtpout.mac.com ([17.250.248.86]:40697 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262453AbVESCWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 22:22:37 -0400
In-Reply-To: <20050518195337.GX5112@stusta.de>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> <20050518195337.GX5112@stusta.de>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
Cc: "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Illegal use of reserved word in system.h
Date: Wed, 18 May 2005 22:22:24 -0400
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 18, 2005, at 15:53:37, Adrian Bunk wrote:
> Looking at the source code of MySQL, it seems MySQL does some dirty
> tricks for using the inlines from asm/atomic.h in userspace.
>
> It's _really_ wrong to do this.

A project that had some discussion a while ago was to clean up the
kernel headers and separate them from the kernel-ABI ones, such that
the ABI headers don't need to use CONFIG_* defines or anything else.
that might be iffy.

I suppose a related project would be to build a generic architecture
library (How about "libarch"?) that has a clean set of headers and
context-independent functions  (ASM memset, ASM memmove, etc), with
the ability to be used directly in userspace or kernelspace, and
exported via a vDSO to userspace for applications that want it.  It
could share the same memory pages between the kernel and userspace,
and with the appropriate config options, it could provide locking
and memory routines optimized for the particular architecture.

I realize that locking routines for some architectures would need to
be implemented by a libc via kernel calls, as the requisite opcodes
are unavailable under usermode, but that could easily be handled by
a wrapper library, as long as the kernel-supported functions and
inlines are provided cleanly and without clutter.  The simplistic
__KERNEL__ define could just switch between privileged-opcode inlines
and unprivileged ones, including undefining them entirely and telling
the wrapper libc headers to implement them with syscalls.

This would be a major project, but I think it would make life a lot
easier for application developers.  I also think that this library
would need to be licensed under the GPL, due to the existing license
on the kernel code that would be copied, but it _might_ be useable
from proprietary applications  (NOTE: IANAL, and I certainly don't
claim to speak for the kernel community at large, so YMMV and you may
well get sued for such usage, but it would still be very useful in
low-latency GPL'ed software that needs atomic ops and spinlocks, and
could be used for more if we threw in the linked list implementation
and other completely arch-agnostic code.)

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------

