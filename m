Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266501AbUGKF01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUGKF01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 01:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUGKF01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 01:26:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:40685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266501AbUGKF0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 01:26:24 -0400
Date: Sat, 10 Jul 2004 22:25:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-Id: <20040710222510.0593f4a4.akpm@osdl.org>
In-Reply-To: <20040709182638.GA11310@elte.hu>
References: <20040709182638.GA11310@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> I took a
>  look at latencies and indeed 2.6.7 is pretty bad - latencies up to 50
>  msec (!) can be easily triggered using common workloads, on fast 2GHz+
>  x86 system - even when using the fully preemptible kernel!

What were those workloads?

Certainly 2.6+preempt is not as good as 2.4+LL at this time, but 2.6 isn't
too bad either.  Even under heavy filesystem load it's hard to exceed a 0.5
millisecond holdoff.  There are still a few problem in the ext3 checkpoint
buffer handling, but those seem pretty hard to hit.  I doubt if the `Jack'
testers were running `dbench 1000' during their testing.  

All of which makes me suspect that the problems which the `Jack' testers
saw were not directly related to long periods of non-preemption in-kernel. 
At least, not in core kernel/fs/mm code.  There have been problem in the
past in places like i2c drivers, fbdev scrolling, etc.

What we need to do is to encourage audio testers to use ALSA drivers, to
enable CONFIG_SND_DEBUG in the kernel build and to set
/proc/asound/*/*/xrun_debug and to send us the traces which result from
underruns.

As for the patch, well, sprinkling rescheduling points everywhere is still
not the preferred approach.  But adding more might_sleep() checks is a
sneaky way of making it more attractive ;)

Minor point:  this:

	cond_resched();
	function_which_might_sleep();

is less efficient than

	function_which_might_sleep();
	cond_resched();

because if function_which_might_sleep() _does_ sleep, need_resched() will
likely be false when we hit cond_resched(), thus saving a context switch. 
Unfortunately, might_sleep() calls tend to go at the entry to functions,
whereas cond_resched() calls should be neat the exit point, or inside loop
bodies.
