Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbTEIL2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTEIL1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:27:45 -0400
Received: from mrt-aod.iram.es ([150.214.224.146]:29196 "EHLO mrt-lx16.iram.es")
	by vger.kernel.org with ESMTP id S262463AbTEIL0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:26:36 -0400
Date: Fri, 9 May 2003 11:37:29 +0000
From: paubert <paubert@iram.es>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509113729.C16311@mrt-lx16.iram.es>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com> <20030509042659.GS8978@holomorphy.com> <3EBB4735.30701@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB4735.30701@nortelnetworks.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 02:14:13AM -0400, Chris Friesen wrote:
> William Lee Irwin III wrote:
> 
> >Try the timebase instead.
> 
> The timestamp is not hard to get.  The problem is getting a medium-frequency 
> 
> (2KHz or so) hardware interrupt to drive the test.

Reload the decrementer with a smaller value, and read the decrementer value
at the beginning of every timer_interrupt. Timekeeping only depends on the
timebase on PPC (I wrote most of the code), taking additional decrementer
interrupts does not harm. Actually the simplest and most efficient way
to perform a self IPI on PPC is to write 0 to the decrementer (2 machine
instructions). 

Actually, a way to measure the longest time during which interrupts are masked
would be:

	- when disabling interrupts, set decrementer to zero if they
	were previously enabled.
	- read the decrementer on every timer/external interrupt,
	if the value is negative and too large print the value
	and the point at which the interrupts were reenabled.

That's not perfect (it will generate not too many false positives but
quite some overhead, but it should work).

	Gabriel 
