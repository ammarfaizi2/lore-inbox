Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUG2Pge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUG2Pge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267747AbUG2PMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:12:35 -0400
Received: from mail.timesys.com ([65.117.135.102]:46120 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S265900AbUG2O0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:26:08 -0400
Message-ID: <410908FA.7090308@timesys.com>
Date: Thu, 29 Jul 2004 10:26:02 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com>
In-Reply-To: <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 14:25:39.0421 (UTC) FILETIME=[EC0030D0:01C47577]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

>
> On Jul 29, 2004, at 8:14 AM, Greg Weeks wrote:
>
>> I'm seeing what appears to be a bug in the ppc kernel trap math 
>> emulator. An extreme case for multiplies isn't working the way gcc 
>> soft-float or hardware floating point is. The value in mindble is the 
>> smallest that can be represented in a double. When we try to divide 
>> it by two we should see an underflow and a return value of 0. We see 
>> this when using soft-float in gcc, or when there is HW floating point 
>> support, but it fails when the kernel trap emulator is used.
>>
>> If anyone can verify this on a PPC other than an 8560 without 
>> hardware floating point I'd appreciate it. I did all of these tests 
>> with a 2.6.X based kernels. The x86 was 2.6.6 vanilla, 8560 is 2.6.6 
>> with lots of stuff added and support for 8560. The 8260 was 2.6.0 
>> with changes. I bumped into this with the LSB ldexp test. A simple 
>> multiply shows the problem though.
>>
>> Greg Weeks
>>
>> mulbug.c file
>> ------------------------------------------
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <string.h>
>> #include <math.h>
>> #include <errno.h>
>>
>> int main()
>> {
>>        double  x, rtval;
>>        double mindble = 4.9406564584124654418e-324;
>>
>>        x = mindble;
>>
>>        printf("x = %.20g\n", x);
>>
>>        errno = 0;
>>        rtval = ldexp(x, -1);
>>
>>        printf("using ldexp(x, -1) ERRNO = %d - %s,  %.20g\n",
>>            errno, strerror(errno), rtval);
>>
>>        printf("using (x * .5) %.20g\n", (x * .5));
>>
>>   exit(0);
>> }
>> -----------------------------------------
>>
>> compile with:
>> gcc mulbug.c -lm -o mulbug
>>
>>
>> on an 8260 ppc with HW float.
>>
>> x = 4.9406564584124654418e-324
>> using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
>> using (x * .5) 0
>>
>> on an x86 with HW float.
>>
>> x = 4.9406564584124654418e-324
>> using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
>> using (x * .5) 0
>>
>> on an 8560 ppc with kernel trap float emulator.
>>
>> x = 4.9406564584124654418e-324
>> using ldexp(x, -1) ERRNO = 0 - Success,  4.9406564584124654418e-324
>> using (x * .5) 4.9406564584124654418e-324
>
>
> I get the same results on an 8560, with 2.6.8-rc2.  I do not think 
> this is an issue with 8560, but the kernel math emulation's 
> precision.  It is most likely the case that the gcc soft-float code is 
> 'more correct'.  What version of gcc were you using?  It might be 
> possible to replace the kernel fp emulation with gcc's (never looked 
> at how gcc does it).
>
That's what I suspect as well. I'm using a gcc 3.4 snapshot and a 3.4 
release. The kernel math-emu code is based on gcc anyway. It appears the 
multiply is working ok, it's when we go to pack the fp value back up 
that we lose it.

This is the debug output from the multiply.

fmul: dfc20368 dfc203d0 dfc20368
A: 0 8388608 0 -1074 (0) [00800000.00000000 ffffffcd]
B: 0 8388608 0 -1 (0) [00800000.00000000 3fe]
D: 0 8388608 0 -1075 (0) [00800000.00000000 ffffffcc]

>> on an 8260 with soft-float in the gcc
>>
>> x = 4.9406564584124654418e-324
>> using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
>> using (x * .5) 0
>

