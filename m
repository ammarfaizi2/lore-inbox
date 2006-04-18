Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWDRJRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWDRJRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWDRJRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:17:31 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:14791 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750878AbWDRJRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:17:31 -0400
Date: Tue, 18 Apr 2006 11:17:24 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Liu haixiang <liu.haixiang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on Schedule and Preemption
Message-ID: <20060418091724.GA7258@rhlx01.fht-esslingen.de>
References: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 18, 2006 at 03:23:01PM +0800, Liu haixiang wrote:
> Hi All,
> 
> Now I am developing the driver on Linux kernel 2.6.11. And I met the
> problem that kernel will dump my stack from time to time. And the
> kernel log will give me messages like "scheduling while atomic: ...".
> 
> Then I found the code in sched.c:
> 
> if (likely(!current->exit_state)) {
> 	if (unlikely(in_atomic())) {
> 		printk(KERN_ERR "scheduling while atomic: "
> 			"%s/0x%08x/%d\n",
> 			current->comm, preempt_count(), current->pid);
> 		dump_stack();
> 	}
> }
> 
> Anybody can explain above code for me?

OK, I'll try, but there should be many references and explanations to it
on the internet already (did you look?).

If the current task is running and thus not yet exiting (!current->exit_state)
and is also in an atomic code section (i.e. under lock), it shouldn't call
any reschedule function (which also happens by just calling msleep(): use
mdelay() instead in that case!).

Generally spoken you should leave locked code sections ASAP (don't waste
too much time in there), and not call any functions that schedule to the
next task in there (msleep(), ...).

BTW, the code above is an old unoptimized version, fixed by me recently.

Andreas Mohr
