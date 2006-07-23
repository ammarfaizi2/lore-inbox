Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWGWAKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWGWAKq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWGWAKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:10:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbWGWAKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:10:45 -0400
Date: Sat, 22 Jul 2006 17:10:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <20060722194018.GA28924@redhat.com>
Message-ID: <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Jul 2006, Dave Jones wrote:
>
> This stuff makes my head hurt. Someone who is motivated
> enough to fix up hotplug-cpu can fix this up later.
> In the meantime, this patch should cure the lockdep
> warnings that seem to trigger very easily.

It doesn't seem to fix all problems. On CPU unplug, I still get deadlocks 
through some workqueue:

 [<c03af64a>] __mutex_lock_slowpath+0x4d/0x7b
 [<c03af687>] .text.lock.mutex+0xf/0x14
 [<c0137591>] __lock_cpu_hotplug+0x36/0x56
 [<c01375ca>] lock_cpu_hotplug+0xa/0xc
 [<c012f7c2>] flush_workqueue+0x2d/0x61
 [<c012f83b>] flush_scheduled_work+0xd/0xf
 ...

and the nasty part is that this can apparently hit _any_ process that 
wants to flush workqueues (in one particular case, it was through 
tty_release() -> release_dev() in drivers/char/tty.c).

The whole CPU hotplug locking seems to be broken.

		Linus
