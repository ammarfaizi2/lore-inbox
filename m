Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUG2OIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUG2OIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUG2OH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:07:28 -0400
Received: from motgate8.mot.com ([129.188.136.8]:27028 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S264668AbUG2OGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:06:51 -0400
In-Reply-To: <4108F845.7080305@timesys.com>
References: <4108F845.7080305@timesys.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [BUG] PPC math-emu multiply problem
Date: Thu, 29 Jul 2004 09:06:44 -0500
To: Greg Weeks <greg.weeks@timesys.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 29, 2004, at 8:14 AM, Greg Weeks wrote:

> I'm seeing what appears to be a bug in the ppc kernel trap math 
> emulator. An extreme case for multiplies isn't working the way gcc 
> soft-float or hardware floating point is. The value in mindble is the 
> smallest that can be represented in a double. When we try to divide it 
> by two we should see an underflow and a return value of 0. We see this 
> when using soft-float in gcc, or when there is HW floating point 
> support, but it fails when the kernel trap emulator is used.
>
> If anyone can verify this on a PPC other than an 8560 without hardware 
> floating point I'd appreciate it. I did all of these tests with a 
> 2.6.X based kernels. The x86 was 2.6.6 vanilla, 8560 is 2.6.6 with 
> lots of stuff added and support for 8560. The 8260 was 2.6.0 with 
> changes. I bumped into this with the LSB ldexp test. A simple multiply 
> shows the problem though.
>
> Greg Weeks
>
> mulbug.c file
> ------------------------------------------
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> #include <math.h>
> #include <errno.h>
>
> int main()
> {
>        double  x, rtval;
>        double mindble = 4.9406564584124654418e-324;
>
>        x = mindble;
>
>        printf("x = %.20g\n", x);
>
>        errno = 0;
>        rtval = ldexp(x, -1);
>
>        printf("using ldexp(x, -1) ERRNO = %d - %s,  %.20g\n",
>            errno, strerror(errno), rtval);
>
>        printf("using (x * .5) %.20g\n", (x * .5));
>
>   exit(0);
> }
> -----------------------------------------
>
> compile with:
> gcc mulbug.c -lm -o mulbug
>
>
> on an 8260 ppc with HW float.
>
> x = 4.9406564584124654418e-324
> using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
> using (x * .5) 0
>
> on an x86 with HW float.
>
> x = 4.9406564584124654418e-324
> using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
> using (x * .5) 0
>
> on an 8560 ppc with kernel trap float emulator.
>
> x = 4.9406564584124654418e-324
> using ldexp(x, -1) ERRNO = 0 - Success,  4.9406564584124654418e-324
> using (x * .5) 4.9406564584124654418e-324

I get the same results on an 8560, with 2.6.8-rc2.  I do not think this 
is an issue with 8560, but the kernel math emulation's precision.  It 
is most likely the case that the gcc soft-float code is 'more correct'. 
  What version of gcc were you using?  It might be possible to replace 
the kernel fp emulation with gcc's (never looked at how gcc does it).

> on an 8260 with soft-float in the gcc
>
> x = 4.9406564584124654418e-324
> using ldexp(x, -1) ERRNO = 34 - Numerical result out of range,  0
> using (x * .5) 0
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

