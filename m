Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161447AbWBUJKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161447AbWBUJKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 04:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWBUJKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 04:10:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161447AbWBUJKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 04:10:00 -0500
Date: Tue, 21 Feb 2006 04:09:58 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: softlockup interaction with slow consoles
In-Reply-To: <20060220.131847.25386315.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com>
References: <20060220.131847.25386315.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, David S. Miller wrote:

> When register_console() runs, it dumps the entire log buffer to the
> console device with interrupts off.
> 
> If you're going over a slow console, this can easily take more than 10
> seconds especially on SMP with many cpus brought up.
> 
> This makes the softlock fire, which is terribly annoying :-)
> 
> I think the bug is in the console registry code, I think it should
> capture chunks of the existing console buffer into some local memory and
> push things piece by piece with interrupts enabled to the console
> driver(s).
> 
> Any better ideas?

is this a boot-time-only problem? In recent updates to the softlockup 
code in -mm:

 timer-irq-driven-soft-watchdog-cleanups.patch
 timer-irq-driven-soft-watchdog-percpu-race-fix.patch
 timer-irq-driven-soft-watchdog-percpu-fix.patch
 timer-irq-driven-soft-watchdog-boot-fix.patch

i changed soft lockup detection to be turned off during bootup. That
should work around any boot-time warnings.

(if this can happen on a booted up system then the real fix would indeed
be to split up register_console()'s workload - that would also make it
more preemption-friendly. But at first sight it looks quite complex to
do.)

	Ingo
