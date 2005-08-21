Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVHUJul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVHUJul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVHUJul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:50:41 -0400
Received: from siaag2ah.compuserve.com ([149.174.40.141]:22623 "EHLO
	siaag2ah.compuserve.com") by vger.kernel.org with ESMTP
	id S1750917AbVHUJul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:50:41 -0400
Date: Sun, 21 Aug 2005 05:47:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: FPU-intensive programs crashing with floating point 
  exception on Cyrix MII
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Message-ID: <200508210550_MC3-1-A7CF-D29E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 12:37:30 +0200, Ondrej Zary wrote:

> >   Could you modify this to print the full values of cwd and swd like this?
> > 
> >         printk("MATH ERROR: cwd = 0x%hx, swd = 0x%hx\n", cwd, swd);
> > 
> > Then post the result.
> MATH ERROR: cwd = 0x37f, swd = 0x5020
> MATH ERROR: cwd = 0x37f, swd = 0x20
> MATH ERROR: cwd = 0x37f, swd = 0x20
> MATH ERROR: cwd = 0x37f, swd = 0x2020
> MATH ERROR: cwd = 0x37f, swd = 0x20
> MATH ERROR: cwd = 0x37f, swd = 0x1820
> MATH ERROR: cwd = 0x37f, swd = 0x1820
> MATH ERROR: cwd = 0x37f, swd = 0x2020
> MATH ERROR: cwd = 0x37f, swd = 0x20
> MATH ERROR: cwd = 0x37f, swd = 0x2800     <===========
> MATH ERROR: cwd = 0x37f, swd = 0x1820
> MATH ERROR: cwd = 0x37f, swd = 0x820
> MATH ERROR: cwd = 0x37f, swd = 0x2820
> MATH ERROR: cwd = 0x37f, swd = 0x2820
> MATH ERROR: cwd = 0x37f, swd = 0x1820
> MATH ERROR: cwd = 0x37f, swd = 0x820
> MATH ERROR: cwd = 0x37f, swd = 0x1a20

 The error I marked has no exception flags set.  The rest are all (masked)
denormal exceptions.  Why your Cyrix MII would cause an FPU exception in these
cases is beyond me.  Could you try the statically-linked mprime program?

 I had hoped someone who knew more about FPU error handling would jump in.
The below code from arch/i386/kernel/traps.c sends a signal back to
userspace even when the status word shows a masked (or no) exception has
occurred.  The 'case 0x000' strongly suggests this is deliberate but I
don't know why.


        /*
         * (~cwd & swd) will mask out exceptions that are not set to unmasked
         * status.  0x3f is the exception bits in these regs, 0x200 is the
         * C1 reg you need in case of a stack fault, 0x040 is the stack
         * fault bit.  We should only be taking one exception at a time,
         * so if this combination doesn't produce any single exception,
         * then we have a bad program that isn't syncronizing its FPU usage
         * and it will suffer the consequences since we won't be able to
         * fully reproduce the context of the exception
         */
        cwd = get_fpu_cwd(task);
        swd = get_fpu_swd(task);
        switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
                case 0x000:
                default:
                        break;
                case 0x001: /* Invalid Op */
                case 0x041: /* Stack Fault */
                case 0x241: /* Stack Fault | Direction */
                        info.si_code = FPE_FLTINV;
                        /* Should we clear the SF or let user space do it ???? */
                        break;


(And it looks like there is a small bug in there.  The switch should be:

        switch (((~cwd) & swd & 0x3f) | (swd & 1 ? swd & 0x240 : 0)) {

because the SF and CC1 bits are only relevant when IE is set.)

__
Chuck
