Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265964AbRGERmT>; Thu, 5 Jul 2001 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266076AbRGERmJ>; Thu, 5 Jul 2001 13:42:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27777 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265964AbRGERl7>; Thu, 5 Jul 2001 13:41:59 -0400
Date: Thu, 5 Jul 2001 13:41:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: mdaljeet@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: floating point problem
In-Reply-To: <CA256A80.005F1790.00@d73mta01.au.ibm.com>
Message-ID: <Pine.LNX.3.95.1010705133657.25259A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001 mdaljeet@in.ibm.com wrote:

> In Linux PPC, the MSR[FP] bit (that is floating point available bit) is off
> (atleast for non-SMP).
>

Yes, so the first FP instruction per process lets "lazy FPU" save/restore
work.

 
> Due to this, whenever some floating point instruction is executed in 'user
> mode', it leads to a exception 'FPUnavailable'. The exception handler for
> this exception apart from setting the MSR[FP] bit, also sets the MSR[FE0]
> and MSR[FE1] bits. These bits basically enables the floating point
> exceptions so that if there are some floating point exception conditions
> encountered while exeuting a floating point instruction, an appropriate
> exception is raised.
> But whenever some floating point instruction is executed in 'kernel mode',
> 'FPUnavailabe' exception handler code does not set the 'MSR[FE0] and
> MSR[FE1]' bits.
>

The kernel is not supposed to use floating-point.

[SNIPPED...]

I think all you need is this:

/*
 *  Note FPU control only exists per process. Therefore, you have
 *  to set up the FPU before you use it in any program.
 */
#include <i386/fpu_control.h>

#define FPU_MASK (_FPU_MASK_IM |\
                  _FPU_MASK_DM |\
                  _FPU_MASK_ZM |\
                  _FPU_MASK_OM |\
                  _FPU_MASK_UM |\
                  _FPU_MASK_PM)

void fpu()
{
    __setfpucw(_FPU_DEFAULT & ~FPU_MASK);
}


main() {
   double zero=0.0;
   double one=1.0;
   fpu();

   one /=zero;
}



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


