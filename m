Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJ3MwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTJ3MwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:52:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41615 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262422AbTJ3Mv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:51:58 -0500
Date: Thu, 30 Oct 2003 07:53:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sreeram Kumar Ravinoothala <sreeram.ravinoothala@wipro.com>
cc: "Magnus Naeslund(t)" <mag@fbab.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Question on SIGFPE
In-Reply-To: <94F20261551DC141B6B559DC491086727C8C69@blr-m3-msg.wipro.com>
Message-ID: <Pine.LNX.4.53.0310300743300.3402@chaos>
References: <94F20261551DC141B6B559DC491086727C8C69@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Sreeram Kumar Ravinoothala wrote:

> Hi,
> 	I tried this. It says that the address is 0. And also I saw that
> it doesn't fall into any of the si_codes of SIGFPE.
>
> Regards
> Sreeram
>

First, to see if it's an access violation (#GP) or an actual FPE,
set the FPU unit to ignore /0 errors. You do it like this:

---------------
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
//    __setfpucw(_FPU_DEFAULT & ~FPU_MASK);
    __setfpucw(_FPU_DEFAULT);
}


main() {
   double zero=0.0;
   double one=1.0;
   fpu();

   one /=zero;
}
--------------

With the above code, you can divide by zero with no problem. If
you unmask, using the FPU_MASK, you get the divide by zero error.

If your program now "functions", you have a real divide by zero error
that may be related to "real-world" data, that was not caught during
your initial testing.

If your program still fails, the error is really caused by the
FPU attempting to access memory you don't own. Note that all
floating-pount numbers exist as memory oprands in Intel stuff.
So you could have an out-of-bounds access or, perhaps, a stack-
overflow.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


