Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbTCOVD4>; Sat, 15 Mar 2003 16:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbTCOVD4>; Sat, 15 Mar 2003 16:03:56 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:23081
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261570AbTCOVDz>; Sat, 15 Mar 2003 16:03:55 -0500
Date: Sat, 15 Mar 2003 16:11:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Willem Riede <wrlk@riede.org>
cc: dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Any hope for ide-scsi (error handling)?
In-Reply-To: <20030315210120.GI7082@linnie.riede.org>
Message-ID: <Pine.LNX.4.50.0303151602200.9158-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
 <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com>
 <20030315210120.GI7082@linnie.riede.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, Willem Riede wrote:

> Indeed. If you get there, the command in progress is hung.
> To be able to restart the device, the old command needs to be
> aborted. But that is an inherently racy undertaking. 
> 
> Nominally, I just want to set HWGROUP(drive)->handler = NULL.
> But there is a small chance, that there is actually (interrupt) 
> activity going on for the command, which would result in a new 
> entry in HWGROUP(drive)->handler popping up after it is cleared.
> 
> The loop as programmed significantly increases the odds that 
> the old command is really aborted. 
> 
> It may not be elegant to schedule(1) with the lock taken, but it
> does work.
> 
> However, my latest patch doesn't seem to be applied, since in my
> version I have a set_current_state(TASK_INTERRUPTIBLE); before 
> the schedule.

Yeah but what happens when a task tries to acquire ide_lock? Incidentally 
this one crept in via timer softirq so if ide_timer_expiry gets there 
before your scheduled timeout timer?

NMI Watchdog detected LOCKUP on CPU0, eip c02be73d, registers:
CPU:    0
EIP:    0060:[<c02be73d>]    Tainted: PF 
EFLAGS: 00000086
EIP is at .text.lock.ide_io+0x40/0x93

Call Trace:
 [<c03557e1>] i8042_timer_func+0x21/0x30
 [<c02bdcc0>] ide_timer_expiry+0x0/0x310

-- 
function.linuxpower.ca
