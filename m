Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUGMPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUGMPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUGMPA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:00:56 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:17049 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265293AbUGMPAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:00:54 -0400
Date: Tue, 13 Jul 2004 17:00:54 +0200
From: bert hubert <ahu@ds9a.nl>
To: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713150054.GA1112@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713143947.GG21066@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 07:39:47AM -0700, William Lee Irwin III wrote:

> > 49ms non-preemptible critical section violated 1 ms preempt threshold 
> > starting at snd_pcm_action_lock_irq+0x1b/0x1d0 [snd_pcm] and ending at 
> > snd_pcm_action_lock_irq+0x65/0x1d0 [snd_pcm]

woa

> > 2) 49ms non-preemptible critical section violated 1 ms preempt threshold 
> > starting at sys_ioctl+0x42/0x270 and ending at sys_ioctl+0xbd/0x270
> > 40-50 ms most of the time, 12 ms couple of times.
> > Let me now if you need those traces for some of these (I've built kernel 
> > with 8K stacks).
> 
> ioctl() is typically grossly inefficient and even involves the BKL.

Indeed - but 49ms is stunning and worthy of investigation. The interesting
thing is that sys_ioctl blankly locks the kernel, even if the systems below
it don't need it. Would be a big change to fix.

In this case, how about adding

	printk(KERN_DEBUG "ioctl cmd=%d\n", cmd);

here in fs/ioctl.c:

	unlock_kernel();
	fput(filp);

out:
		return error;
}

Or something else to instrument ioctl?

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
