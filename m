Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUCZVpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCZVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:45:30 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:22443 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261296AbUCZVpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:45:21 -0500
Date: Fri, 26 Mar 2004 15:45:19 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Daniel Forrest <forrest@lmcg.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
Message-ID: <20040326214519.GA22309@hexapodia.org>
References: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel isn't the right forum for this, but I'll take a stab
anyways.

On Fri, Mar 26, 2004 at 02:54:31PM -0600, Daniel Forrest wrote:
[snip: 180 dual Xeon boxes]
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

The kernel should be doing the right thing to preserve FPU state during
context switches.  That doesn't prevent the app from doing things wrong
and thus getting the wrong answer (perhaps only under certain
circumstances).  And of course the kernel might have bugs (though it's
unlikely to be as simple as "doesn't preserve FPU state correctly"; a
lot of people depend on that codepath being right.)

Likely there is some difference in one of the following areas:
 - hardware problems
 - kernel
 - libraries
 - CPU microcode

Or, you have a bug in your program which is triggered by some
environmental factor.  (For example, an inter-thread race condition
affected by IO interrupts.)

To eliminate them:
 - first, run memtest86 or a similar program to verify that you are not
   simply victim of a bad memory stick.
 - next, check that the kernel, libc, and libm are identical across the
   machines that display the problem.
 - next, check /proc/cpuinfo and dmesg(1) output to verify that your
   CPUs are the same stepping, and running the same microcode.  (The
   likelihood that this is the problem is so small as to be almost not
   worth mentioning.)

> I have run the same test with the program compiled without -ffast-math
> enabled and the results are always identical.

You don't say how many different results you've gotten.  Is there just
one correct and one incorrect result?  Or do different runs give
different incorrect results?  What is the software environment?
(language, libraries, threading, etc.)

Basically, at this point you haven't provided us enough information to
be able to even point a finger at the kernel.  It's certainly possible
that there's a bug, but it's pretty unlikely (IMO).  I'd be looking at
hardware and at threading problems in the apps, first.

-andy
