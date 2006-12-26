Return-Path: <linux-kernel-owner+w=401wt.eu-S932678AbWLZPfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWLZPfS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWLZPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:35:18 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:48531 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbWLZPfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:35:16 -0500
Date: Tue, 26 Dec 2006 07:36:10 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Florin Iucha <florin@iucha.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
Message-Id: <20061226073610.1b86a7cc.randy.dunlap@oracle.com>
In-Reply-To: <20061226124019.GA3701@elte.hu>
References: <20061225224047.GB6087@iucha.net>
	<20061225225616.GA22307@iucha.net>
	<20061226022538.13ea8b3f.akpm@osdl.org>
	<20061226124019.GA3701@elte.hu>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2006 13:40:19 +0100 Ingo Molnar wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > [ 2844.871895] BUG: scheduling while atomic: cp/0x20000000/2965
> 
> > This is the second report we've had where bit 29 of ->preempt_count is 
> > getting set.  I don't think there's any legitimate way in which that 
> > bit can get set.  (Ingo?)

First one was me, on x86_64 UP.  I ran memtest86 many hours
with no problems found.  It's an almost-new system fwiw.

> It's not legitimate (the highest legitimate bit is PREEMPT_ACTIVE, bit 
> 28). Nor can i think of any bug scenario barring outright memory 
> corruption (either hardware or kernel induced) that could cause this. 
> It's quite hard to trigger bit 29 there via any of the scheduling 
> mechanisms: either the preempt count would have to underflow massively 
> /and/ avoid detection during that undflow (sheer impossible) or the 
> HARDIRQ_COUNT would have to overflow to more than 4096 (again near 
> impossible to trigger), and simultaneously the softirq and preempt count 
> would have to overflow by 256 /at once/, or underflow by 1 at once. The 
> likelyhood of that makes the likelyhood of GPL-ed Windows a sure bet in 
> comparison.
> 
> So my guess would still be memory corruption of some sort, or some 
> really weird compiler bug. We just recently mandated REGPARM on i386 for 
> example, it would be interesting to know whether an older (say 2.6.18 or 
> 19) config had CONFIG_REGPARM enabled or not? Regparm can also tax the 
> hardware (the CPU in particular) a bit more.

I've had at least one more occurrence of it:

[   78.804940] BUG: scheduling while atomic: kbd/0x20000000/3444
[   78.804944] 
[   78.804945] Call Trace:
[   78.804952]  [<ffffffff80521ae0>] __sched_text_start+0x60/0xae0
[   78.804958]  [<ffffffff8022c2df>] default_wake_function+0xd/0xf
[   78.804962]  [<ffffffff80229504>] __wake_up_common+0x3e/0x68
[   78.804966]  [<ffffffff8022c72f>] __cond_resched+0x1c/0x44
[   78.804969]  [<ffffffff8052266b>] cond_resched+0x29/0x30
[   78.804973]  [<ffffffff805244d6>] __reacquire_kernel_lock+0x29/0x49
[   78.804977]  [<ffffffff80522603>] thread_return+0xa3/0xe2
[   78.804981]  [<ffffffff8022c72f>] __cond_resched+0x1c/0x44
[   78.804985]  [<ffffffff8052266b>] cond_resched+0x29/0x30
[   78.804989]  [<ffffffff803a8f6e>] device_add+0x3e1/0x53e
[   78.804993]  [<ffffffff803a90e4>] device_register+0x19/0x1d
[   78.804996]  [<ffffffff803a91c7>] device_create+0xdf/0x110
[   78.805001]  [<ffffffff8037fd67>] set_palette+0x5c/0x60
[   78.805005]  [<ffffffff8037fc38>] reset_terminal+0x1f0/0x1f5
[   78.805010]  [<ffffffff8037b78e>] vcs_make_sysfs+0x5e/0x62
[   78.805014]  [<ffffffff80380fc2>] con_open+0x88/0x9b
[   78.805018]  [<ffffffff803765b2>] tty_open+0x19c/0x310
[   78.805022]  [<ffffffff8027b4f9>] chrdev_open+0x164/0x19d
[   78.805026]  [<ffffffff8027b395>] chrdev_open+0x0/0x19d
[   78.805030]  [<ffffffff802772c9>] __dentry_open+0xe9/0x1ba
[   78.805034]  [<ffffffff8027742f>] nameidata_to_filp+0x2d/0x3f
[   78.805038]  [<ffffffff80277477>] do_filp_open+0x36/0x46
[   78.805042]  [<ffffffff8027714b>] get_unused_fd+0x70/0x105
[   78.805046]  [<ffffffff802774d6>] do_sys_open+0x4f/0xd7
[   78.805050]  [<ffffffff80277587>] sys_open+0x1b/0x1d
[   78.805054]  [<ffffffff8020996e>] system_call+0x7e/0x83

---
~Randy
