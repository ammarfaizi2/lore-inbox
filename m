Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTJ3NUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTJ3NUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:20:19 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:40099 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262440AbTJ3NUM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:20:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on SIGFPE
Date: Thu, 30 Oct 2003 18:48:27 +0530
Message-ID: <94F20261551DC141B6B559DC491086727C8C70@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on SIGFPE
Thread-Index: AcOe5HOR0jgS7PqbToCnlggpoVH/CQAAyCpA
From: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
To: <root@chaos.analogic.com>
Cc: "Magnus Naeslund(t)" <mag@fbab.net>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Oct 2003 13:19:45.0957 (UTC) FILETIME=[7CC7B550:01C39EE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr Johnson,
    Thanks for the mail. Actually I see that there is no fpu_control.h
in my src.

Thanks and Regards
SReeram

---Never doubt that a small group of thoughtful, committed people can
change the world. Indeed, it is the only thing that ever has. -- Copied
from a mail
 

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Thursday, October 30, 2003 6:23 PM
To: Sreeram Kumar Ravinoothala
Cc: Magnus Naeslund(t); Linux kernel
Subject: RE: Question on SIGFPE


On Thu, 30 Oct 2003, Sreeram Kumar Ravinoothala wrote:

> Hi,
> 	I tried this. It says that the address is 0. And also I saw that
it 
> doesn't fall into any of the si_codes of SIGFPE.
>
> Regards
> Sreeram
>

First, to see if it's an access violation (#GP) or an actual FPE, set
the FPU unit to ignore /0 errors. You do it like this:

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

With the above code, you can divide by zero with no problem. If you
unmask, using the FPU_MASK, you get the divide by zero error.

If your program now "functions", you have a real divide by zero error
that may be related to "real-world" data, that was not caught during
your initial testing.

If your program still fails, the error is really caused by the FPU
attempting to access memory you don't own. Note that all floating-pount
numbers exist as memory oprands in Intel stuff. So you could have an
out-of-bounds access or, perhaps, a stack- overflow.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


