Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVHFOy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVHFOy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 10:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVHFOy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 10:54:28 -0400
Received: from THUNK.ORG ([69.25.196.29]:28851 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261335AbVHFOy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 10:54:26 -0400
Date: Sat, 6 Aug 2005 10:54:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Message-ID: <20050806145418.GA16523@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
	tony@atomide.com, tuukka.tikkanen@elektrobit.com,
	ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508021443.55429.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 02:43:55PM +1000, Con Kolivas wrote:
> This is a code reordered version of the dynamic ticks patch from Tony Lindgen 
> and Tuukka Tikkanen - sorry about spamming your mail boxes with this, but 
> thanks for the code. There is significant renewed interest by the lkml 
> audience for such a feature which is why I'm butchering your code (sorry 
> again if you don't like me doing this). The only real difference between your 
> code and this patch is moving the #ifdef'd code out of code paths and putting 
> it into dyn-tick specific files. 
> 
> This has slightly more build fixes than the last one I posted and boots and 
> runs fine on my laptop. So far at absolute idle it appears this pentiumM 1.7 
> is claiming to have _25%_ more battery life. I'll need to investigate further 
> to see the real power savings. 

Hi Con,

I had a chance to try out your patch (2.6.13-rc4-dtck-2.patch) and
using either the APIC or PIT timer, if dynamic tick is enabled, on my
laptop, this kicks up the bus mastering activity enough so that the
processor doesn't have a chance to enter the C4 state, and stays stuck
at C2.  As a result, enabling dynamic tick _increases_ power
consumption by 20% on my T40 laptop (1.6 MHz Pentium M).  I monitored
power utilization using pmstats-0.2, and used
/proc/acpi/processor/CPU/power to monitor bus mastering activity and the CPU C-states.

As soon as I disabled dynamic tick using:

	echo 0 > /sys/devices/system/timer/timer0/dyn_tick_state

The number of ticks went up to 1024, bus mastering activity dropped to
zero, and the processor entered C4 state, and power utilization
dropped by 20%.

When I enabled dynamic tick using:

	echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state

The number of ticks dropped down to 60-70 HZ, bus mastering activity
jumpped up to being almost always active, and the processor stayed
stuck at C2 state, and power utilization climbed back up by 20%.

This was on a completely idle, freshly booted machine, without X
running and just a console login.

						- Ted
