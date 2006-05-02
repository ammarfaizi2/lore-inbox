Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWEBN37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWEBN37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEBN37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:29:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14348 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964810AbWEBN36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:29:58 -0400
Date: Tue, 2 May 2006 14:29:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: sched_clock() uses are broken
Message-ID: <20060502132953.GA30146@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Someone just asked a question about sched_clock() on the ARM list, asking
whether there was any way to find the range of values returned by this
function.

My initial thought was "why would you want that", but on considering the
problem a bit further, I could see why the question arises.  In looking
deeper, I discovered a rather sad state of affairs with sched_clock().

The kernel assumes that the following will work:

	unsigned long long t0, t1, time_passed_ns;

	t0 = sched_clock();
	/* do something */
	t1 = sched_clock();

	time_passed_ns = t1 - t0;

This is all very well if sched_clock() returns values filling the
entire range of an unsigned long long - two complement maths will
naturally return the time difference in the case where t1 < t0.

However, this is not the case.  On x86 with TSC, it returns a 54 bit
number.  This means that when t1 < t0, time_passed_ns becomes a very
large number which no longer represents the amount of time.

All uses in kernel/sched.c seem to be aflicted by this problem.

There are several solutions to this - the most obvious being that we
need a function which returns the nanosecond difference between two
sched_clock() return values, and this function needs to know how to
handle the case where sched_clock() has wrapped.

IOW:

	t0 = sched_clock();
	/* do something */
	t1 = sched_clock();

	time_passed = sched_clock_diff(t1, t0);

Comments?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
