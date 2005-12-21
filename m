Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVLUWCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVLUWCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLUWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:02:43 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:47038 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751164AbVLUWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:02:43 -0500
Subject: x86_64 timekeeping buglets
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 21 Dec 2005 17:02:41 -0500
Message-Id: <1135202561.24884.12.camel@x2.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I recently bought a AMD64 X2 box and I have been playing with
the timekeeping code.  I ran into the problem of unsynchronized
TSCs and decided to put some tracing into the timer_interrupt.
I got a couple interesting results.

Consider the following block of code.  I assume that Jan Beulich's
new inline assembler version is still implements this algorithm.

	vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
	if ((((tsc - vxtime.last_tsc) * vxtime.tsc_quot) >> 32) < offset)
		vxtime.last_tsc = tsc - (((long) offset << 32) / vxtime.tsc_quot) - 1;

The first line is correct.  It sets the last_tsc value to a reasonable
estimate of when the PIT timer fired.

If we ignore the scaling the next couple lines are roughly:

	if (delay < offset)
		last_tsc = tsc - offset - 1;

Now assume that the offset value is just slightly larger than the
delay (again assume these values were converted to a common unit).
The last_tsc value will be set to a value which will result in 
a slightly larger offset on the next tick.  This repeats until
the offset accumulates a value large enough to trigger the
lost tick check.  In my case even after the offset overflows the
the remainder was still greater than the delay and the process
continued.  I'm curious if you know what this code was trying
to achieve?

I also notice on a 2.6.13 vintage kernel that the PM timer was 
detected and the vxtime.quot value was set appropriately for the
PM timer but the kernel decided to use the PIT/TSC timekeeping.
I have not checked to see if this still happens with more 
recent kernels.

Jim Houston - Concurrent Computer Corp.


