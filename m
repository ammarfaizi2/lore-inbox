Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUG2NOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUG2NOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUG2NOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:14:55 -0400
Received: from mail.timesys.com ([65.117.135.102]:19952 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S264571AbUG2NOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:14:51 -0400
Message-ID: <4108F845.7080305@timesys.com>
Date: Thu, 29 Jul 2004 09:14:45 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] PPC math-emu multiply problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2004 13:14:22.0468 (UTC) FILETIME=[F6BCF440:01C4756D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing what appears to be a bug in the ppc kernel trap math 
emulator. An extreme case for multiplies isn't working the way gcc 
soft-float or hardware floating point is. The value in mindble is the 
smallest that can be represented in a double. When we try to divide it 
by two we should see an underflow and a return value of 0. We see this 
when using soft-float in gcc, or when there is HW floating point 
support, but it fails when the kernel trap emulator is used.

If anyone can verify this on a PPC other than an 8560 without hardware 
floating point I'd appreciate it. I did all of these tests with a 2.6.X 
based kernels. The x86 was 2.6.6 vanilla, 8560 is 2.6.6 with lots of 
stuff added and support for 8560. The 8260 was 2.6.0 with changes. I 
bumped into this with the LSB ldexp test. A simple multiply shows the 
problem though.

Greg Weeks

mulbug.c file
------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include <errno.h>

int main()
{
        double  x, rtval;
        double mindble = 4.9406564584124654418e-324;

        x = mindble;

        printf("x = %.20g\n", x);

        errno = 0;
        rtval = ldexp(x, -1);

        printf("using ldexp(x, -1) ERRNO = %d - %s,  %.20g\n",
            errno, strerror(errno), rtval);

        printf("using (x * .5) %.20g\n", (x * .5));

   exit(0);
}
-----------------------------------------

compile with:
gcc mulbug.c -lm -o mulbug


on an 8260 ppc with HW float.

x = 4.9406564584124654418e-324
using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
using (x * .5) 0

on an x86 with HW float.

x = 4.9406564584124654418e-324
using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
using (x * .5) 0

on an 8560 ppc with kernel trap float emulator.

x = 4.9406564584124654418e-324
using ldexp(x, -1) ERRNO = 0 - Success,  4.9406564584124654418e-324
using (x * .5) 4.9406564584124654418e-324

on an 8260 with soft-float in the gcc

x = 4.9406564584124654418e-324
using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
using (x * .5) 0


