Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUGMWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUGMWRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUGMWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:17:18 -0400
Received: from holomorphy.com ([207.189.100.168]:20888 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266919AbUGMWQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:16:59 -0400
Date: Tue, 13 Jul 2004 15:16:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lenar L?hmus <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713221654.GJ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <40F40080.8010801@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F40080.8010801@vision.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Wild guess is that you took an IRQ in dec_preempt_count() and that threw
>> your results off. Let me know if the patch below helps at all. My guess
>> is it'll cause more apparent problems than it solves.

On Tue, Jul 13, 2004 at 06:32:16PM +0300, Lenar L?hmus wrote:
> Machine in question is XP2500+@1.84GHz (it was overlocked@2.25GHz during 
> last test, now running at
> official speed). Is this really slow for 1ms?

It should actually be fast enough. I suspect something else, maybe some
slow devices. What's /proc/interrupts look like?


On Tue, Jul 13, 2004 at 06:32:16PM +0300, Lenar L?hmus wrote:
> Applied your patch. Booted.
> With preempt_thresh=1 I still got tons of those violations at schedule().
> With preempt_thresh=2 I do not get those anymore. Apart from sys_ioctl() 
> violation, getting now these:
> 16ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at exit_notify+0x1d/0x7b0 and ending at schedule+0x291/0x480
> 7ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
> 6ms non-preemptible critical section violated 2 ms preempt threshold 
> starting at fget+0x28/0x70 and ending at fget+0x41/0x70

exit_notify() isn't a huge surprise unless you're not doing things with
lots of processes. Actually, it probably is a surprise, since it should
only hurt when you're doing forkbombs and/or threadbombs.

The kmap_atomic() stuff is too consistent. Maybe you're taking an
interrupt during the copy operation.

fget() is mind-bogglingly O(1) and very short. Only plausible guess is
we're seeing interrupts taken there because it's so frequently called.


On Tue, Jul 13, 2004 at 06:32:16PM +0300, Lenar L?hmus wrote:
> No apparent side-effects noticed.
> As before, when running mplayer I'm getting many sys_ioctl() things 
> coupled with messages:
> rtc: lost some interrupts at 1024Hz.
> It happens when madly seeking around in video.

Not surprised either. There's probably enough time spent with interrupts
off the local_irq_save() hurt, and it didn't make your schedule() things
go away, so my wild guesswork thus far is it made things worse with no
tangible benefit, so best to drop that local_irq_save() change.


-- wli
