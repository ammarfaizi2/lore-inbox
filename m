Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVCCRhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVCCRhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVCCRfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:35:33 -0500
Received: from one.firstfloor.org ([213.235.205.2]:11169 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262556AbVCCReq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:34:46 -0500
To: Dror Cohen <dror.xiv@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time Drift Compensation on Linux Clusters
References: <6c58e3190503030650595cbd5@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 03 Mar 2005 18:34:39 +0100
In-Reply-To: <6c58e3190503030650595cbd5@mail.gmail.com> (Dror Cohen's
 message of "Thu, 3 Mar 2005 16:50:52 +0200")
Message-ID: <m1wtsofxao.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dror Cohen <dror.xiv@gmail.com> writes:

> Hi all,
> While working on a Linux cluster with kernel version 2.4.27 we've
> encountered a consistent clock drift problem. We have devised a fix

The normal fix is to use NTP.

The clock drift problem on lost ticks is known, but I don't
think your change is the right fix.

>
> In IO intensive environments a many CPU cycles are spent handling interrupts.
> This is done by the device driver code for the different IO devices.
> Typically, while
> dealing with the hardware, device drivers block other IRQs, including the PIT's
> (timer) IRQ.

Drivers are not supposed to block interrupts for a long time.
If they do in your environment it would be better to fix this.

> Each time a time interrupt is missed the system looses one jiffy.
> These lost jiffies
> accumulate into a consisting clock drift.

It doesn't. jiffies is not used in gettimeofday(), only xtime and
wall_jiffies is. Fixing up jiffies would at best help you against a 
"uptime drift" and make the kernel internal timers a bit more accurate.

Did you really test your code? I bet it doesn't help.

In general using the TSC like this is also dangerous, because
there are system where its rate is not stable (e.g. it can vary
when the CPU changes to lower frequencies for power saving) 

BTW when you submit any patches do it in diff -u format and ready
to apply. Your form is very reviewer and user unfriendly.

> 	> #ifdef X86_TSC_DRIFT_COMPENSATION
> 	>       __u64 cycles = get_cycles();
> 	>       while (xtdc_last < cycles) {
> 	>               (*(unsigned long *)&jiffies)++;

This is also wrong because jiffies is really a 64bit variable.

-Andi
