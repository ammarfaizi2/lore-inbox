Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVCLQYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVCLQYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVCLQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:24:37 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:60296 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261812AbVCLQYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:24:35 -0500
Date: Sat, 12 Mar 2005 09:25:13 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Andrew Morton <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
In-Reply-To: <4233111A.5070807@mvista.com>
Message-ID: <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005, George Anzinger wrote:

> Looks like we need the irq on the read clock also.  This is true both before
> and  after the prior cmos_time changes.
> 
> The attached replaces the patch I sent yesterday.
> 
> For those wanting to fix the kernel with out those patches, all that is needed
> its the chunk that applies, i.e. the _irq on the get_cmos_time() spinlocks.
> 
> And more... That this occures implies we are attempting to update the cmos
> clock on resume seems wrong.  One would presume that the time is wrong at this
> time and we are about to save that wrong time.  Possibly the APM code should
> change time_status to STA_UNSYNC on the way into the sleep (or what ever it is
> called).  Who should we ping with this?

timer_resume, which appears to be the problem, wants to calculate amount 
of time was spent suspended, also your unconditional irq enable in 
get_cmos_time breaks the atomicity of device_power_up and would deadlock 
in sections of code which call get_time_diff() with xtime_lock held. I 
sent a patch subject "APM: fix interrupts enabled in device_power_up" 
which should address this.

Thanks,
	Zwane

