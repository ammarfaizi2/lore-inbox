Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUEaDEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUEaDEL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 23:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUEaDEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 23:04:11 -0400
Received: from mailout.despammed.com ([65.112.71.29]:62460 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S264505AbUEaDEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 23:04:06 -0400
Date: Sun, 30 May 2004 21:50:53 -0500 (CDT)
Message-Id: <200405310250.i4V2ork05673@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mans Rullgard replied to me:

>> A driver, implemented as a module, must do some floating-point
>> computations including trig functions.
>
>Sorry, floating point in the Linux kernel isn't allowed.

No.  Use of floating point HARDWARE, and/or emulation which emulates
troublesome features such as traps, isn't allowed.  Guess why I posted
in the first place, asking whether a certain combination of techniques
might be feasible.

>> Recompile GNU's libc with option "--without-fp".
>
>Probably, but it doesn't matter, since the kernel doesn't link with
>libc.

This unfortunate answer probably does answer my question, thank you.

>> Compile the module's .c files with gcc's "-msoft-float" option and
>> "-D__NO_MATH_INLINES". (Actually I think "-D__NO_MATH_INLINES" is
>> probably unnecessary here.)
>
>Using floating point emulation will be VERY slow.

No kidding.  And if I write my own code to do floating point emulation,
it will be even slower.  But if we do none of the above, then we should
say the result will be even slower because we will wait an infinite amount
of time without getting results.

>> Link the module's .o files with the version of libc produced above,
>> and try to get a loadable .ko from this... or a loadable .o since the
>> target is still kernel 2.4.something.
>
>As I said, the kernel doesn't link with libc.

Right, but is there a way to get a customized libc.a to link with a
module's .o and produce a loadable .o without damaging the rest of the
kernel.  I don't quite know a way.

>Floating point is forbidden in kernel code since the floating point
>registers (and other floating point context) is not saved/restored

No kidding, that's why use of floating point HARDWARE is prohibited.

>might be possible to manually save the floating point context while
>doing some floating point operations.

Yes, my searching found a few people saying they had found tricks like
this, but my impression is that it's very unreliable and they didn't
reveal their entire trickery (probably unteachable as mentioned).
I do think it is better to avoid the floating point hardware entirely.

>What you should do is think again about why you need all this floating
>point in the kernel.

To control a device.

>Could it be moved to userspace somehow?

Yes, if we use a real-time Linux and make a daemon cooperate very closely
with the driver.

>Maybe you could use lookup tables instead of doing floating point
>arithmetic.

You might be right, if the device can only be controlled to position itself
in say 1,000 different ways, then we could have lookup tables for 1,000
different intervals of (emulations of) floating-point numbers, that yield
1,000 different values of sin.  Another table for cos, another for log10,
etc.  But I'd still have to write my own emulations for binary operators
such as +, /, etc., since a 1,000*1,000 lookup table would be too big.
