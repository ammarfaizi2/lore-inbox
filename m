Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVCLT7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVCLT7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVCLT7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:59:09 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:11148 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262021AbVCLT54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:57:56 -0500
Date: Sat, 12 Mar 2005 12:58:36 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Andrew Morton <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
In-Reply-To: <42332F18.5050004@mvista.com>
Message-ID: <Pine.LNX.4.61.0503121248160.2903@montezuma.fsmlabs.com>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com>
 <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com> <42332F18.5050004@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005, George Anzinger wrote:

> I agree.  Still in all that follows, no one has addressed the apparent race
> described above.  The reason the system reported the errors that started this
> thread is that the APM restore code was trying to read the cmos clock (I
> assume to set the xtime clock) WHILE the timer interrupt code what trying to
> set the cmos clock from xtime.

Doesn't my reply explain the actual problem? The code path being;

arch/i386/kernel/apm.c
suspend()
	write_seqlock_irq(xtime_lock)
	...
	write_sequnlock_irq(xtime_lock)
	<interrupts enabled>
	device_power_up()
		timer_resume()
			get_cmos_time();

So this covers the problem that the reporter reported, so yes it's setting 
xtime but we shouldn't be taking interrupts in the first place, so i 
posted the patch to cover that. APM was clearly violating PM resume 
procedures.

Thanks,
	Zwane


