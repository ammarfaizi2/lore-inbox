Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314335AbSDRMfK>; Thu, 18 Apr 2002 08:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314336AbSDRMfJ>; Thu, 18 Apr 2002 08:35:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46415 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314335AbSDRMfI>; Thu, 18 Apr 2002 08:35:08 -0400
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 boot enhancements, Clean up the 32bit entry points 6/11
In-Reply-To: <20020418094413.77178.qmail@web11808.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Apr 2002 06:27:52 -0600
Message-ID: <m1lmbl5gzb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain <etienne_lorrain@yahoo.fr> writes:

> You want to change completely the protected mode entry point, that does
> bother me, you know why (gujin). It is a simple (as simple as possible)
> interface, available from a _very_ long time.

*Cough*  
It is impossibly broken to use, and it has long been said it is
unsupported.  That means when someone breaks it you get to keep the
pieces. 

>   I would say:
> - Please initialise registers (segment registers) before using them, it
>  is already complex enough. A bug there will be really difficult to find.
>  Moreover that remind me another OS using registers (%bx) without
>  initialising it first.

I do.  See setup.S

I could probably change that code sequence to only rely on %cs having
a sane value.  But it is much saner to rely on having %cs, %ds, and
%es having a sane value than to rely on the presence of global
descriptor table, with the descriptors you need.  Especially since
after loading a segment register it is safe to throw away the
descriptor table, and still use the segment.

Also there is only one set of sane protected mode segments values to
use.  Do you know anyone who doesn't use flat 4G segments with a base
of 0?  (While in protected mode.)

Arguing against using registers without initialization might
be credible if you weren't also arguing for, using a global
descriptor table and %ebx and %esi without initialization.

As for bugs I have run that code with %cs, %ds, and %es having totally
different descriptor values from an overwritten gdt and it worked just
fine.

> - Please keep the 'lss SYMBOL_NAME(stack_start),%esp' around, it is the
> _only_ way to know if a kernel is "loaded low" or "loaded high", just in
> case you want to write a bootloader which loads _any_ kernel, even 1.x

????  I guess if you skim forward and find that instruction, and then
read the address of the stack_start symbol, you could figure that out.
But that instruction hasn't been at a constant offset, and there is a
much cleaner way of detecting that, examining the bit in the kernel
header that tells you explicitly.

> - Please stay compatible.

I bumped the kernel boot protocol, so auto detect should be trivial.

I did not break any bootloader using a supported interface.

I added a supportable 32bit entry point.

The interface has not been fixed in time so I don't know what you want
me to be compatible with.

Eric
