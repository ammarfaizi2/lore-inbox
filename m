Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUCZVZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUCZVYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:24:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59521 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261347AbUCZVX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:23:27 -0500
Date: Fri, 26 Mar 2004 16:26:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Daniel Forrest <forrest@lmcg.wisc.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
In-Reply-To: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
Message-ID: <Pine.LNX.4.53.0403261610070.9049@chaos>
References: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004, Daniel Forrest wrote:

> I've tried Googling for an answer on this, but have come up empty and
> I think it likely that someone here probably knows the answer...
>
> We are testing and breaking in 6 racks of compute nodes, each rack
> containing 30 1U boxes, each box containing 2 x 2.8GHz Xeon CPUs.
> Each rack contains identical hardware (single purchase) with the
> exception that one rack has double the memory per node.  The 6 racks
> are located in six different labs across our campus.  It is available
> to me only as a "black box" queueing system.
>
> I am running one of our applications that has been compiled using gcc
> with the -ffast-math option.  I am finding that the identical program
> using the same input data files is producing different results on
> different machines.  However, the differences are all less than the
> precision of a single-precision floating point number.  By this I mean
> that if the results (which are written to 15 digits of precision) are
> only compared to 7 digits then the results are the same.  Also, most
> of the time the 15 digit values are the same.
>
> My question is this: Why aren't the results always the same?  What is
> the -ffast-math option doing?  How are the excess bits of precision
> dealt with during context switches?  Shouldn't the same binary with
> the same inputs produce the same output on identical hardware?
>
> I have run the same test with the program compiled without -ffast-math
> enabled and the results are always identical.
>
> Any insight would be appreciated.

The gcc `man` page says that -ffast-math allows for ANSI and
IEEE rules to be violated. There is also a statement about
not using it in conjunction with -O options as this will result
in incorrect output.

So you get what you asked for.

The FPU has 80-bits of precision internally. Its state is
always saved and restored across context-switches. There
are no "extra bits of precision" as you state.

The FPU's state is not saved during system-calls so the
kernel is not supposed to use the FPU internally.

Look at <math.h> and the files it includes. Note that the
math library takes and returns type double. If you have
declared your floating-point variables as type float, you
will have serious dynamic rounding errors unless you
closely adhere to the IEEE spec. Even then, it might
be serious. If the IEEE spec gets violated by the
--fast-math, you might have discovered the reason why
you get strange values.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


